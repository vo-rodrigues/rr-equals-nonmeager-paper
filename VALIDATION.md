# Repository preparation checks

Validation date: **2026-09-06**.

## Manuscript

- Compiled the copied sources with `latexmk`, pdfLaTeX, and BibTeX under MiKTeX
  on Windows, starting without generated bibliography or auxiliary files.
- The result has nine pages, with no undefined references or citations and no
  LaTeX layout warnings in the final log.
- Rendered and visually inspected all nine pages. At a 1500-pixel longest
  edge, each rendered page matches the source manuscript's existing PDF
  pixel for pixel.
- The eight manuscript source files are byte-identical to their originals.
  The LaTeX input recorder contains no reference to the original source tree.

## Lean

- Ran `lake exe cache get` and `lake build` inside the copied `lean/` project,
  starting without a `.lake` directory. All nine public dependencies were
  fetched at the revisions recorded in the manifest; the shared mathlib cache
  supplied dependency build artifacts.
- `lake build` completed successfully (**3088 jobs**), including the `NonMRR`
  library and `AxiomAudit`, with warnings treated as errors.
- Lean and mathlib remain pinned to **v4.30.0**. The axiom audit's guarded
  checks passed. No manuscript-directory source, sibling dependency, or
  directory junction was used for the build.
- All 29 project `.lean` files and the five copied package, toolchain,
  dependency, license, and citation files are byte-identical to the originals.

## Packaging

- Workflow files pass `actionlint` 1.7.7. Action input names were checked
  against the corresponding pinned upstream action definitions.
- Both workflows run on pushes, pull requests, and manual requests with
  read-only repository-content permissions. The PDF artifact is `paper-pdf`
  and requests 90 days of retention.
- Both citation files validate against the official CFF 1.2.0 JSON schema.
- All relative documentation links resolve within the repository. Git's
  ignore checks exclude the generated PDF, LaTeX auxiliary files, Lean build
  cache and dependencies, and the local verification workspace.
- All 49 original source and supporting files in the preparation inventory
  retain their SHA-256 hashes. The original tree was used only for reading.
- The user initialized Git during preparation and asked to preserve it.
  The preparation did not initialize Git or create any GitHub repository,
  commit, release, or upload.

## Limits

These are local packaging and compilation checks. The GitHub-hosted Ubuntu
workflows have not run yet; they will run after the repository is published.
This preparation does not constitute a new mathematical review. The Lean
scope remains the lower bound, as described in
[the manuscript correspondence](lean/docs/MANUSCRIPT.md).
