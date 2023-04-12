ta_slot_assignment([ta(HT,HN)|TT],RemTAs,Name):-
	HT = Name,
    HN1 is HN-1,
    HN1 >= 0,
	RemTAs = [ta(HT,HN1)|TT].
	
ta_slot_assignment([ta(HT,HTN)|TT],[ta(HT,HTN)|TR],Name):-
	HT \= Name,
	ta_slot_assignment(TT,TR,Name).

%Edone
slot_assignment(LabsNum,TAs,RemTAs,Assignment):-
	permutation(TAs,P),
	slot_assignment_helper(LabsNum,P,P,RemTAs,Assignment).
	
slot_assignment_helper(0,_,RemTAs,RemTAs,[]).	
	
slot_assignment_helper(LabsNum,TAs,RemTAsT,RemTAs,Assignment):-
	LabsNumNew is LabsNum-1,
	TAs = [ta(HN,_)|TTT],
	ta_slot_assignment(RemTAsT,RemTAsNEW,HN),
	slot_assignment_helper(LabsNumNew,TTT,RemTAsNEW,RemTAs,TAssignment),
	Assignment = [HN | TAssignment].
%DDone
max_slots_per_day(DaySched,Max):-
    maxSlot_helper1(DaySched,TAs),
    maxSlot_helper2(TAs,DaySched,Max).

maxSlot_helper1([],[]).
maxSlot_helper1([H|T],TAs):- 
    maxSlot_helper1(T,L1),
    union(H,L1,TAs).
maxSlot_helper2([],_,_).
maxSlot_helper2([H|T],DaySched,Max):-
    maxSlot_helper3(H,DaySched,0,Max),
    maxSlot_helper2(T,DaySched,Max).
maxSlot_helper3(_,[],_,_).
maxSlot_helper3(E,[H|T],Count,Max):-
    Count=<Max,
    member(E,H),!,
    Count1 is Count+1,
    maxSlot_helper3(E,T,Count1,Max).
maxSlot_helper3(E,[H|T],Count,Max):-
    Count=<Max,
    \+member(E,H),
    maxSlot_helper3(E,T,Count,Max).    
%Cdone