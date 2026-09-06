# Determining the Rearrangement Number

Manuscript and accompanying Lean 4 formalization by **Vinicius de Oliveira Rodrigues**.

The manuscript proves in ZFC that the rearrangement number equals the uniformity
of the meagre ideal: **rr = non(M)**. The Lean formalization proves the lower
bound **non(M) ≤ rr**. It does not formalize the reverse inequality or the
manuscript's further corollaries.

## Contents

| Directory | Contents |
| --- | --- |
| [paper/](paper/) | Current manuscript, bibliography, and TikZ figures. |
| [lean/](lean/) | Lean sources, pinned dependencies, and axiom audit. |
| [.github/workflows/](.github/workflows/) | Independent PDF and Lean checks. |

See the [manuscript correspondence](lean/docs/MANUSCRIPT.md) for the exact
formalized scope and differences in proof organization.

## Build the paper

Install a LaTeX distribution (TeX Live or MiKTeX) with `latexmk`, pdfLaTeX,
BibTeX, and the packages listed in the [paper instructions](paper/README.md).
From the repository root:

```sh
cd paper
latexmk -pdf -file-line-error -halt-on-error -interaction=nonstopmode main.tex
```

The output is `paper/main.pdf`. The bibliography is generated from the included
BibTeX source; figures are drawn with TikZ and need no external image files.

## Download the latest PDF

After this repository is pushed to GitHub:

1. Open **Actions**, then **Paper PDF**.
2. Filter by the repository's default branch and select its most recent
   successful **push** run. A pull request run may contain proposed changes.
3. In **Artifacts**, download **paper-pdf** and extract `main.pdf`.

The PDF corresponds to the commit shown on that run. If a newer build failed,
the last successful PDF does not include those newer changes. GitHub requires
you to sign in to download workflow artifacts. Artifacts request 90 days of
retention, subject to repository or organization settings. To regenerate an
expired artifact, use **Run workflow** on the desired branch.

The workflow also runs on pull requests and can be started manually. PDFs are
build artifacts; they are not committed or published as GitHub releases.

## Build the Lean formalization

Install [elan](https://github.com/leanprover/elan#installation) and Git. From the
repository root:

```sh
cd lean
lake exe cache get
lake build
```

Lean and mathlib are pinned to **v4.30.0**. The build checks both the proof
library and `AxiomAudit`, with warnings treated as errors. See the
[Lean README](lean/README.md) for definitions, entry points, and trust details.
The **Lean** workflow runs these checks on pushes, pull requests, and manual runs.

The local preparation results are recorded in [VALIDATION.md](VALIDATION.md).

## Citation

For the manuscript, cite *Determining the Rearrangement Number*,
Vinicius de Oliveira Rodrigues. Machine-readable metadata is in
[CITATION.cff](CITATION.cff). If you use the formalization, also cite the
[software metadata](lean/CITATION.cff).

## Licenses

- The manuscript, its LaTeX sources, bibliography, figures, and documentation
  under `paper/` are licensed under [CC BY 4.0](paper/LICENSE).
- The Lean formalization and its documentation are licensed under
  [Apache-2.0](lean/LICENSE).
- Repository infrastructure, workflows, and documentation outside `paper/`
  are licensed under [Apache-2.0](LICENSE).

Third-party dependencies retain their own licenses and are fetched during
the build.

## Contact

This repository is not accepting external contributions or pull requests.
For questions, comments, or suggested corrections, please email
[vinior@ime.usp.br](mailto:vinior@ime.usp.br).
