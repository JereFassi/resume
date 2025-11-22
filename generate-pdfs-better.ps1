# Generate PDFs using Chrome/Edge with proper emoji support
# This method preserves emojis correctly

Write-Host "Generating PDFs with emoji support using browser rendering..." -ForegroundColor Cyan

# Find Chrome or Edge
$chrome = $null
$chromePaths = @(
    "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
    "$env:ProgramFiles (x86)\Google\Chrome\Application\chrome.exe",
    "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe",
    "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
    "$env:ProgramFiles (x86)\Microsoft\Edge\Application\msedge.exe"
)

foreach ($path in $chromePaths) {
    if (Test-Path $path) {
        $chrome = $path
        Write-Host "Found browser: $path" -ForegroundColor Green
        break
    }
}

if (-not $chrome) {
    Write-Host "ERROR: Chrome or Edge not found!" -ForegroundColor Red
    Write-Host "Please install Chrome or Edge to generate PDFs with emoji support." -ForegroundColor Yellow
    exit 1
}

# Create pdf directory if it doesn't exist
New-Item -ItemType Directory -Force -Path pdf | Out-Null

Write-Host ""
Write-Host "NOTE: Please close all PDF files in the pdf/ folder before continuing." -ForegroundColor Yellow
Write-Host "Press any key to continue or Ctrl+C to cancel..." -ForegroundColor Cyan
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Write-Host ""

# Function to convert markdown to PDF via Chrome
function Convert-MarkdownToPdf {
    param(
        [string]$InputFile,
        [string]$OutputFile,
        [string]$Title
    )
    
    Write-Host "Generating $OutputFile..." -ForegroundColor Yellow
    
    # Create temp HTML file in current directory for better access
    $tempHtml = "temp_resume.html"
    
    pandoc $InputFile -o $tempHtml `
        --standalone `
        --css=.github/styles/resume.css `
        --metadata title="$Title" `
        --embed-resources
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  ERROR: Pandoc conversion failed for $InputFile" -ForegroundColor Red
        return
    }
    
    # Verify HTML was created
    if (-not (Test-Path $tempHtml)) {
        Write-Host "  ERROR: HTML file was not created" -ForegroundColor Red
        return
    }
    
    # Get absolute paths
    $htmlPath = (Resolve-Path $tempHtml).Path
    $pdfPath = Join-Path $PWD $OutputFile
    
    # Convert HTML to PDF using Chrome/Edge - use --run-all-compositor-stages-before-draw for better rendering
    $chromeArgs = @(
        "--headless=new"
        "--disable-gpu"
        "--print-to-pdf=$pdfPath"
        "--no-margins"
        "--run-all-compositor-stages-before-draw"
        "file:///$($htmlPath.Replace('\', '/'))"
    )
    
    $process = Start-Process -FilePath $chrome -ArgumentList $chromeArgs -Wait -NoNewWindow -PassThru
    
    # Wait a moment for file to be written
    Start-Sleep -Milliseconds 500
    
    if ($process.ExitCode -eq 0 -and (Test-Path $pdfPath)) {
        Write-Host "  Success: Created successfully" -ForegroundColor Green
    } else {
        Write-Host "  ERROR: Browser PDF generation failed (Exit code: $($process.ExitCode))" -ForegroundColor Red
    }
    
    # Clean up temp file
    Remove-Item $tempHtml -ErrorAction SilentlyContinue
}

# Generate all PDFs
Convert-MarkdownToPdf -InputFile "jere-cloud-resume-en.md" -OutputFile "pdf\jere-cloud-resume-en.pdf" -Title "Lucas Jeremias Fassi - Cloud Resume"
Convert-MarkdownToPdf -InputFile "jere-cloud-resume-es.md" -OutputFile "pdf\jere-cloud-resume-es.pdf" -Title "Lucas Jeremias Fassi - CV Cloud"
Convert-MarkdownToPdf -InputFile "jere-basic-resume.md" -OutputFile "pdf\jere-basic-resume.pdf" -Title "Lucas Jeremias Fassi - Resume"
Convert-MarkdownToPdf -InputFile "resume-ATS.md" -OutputFile "pdf\resume-ATS.pdf" -Title "Lucas Jeremias Fassi - Resume (ATS)"

Write-Host ""
Write-Host "All PDFs generated successfully with emoji support!" -ForegroundColor Green
Write-Host "PDFs are in the pdf/ folder. Emojis should now display correctly!" -ForegroundColor Cyan
