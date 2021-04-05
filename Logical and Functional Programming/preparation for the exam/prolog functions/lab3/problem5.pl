cls :- write('\33\[2J').

% 5. Two integers, n and m are given. Write a predicate to determine all possible sequences of numbers
% from 1 to n, such that between any two numbers from consecutive positions, the absolute difference
% to be >= m.

member1(H,[H|_]).
member1(I, [_|T]):- member1(I, T).

candidat(N, N).
candidat(N, I):-
    N > 1,
    N1 is N - 1,
    candidat(N1, I).

numbers(N,M,Rez):-
    candidat(N, I),
    numbers_aux(N, M, Rez, [I]).

numbers_aux(_, _, Rez, Rez).
numbers_aux(N,M,Rez,[H|Col]):-
    candidat(N, I),
    not(member1(I,[H|Col])),
    abs(H - I) > M - 1,
    numbers_aux(N, M, Rez, [I,H|Col]).





























