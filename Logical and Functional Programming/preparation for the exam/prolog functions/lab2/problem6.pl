cls :- write('\33\[2J').

% 6.
% a. Determine the product of a number represented as digits in a list to a given digit.
% Eg.: [1 9 3 5 9 9] * 2 => [3 8 7 1 9 8]
% b. For a heterogeneous list, formed from integer numbers and list of numbers, write a predicate to replace
% every sublist with the position of the maximum element from that sublist.
% [1, [2, 3], [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>
% [1, [2], [1, 3], 3, 6, [2], 5, [1, 2, 3], 7]

% list_to_number(L:list, Col:partial result, Rez: the result)
% (i,i,o)

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

list_product(L, Number, Rez):-
    list_to_number(L, 0, N1),
    N2 is N1 * Number,
    number_to_list(N2, [], Rez).

% b)

find_max([], Rez, Rez).
find_max([H|T], Col, Rez):-
    H > Col,!,
    find_max(T, H, Rez).
find_max([_|T], Col, Rez):-
    find_max(T, Col, Rez).

build_max_pos([],_,_,[]).
build_max_pos([H|T],Pos,Max,[Pos|Rez]):-
    H =:= Max,!,
    Pos1 is Pos + 1,
    build_max_pos(T,Pos1,Max,Rez).
build_max_pos([_|T],Pos, Max,Rez):-
    Pos1 is Pos + 1,
    build_max_pos(T,Pos1, Max, Rez).

heter_subst([],[]).
heter_subst([H|T], [Rez1|Rez]):-
    is_list(H),!,
    find_max(H, -9999, Max),
    build_max_pos(H, 1, Max, Rez1),
    heter_subst(T,Rez).
heter_subst([H|T], [H|Rez]):-
    heter_subst(T,Rez).































