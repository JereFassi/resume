# Lucas Jeremias Fassi – Resume Repository

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
3. Generates PDFs for both Markdown versions.
4. Uploads them as build artifacts.

Download from the Actions run summary.

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

## Suggested Future Enhancements

- Add Spanish and Portuguese localized versions (`JereCV-es.md`, `JereCV-pt.md`).
- Integrate shields (e.g. GitHub profile visits) in README.
- Add a changelog summarizing major updates.

## Contributing / Feedback

Open an issue or PR with suggestions. Recruiters/employers may fork and annotate directly.

## License

You may read and share the resume. Commercial reuse of content without permission is prohibited.

---

_Last updated: 2025-11-21_
