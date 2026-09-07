import Solution

/-! Transitive axiom guards for every declaration selected by Comparator. -/

/-- info: 'PalomarRR.nonM_minimum' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms PalomarRR.nonM_minimum

/-- info: 'PalomarRR.rr_minimum' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms PalomarRR.rr_minimum

/-- info: 'PalomarRR.nonM_le_rr' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms PalomarRR.nonM_le_rr
