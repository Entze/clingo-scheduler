
%%% beginarea_not_present

__beginarea_present(Day) :-
    day(Day),
    area(Area), beginarea(Area),
    slot(Slot),
    Slot = (Day,Hour,Quarterhour),
    slot_area(Slot,Area).

#minimize {
    scale_beginarea_not_present@level_beginarea_not_present,Day:
        day(Day),
        not __beginarea_present(Day)
    }.

%%% endarea_not_present

__endarea_present(Day) :-
    day(Day),
    area(Area), endarea(Area),
    slot(Slot),
    Slot = (Day,Hour,Quarterhour),
    slot_area(Slot,Area).

#minimize {
    scale_endarea_not_present@level_endarea_not_present,Day:
        day(Day),
        not __endarea_present(Day)
    }.

%%% beginarea_not_first

#minimize {
    scale_beginarea_not_first@level_beginarea_not_first,Day:
        day(Day),
        FirstSlot = (Day,Hour,Quarterhour),
        slot(EarlierSlot), slot(FirstSlot), lt(EarlierSlot,FirstSlot),
        area(BeginArea), area(NotBeginArea),
        beginarea(BeginArea), not beginarea(NotBeginArea),
        slot_area(FirstSlot,BeginArea), slot_area(EarlierSlot,NotBeginArea)
    }.

%%% endarea_not_last

#minimize {
    scale_endarea_not_last@level_endarea_not_last,Day:
        day(Day),
        LastSlot = (Day,Hour,Quarterhour),
        slot(LastSlot), slot(LaterSlot), lt(LastSlot,LaterSlot),
        area(EndArea), area(NotEndArea),
        endarea(EndArea), not endarea(NotEndArea),
        slot_area(LastSlot,EndArea), slot_area(LaterSlot,NotEndArea)
    }.

%%% coretimeslot_absent

#minimize {
    scale_coretimeslot_absent@level_coretimeslot_absent,Slot:
        slot(Slot),
        coretimeslot(Slot),
        not slot_area(Slot, _)
}.

%%% overbooked

#minimize {
    (N-M)*scale_overbooked@level_overbooked:
        weeklymaxquarterhours(M),
        gequarterhours(N),
        N > M
}.

%%% underbooked

#minimize {
    (M-N)*scale_underbooked@level_underbooked:
        weeklyminquarterhours(M),
        lequarterhours(N),
        N < M
}.

%%% area_day_overbooked


#minimize {
    (N-M)*scale_area_day_overbooked@level_area_day_overbooked,Area,Day:
        area(Area), day(Day),
        area_dailymaxquarterhours(Area,M),
        area_day_gequarterhours(Area,Day,N),
        N > M
    }.

%%% area_day_underbooked

#minimize {
    (M-N)*scale_area_day_underbooked@level_area_day_underbooked,Area,Day:
        area(Area), day(Day),
        area_dailyminquarterhours(Area,M),
        area_day_lequarterhours(Area,Day,N),
        N < M
    }.

%%% area_overbooked

#minimize {
    (N-M)*scale_area_overbooked@level_area_overbooked,Area:
        area(Area),
        area_gequarterhours(Area,N),
        area_weeklymaxquarterhours(Area,M),
        N > M
    }.

%%% area_underbooked

#minimize {
    (M-N)*scale_area_underbooked@level_area_underbooked,Area :
        area(Area),
        area_lequarterhours(Area,N),
        area_weeklyminquarterhours(Area,M),
        N < M
    }.

%%% endarea_too_late

#minimize {
    N*scale_endarea_too_late@level_endarea_too_late,Day:
        day(Day),
        area(EndArea), endarea(EndArea),
        slot(EndSlot), EndSlot = (Day,Hour2,Quarterhour2),
        slot(FirstSlot), min(FirstSlot), FirstSlot = (Day,Hour1,Quarterhour1),
        slot_area(EndSlot,EndArea),
        span(FirstSlot,EndSlot,N),
        N > 0
}.

%%% beginarea_too_early

#minimize {
    N*scale_beginarea_too_early@level_beginarea_too_early,Day:
        day(Day),
        area(BeginArea), beginarea(BeginArea),
        slot(StartSlot), StartSlot = (Day,Hour1,Quarterhour1),
        slot(LastSlot), max(LastSlot), LastSlot = (Day,Hour2,Quarterhour2),
        slot_area(StartSlot, BeginArea),
        span(StartSlot, LastSlot, N),
        N > 0
}.

%%% area_day_context_saturation

#minimize {
    (N-M)*scale_area_day_context_saturation@level_area_day_context_saturation,Area,Day:
        area(Area), day(Day),
        area_day_gecontextwindow(Area,Day,N),
        area_blockmaxquarterhours(Area,M),
        N > M
}.


%%% area_day_context_fragmentation

__area_untilslot_fragmentationindicator(Area,Slot,Min-1) :-
    area(Area), slot(Slot),
    slot_area(Slot,Area),
    area_blockminquarterhours(Area,Min).
__area_untilslot_fragmentationindicator(Area,Slot,N-1) :-
    area(Area), slot(Slot),
    slot(Pred), succ(Pred,Slot),
    slot_area(Slot,Area),
    __area_untilslot_fragmentationindicator(Area,Pred,N).

__area_fragmentationslot(Area,Slot) :-
    area(Area), slot(Slot),
    slot_area(Slot,Area),
    slot(Succ), succ(Slot,Succ),
    not slot_area(Succ,Area),
    not __area_untilslot_fragmentationindicator(Area,Slot,0).

#minimize {
    scale_area_day_context_fragementation@level_area_day_context_fragmentation,Area,Slot:
        area(Area), slot(Slot),
        __area_fragmentationslot(Area,Slot)
}.
