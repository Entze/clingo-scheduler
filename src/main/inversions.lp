
%%% fixed_slots

#minimize {
    scale_fixed_slots@level_fixed_slots,Slot,Area:
        slot(Slot), area(Area),
        fixedslot_area(Slot,Area),
        not slot_area(Slot,Area)
}.

#minimize {
    scale_fixed_slots@level_fixed_slots,Slot,Area:
        slot(Slot), area(Area),
        fixedslot_area(_,Area),
        not fixedslot_area(Slot,Area),
        slot_area(Slot,Area)
}.

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
    scale_overbooked@level_overbooked,N-M:
        weeklymaxquarterhours(M),
        gequarterhours(N),
        N > M
}.

%%% underbooked

#minimize {
    scale_underbooked@level_underbooked,M-N:
        weeklyminquarterhours(M),
        lequarterhours(N),
        N < M
}.

%%% area_day_overbooked


#minimize {
    scale_area_day_overbooked@level_area_day_overbooked,Area,Day,N-M:
        area(Area), day(Day),
        area_dailymaxquarterhours(Area,M),
        area_day_gequarterhours(Area,Day,N),
        N > M
    }.

%%% area_day_underbooked

#minimize {
    scale_area_day_underbooked@level_area_day_underbooked,Area,Day,M-N:
        area(Area), day(Day),
        area_dailyminquarterhours(Area,M),
        area_day_lequarterhours(Area,Day,N),
        N < M
    }.

%%% area_overbooked

#minimize {
    scale_area_overbooked@level_area_overbooked,Area,N-M:
        area(Area),
        area_gequarterhours(Area,N),
        area_weeklymaxquarterhours(Area,M),
        N > M
    }.

%%% area_underbooked

#minimize {
    scale_area_underbooked@level_area_underbooked,Area,M-N:
        area(Area),
        area_lequarterhours(Area,N),
        area_weeklyminquarterhours(Area,M),
        N < M
    }.

%%% endarea_too_late

__firstslot(Slot) :-
    slot(Slot),
    coretimeslot(Slot),
    slot(Pred), succ(Pred,Slot),
    not coretimeslot(Pred).
__firstslot(Slot) :-
    slot(Slot),
    not coretimeslot(_),
    max(Slot).
__lastslot(Slot) :-
    slot(Slot),
    coretimeslot(Slot),
    slot(Succ), succ(Slot,Succ),
    not coretimeslot(Succ).
__lastslot(Slot) :-
    slot(Slot),
    not coretimeslot(_),
    min(Slot).


#minimize {
    scale_endarea_too_late@level_endarea_too_late,EarlierSlot:
        day(Day),
        area(EndArea), endarea(EndArea),
        slot(EndSlot), EndSlot = (Day,Hour2,Quarterhour2),
        slot_area(EndSlot,EndArea),
        slot(LastSlot), __lastslot(LastSlot), LastSlot = (Day,Hour1,Quarterhour1),
        lt(LastSlot,EarlierSlot),
        lt(EarlierSlot,EndSlot)
}.

%%% beginarea_too_early

#minimize {
    scale_beginarea_too_early@level_beginarea_too_early,LaterSlot:
        day(Day),
        area(BeginArea), beginarea(BeginArea),
        slot(StartSlot), StartSlot = (Day,Hour1,Quarterhour1),
        slot_area(StartSlot, BeginArea),
        slot(FirstSlot), __firstslot(FirstSlot), FirstSlot = (Day,Hour2,Quarterhour2),
        lt(StartSlot,LaterSlot), lt(LaterSlot,FirstSlot)
}.

%%% area_day_context_saturation

#minimize {
    scale_area_day_context_saturation@level_area_day_context_saturation,Area,Day,N-M:
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
