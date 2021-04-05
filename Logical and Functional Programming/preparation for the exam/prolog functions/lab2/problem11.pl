cls :- write('\33\[2J').

% 11.
% a. Replace all occurrences of an element from a list with another element e.
% b. For a heterogeneous list, formed from integer numbers and list of numbers, define a predicate to determine
% the maximum number of the list, and then to replace this value in sublists with the maximum value of sublist.
% Eg.: [1, [2, 5, 7], 4, 5, [1, 4], 3, [1, 3, 5, 8, 5, 4], 5, [5, 9, 1], 2] =>
% [1, [2, 7, 7], 4, 5, [1, 4], 3, [1, 3, 8, 8, 8, 4], 5, [9, 9, 1], 2]

% a)

replace_occurence([],_,_,[]).
replace_occurence([H|T],H,Other,[Other|Rez]):-
    !,replace_occurence(T,H,Other,Rez).
replace_occurence([H|T], El, Other, [H|Rez]):-
    replace_occurence(T,El,Other,Rez).

% b)

find_max([], Rez, Rez).
find_max([H|T], Col, Rez):-
    number(H),
    H > Col,!,
    find_max(T, H, Rez).
find_max([_|T], Col, Rez):-
    find_max(T, Col, Rez).

heter_subst([],_,[]).
heter_subst([H|T],Max,[Rez1|Rez]):-
    is_list(H),!,
    find_max(H, -9999, Local_max),
    replace_occurence(H,Max,Local_max,Rez1),
    heter_subst(T,Max,Rez).
heter_subst([H|T],Max,[H|Rez]):-
    heter_subst(T,Max,Rez).

heter_subst_wrapper(L,Rez):-
    find_max(L, -9999, Max),
    heter_subst(L,Max,Rez).
























