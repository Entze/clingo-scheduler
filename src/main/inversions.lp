
%%% beginarea_not_present

__inversion_beginarea_present(Day) :-
    day(Day),
    area(Area), beginarea(Area),
    slot(Slot),
    Slot = (Day, Hour, Quarterhour),
    slot_area(Slot, Area).
inversion(beginarea_not_present, (Day,)) :-
    day(Day),
    not __inversion_beginarea_present(Day).


%%% endarea_not_present

__inversion_endarea_present(Day) :-
    day(Day),
    area(Area), endarea(Area),
    slot(Slot),
    Slot = (Day, Hour, Quarterhour),
    slot_area(Slot, Area).
inversion(endarea_not_present, (Day,)) :-
    day(Day),
    not __inversion_endarea_present(Day).


%%% beginarea_not_first

inversion(beginarea_not_first, (Day,)) :-
    day(Day),
    FirstSlot = (Day, Hour, Quarterhour),
    slot(EarlierSlot), slot(FirstSlot), lt(EarlierSlot, FirstSlot),
    area(BeginArea), area(NotBeginArea), BeginArea != NotBeginArea,
    beginarea(BeginArea),
    slot_area(FirstSlot,BeginArea), slot_area(EarlierSlot,NotBeginArea).


%%% endarea_not_last

inversion(endarea_not_last, (Day,)) :-
    day(Day),
    LastSlot = (Day, Hour, Quarterhour),
    slot(LastSlot), slot(LaterSlot), lt(LastSlot, LaterSlot),
    area(EndArea), area(NotEndArea), EndArea != NotEndArea,
    endarea(EndArea),
    slot_area(LastSlot,EndArea), slot_area(LaterSlot,NotEndArea).


%%% area_day_overbooked


inversion(area_day_overbooked, (Area,Day,N)) :-
    area(Area), day(Day),
    area_dailymaxquarterhours(Area, M),
    area_day_gequarterhours(Area,Day,N),
    N > M.


%%% area_day_underbooked


inversion(area_day_underbooked, (Area,Day,N)) :-
    area(Area), day(Day),
    area_dailyminquarterhours(Area,M),
    area_day_lequarterhours(Area,Day,N),
    N < M.


%%% coretimeslot_absent

inversion(coretimeslot_absent, (Slot,)) :-
    slot(Slot),
    coretimeslot(Slot),
    not slot_area(Slot, _).


%%% context_switch

inversion(context_switch, (Slot1,Slot2)) :-
    slot(Slot1), slot(Slot2),
    area(Area1), area(Area2), Area1 != Area2,
    succ(Slot1,Slot2),
    slot_area(Slot1, Area1), slot_area(Slot2, Area2).


%%% overbooked_weekly_quarterhours

__inversion_untilslot_gequarterhours(MinSlot, 0) :-
    slot(MinSlot), min(MinSlot).
__inversion_untilslot_gequarterhours(Slot, N) :-
    slot(Slot),
    slot(Pred), succ(Pred,Slot),
    __inversion_untilslot_gequarterhours(Pred, N).
__inversion_untilslot_gequarterhours(MinSlot, N) :-
    slot(MinSlot), min(MinSlot),
    slot(MaxSlot), max(MaxSlot),
    MinSlot = (Day, Hour, Quarterhour),
    MaxSlot = (PredDay, PredHour, PredQuarterhour),
    succ(PredDay, Day),
    __inversion_untilslot_gequarterhours(MaxSlot, N).
__inversion_untilslot_gequarterhours(Slot, N+1) :-
    slot(Slot),
    slot(Pred), succ(Pred,Slot),
    slot_area(Slot, _),
    __inversion_untilslot_gequarterhours(Pred, N).

__inversion_weekly_gequarterhours(N) :-
    day(Day), max(Day),
    slot(Slot), max(Slot),
    Slot = (Day, Hour, Quarterhour),
    __inversion_untilslot_gequarterhours(Slot,N).

inversion(overbooked_weekly_quarterhours,(N,)) :-
    weeklymaxquarterhours(M),
    __inversion_weekly_gequarterhours(N),
    N > M.


%%% underbooked_weekly_quarterhours

__inversion_untilslot_lequarterhours(MinSlot, WeekSpan) :-
    slot(MinSlot), min(MinSlot),
    __weekspan(WeekSpan).
__inversion_untilslot_lequarterhours(Slot, N) :-
    slot(Slot),
    slot(Pred), succ(Pred,Slot),
    __inversion_untilslot_lequarterhours(Pred, N).
__inversion_untilslot_lequarterhours(MinSlot, N) :-
    slot(MinSlot), min(MinSlot),
    slot(MaxSlot), max(MaxSlot),
    MinSlot = (Day, Hour, Quarterhour),
    MaxSlot = (PredDay, PredHour, PredQuarterhour),
    succ(PredDay, Day),
    __inversion_untilslot_lequarterhours(MaxSlot, N).
__inversion_untilslot_lequarterhours(Slot, N-1) :-
    slot(Slot),
    slot(Pred), succ(Pred, Slot),
    not slot_area(Slot,_),
    __inversion_untilslot_lequarterhours(Pred, N).

__inversion_weekly_lequarterhours(N) :-
    day(Day), max(Day),
    slot(Slot), max(Slot),
    Slot = (Day, Hour, Quarterhour),
    __inversion_untilslot_lequarterhours(Slot, N).

inversion(underbooked_weekly_quarterhours,(N,)) :-
    weeklyminquarterhours(M),
    __inversion_weekly_lequarterhours(N),
    M > N.


%%% endarea_too_late

inversion(endarea_too_late, (Day, N)) :-
    day(Day),
    slot(LastSlot), slot(EarlierSlot),
    span(EarlierSlot, LastSlot, N),
    lt(EarlierSlot, LastSlot),
    area(Area), endarea(Area),
    LastSlot = (Day, Hour, Quarterhour),
    slot_area(LastSlot, Area).


%%% beginarea_too_early

inversion(beginarea_too_early, (Day, N)) :-
    day(Day),
    slot(FirstSlot), slot(LaterSlot),
    span(FirstSlot, LaterSlot, N),
    lt(FirstSlot, LaterSlot),
    area(Area), beginarea(Area),
    FirstSlot = (Day, Hour, Quarterhour),
    slot_area(FirstSlot, Area).

%%% area_overbooked

%TODO

%%% area_underbooked

%TODO

#show inversion/2.
