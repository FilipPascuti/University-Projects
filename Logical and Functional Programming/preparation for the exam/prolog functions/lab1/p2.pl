cls :- write('\33\[2J').

% 2.
% a. Write a predicate to remove all occurrences of a
% certain atom from a list.
% b. Define a predicate to produce a list of pairs 
% (atom n) from an initial list of atoms. In this 
% initial list atom has n occurrences.
% Eg.: numberatom([1, 2, 1, 2, 1, 3, 1], X) => 
% X = [[1, 4], [2, 2], [3, 1]].

%Solutins:
%a)
%remove_el(L:initial list, El:element to be removed, R: the resulting list)

remove_el([],_,[]).
remove_el([H|T],El,R):- 
    El =:= H,!,
    remove_el(T,El,R).
remove_el([H|T],El,[H|R]):-
    remove_el(T,El,R).

% b)

contains(E,[[E|_]|_]):-!.
contains(E,[_|T]):-contains(E,T).

insert(L,Val,R):- R = [[Val,1]|L].

increment([],_,[]).
increment([[H,T1]|T2],El,R):-
    H is El,!,
    increment(T2,El,R1),
    Val is T1 + 1,
    R = [[H,Val]|R1].
increment([[H,T1]|T2],El,[[H,T1]|R]):-
    increment(T2,El,R).

create_map([],Rez,Rez).
create_map([H|T],R,Rez):-
    contains(H,R),!,
    increment(R,H,R1),
    create_map(T,R1,Rez).
create_map([H|T],R,Rez):-
    insert(R,H,R1),
    create_map(T,R1,Rez).












