isonsameday_area_area(PreparationArea, Area) :-
    area(PreparationArea),
    area(Area),
    preparationarea_area(PreparationArea, Area).

isonsameday_area_area(Area, ReviewArea) :-
    area(Area),
    area(ReviewArea),
    reviewarea_area(ReviewArea, Area).

beforearea_area(PreparationArea, Area) :-
    area(PreparationArea),
    area(Area),
    preparationarea_area(PreparationArea, Area).

beforearea_area(Area, ReviewArea) :-
    area(Area),
    area(ReviewArea),
    reviewarea_area(ReviewArea, Area).
