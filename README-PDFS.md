# PDF Generation Guide

## Local PDF Generation (Recommended)

PDFs are generated **locally** using Chrome/Edge for the best quality and emoji support. They are committed to the repository.

### Generate PDFs Manually

```powershell
.\generate-local-pdfs.ps1
```

### Automatic Generation (Git Pre-Push Hook)

A Git hook automatically regenerates PDFs before each push to keep them in sync with markdown changes.

**Setup the hook** (one-time):

```powershell
# Make the hook executable (Git Bash or WSL)
chmod +x .git/hooks/pre-push
```

The hook will:

1. Run before every `git push`
2. Regenerate all PDFs
3. Prompt you to commit PDF changes if detected
4. Allow the push to continue

**Disable the hook temporarily:**

```powershell
git push --no-verify
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
- `.git/hooks/pre-push` - Automatic pre-push hook
- `.github/workflows/build-pdf.yml` - Validation workflow
