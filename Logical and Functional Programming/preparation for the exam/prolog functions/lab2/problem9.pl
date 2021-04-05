cls :- write('\33\[2J').

% 9.
% a. For a list of integer number, write a predicate to add in list after 1-st, 3-rd, 7-th, 15-th element a given value
% e.
% b. For a heterogeneous list, formed from integer numbers and list of numbers; add in every sublist after 1-st,
% 3-rd, 7-th, 15-th element the value found before the sublist in the heterogenous list. The list has the particularity
% that starts with a number and there aren’t two consecutive elements lists.
% Eg.: [1, [2, 3], 7, [4, 1, 4], 3, 6, [7, 5, 1, 3, 9, 8, 2, 7], 5] =>
% [1, [2, 1, 3], 7, [4, 7, 1, 4, 7], 3, 6, [7, 6, 5, 1, 6, 3, 9, 8, 2, 6, 7], 5].

% a)

add_after([],_,_,_,[]).
add_after([H|T],El,CPos,WPos,[H,El|Rez]):-
    CPos =:= WPos,!,
    CPos1 is CPos + 1,
    WPos1 is WPos * 2 + 1,
    add_after(T,El,CPos1,WPos1,Rez).
add_after([H|T],El,CPos,WPos,[H|Rez]):-
    CPos1 is CPos + 1,
    add_after(T,El,CPos1,WPos,Rez).

% b)

heter_subst([],[]).
heter_subst([H1,H2|T],[H1,Rez1|Rez]):-
    is_list(H2),!,
    add_after(H2,H1,1,1,Rez1),
    heter_subst(T,Rez).
heter_subst([H|T],[H|Rez]):-
    heter_subst(T,Rez).






























