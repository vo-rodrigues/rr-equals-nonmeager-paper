# Correspondence with the manuscript

Reviewed against *Determining the Rearrangement Number*, by Vinicius de
Oliveira Rodrigues, in its source version available on **2026-09-06**.
The section and lemma numbers below identify that version. The manuscript
is a mathematical reference, not a build dependency.

## Scope and outcome

The formalization proves the **lower-bound direction** of the manuscript's
Main Theorem 1.2:

```lean
NonMRR.nonM_le_rr : NonMRR.nonM ≤ NonMRR.rr
```

The final review found no mismatch affecting this result in the definitions,
quantifier order, numerical constants, or use of classical ingredients.
The final theorem is closed: it has no hypothesis supplying a slalom theorem,
a finite block catalogue, a cardinal inequality, or existence of rearrangements.
All such data and the particular category comparison used below are proved.

The reverse bound `rr ≤ nonM`, the equality `rr = nonM`, and the variants and
subseries corollaries in Section 5 are **not formalized here**. The scope is
the complete proof of `nonM ≤ rr`, not a formalization of the entire manuscript.

## Definitions

| Manuscript | Formal counterpart | Review |
| --- | --- | --- |
| Section 2: `S_m(a)` and `S_m^π(a)` | [Series.partialSum](../NonMRR/Series.lean), [BlockAnalysis.rearrangedPartialSum](../NonMRR/BlockAnalysis.lean) | Both sum the terms indexed by `0, …, m-1`; the reordered term is `a (π i)`. |
| Conditionally convergent real series | [ConditionalSeries](../NonMRR/Series.lean) | Ordered convergence through `SummationFilter.conditional ℕ`, and failure of absolute summability. The sum is stored together with its proof; uniqueness ensures it is the original sum. |
| Definition 2.1: rearranging family and `rr` | [Rearranges, IsRearranging, rr](../NonMRR/Series.lean) | A permutation fails to converge to the original sum. This includes divergence and convergence to another sum. |
| Uniformity of the meagre ideal | [nonM](../NonMRR/Category.lean) | Defined directly from nonmeagre subsets of the usual real line; not defined by slaloms or an alternative topology. |
| Eventual domination and `b` | [boundingRelation, boundingNumber](../NonMRR/Bounding.lean) | The relation `f < g` infinitely often has precisely the unbounded families as its dominating families. |
| Bounded slaloms and infinite catches | [Slalom, slalomRelation](../NonMRR/Slaloms.lean) | Finite subsets of ℕ with the stated pointwise width bound; catches use `Filter.Frequently` at `atTop`. |
| Cardinal minima | [Category](../NonMRR/Category.lean), [RiemannBaire](../NonMRR/RiemannBaire.lean), [Main](../NonMRR/Main.lean) | Nonempty sets of witnesses are proved before the minimum is used; `sInf` is not applied as an unsupported empty minimum. |

## Finite estimate and block construction

| Manuscript step | Formal result | Review |
| --- | --- | --- |
| Lemma 3.1: balanced sign vectors | [finite_counting_estimate](../NonMRR/FiniteVectors.lean) | Sum zero, absolute value `1/L`, and at most `4q⁴` bad vectors in every ordering. For real entries, the absolute-value condition is equivalent to membership in `{−1/L, 1/L}`. |
| Equations (3.1)–(3.3): orthogonality and prefix squares | [Walsh](../NonMRR/Walsh.lean) | Coordinate flips on the Boolean cube prove cancellation and orthogonality; Bessel bounds the sum of squared prefixes. |
| Telescoping and fourth-moment bound | [FiniteAnalytic](../NonMRR/FiniteAnalytic.lean) | Endpoint cancellation, bounded increments, and Cauchy–Schwarz give the same uniform fourth-moment estimate and counting bound. |
| Embedding and order of visits | [FiniteEmbedding](../NonMRR/FiniteEmbedding.lean) | A single finite permutation represents the order of visits for every candidate vector. The prefix length depends on the global cutoff, not on the candidate vector. |
| Equation (4.1) and the union of two exceptional sets | [Catalogue](../NonMRR/Catalogue.lean) | Uses `q(n) = 2^(n+1)`, tolerance `1/q(n)`, and width `r(n) = 8*q(n)^4`. The factor 8 is the sum of the two bounds `4*q(n)^4`. |
| Finite supports, balance, and absolute mass | [Catalogue](../NonMRR/Catalogue.lean) | Consecutive disjoint supports are constructed. Every available vector has exact absolute mass 1; the analytic interface only needs mass at least 1. |
| Equation (4.2): bad slalom | [badValues](../NonMRR/Selection.lean) | A value is bad when some natural or reordered prefix strictly exceeds the tolerance. |
| The zero-sum conditional witness | [selected_blocks_give_zero_witness](../NonMRR/Selection.lean) | Infinitely many available selections force failure of absolute convergence. Eventual avoidance gives convergence to zero in both orders. |
| Lemma 4.1: the morphism | [blockMorphism, exists_divergent_slalom_morphism](../NonMRR/Morphism.lean) | An explicit `Relation.Morphism` is exported, together with positivity and divergence to infinity of its width. The rearrangement relation has norm exactly `rr`. |
| Image of dominating families | [dominating_response_image](../NonMRR/Construction.lean) | The implication defining the morphism sends an unbounded family and a rearranging family to a dominating slalom family. |

## Differences in presentation

These differences preserve the required implications and are deliberate.

1. **Finite maxima.** The bad event is written as the existence of a prefix
   above the threshold, rather than introducing a separate maximum function.
   These are equivalent for the finite prefixes in Lemma 3.1. For embedded
   blocks, the proof identifies each global prefix with a finite prefix;
   it needs only this direction, rather than equality of two supremum objects.
2. **Empty stages.** The finite lemma also permits `m = 0`. No candidate exists
   at such a stage. Any positive support length is harmless; the proof does
   not depend on forcing a particular length for an unused stage.
3. **Convergence of the block sum.** The code uses mathlib's dominated-convergence
   theorem for series instead of repeating the explicit geometric-tail
   epsilon argument. Its hypotheses are proved: summability in the block index
   at each coordinate follows from disjoint supports, each finite balanced
   block has sum zero, and the dominating tolerance is summable. This does
   not interchange two conditionally convergent series without justification.
4. **Fallback challenge.** The manuscript tests conditional convergence before
   choosing the constructed series. The code tests conditional convergence
   *with sum zero*. Whenever the morphism argument uses this branch, the
   avoidance lemma has already proved both conditions, so the stronger test
   selects the same required witness.
5. **Relation infrastructure.** The generic `Relation` type permits an empty
   challenge type, a harmless generalization of Section 2. The concrete
   challenge types used here are inhabited. The necessary upper bound for
   sequential norms is proved; the full general product identity is not needed.
6. **Category comparison.** The manuscript invokes the standard identification
   `non(M) = ‖S_r‖`. The formalization proves the sufficient comparison
   `nonM ≤ boundingNumber * blockSlalomNumber` directly. It does not assume
   or announce a formal proof of that general identification.

## The final cardinal argument

Write `b = boundingNumber` and `σ = blockSlalomNumber`. For every rearranging
family `P`, the formal proof establishes:

```text
b ≤ |P|
σ ≤ b · |P| ≤ |P|
nonM ≤ b · σ ≤ |P|.
```

The products collapse because `P` is infinite, as also proved. The main theorem
then chooses an actual rearranging family of cardinality `rr`.

The category comparison is constructed from a family of increasing sequences
of size at most `b` and a strong coincidence family of size at most `σ`.
Pasting their finite binary blocks gives a nonmeagre subset of Cantor space.
Binary expansions transfer the needed bound to the actual real line.
This explains the additional category modules compared with the shorter
manuscript argument.

The classical ingredients required by this route are proved over mathlib:
zero padding proves the lower bound by `b`, and a Baire argument constructs
a permutation with unbounded partial sums for every non-absolutely summable
real sequence. The latter supplies rearranging families; it is not a
formalization of the full Riemann theorem prescribing an arbitrary sum.

## Verification

The [axiom audit](../AxiomAudit.lean) checks the final closed target and the
literal cardinal definitions. Guarded checks make an unexpected axiom in a
listed result a build failure. See [VERIFICATION.md](VERIFICATION.md) for the
publication checks and their limits.
