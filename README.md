# Lucas Jeremias Fassi – Resume

| Cloud (EN)                                                                | Cloud (ES)                                                                | General                                                             | ATS Plain                                             | JSON Data                  |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------- | ------------------------------------------------------------------- | ----------------------------------------------------- | -------------------------- |
| [Markdown](jere-cloud-resume-en.md) · [PDF](pdf/jere-cloud-resume-en.pdf) | [Markdown](jere-cloud-resume-es.md) · [PDF](pdf/jere-cloud-resume-es.pdf) | [Markdown](jere-basic-resume.md) · [PDF](pdf/jere-basic-resume.pdf) | [Markdown](resume-ATS.md) · [PDF](pdf/resume-ATS.pdf) | [resume.json](resume.json) |

> Quick access: pick the version that fits the role (Cloud EN/ES, General SWE, ATS, or JSON for tooling).

## Overview

Multi-version resume optimized for: Cloud / AWS admin & DevOps roles, general backend engineering, and ATS parsing.

## Local PDF Generation

Use the script:

```powershell
./generate-local-pdfs.ps1
```

Pre-commit hook keeps PDFs in sync automatically when markdown changes.

## JSON Resume

`resume.json` follows the [JSON Resume](https://jsonresume.org) schema and can be used with themes or APIs.

```powershell
npm install -g resume-cli
resume validate
resume export resume.html
```

## Feedback

Open an issue or PR for improvements.

---

_Last updated: 2025-11-22_
