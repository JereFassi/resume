# Generate PDFs locally with custom styling
# Run this from the repository root

Write-Host "Generating PDFs with custom styling..." -ForegroundColor Cyan

# Check if wkhtmltopdf is installed
$wkhtmltopdf = Get-Command wkhtmltopdf -ErrorAction SilentlyContinue

if (-not $wkhtmltopdf) {
    Write-Host "`nwkhtmltopdf not found!" -ForegroundColor Yellow
    Write-Host "`nInstall wkhtmltopdf (recommended):" -ForegroundColor Cyan
    Write-Host "  Download from: https://wkhtmltopdf.org/downloads.html" -ForegroundColor White
    Write-Host "  Or install via Chocolatey: choco install wkhtmltopdf" -ForegroundColor White
    exit 1
}

# Create pdf directory if it doesn't exist
New-Item -ItemType Directory -Force -Path pdf | Out-Null

# Generate cloud resume (English)
Write-Host "`nGenerating jere-cloud-resume-en.pdf..." -ForegroundColor Yellow
pandoc jere-cloud-resume-en.md -o pdf/jere-cloud-resume-en.pdf `
    --pdf-engine=wkhtmltopdf `
    --pdf-engine-opt=--enable-local-file-access `
    --pdf-engine-opt=--encoding `
    --pdf-engine-opt=utf-8 `
    --css=.github/styles/resume.css `
    --metadata title="Lucas Jeremias Fassi - Cloud Resume" `
    --standalone `
    --embed-resources

# Generate cloud resume (Spanish)
Write-Host "Generating jere-cloud-resume-es.pdf..." -ForegroundColor Yellow
pandoc jere-cloud-resume-es.md -o pdf/jere-cloud-resume-es.pdf `
    --pdf-engine=wkhtmltopdf `
    --pdf-engine-opt=--enable-local-file-access `
    --pdf-engine-opt=--encoding `
    --pdf-engine-opt=utf-8 `
    --css=.github/styles/resume.css `
    --metadata title="Lucas Jeremias Fassi - CV Cloud" `
    --standalone `
    --embed-resources

# Generate basic resume
Write-Host "Generating jere-basic-resume.pdf..." -ForegroundColor Yellow
pandoc jere-basic-resume.md -o pdf/jere-basic-resume.pdf `
    --pdf-engine=wkhtmltopdf `
    --pdf-engine-opt=--enable-local-file-access `
    --pdf-engine-opt=--encoding `
    --pdf-engine-opt=utf-8 `
    --css=.github/styles/resume.css `
    --metadata title="Lucas Jeremias Fassi - Resume" `
    --standalone `
    --embed-resources

# Generate ATS resume (no styling)
Write-Host "Generating resume-ATS.pdf..." -ForegroundColor Yellow
pandoc resume-ATS.md -o pdf/resume-ATS.pdf `
    --pdf-engine=wkhtmltopdf `
    --pdf-engine-opt=--enable-local-file-access `
    --pdf-engine-opt=--encoding `
    --pdf-engine-opt=utf-8 `
    --metadata title="Lucas Jeremias Fassi - Resume (ATS)" `
    --standalone

Write-Host "`n✅ All PDFs generated successfully in pdf/ folder!" -ForegroundColor Green
Write-Host "Open them to preview the new styling." -ForegroundColor Cyan
