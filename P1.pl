ta_slot_assignment([ta(HT,HN)|TT],RemTAs,Name):-
	HT = Name,
    HN1 is HN-1,
    HN1 >= 0,
	RemTAs = [ta(HT,HN1)|TT].
	
ta_slot_assignment([ta(HT,HTN)|TT],[ta(HT,HTN)|TR],Name):-
	HT \= Name,
	ta_slot_assignment(TT,TR,Name).

%Edone

comb(0,_,[]).
comb(N,L,[H|T]) :- 
   N > 0,
   comb_helper(H,L,Res), 
   N1 is N-1, 
   comb(N1,Res,T).

comb_helper(H,[H|T],T).
comb_helper(E,[_|T],Res):- 
   comb_helper(E,T,Res).


slot_assignment(LabsNum,TAs,RemTAs,Assignment):-
	comb(LabsNum,TAs,C),
    slot_assignment_helper(C,TAs,RemTAs,[],Assignment).

%slot_assignment_helper([],RemTAs,RemTAs,Assignment,Assignment).
slot_assignment_helper([],RemTAs,RemTAs,AssignmentAcc,Assignment):-
    permutation(AssignmentAcc,Assignment).
slot_assignment_helper([ta(Name,_)|T],TAs,RemTAs,AssignmentAcc,Assignment):-
    ta_slot_assignment(TAs,RemTAsNew,Name),
    append(AssignmentAcc,[Name],AssignmentAccNew),
    slot_assignment_helper(T,RemTAsNew,RemTAs,AssignmentAccNew,Assignment).

%DDone

max_slots_per_day([[],[],[],[],[]],_).
max_slots_per_day(DaySched,Max):-
    maxSlot_helper1(DaySched,TAs),
    maxSlot_helper2(TAs,DaySched,Max,App),
    max_list(App,MaxApp),
    MaxApp=<Max.

maxSlot_helper1([],[]).
maxSlot_helper1([H|T],TAs):- 
    maxSlot_helper1(T,L1),
    union(H,L1,TAs).
maxSlot_helper2([],_,_,[]).
maxSlot_helper2([H|T],DaySched,Max,App):-
    maxSlot_helper3(H,DaySched,Counter,Max),
    maxSlot_helper2(T,DaySched,Max,App1),
    App =[Counter|App1].
maxSlot_helper3(_,[],0,_).
maxSlot_helper3(E,[H|T],Count,Max):-
    member(E,H),!,
    maxSlot_helper3(E,T,Count1,Max),
    Count is Count1+1.
maxSlot_helper3(E,[H|T],Count,Max):-
    \+member(E,H),
    maxSlot_helper3(E,T,Count,Max). 

%Cdone

day_schedule(DaySlots,TAs,RemTAs,Assignment):-
    day_helper(DaySlots,TAs,RemTAs,[],Assignment).

day_helper([],TAs,TAs,Acc,Assignment):-reverse(Acc,Assignment).
day_helper([H|T],TAs,RemTAs,Acc,Assignment):-
    slot_assignment(H,TAs,RemTAs1,Assignment1),
    NAcc=[Assignment1|Acc],
    day_helper(T,RemTAs1,RemTAs,NAcc,Assignment).

%Bdone

week_schedule([],_,_,[]).
week_schedule([H|T],TAs,DayMax,WeekSched):-
    day_schedule(H,TAs,RemTAs,Assignment),
    max_slots_per_day(Assignment,DayMax),
    week_schedule(T,RemTAs,DayMax,WeekSched2),
    WeekSched=[Assignment|WeekSched2].

%Adone