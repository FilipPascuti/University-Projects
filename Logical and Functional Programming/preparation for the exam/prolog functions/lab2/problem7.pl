cls :- write('\33\[2J').

% 7.
% a. Determine the position of the maximal element of a linear list.
% Eg.: maxpos([10,14,12,13,14], L) produces L = [2,5].
% b. For a heterogeneous list, formed from integer numbers and list of numbers, replace every sublist with the
% position of the maximum element from that sublist.
% [1, [2, 3], [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>
% [1, [2], [1, 3], 3, 6, [2], 5, [1, 2, 3], 7]

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

find_max_pos(L,Rez):-
    find_max(L, -9999, Max),
    build_max_pos(L, 1, Max, Rez).

heter_subst()



















