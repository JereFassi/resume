# Lucas Jeremias Fassi – Resume Repository

![GitHub last commit](https://img.shields.io/github/last-commit/JereFassi/resume?style=flat-square)
![GitHub repo size](https://img.shields.io/github/repo-size/JereFassi/resume?style=flat-square)
![GitHub stars](https://img.shields.io/github/stars/JereFassi/resume?style=flat-square)
![GitHub forks](https://img.shields.io/github/forks/JereFassi/resume?style=flat-square)
![Build Status](https://img.shields.io/github/actions/workflow/status/JereFassi/resume/build-pdf.yml?branch=main&style=flat-square&label=PDF%20Build)
![License](https://img.shields.io/badge/license-All%20Rights%20Reserved-red?style=flat-square)

This repository hosts my resume in multiple developer-friendly formats:

- `jere-cloud-resume.md` – Cloud & infrastructure-focused version (AWS admin, DevOps, part-time roles).
- `jere-cloud-resume-es.md` – Versión en español del CV enfocado en cloud/infraestructura.
- `jere-basic-resume.md` – General software engineer version (broader scope).
- `resume-ATS.md` – Plain, ATS-optimized version (minimal styling).
- `resume.json` – JSON Resume schema representation (portable, API-friendly).

## Goals

- Clean, scannable Markdown for recruiters and engineers.
- Multiple tailored versions for different role types (cloud/infra vs. full-stack).
- ATS compatibility (no tables/images; clear headings; keyword density).
- Version control for iterative improvements.
- Automated PDF export (optional GitHub Actions workflow included).

## File Overview

| File                              | Purpose                                                              |
| --------------------------------- | -------------------------------------------------------------------- |
| `jere-cloud-resume.md`            | Cloud/infrastructure-focused resume for AWS admin & DevOps roles.    |
| `jere-cloud-resume-es.md`         | Spanish version of cloud-focused resume.                             |
| `jere-basic-resume.md`            | General software engineering resume (backend, full-stack, teaching). |
| `resume-ATS.md`                   | Simplified ATS-optimized version.                                    |
| `resume.json`                     | Structured data for tooling / APIs based on JSON Resume schema.      |
| `pdf/`                            | Auto-generated PDF versions (updated on push to main).               |
| `.github/workflows/build-pdf.yml` | Action to generate PDF artifacts via Pandoc.                         |

## Generate PDF Locally

Requires [Pandoc](https://pandoc.org/) installed. On Windows (PowerShell):

```powershell
pandoc jere-cloud-resume.md -o jere-cloud-resume.pdf
pandoc jere-cloud-resume-es.md -o jere-cloud-resume-es.pdf
pandoc jere-basic-resume.md -o jere-basic-resume.pdf
pandoc resume-ATS.md -o resume-ATS.pdf
```

Optional flags for better typography:

```powershell
pandoc jere-cloud-resume.md -o jere-cloud-resume.pdf --pdf-engine=wkhtmltopdf --highlight-style=tango
```

If using MiKTeX/TeX Live for LaTeX engine:

```powershell
pandoc jere-cloud-resume.md -o jere-cloud-resume.pdf --pdf-engine=xelatex -V mainfont="Calibri" -V geometry:margin=1in
```

## GitHub Actions PDF Export

On every push to `main`, the workflow:

1. Checks out repository.
2. Installs Pandoc.
3. Generates PDFs for all resume versions.
4. Commits them to the `pdf/` folder.

**Direct download links:**
- [jere-cloud-resume.pdf](pdf/jere-cloud-resume.pdf)
- [jere-cloud-resume-es.pdf](pdf/jere-cloud-resume-es.pdf)
- [jere-basic-resume.pdf](pdf/jere-basic-resume.pdf)
- [resume-ATS.pdf](pdf/resume-ATS.pdf)

## JSON Resume Usage

The `resume.json` file follows https://jsonresume.org schema. You can:

- Publish via `resume-cli` (`npm install -g resume-cli`).
- Render with community themes.
- Feed into custom portfolio generators.

Example render command:

```powershell
npm install -g resume-cli
resume validate
resume export resume.html
```

## Contributing / Feedback

Open an issue or PR with suggestions. Recruiters/employers may fork and annotate directly.

## License

You may read and share the resume. Commercial reuse of content without permission is prohibited.

---

_Last updated: 2025-11-21_
