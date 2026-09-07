/-
Copyright (c) 2026 Vinicius de Oliveira Rodrigues.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Analysis.PSeries
import Mathlib.SetTheory.Cardinal.Arithmetic
import Mathlib.Topology.Baire.CompleteMetrizable
import Mathlib.Topology.Instances.Real.Lemmas

/-!
# The rearrangement number: non(M) ≤ rr

This independent statement surface formalizes the lower-bound direction of
*Determining the Rearrangement Number*, Main Theorem 1.2, by Vinicius de Oliveira
Rodrigues. It imports only mathlib, not the proof development.

The real line has its usual topology. A rearranging family changes the sum or
destroys convergence of every conditionally convergent real series. Ordered
summation is explicit: `SummationFilter.conditional ℕ` takes initial segments
of ℕ. Absolute summability uses the absolute values of the terms.

The two existence statements certify that the cardinal infima below are
attained. The principal inequality has no additional hypotheses. The reverse
inequality, the equality rr = non(M), and the manuscript's further corollaries
are outside this submission. All definitions are fully specified; only the
three theorem proofs are deliberate Challenge holes.
-/

open Cardinal

namespace NonMRR

/-- A real series with its ordered sum, convergent but not absolutely convergent. -/
structure ConditionalSeries where
  term : ℕ → ℝ
  sum : ℝ
  converges : HasSum term sum (SummationFilter.conditional ℕ)
  not_absolute : ¬ Summable (fun n ↦ |term n|)

/-- A permutation changes the ordered sum or makes the series divergent. -/
def Rearranges (a : ConditionalSeries) (π : Equiv.Perm ℕ) : Prop :=
  ¬ HasSum (a.term ∘ π) a.sum (SummationFilter.conditional ℕ)

/-- A family rearranging every conditionally convergent real series. -/
def IsRearranging (s : Set (Equiv.Perm ℕ)) : Prop :=
  ∀ a : ConditionalSeries, ∃ π ∈ s, Rearranges a π

/-- The least cardinality of a rearranging family of permutations of ℕ. -/
noncomputable def rr : Cardinal :=
  sInf {κ | ∃ s : Set (Equiv.Perm ℕ), IsRearranging s ∧ #s = κ}

universe u

/-- The infimum of cardinalities of nonmeagre subsets of a topological space. -/
noncomputable def nonMeagreCardinal (X : Type u) [TopologicalSpace X] : Cardinal.{u} :=
  sInf {κ | ∃ s : Set X, ¬ IsMeagre s ∧ Cardinal.mk s = κ}

/-- The least cardinality of a nonmeagre subset of the usual real line. -/
noncomputable def nonM : Cardinal := nonMeagreCardinal ℝ

end NonMRR

namespace PalomarRR

-- Only this statement module permits the three intentional proof holes.
set_option warningAsError false

/-- A nonmeagre real set attains the minimum defining non(M). -/
theorem nonM_minimum :
    ∃ s : Set ℝ, ¬ IsMeagre s ∧ Cardinal.mk s = NonMRR.nonM := by
  sorry

/-- A rearranging family attains the minimum defining rr. -/
theorem rr_minimum :
    ∃ P : Set (Equiv.Perm ℕ), NonMRR.IsRearranging P ∧ #P = NonMRR.rr := by
  sorry

/-- The uniformity of the real meagre ideal is at most the rearrangement number. -/
theorem nonM_le_rr : NonMRR.nonM ≤ NonMRR.rr := by
  sorry

end PalomarRR
