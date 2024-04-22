
day(monday). day(tuesday). day(wednesday). day(thursday). day(friday).
succ(monday, tuesday). succ(tuesday, wednesday). succ(wednesday, thursday). succ(thursday, friday).

hour(6..19).
succ(H, H+1) :-
    hour(H), hour(H+1).

quarterhour(0..3).
succ(Q, Q+1) :-
    quarterhour(Q), quarterhour(Q+1).

slot((Day, Hour, Quarterhour)) :-
    day(Day), hour(Hour), quarterhour(Quarterhour).

succ(Slot1, Slot2) :-
    slot(Slot1), slot(Slot2),
    Slot1 = (Day, Hour, Quarterhour),
    Slot2 = (Day, Hour, Quarterhour+1),
    quarterhour(Quarterhour), quarterhour(Quarterhour+1).

succ(Slot1, Slot2) :-
    slot(Slot1), slot(Slot2),
    Slot1 = (Day, Hour, 3),
    Slot2 = (Day, Hour + 1, 0),
    hour(Hour), hour(Hour + 1).

min(A) :-
    succ(A,_),
    not succ(_,A).

max(B) :-
    succ(_,B),
    not succ(B,_).

lt(A,B) :- succ(A,B).
lt(A,C) :- succ(A,B), lt(B,C).

gt(B,A) :- succ(A,B).
gt(C,A) :- succ(A,B), gt(C,B).

span(A, A, 0) :- succ(A,_).
span(B, B, 0) :- succ(B,_).
span(A, B, 1) :- succ(A,B).
span(A, C, N+1) :- succ(A,B), span(B,C,N).

__weekspan(W) :-
    W = #sum { Span,Day :
                        day(Day),
                        min(MinSlot), max(MaxSlot),
                        MinSlot = (Day, MinHour, MinQuarterhour),
                        MaxSlot = (Day, MaxHour, MaxQuarterhour),
                        span(MinSlot, MaxSlot, Span)
            }.

area_untilslot_gequarterhours(Area,Min,0) :-
    area(Area), slot(Min),
    min(Min).
area_untilslot_gequarterhours(Area,Slot,N) :-
    area(Area), slot(Slot), slot(Pred),
    succ(Pred, Slot),
    area_untilslot_gequarterhours(Area,Pred,N).
area_untilslot_gequarterhours(Area,Slot,N+1) :-
    area(Area), slot(Slot), slot(Pred),
    succ(Pred, Slot),
    slot_area(Slot,Area),
    area_untilslot_gequarterhours(Area,Pred,N).
area_day_gequarterhours(Area, Day, N) :-
    area(Area), day(Day),
    slot(Slot), max(Slot),
    Slot = (Day, Hour, Quarterhour),
    area_untilslot_gequarterhours(Area, Slot, N).

area_weeklyuntilslot_gequarterhours(Area, Min, 0) :-
    area(Area), slot(Min),
    Min = (Day, Hour, Quarterhour),
    min(Min), min(Day).
area_weeklyuntilslot_gequarterhours(Area, Slot, N) :-
    area(Area), slot(Slot),
    slot(Pred),
    succ(Pred, Slot),
    area_weeklyuntilslot_gequarterhours(Area, Pred, N).
area_weeklyuntilslot_gequarterhours(Area, Slot, N) :-
    area(Area), slot(Slot),
    Slot = (Day1, Hour1, Quarterhour1),
    slot(Pred),
    Pred = (Day2, Hour2, Quarterhour2),
    succ(Day1, Day2),
    min(Slot), max(Pred),
    area_weeklyuntilslot_gequarterhours(Area, Pred, N).
area_weeklyuntilslot_gequarterhours(Area, Slot, N+1) :-
    area(Area), slot(Slot),
    slot(Pred),
    succ(Pred, Slot),
    slot_area(Slot, Area),
    area_weeklyuntilslot_gequarterhours(Area, Pred, N).
area_weekly_gequarterhours(Area, N) :-
    area(Area), slot(Slot),
    max(Slot),
    Slot = (Day, Hour, Quarterhour),
    max(Day),
    area_weeklyuntilslot_gequarterhours(Area, Slot, N).

area_untilslot_lequarterhours(Area,MinSlot,Span) :-
    area(Area), slot(MinSlot), min(MinSlot),
    slot(MaxSlot), max(MaxSlot),
    span(MinSlot, MaxSlot, Span).
area_untilslot_lequarterhours(Area,Slot,N) :-
    area(Area), slot(Slot),
    slot(Pred), succ(Pred, Slot),
    area_untilslot_lequarterhours(Area,Pred,N).
area_untilslot_lequarterhours(Area,Slot,N-1) :-
    area(Area), slot(Slot),
    slot(Slot), succ(Pred, Slot),
    not slot_area(Slot, Area),
    area_untilslot_lequarterhours(Area,Pred,N).
area_day_lequarterhours(Area,Day,N) :-
    area(Area), day(Day),
    slot(Slot), max(Slot),
    Slot = (Day, Hour, Quarterhour),
    area_untilslot_lequarterhours(Area,Slot,N).

area_weeklyuntilslot_lequarterhours(Area, Min, Span) :-
    area(Area), slot(Min),
    Min = (Day, Hour, Quarterhour),
    __weekspan(Span),
    min(Min), min(Day).
area_weeklyuntilslot_lequarterhours(Area, Slot, N) :-
    area(Area), slot(Slot),
    slot(Pred),
    succ(Pred, Slot),
    area_weeklyuntilslot_lequarterhours(Area, Pred, N).
area_weeklyuntilslot_lequarterhours(Area, Slot, N) :-
    area(Area), slot(Slot),
    Slot = (Day1, Hour1, Quarterhour1),
    slot(Pred),
    Pred = (Day2, Hour2, Quarterhour2),
    succ(Day1, Day2),
    min(Slot), max(Pred),
    area_weeklyuntilslot_lequarterhours(Area, Pred, N).
area_weeklyuntilslot_lequarterhours(Area, Slot, N-1) :-
    area(Area), slot(Slot),
    slot(Pred),
    succ(Pred, Slot),
    slot_area(Slot, Area),
    area_weeklyuntilslot_lequarterhours(Area, Pred, N).
area_weekly_lequarterhours(Area, N) :-
    area(Area), slot(Slot),
    max(Slot),
    Slot = (Day, Hour, Quarterhour),
    max(Day),
    area_weeklyuntilslot_lequarterhours(Area, Slot, N).
