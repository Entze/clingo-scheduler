0{
    slot_area(Slot, Area) :
        area(Area)
}1 :-
    slot(Slot).

 :- slot_area(Min, _),
    slot(Min),
    min(Min).

 :- slot_area(Max, _),
    slot(Max),
    max(Max).

#show slot_area/2.
