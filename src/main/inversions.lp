
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


inversion(area_day_overbooked,N-M,(Area,Day)) :-
    area(Area), day(Day),
    area_dailymaxquarterhours(Area,M),
    area_day_quarterhours(Area,Day,N),
    N > M.


%%% area_day_underbooked


inversion(area_day_underbooked,M-N,(Area,Day)) :-
    area(Area), day(Day),
    area_dailyminquarterhours(Area,M),
    area_day_quarterhours(Area,Day,N),
    N < M.


%%% coretimeslot_absent

inversion(coretimeslot_absent,(Slot,)) :-
    slot(Slot),
    coretimeslot(Slot),
    not slot_area(Slot, _).


%%% context_switch

inversion(context_switch,(Slot1,Slot2)) :-
    slot(Slot1), slot(Slot2),
    area(Area1), area(Area2), Area1 != Area2,
    succ(Slot1,Slot2),
    slot_area(Slot1,Area1), slot_area(Slot2,Area2).


%%% overbooked

inversion(overbooked,N-M,()) :-
    weeklymaxquarterhours(M),
    quarterhours(N),
    N > M.


%%% underbooked

inversion(underbooked,M-N,()) :-
    weeklyminquarterhours(M),
    quarterhours(N),
    M > N.


%%% endarea_too_late

inversion(endarea_too_late,N,(Day,)) :-
    day(Day),
    slot(EndSlot), slot(FirstSlot),
    min(FirstSlot),
    span(FirstSlot, EndSlot, N),
    N > 0,
    area(Area), endarea(Area),
    EndSlot = (Day,Hour,Quarterhour),
    slot_area(EndSlot, Area).


%%% beginarea_too_early

inversion(beginarea_too_early, N, (Day,)) :-
    day(Day),
    slot(StartSlot), slot(LastSlot),
    max(LastSlot),
    span(StartSlot, LastSlot, N),
    N > 0,
    area(Area), beginarea(Area),
    StartSlot = (Day,Hour,Quarterhour),
    slot_area(StartSlot, Area).

%%% area_overbooked

inversion(area_overbooked,N-M,(Area,)) :-
    area(Area),
    area_quarterhours(Area,N),
    area_weeklymaxquarterhours(Area,M),
    N > M.

%%% area_underbooked

inversion(area_underbooked,M-N,(Area,)) :-
    area(Area),
    area_quarterhours(Area,N),
    area_weeklyminquarterhours(Area,M),
    N < M.

#show inversion/2.
#show inversion/3.
