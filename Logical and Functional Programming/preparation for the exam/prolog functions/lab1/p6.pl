% 6.
% a. Write a predicate to test if a list is a set.
% b. Write a predicate to remove the first three occurrences of an element in a list. If the element occurs less
% than three times, all occurrences will be removed.

% a)
is_set([]).
is_set([H|T]):-
    not(member(H,T)),!,
    is_set(T).

% b)
removeOcc([],_,_,[]).
removeOcc([H|T],H,Occ,R):-
    Occ < 3,!,
    Occ1 is Occ + 1,
    removeOcc(T,H,Occ1,R).
removeOcc([H|T],C,Occ,[H|R]):-
    removeOcc(T,C,Occ,R).









