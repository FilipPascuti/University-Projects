cls :- write('\33\[2J').

% 1. Write a predicate to generate the list of all subsets with all elements of a given list.
% Eg: [2, 3, 4] N=2 => [[2,3],[2,4],[3,4]]

candidat([H|_],H).
candidat([_|T],I):-candidat(T,I).

subsets(L, N, Rez):-
    candidat(L, I),
    subsets_aux(L, N, Rez, 1, [I]).

subsets_aux(_,N,Col,N,Col).
subsets_aux(L,N,Rez,Size,[H|Col]):-
    Size < N,
    candidat(L, I),
    I < H,
    Size1 is Size + 1,
    subsets_aux(L,N,Rez,Size1,[I,H|Col]).











































