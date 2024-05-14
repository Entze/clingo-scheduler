
%% area_untilslot_gequarterhours/3
% Describes how many times(2) has Area(0) been allocated _at least_ up to this
% Slot(1) (inclusive).

area_untilslot_gequarterhours(Area,MinSlot,0) :-
    area(Area), slot(MinSlot),
    min(MinSlot).
area_untilslot_gequarterhours(Area,Slot,N) :-
    area(Area), slot(Slot),
    slot(Pred),
    succ(Pred, Slot),
    area_untilslot_gequarterhours(Area,Pred,N).
area_untilslot_gequarterhours(Area,Slot,N+1) :-
    area(Area), slot(Slot), slot(Pred),
    succ(Pred, Slot),
    slot_area(Slot,Area),
    area_untilslot_gequarterhours(Area,Pred,N).


%% area_day_gequarterhours/3
% Describes how many times(2) has Area(0) been allocated _at least_ on this
% Day(1).

area_day_gequarterhours(Area, Day, N) :-
    area(Area), day(Day),
    slot(Slot), Slot = (Day,Hour,Quarterhour),
    area_untilslot_gequarterhours(Area,Slot,N).


%% area_untilday_gequarterhours/3
% Describes how many times(2) has Area(0) been allocated _at least_ up to this
% Day(1) (inclusive).

area_untilday_gequartershours(Area,MinDay,N) :-
    area(Area), day(MinDay),
    min(MinDay),
    area_day_gequarterhours(Area,MinDay,N).
area_untilday_gequartershours(Area,Day,N+M) :-
    area(Area), day(Day),
    day(Pred),
    succ(Pred, Day),
    area_day_gequarterhours(Area,Day,M),
    area_untilday_gequartershours(Area,Pred,N).


%% area_gequarterhours/2
% Describes how many times(1) has Area(0) been allocated _at least_ in this
% week.

area_gequarterhours(Area, N) :-
    area(Area),
    day(Day),
    area_untilday_gequartershours(Area,Day,N).


%% area_untilslot_lequarterhours/3
% Describes how many times(2) has Area(0) been allocated _at most_ up to this
% Slot(1) (inclusive).

area_untilslot_lequarterhours(Area,MinSlot,Span) :-
    area(Area), slot(MinSlot), min(MinSlot),
    slot(MaxSlot), max(MaxSlot),
    span(MinSlot,MaxSlot,Span).
area_untilslot_lequarterhours(Area,Slot,N) :-
    area(Area), slot(Slot),
    slot(Pred), succ(Pred, Slot),
    area_untilslot_lequarterhours(Area,Pred,N).
area_untilslot_lequarterhours(Area,Slot,N-1) :-
    area(Area), slot(Slot),
    slot(Slot), succ(Pred,Slot),
    not slot_area(Slot,Area),
    area_untilslot_lequarterhours(Area,Pred,N).


%% area_day_lequarterhours/3
% Describes how many times(2) has Area(0) been allocated _at most_ on this
% Day(1).

area_day_lequarterhours(Area,Day,N) :-
    area(Area), day(Day),
    slot(Slot), Slot = (Day,Hour,Quarterhour),
    area_untilslot_lequarterhours(Area,Slot,N).


%% area_day_lequarterhours/3
% Describes how many times(2) has Area(0) been allocated _at most_ up to this
% Day(1) (inclusive).

area_untilday_lequarterhours(Area,MinDay,N) :-
    area(Area), day(MinDay),
    min(MinDay),
    area_day_lequarterhours(Area,MinDay,N).
area_untilday_lequarterhours(Area,Day,N+M) :-
    area(Area), day(Day),
    day(Pred), succ(Pred, Day),
    area_day_lequarterhours(Area,Day,M),
    area_untilday_lequarterhours(Area,Pred,N).


%% area_lequarterhours/2
% Describes how many times(1) has Area(0) been allocated _at most_ in this
% week.

area_lequarterhours(Area,N) :-
    area(Area),
    day(Day), max(Day),
    area_untilday_lequarterhours(Area,Day,N).


%% area_day_quarterhours/3
% Describes how many times(2) has Area(0) been allocated on this Day(1).

%area_day_quarterhours(Area,Day,N) :-
%    area(Area), day(Day),
%    area_day_lequarterhours(Area,Day,N),
%    area_day_gequarterhours(Area,Day,N).


%% area_quarterhours/2
% Describes how many times(1) has Area(0) been allocated in this week.

%area_quarterhours(Area,N) :-
%    area(Area),
%    area_gequarterhours(Area, N),
%    area_lequarterhours(Area, N).

%% untilslot_gequarterhours/2
% Describes how many times(1) has any area been allocated _at least_ up to
% this Slot(0).

untilslot_gequarterhours(MinSlot,0) :-
    slot(MinSlot),
    min(MinSlot).
untilslot_gequarterhours(Slot,N) :-
    slot(Slot),
    slot(Pred), succ(Pred,Slot),
    untilslot_gequarterhours(Pred,N).
untilslot_gequarterhours(Slot,N+1) :-
    slot(Slot),
    slot(Pred), succ(Pred,Slot),
    slot_area(Slot,_),
    untilslot_gequarterhours(Pred,N).

%% day_gequarterhours/2
% Describes how many times(1) has any area been allocated _at least_ on this
% Day(0).

day_gequarterhours(Day,N) :-
    day(Day),
    slot(Slot), Slot = (Day,Hour,Quarterhour),
    untilslot_gequarterhours(Slot,N).


%% untilday_gequarterhours/2
% Describes how many times(1) has any area been allocated _at least_ up to this
% Day(0).

untilday_gequarterhours(MinDay,N) :-
    day(MinDay),
    min(MinDay),
    day_gequarterhours(MinDay,N).
untilday_gequarterhours(Day,N+M) :-
    day(Day),
    day(Pred), succ(Pred,Day),
    day_gequarterhours(Day,M),
    untilday_gequarterhours(Pred,N).

%% gequarterhours/1
% Describes how many times(0) has any area been allocated _at least_ in this
% week.

gequarterhours(N) :-
    day(Day),
    untilday_gequarterhours(Day, N).


%% untilslot_lequarterhours/2
% Describes how many times(1) has any area been allocated _at least_ up to
% this Slot(0).

untilslot_lequarterhours(MinSlot,Span) :-
    slot(MinSlot), min(MinSlot),
    slot(MaxSlot), max(MaxSlot),
    MinSlot = (Day,Hour1,Quarterhour1),
    MaxSlot = (Day,Hour2,Quarterhour2),
    span(MinSlot,MaxSlot,Span).
untilslot_lequarterhours(Slot,N) :-
    slot(Slot),
    slot(Pred), succ(Pred,Slot),
    untilslot_lequarterhours(Pred,N).
untilslot_lequarterhours(Slot,N-1) :-
    slot(Slot),
    slot(Pred), succ(Pred,Slot),
    not slot_area(Slot,_),
    untilslot_lequarterhours(Pred,N).


%% day_lequarterhours/2
% Describes how many times(1) has any area been allocated _at most_ on this
% Day(0).

day_lequarterhours(Day,N) :-
    day(Day),
    slot(Slot), Slot = (Day,Hour,Quarterhour),
    untilslot_lequarterhours(Slot,N).


%% untilday_lequarterhours/2
% Describes how many times(1) has any area been allocated _at most_ up to this
% Day(0).

untilday_lequarterhours(MinDay,N) :-
    day(MinDay), min(MinDay),
    day_lequarterhours(MinDay,N).
untilday_lequarterhours(Day,N+M) :-
    day(Day),
    day(Pred), succ(Pred,Day),
    day_lequarterhours(Day,M),
    untilday_lequarterhours(Pred,N).

%% lequarterhours/1
% Describes how many times(0) has any area been allocated _at most_ in this
% week.

lequarterhours(N) :-
    day(MaxDay), max(MaxDay),
    untilday_lequarterhours(MaxDay, N).


%% quarterhours/1
% Describes how many times(0) any Area has been allocated in this week.

%quarterhours(N) :-
%    lequarterhours(N),
%    gequarterhours(N).


%% area_untilslot_gecontextwindow/3
% Describes how large(2) the context window for an Area(0) _at least_ until
% this Slot(1) is.

area_untilslot_gecontextwindow(Area,Slot,1) :-
    area(Area), slot(Slot),
    slot_area(Slot,Area).
area_untilslot_gecontextwindow(Area,Slot,N + 1) :-
    area(Area), slot(Slot),
    slot(Pred), succ(Pred,Slot),
    slot_area(Slot,Area),
    area_untilslot_gecontextwindow(Area,Pred,N).


%% area_day_gecontextwindow/3
% Describe how large(2) the largest context window for an Area(0) _at least_
% for this Day(1) is.

area_day_gecontextwindow(Area,Day,N) :-
    area(Area), day(Day),
    slot(Slot), Slot = (Day,Hour,Quarterhour),
    area_untilslot_gecontextwindow(Area,Slot,N).
