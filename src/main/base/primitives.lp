day(monday). day(tuesday). day(wednesday). day(thursday). day(friday). succ(monday, tuesday). succ(tuesday, wednesday). succ(wednesday, thursday). succ(thursday, friday). hour(7..18).

succ(H, H+1) :-
    hour(H),
    hour(H+1).

quarterhour(0..3).

succ(Q, Q+1) :-
    quarterhour(Q),
    quarterhour(Q+1).

slot((Day, Hour, Quarterhour)) :-
    day(Day),
    hour(Hour),
    quarterhour(Quarterhour).

succ(Slot1, Slot2) :-
    slot(Slot1),
    slot(Slot2),
    Slot1 = (Day, Hour, Quarterhour),
    Slot2 = (Day, Hour, Quarterhour+1),
    quarterhour(Quarterhour),
    quarterhour(Quarterhour+1).

succ(Slot1, Slot2) :-
    slot(Slot1),
    slot(Slot2),
    Slot1 = (Day, Hour, 3),
    Slot2 = (Day, Hour+1, 0),
    hour(Hour),
    hour(Hour+1).

min(A) :-
    succ(A, _),
    not succ(_, A).

max(B) :-
    succ(_, B),
    not succ(B, _).

lt(A, B) :-
    succ(A, B).

lt(A, C) :-
    succ(A, B),
    lt(B, C).

gt(B, A) :-
    succ(A, B).

gt(C, A) :-
    succ(A, B),
    gt(C, B).

span(A, A, 0) :-
    succ(A, _).

span(B, B, 0) :-
    succ(_, B).

span(A, B, 1) :-
    succ(A, B).

span(A, C, N+1) :-
    succ(A, B),
    span(B, C, N).

day_span(Day, N) :-
    day(Day),
    slot(Slot1),
    Slot1 = (Day, Hour1, Quarterhour1),
    min(Slot1),
    slot(Slot2),
    Slot2 = (Day, Hour2, Quarterhour2),
    max(Slot2),
    span(Slot1, Slot2, N).

fluidareastotalweight(Total) :-
    Total = #sum {
        Weight, Area :
            fluidarea_weight(Area, Weight)
    }.
