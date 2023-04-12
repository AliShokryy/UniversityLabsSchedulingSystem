
















%Hello
% e)

ta_slot_assignment([ta(HT,HN)|TT],RemTAs,Name):-
	HT = Name,!,
    HN1 is HN-1,
    HN1 >= 0,
	RemTAs = [ta(HT,HN1)|TT].
	
ta_slot_assignment([ta(HT,_)|TT],[HT|TR],Name):-
	HT \= Name,!,
	ta_slot_assignment(TT,TR,Name).

