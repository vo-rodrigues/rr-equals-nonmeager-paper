# Publication verification

Verification date: **2026-09-06**.

## Build results

Both of the following builds completed successfully, including the default
`NonMRR` and `AxiomAudit` targets, with warnings treated as errors:

1. The working source tree.
2. A standalone copy outside the manuscript repository, starting without a
   `.lake` directory. Lake fetched the nine pinned public Git dependencies;
   mathlib's cache supplied their compiled artifacts. All project modules
   were then compiled from the copied sources. No parent-repository files,
   sibling checkout, local path dependency, or directory junction was used.

The standalone build used:

```sh
lake exe cache get
lake build
```

The checked versions are Lean **v4.30.0** and mathlib **v4.30.0**, with mathlib
commit `c5ea00351c28e24afc9f0f84379aa41082b1188f`. All nine dependency checkouts
matched [the manifest](../lake-manifest.json), with no tracked modifications.
The 27 modules under `NonMRR/` are all reachable from [NonMRR.lean](../NonMRR.lean).

## Logical checks

The closed theorem is:

```lean
NonMRR.nonM_le_rr : NonMRR.nonM ≤ NonMRR.rr
```

[AxiomAudit.lean](../AxiomAudit.lean) contains 20 guarded transitive axiom
checks, including the main theorem, the explicit morphism, the finite estimate,
the category comparison, and existence of rearranging families. Each reported
exactly:

```text
[propext, Classical.choice, Quot.sound]
```

Five further checks fix the closed target, the literal definitions of both
cardinals, failure of unconditional summability for a conditional series,
and preservation by the identity permutation. A temporary negative control
with an extra axiom was rejected by the guard; it is not part of the sources.
The project sources contain no `sorry`, `admit`, custom axiom, `native_decide`,
or unsafe declaration.

The [manuscript review](MANUSCRIPT.md) records the mathematical correspondence
and differences in presentation. The verified scope is `nonM ≤ rr`; neither
the reverse inequality nor the full equality is claimed here.

## Publication files

- [CITATION.cff](../CITATION.cff) was validated against the official CFF 1.2.0
  schema. It contains no placeholder repository URL or invented DOI.
- The Lake configuration and [GitHub workflow](../../.github/workflows/lean.yml)
  were parsed and checked before packaging. The combined repository workflow
  builds inside `lean/`, without assuming a repository or branch name.
- Local documentation links resolve inside this source tree. Source and
  configuration files have UTF-8 encoding and LF line endings.
- The [Apache-2.0 license](../LICENSE), citation metadata, [editor settings](../../.editorconfig),
  dependency manifest, and toolchain pin are included. Build products and
  downloaded dependencies are excluded by [.gitignore](../.gitignore).

The GitHub workflow is prepared for publication but has not been executed on
GitHub. The completed builds above ran locally on Windows; the configured
Ubuntu runner remains a separate CI check once the repository is published.

The checks above record the original standalone verification. Checks of the
combined paper and Lean repository are recorded in [VALIDATION.md](../../VALIDATION.md).
