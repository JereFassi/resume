# PDF Generation Guide

## Local PDF Generation (Recommended)

PDFs are generated **locally** using Chrome/Edge for the best quality and emoji support. They are committed to the repository.

### Generate PDFs Manually

```powershell
.\generate-local-pdfs.ps1
```

### Automatic Generation (Git Pre-Commit Hook)

A Git hook automatically regenerates PDFs **when you commit changes** to markdown resume files.

**Setup the hook** (one-time):

```powershell
# Make the hook executable (Git Bash or WSL)
chmod +x .git/hooks/pre-commit
```

The hook will:

1. Run before `git commit` if you've changed any resume markdown files
2. Regenerate all PDFs automatically
3. Add the updated PDFs to your commit
4. Complete the commit with both markdown and PDF changes

**Skip the hook temporarily:**

```powershell
git commit --no-verify
```

## Why Local Generation?

- **Better Quality**: Chrome on Windows renders fonts and emojis better than Chromium on Linux
- **Consistency**: Same rendering engine every time
- **Faster**: No CI/CD wait time
- **Control**: You review PDF changes before committing

## GitHub Actions

The workflow now **validates** files instead of building PDFs:

- ✅ Checks PDF files exist
- ✅ Validates markdown structure
- ✅ Validates JSON resume schema

## Files

- `generate-local-pdfs.ps1` - Script for local PDF generation
- `.git/hooks/pre-commit` - Automatic pre-commit hook
- `.github/workflows/build-pdf.yml` - Validation workflow
