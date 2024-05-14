
#const level_lowest_hard_constraint = 1.
#const level_highest_soft_constraint = level_lowest_hard_constraint - 1.

#const level_fixed_slots = level_beginarea_not_present + 50.
#const level_beginarea_not_present = level_endarea_not_present.
#const level_endarea_not_present = level_beginarea_not_first + 50.
#const level_beginarea_not_first = level_endarea_not_last.
#const level_endarea_not_last = level_coretimeslot_absent + 50.
#const level_coretimeslot_absent = level_overbooked + 50.
#const level_overbooked = level_underbooked.
#const level_underbooked = level_area_overbooked + 50.
#const level_area_overbooked = level_area_underbooked.
#const level_area_underbooked = level_area_day_overbooked + 50.
#const level_area_day_overbooked = level_area_day_underbooked.
#const level_area_day_underbooked = level_lowest_hard_constraint + 50.

#const level_highest_natural_hard_constraint = level_fixed_slots.

#const level_endarea_too_late = level_highest_soft_constraint - 50.
#const level_beginarea_too_early = level_endarea_too_late - 50.
#const level_area_day_context_fragmentation = level_beginarea_too_early - 50.
#const level_area_day_context_saturation = level_area_day_context_fragmentation.

#const level_lowest_natural_soft_constraint = level_area_day_context_saturation.

#const scale_fixed_slots = 1.

#const scale_beginarea_not_present = 1.
#const scale_endarea_not_present = 1.

#const scale_beginarea_not_first = 1.
#const scale_endarea_not_last = 1.

#const scale_coretimeslot_absent = 1.

#const scale_overbooked = 1.
#const scale_underbooked = 1.

#const scale_area_day_overbooked = 1.
#const scale_area_day_underbooked = 1.

#const scale_area_overbooked = 1.
#const scale_area_underbooked = 1.

#const scale_endarea_too_late = 1.
#const scale_beginarea_too_early = 1.

#const scale_area_day_context_saturation = 1.
#const scale_area_day_context_fragementation = 1.
