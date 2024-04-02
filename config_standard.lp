
area(preestimations).
area(concepts).

area(meeting_devc).
area(meeting_triage).
area(meeting_featureeval).

area(review_daily_start).
area(review_daily_end).
area(review_weekly).


area_minquarterhours(review_daily_start, 10).
area_maxquarterhours(review_daily_start, 10).

area_minquarterhours(review_daily_end, 5).
area_maxquarterhours(review_daily_end, 5).

area_minquarterhours(meeting_devc, 4).
area_maxquarterhours(meeting_devc, 4).

% Monday=0, Tuesday=1, Wednesday=2, Thursday=3, Friday=4
%:- not quarterhours(154).

:- not slot_area((2,10,1), meeting_devc).
:- not slot_area((2,10,2), meeting_devc).
:- not slot_area((2,10,3), meeting_devc).
:- not slot_area((2,11,0), meeting_devc).

%:- slot_area(LastSlot, review_daily_end),
%    later(LastSlot,LaterSlot),
%    slot_area(LaterSlot,_).

%:- slot_area(FirstSlot, review_daily_start),
%    later(EarlierSlot, FirstSlot),
%    slot_area(EarlierSlot,_).

%:- not gequarterhours_slot_area(2,(0,18,3),review_daily_start).
%:- not gequarterhours_slot_area(4,(1,18,3),review_daily_start).