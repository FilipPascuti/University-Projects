% a. Define a predicate to remove from a list all repetitive elements.
% Eg.: l=[1,2,1,4,1,3,4] => l=[2,3])
% b. Remove all occurrence of a maximum value from a list on integer numbers.

% member1(El:element, L:list)
% (i,i)
member1(El,[El|_]):-!.
member1(El,[_|T]):-member1(El,T).

% removeDup(L:initial list, R: resulting list)
% (i,o)

removeDup([],[]):-!.
removeDup([H|T],R):-
    member1(H,T),!,
    removeDup(T,R).
removeDup([H|T],[H|R]):-
    removeDup(T,R).

% findMax(L:initial list, C:current_max, R:result)
% (i,i,o)

findMax([],Rez,Rez).
findMax([H|T],C,R):-
    H > C,!,
    findMax(T,H,R).
findMax([_|T],C,R):-
    findMax(T,C,R).

findMaxWrapper([H|T],R):-findMax([H|T],H,R).

removeMax([],_,[]).
removeMax([H|T],H,R):-!,removeMax(T,H,R).
removeMax([H|T],C,[H|R]):-removeMax(T,C,R).

removeMaxWrapper(L,R):-
    findMaxWrapper(L,R1),
    removeMax(L,R1,R).



