
% >= 0 --> mandatory
%  < 0 --> best effort

#const level_lowest_hard_constraint = 1000.
#const level_highest_soft_constraint = level_lowest_hard_constraint - 1.

#const level_beginarea_not_present = level_endarea_not_present.
#const level_endarea_not_present = level_beginarea_not_first + 50.
#const level_beginarea_not_first = level_endarea_not_last.
#const level_endarea_not_last = level_coretimeslot_absent + 50.
#const level_coretimeslot_absent = level_weekly_overbooked + 50.
#const level_weekly_overbooked = level_weekly_underbooked.
#const level_weekly_underbooked = level_area_day_overbooked + 50.
#const level_area_day_overbooked = level_area_day_underbooked.
#const level_area_day_underbooked = level_area_weekly_overbooked + 50.
#const level_area_weekly_overbooked = level_area_weekly_underbooked.
#const level_area_weekly_underbooked = level_lowest_hard_constraint + 50.

#const level_highest_natural_hard_constraint = level_beginarea_not_present.

#const level_endarea_too_late = level_highest_soft_constraint - 50.
#const level_beginarea_too_early = level_endarea_too_late - 50.
#const level_context_switch = level_beginarea_too_early - 50.

#const level_lowest_natural_soft_constraint = level_context_switch.

penalty(beginarea_not_present, 1, level_beginarea_not_present).
penalty(endarea_not_present, 1, level_endarea_not_present).

penalty(beginarea_not_first, 1, level_beginarea_not_first).
penalty(endarea_not_last, 1, level_endarea_not_last).

penalty(weekly_overbooked, 1, level_weekly_overbooked).
penalty(weekly_underbooked, 1, level_weekly_underbooked).

penalty(area_weekly_overbooked,1, level_area_weekly_overbooked).
penalty(area_weekly_underbooked,1, level_area_weekly_underbooked).

penalty(area_day_overbooked,1, level_area_day_overbooked).
penalty(area_day_underbooked,1, level_area_day_underbooked).

penalty(coretimeslot_absent, 1, level_coretimeslot_absent).

penalty(endarea_too_late, 1, level_endarea_too_late).
penalty(beginarea_too_early, 1, level_beginarea_too_early).

penalty(context_switch, 1, level_context_switch).
