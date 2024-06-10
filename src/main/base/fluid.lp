#const fluidbuffer=2.

__minpreplannedweekly_quarterhours(N) :-
    N = #sum {
        M, Area :
            area_weeklyminquarterhours(Area, M),
            not fluidarea_weight(Area, _)
    }.

__maxpreplannedweekly_quarterhours(N) :-
    N = #sum {
        M, Area :
            area_weeklymaxquarterhours(Area, M),
            not fluidarea_weight(Area, _)
    }.

area_weeklyminquarterhours(Area, Quarterhours) :-
    fluidarea_weight(Area, Weight),
    weeklyminquarterhours(All),
    __minpreplannedweekly_quarterhours(Preplanned),
    Available = All-Preplanned,
    fluidareastotalweight(TotalWeights),
    Quarterhours = ((Available*Weight)/TotalWeights)-fluidbuffer.

area_weeklymaxquarterhours(Area, Quarterhours) :-
    fluidarea_weight(Area, Weight),
    weeklymaxquarterhours(All),
    __maxpreplannedweekly_quarterhours(Preplanned),
    Available = All-Preplanned,
    fluidareastotalweight(TotalWeights),
    Quarterhours = ((Available*Weight)/TotalWeights)+fluidbuffer.
