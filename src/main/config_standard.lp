

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
area_weeklyminquarterhours(review_daily_start, 10).
area_weeklymaxquarterhours(review_daily_start, 10).

area_dailyminquarterhours(review_daily_end, 1).
area_dailymaxquarterhours(review_daily_end, 1).
area_weeklyminquarterhours(review_daily_end, 5).
area_weeklymaxquarterhours(review_daily_end, 5).

area_dailyminquarterhours(pause, 2).
area_dailymaxquarterhours(pause, 2).
area_weeklyminquarterhours(pause, 10).
area_weeklymaxquarterhours(pause, 10).

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

__minpreplannedweekly_quarterhours(
    Review_daily_start +
    Review_daily_end +
    Pause +
    Meeting_devc +
    Meeting_triage +
    Meeting_feature_eval
) :-
    area_weeklyminquarterhours(review_daily_start, Review_daily_start),
    area_weeklyminquarterhours(review_daily_end, Review_daily_end),
    area_weeklyminquarterhours(pause, Pause),
    area_weeklyminquarterhours(meeting_devc, Meeting_devc),
    area_weeklyminquarterhours(meeting_triage, Meeting_triage),
    area_weeklyminquarterhours(meeting_feature_eval, Meeting_feature_eval).

__maxpreplannedweekly_quarterhours(
    Review_daily_start +
    Review_daily_end +
    Pause +
    Meeting_devc +
    Meeting_triage +
    Meeting_feature_eval
) :-
    area_weeklymaxquarterhours(review_daily_start, Review_daily_start),
    area_weeklymaxquarterhours(review_daily_end, Review_daily_end),
    area_weeklymaxquarterhours(pause, Pause),
    area_weeklymaxquarterhours(meeting_devc, Meeting_devc),
    area_weeklymaxquarterhours(meeting_triage, Meeting_triage),
    area_weeklymaxquarterhours(meeting_feature_eval, Meeting_feature_eval).

fluidarea_weight(pre_estimations, 5).
fluidarea_weight(concepts, 3).
fluidarea_weight(improvements, 2).

#const fluidbuffer = 2.

area_weeklyminquarterhours(Area, Quarterhours) :-
    fluidarea_weight(Area, Weight),
    weeklyminquarterhours(All),
    __minpreplannedweekly_quarterhours(Preplanned),
    Available = All - Preplanned,
    fluidareastotalweight(TotalWeights),
    Quarterhours = ((Available * Weight) / TotalWeights) - fluidbuffer.

area_weeklymaxquarterhours(Area, Quarterhours) :-
    fluidarea_weight(Area, Weight),
    weeklymaxquarterhours(All),
    __maxpreplannedweekly_quarterhours(Preplanned),
    Available = All - Preplanned,
    fluidareastotalweight(TotalWeights),
    Quarterhours = (Available * Weight) / TotalWeights + fluidbuffer.

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

:~ slot_area(Slot, pause),
    slot(Slot),
    Slot = (Day, Hour, Quarterhour),
    span(Slot, (Day, 12, 2), D). [D@level_lowest_natural_soft_constraint-1,pause,Slot]
:~ slot_area(Slot, pause),
    slot(Slot),
    Slot = (Day, Hour, Quarterhour),
    span((Day, 13, 0), Slot, D). [D@level_lowest_natural_soft_constraint-1,pause,Slot]
