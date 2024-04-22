

area(review_daily_start).
area(review_daily_end).
area(pause).

area(pre_estimations).
area(concepts).
area(improvements).

area(meeting_devc).
area(meeting_triage).
area(meeting_feature_eval).

beginarea(review_daily_start).
endarea(review_daily_end).

area_dailyminquarterhours(review_daily_start, 2).
area_dailymaxquarterhours(review_daily_start, 2).

area_dailyminquarterhours(review_daily_end, 1).
area_dailymaxquarterhours(review_daily_end, 1).

area_dailyminquarterhours(pause, 2).
area_dailymaxquarterhours(pause, 2).

area_dailyminquarterhours(pre_estimations, 1).
area_weeklyminquarterhours(pre_estimations, (14 * 4) + 0).
area_weeklymaxquarterhours(pre_estimations, (16 * 4) + 0).

area_dailyminquarterhours(concepts, 1).
area_weeklyminquarterhours(concepts, (9 * 4) + 1).
area_weeklymaxquarterhours(concepts, (10 * 4) + 3).

area_dailyminquarterhours(improvements, 1).
area_weeklyminquarterhours(improvements, (4 * 4) + 2).
area_weeklymaxquarterhours(improvements, (5 * 4) + 2).

area_dailyminquarterhours(meeting_devc, 0).
area_dailymaxquarterhours(meeting_devc, 4).
area_weeklyminquarterhours(meeting_devc, 4).
area_weeklymaxquarterhours(meeting_devc, 4).

area_dailyminquarterhours(meeting_triage, 0).
area_dailymaxquarterhours(meeting_triage, 5).
area_weeklyminquarterhours(meeting_triage, 5).
area_weeklymaxquarterhours(meeting_triage, 5).

area_dailyminquarterhours(meeting_feature_eval, 0).
area_dailymaxquarterhours(meeting_feature_eval, 2).
area_weeklyminquarterhours(meeting_feature_eval, 4).
area_weeklymaxquarterhours(meeting_feature_eval, 4).

coretimeslot(Slot) :-
    slot(Slot),
    Slot = (Day, Hour, Quarterhour),
    day(Day), Day != friday,
    10 <= Hour, Hour < 16.

coretimeslot(Slot) :-
    slot(Slot),
    Slot = (friday, Hour, Quarterhour),
    10 <= Hour, Hour < 15.

weeklyminquarterhours((38 * 4 + 2) + (2 * 5)).
weeklymaxquarterhours((38 * 4 + 2) + (2 * 5)).


:~ not slot_area((wednesday,10,1), meeting_devc).[1@level_highest_natural_hard_constraint+1]
:~ not slot_area((wednesday,10,2), meeting_devc).[1@level_highest_natural_hard_constraint+1]
:~ not slot_area((wednesday,10,3), meeting_devc).[1@level_highest_natural_hard_constraint+1]
:~ not slot_area((wednesday,11,0), meeting_devc).[1@level_highest_natural_hard_constraint+1]

:~ not slot_area((wednesday,11,1), meeting_triage).[1@level_highest_natural_hard_constraint+1]
:~ not slot_area((wednesday,11,2), meeting_triage).[1@level_highest_natural_hard_constraint+1]
:~ not slot_area((wednesday,11,3), meeting_triage).[1@level_highest_natural_hard_constraint+1]
:~ not slot_area((wednesday,12,0), meeting_triage).[1@level_highest_natural_hard_constraint+1]
:~ not slot_area((wednesday,12,1), meeting_triage).[1@level_highest_natural_hard_constraint+1]

:~ not slot_area((monday, 12,0), meeting_feature_eval).   [1@level_highest_natural_hard_constraint+1]
:~ not slot_area((monday, 12,1), meeting_feature_eval).   [1@level_highest_natural_hard_constraint+1]
:~ not slot_area((wednesday,13,0), meeting_feature_eval). [1@level_highest_natural_hard_constraint+1]
:~ not slot_area((wednesday,13,1), meeting_feature_eval). [1@level_highest_natural_hard_constraint+1]

:~ slot_area((thursday,14,1), _). [1@level_highest_natural_hard_constraint+1]
:~ slot_area((thursday,14,2), _). [1@level_highest_natural_hard_constraint+1]
:~ slot_area((thursday,14,3), _). [1@level_highest_natural_hard_constraint+1]
:~ slot_area((thursday,15,0), _). [1@level_highest_natural_hard_constraint+1]
:~ slot_area(Slot, pause),
    slot(Slot),
    span(Slot, (thursday,13,3),D). [D@level_highest_natural_hard_constraint+1]
:~ slot_area(Slot, pause),
    slot(Slot),
    span((thursday,14,0),Slot,D). [D@level_highest_natural_hard_constraint+1]


:~ slot_area(Slot, review_daily_end),
    slot(Slot),
    span((tuesday,16,1), Slot, D). [D@level_highest_natural_hard_constraint+1, review_daily_end,Slot]
:~ slot_area(Slot, review_daily_end),
    slot(Slot),
    span((thursday,17,2), Slot, D). [D@level_highest_natural_hard_constraint+1, review_daily_end,Slot]

:~ slot_area(Slot, review_daily_end),
    slot(Slot),
    span(Slot, (tuesday,16,2), D). [D@level_highest_soft_constraint-1,review_daily_end,Slot]

:~ slot_area(Slot, review_daily_end),
    slot(Slot),
    span(Slot, (thursday,17,2), D). [D@level_highest_soft_constraint-1,review_daily_end,Slot]


:~ slot_area(Slot, review_daily_start),
    slot(Slot),
    Slot = (Day, Hour, Quarterhour),
    span(Slot, (Day, 8, 1), D). [D@level_highest_soft_constraint-2,review_daily_start,Slot]

:~ slot_area(Slot, review_daily_end),
    slot(Slot),
    Slot = (Day, Hour, Quarterhour),
    span((Day, 16, 2), Slot, D). [D@level_highest_soft_constraint-3,review_daily_end,Slot]

:~ slot_area(Slot, pause),
    slot(Slot),
    Slot = (Day, Hour, Quarterhour),
    span(Slot, (Day, 11, 2), D). [D@level_highest_soft_constraint-4,pause,Slot]
:~ slot_area(Slot, pause),
    slot(Slot),
    Slot = (Day, Hour, Quarterhour),
    span((Day, 13,0), Slot,D). [D@level_highest_soft_constraint-4,pause,Slot]

:~ area(Area), area_fluid_gap(Area, Gap). [Gap@level_lowest_natural_soft_constraint-1,Area]

:~ slot_area(Slot, pause),
    slot(Slot),
    Slot = (Day, Hour, Quarterhour),
    span(Slot, (Day, 12, 2), D). [D@level_lowest_natural_soft_constraint-2,pause,Slot]
:~ slot_area(Slot, pause),
    slot(Slot),
    Slot = (Day, Hour, Quarterhour),
    span((Day, 13, 0), Slot, D). [D@level_lowest_natural_soft_constraint-2,pause,Slot]


__area_fluid_totalweeklyslots(P + C + I) :-
    __area_weeklyslots(pre_estimations, P),
    __area_weeklyslots(concepts, C),
    __area_weeklyslots(improvements, I).

__area_fluid_ispercentage(Area, (N * 100) / (T * 100)) :-
    __area_weeklyslots(Area, N),
    __area_fluid_totalweeklyslots(T).

__area_fluid_shouldpercentage(pre_estimations, 5000).
__area_fluid_shouldpercentage(concepts, 3333).
__area_fluid_shouldpercentage(concepts, 1667).

area_fluid_gap(Area, P - Q) :-
    __area_fluid_ispercentage(Area, P),
    __area_fluid_shouldpercentage(Area,Q),
    P < Q.

area_fluid_gap(Area, Q - P) :-
    __area_fluid_ispercentage(Area, P),
    __area_fluid_shouldpercentage(Area,Q),
    P > Q.

