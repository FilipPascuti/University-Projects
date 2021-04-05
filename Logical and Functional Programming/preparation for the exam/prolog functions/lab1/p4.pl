% 4.
% a. Write a predicate to determine the difference of two sets.
% b. Write a predicate to add value 1 after every even element from a list

% Solution
% a)
% diff(L:initial set1, M: initial set2, R:resulting set)
% (i,i,o) 
differ([],_,[]).
differ([H|T],M,R):-
    member(H,M),!,
    differ(T,M,R).
differ([H|T],M,[H|R]):-
    differ(T,M,R).

% b)
add_one([],[]).
add_one([H|T],[H,1|R]):-
    H mod 2 =:= 0,!,
    add_one(T,R).
add_one([H|T],[H|R]):-
    add_one(T,R).











