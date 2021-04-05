cls :- write('\33\[2J').

% 5.
% a. Substitute all occurrences of an element of a list with all the elements of another list.
% Eg. subst([1,2,1,3,1,4],1,[10,11],X) produces X=[10,11,2,10,11,3,10,11,4].
% b. For a heterogeneous list, formed from integer numbers and list of numbers, replace in every sublist all
% occurrences of the first element from sublist it a new given list.
% Eg.: [1, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] si [11, 11] =>
% [1, [11, 11, 1, 11, 11], 3, 6, [11, 11, 10, 1, 3, 9], 5, [11 11 11 11 11 11], 7]

concatenate([],L2,L2).
concatenate([H|T], L2, [H|Rez]):-
    concatenate(T,L2,Rez).

% a)
subst([],_,_,[]).
subst([H|T], El, Substitute, Rez):-
    H =:= El,!,
    subst(T,El,Substitute, Rez1),
    concatenate(Substitute, Rez1, Rez2),
    Rez = Rez2.
subst([H|T], El, Substitute, [H|Rez]):-
    subst(T,El,Substitute, Rez).

% b)
heter_subst([],_,[]).
heter_subst([H|T],Substitute, [Rez1|Rez]):-
    is_list(H),!,
    H = [A|_],
    subst(H, A, Substitute, Rez1),
    heter_subst(T,Substitute,Rez).
heter_subst([H|T],Substitute, [H|Rez]):-
    heter_subst(T,Substitute,Rez).






























