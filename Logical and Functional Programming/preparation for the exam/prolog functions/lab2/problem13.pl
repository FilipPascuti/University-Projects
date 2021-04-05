cls :- write('\33\[2J').

% 13.
% a. Given a linear numerical list write a predicate to remove all sequences of consecutive values.
% Eg.: remove([1, 2, 4, 6, 7, 8, 10], L) will produce L=[4, 10].
% b. For a heterogeneous list, formed from integer numbers and list of numbers; write a predicate to delete from
% every sublist all sequences of consecutive values.
% Eg.: [1, [2, 3, 5], 9, [1, 2, 4, 3, 4, 5, 7, 9], 11, [5, 8, 2], 7] =>
% [1, [5], 9, [4, 7, 9], 11, [5, 8, 2], 7] 

% a)

removeInc([], []).
removeInc([H], [H]).
removeInc([H1,H2], []):- H1 is H2 - 1,!.
removeInc([H1,H2,H3|T], R):-
    H1 is H2 - 1,
    H2 is H3 - 1,!,
    removeInc([H2,H3|T], R).
removeInc([H1,H2,H3|T], R):-
    H1 is H2 - 1,
    not(H3 is H2 - 1),!,
    removeInc([H3|T], R).
removeInc([H1,H2|T], [H1|R]):-
    not(H1 is H2 - 1),!,
    removeInc([H2|T], R).





























