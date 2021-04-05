cls :- write('\33\[2J').
% 8.
% a. Determine the successor of a number represented as digits in a list.
% Eg.: [1 9 3 5 9 9] --> [1 9 3 6 0 0]
% b. For a heterogeneous list, formed from integer numbers and list of numbers, determine the successor of a
% sublist considered as a number.
% [1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] =>
% [1, [2, 4], 4, 5, [6, 8, 0], 10, 11, [1, 2, 1], 6]

list_to_number([],Rez,Rez).
list_to_number([H|T],Col,Rez):-
    Col1 is Col * 10 + H,
    list_to_number(T,Col1,Rez).

% list_to_number(L:initial number, Col:partial result, Rez: the result)
% (i,i,o)
number_to_list(0, Rez, Rez):-!.
number_to_list(N, Col,Rez):-
    Rest is N mod 10,
    N1 is N//10,
    Col1 = [Rest|Col],
    number_to_list(N1, Col1, Rez).

% a)

list_successor(L, Rez):-
    list_to_number(L, 0, N1),
    N2 is N1 + 1,
    number_to_list(N2, [], Rez).

% b)

heter_successor([],[]).
heter_successor([H|T],[Rez1|Rez]):-
    is_list(H),!,
    list_successor(H, Rez1),
    heter_successor(T, Rez).
heter_successor([H|T],[H|Rez]):-
    heter_successor(T, Rez).


























