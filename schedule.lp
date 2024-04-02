
weekday(0..4).
hour(6..19).
quarterhour(0..3).

slot((Weekday, Hour, Quarterhour)) :-
    weekday(Weekday), hour(Hour), quarterhour(Quarterhour).

succ(Slot1,Slot2) :-
    slot(Slot1), slot(Slot2),
    Slot1 = (Weekday, Hour, Quarterhour),
    Slot2 = (Weekday, Hour, Quarterhour + 1),
    weekday(Weekday), hour(Hour), quarterhour(Quarterhour),
    quarterhour(Quarterhour + 1).

later(Slot1, Slot2) :-
    slot(Slot1), slot(Slot2),
    Slot1 = (Weekday, Hour1, _),
    Slot2 = (Weekday, Hour2, _),
    Hour1 < Hour2.

later(Slot1, Slot2) :-
    slot(Slot1), slot(Slot2),
    Slot1 = (Weekday, Hour, Quarterhour1),
    Slot2 = (Weekday, Hour, Quarterhour2),
    Quarterhour1 < Quarterhour2.

succ(Slot1,Slot2) :-
    slot(Slot1), slot(Slot2),
    Slot1 = (Weekday, Hour, 3),
    Slot2 = (Weekday, Hour + 1, 0),
    weekday(Weekday), hour(Hour),
    hour(Hour + 1).

succ(Slot1,Slot2) :-
    slot(Slot1), slot(Slot2),
    Slot1 = (Weekday, 19, 3),
    Slot2 = (Weekday + 1, 6, 0),
    weekday(Weekday),
    weekday(Weekday + 1).

{ slot_area(Slot,Area) : area(Area) } 1 :- slot(Slot).

:- slot_area((0,6,0),_).
:- slot_area((4,19,3),_).

#show slot_area/2.
