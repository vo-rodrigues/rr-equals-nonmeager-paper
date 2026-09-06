/-
Copyright (c) 2026 Vinicius de Oliveira Rodrigues.
Released under Apache 2.0 license as described in the file LICENSE.
-/

import NonMRR

/-!
# Kernel axiom audit

Run `lake env lean AxiomAudit.lean`. Each `#guard_msgs` checks the complete
transitive axiom list against the three standard axioms of Lean/mathlib.
An unexpected dependency is an error, so it also fails the default `lake build`.
-/

/-- info: 'NonMRR.finite_counting_estimate' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.finite_counting_estimate

/-- info: 'NonMRR.conditional_series_of_disjoint_balanced_blocks' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.conditional_series_of_disjoint_balanced_blocks

/-- info: 'NonMRR.walshCatalogue' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.walshCatalogue

/-- info: 'NonMRR.boundingNumber_le_cardinal_of_isRearranging' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.boundingNumber_le_cardinal_of_isRearranging

/-- info: 'NonMRR.blockSlalomNumber_le_cardinal_of_isRearranging' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.blockSlalomNumber_le_cardinal_of_isRearranging

/-- info: 'NonMRR.nonMeagreCardinal_le_product_of_gap_and_coincidence' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.nonMeagreCardinal_le_product_of_gap_and_coincidence

/-- info: 'NonMRR.nonM_le_nonMeagreCardinal_bool' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.nonM_le_nonMeagreCardinal_bool

/-- info: 'NonMRR.exists_gap_unbounded_family' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.exists_gap_unbounded_family

/-- info: 'NonMRR.selected_blocks_give_zero_witness' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.selected_blocks_give_zero_witness

/-- info: 'NonMRR.tendsto_partialSum_extend' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.tendsto_partialSum_extend

/-- info: 'NonMRR.not_summable_abs_extend' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.not_summable_abs_extend

/-- info: 'NonMRR.slalom_cover_to_strong_coincidence' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.slalom_cover_to_strong_coincidence

/-- info: 'NonMRR.nonM_le_cardinal_of_isRearranging' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.nonM_le_cardinal_of_isRearranging

/-- info: 'NonMRR.exists_preserved_series_of_cardinal_lt_nonM' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.exists_preserved_series_of_cardinal_lt_nonM

/-- info: 'NonMRR.exists_perm_unbounded_partialSum' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.exists_perm_unbounded_partialSum

/-- info: 'NonMRR.isRearranging_univ' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.isRearranging_univ

/-- info: 'NonMRR.exists_rearranging_family_of_cardinal_rr' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.exists_rearranging_family_of_cardinal_rr

/-- info: 'NonMRR.nonM_le_rr' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms NonMRR.nonM_le_rr

/-- info: 'NonMRR.blockMorphism' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in
#print axioms NonMRR.blockMorphism

/-- info: 'NonMRR.exists_divergent_slalom_morphism' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in
#print axioms NonMRR.exists_divergent_slalom_morphism

/-- Check the closed target, without parameters, assumptions or alternative invariants. -/
example : NonMRR.nonM ≤ NonMRR.rr := NonMRR.nonM_le_rr

/-- The definition of `nonM` is literally the real meagre-ideal uniformity. -/
example : NonMRR.nonM = sInf {κ : Cardinal |
    ∃ s : Set ℝ, ¬ IsMeagre s ∧ Cardinal.mk s = κ} := rfl

/-- The definition of `rr` is literally the minimum over rearranging families. -/
example : NonMRR.rr = sInf {κ : Cardinal |
    ∃ s : Set (Equiv.Perm ℕ), NonMRR.IsRearranging s ∧ Cardinal.mk s = κ} := rfl

/-- Ordered conditional convergence must not silently become unconditional summability. -/
example (a : NonMRR.ConditionalSeries) : ¬ Summable a.term :=
  fun h ↦ a.not_absolute h.abs

/-- The identity must preserve every conditional series, including its natural sum. -/
example (a : NonMRR.ConditionalSeries) : ¬ NonMRR.Rearranges a (Equiv.refl ℕ) := by
  intro h
  exact h a.converges
