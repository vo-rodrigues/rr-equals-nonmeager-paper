# The rearrangement number: `non(M) ≤ rr` in Lean

A standalone Lean 4 formalization of the lower bound from
*Determining the Rearrangement Number*, by Vinicius de Oliveira Rodrigues.

The main result, in [NonMRR/Main.lean](NonMRR/Main.lean), has no additional hypotheses:

```lean
import NonMRR

example : NonMRR.nonM ≤ NonMRR.rr := NonMRR.nonM_le_rr
```

`nonM` is the least cardinality of a **nonmeagre subset of ℝ**, with its usual
topology. `rr` is the least cardinality of a family of permutations of ℕ such
that every conditionally convergent real series is sent, by some permutation
in the family, to a series that diverges or converges to a different sum.
The existence of both defining minima is proved.

This Lean project proves the lower bound `non(M) ≤ rr`. The reverse inequality,
the equality `rr = non(M)`, and the manuscript's further corollaries are outside
its scope. See [the manuscript correspondence and review](docs/MANUSCRIPT.md)
for the exact coverage and the differences in proof organization.

## Build

Install [Lean through elan](https://github.com/leanprover/elan#installation)
and Git. From the root of this repository, run:

```sh
cd lean
lake exe cache get
lake build
```

The toolchain is **Lean v4.30.0**, with **mathlib v4.30.0**, pinned by
[lean-toolchain](lean-toolchain) and [lake-manifest.json](lake-manifest.json).
The only direct dependency is mathlib. Its transitive dependencies are also
pinned. No manuscript files, parent directory, sibling project, local path
dependency, or particular GitHub repository name is required.

`lake build` checks the proof library and [AxiomAudit.lean](AxiomAudit.lean).
Warnings are errors. The [GitHub workflow](../.github/workflows/lean.yml) runs these
checks inside `lean/` on pushes and pull requests, without assuming
a particular default branch.

## Trust and semantics

The proofs contain no `sorry`, custom axioms, `native_decide`, or kernel bypass.
The audit checks the transitive axiom lists of the main results against
`propext`, `Classical.choice`, and `Quot.sound`, the usual Lean/mathlib axioms.
It **fails the build** if a checked list changes. Successful guarded checks
are silent; to inspect the axiom list directly, use `#print axioms NonMRR.nonM_le_rr`.

The audit also checks the closed target, the literal definitions of both
cardinals, the distinction between conditional and unconditional convergence,
and preservation of the sum by the identity permutation. To run it separately
from inside `lean/`:

```sh
lake env lean AxiomAudit.lean
```

Ordered convergence uses `HasSum a s (SummationFilter.conditional ℕ)`.
`hasSum_conditional_iff` proves equivalence with convergence of sums over
`Finset.range n`. Failure of absolute convergence is
`¬ Summable (fun n ↦ |a n|)`.

## Reading the proof

| Entry point | Content |
| --- | --- |
| [Series](NonMRR/Series.lean), [Category](NonMRR/Category.lean) | Definitions of the two cardinals and conditional series. |
| [FiniteVectors](NonMRR/FiniteVectors.lean) | Balanced sign vectors and the uniform `4q⁴` counting estimate, using Walsh orthogonality, Bessel, telescoping, and Cauchy–Schwarz. |
| [FiniteEmbedding](NonMRR/FiniteEmbedding.lean), [Catalogue](NonMRR/Catalogue.lean) | Embedding into disjoint blocks and the `8q⁴` exceptional-value bound. |
| [BlockAnalysis](NonMRR/BlockAnalysis.lean), [Selection](NonMRR/Selection.lean) | Conditional convergence and simultaneous preservation of the selected series. |
| [Construction](NonMRR/Construction.lean), [Morphism](NonMRR/Morphism.lean) | Challenge/response maps and the explicit Galois–Tukey morphism. |
| [LowerBound](NonMRR/LowerBound.lean) | The classical bounding-number lower bound, proved by inserting zeros. |
| [SlalomCoding](NonMRR/SlalomCoding.lean), [CategoryBound](NonMRR/CategoryBound.lean) | The category comparison and the lower bound for every rearranging family. |
| [RiemannBaire](NonMRR/RiemannBaire.lean) | Rearrangements with unbounded partial sums, ensuring that rearranging families exist. |
| [Main](NonMRR/Main.lean) | Passage to the minimum cardinal and `nonM_le_rr`. |

The theorem `exists_preserved_series_of_cardinal_lt_nonM` also provides the
simultaneous witnessing statement: every family smaller than `nonM` preserves
the sum of some conditionally convergent real series.

## References and citation

The finite estimate and the block construction follow Sections 3–4 of
*Determining the Rearrangement Number*. The formalization supplies proofs of
the classical ingredients it needs; it does not add them as assumptions.

- M. A. Cardona and D. A. Mejía, [*Localization and anti-localization cardinals*, §§3 and 5](https://arxiv.org/abs/2305.03248): category and finite-function coding.
- A. Blass, J. Brendle, W. Brian, J. D. Hamkins, M. Hardy, and P. B. Larson, [*The rearrangement number*](https://arxiv.org/abs/1612.07830): the spacing argument for the bounding-number lower bound.

Citation metadata for this software is provided in [CITATION.cff](CITATION.cff).

## License

Released under the [Apache License 2.0](LICENSE).

The manuscript sources and PDF build instructions are in [paper/](../paper/README.md).
