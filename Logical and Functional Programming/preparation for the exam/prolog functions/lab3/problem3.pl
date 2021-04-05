cls :- write('\33\[2J').

% 3. Write a predicate to determine all decomposition of n (n given, positive), as sum of consecutive natural
% numbers.

one_solution(0,_,[]).
one_solution(N, E, [E|Rez]):-
    N >= E,
    N1 is N - E,
    E1 is E + 1,
    one_solution(N1, E1, Rez).   

decompose(N,E,Rez):-
    one_solution(N,E,Rez).
decompose(N,E,Rez):-
    N > E,
    E1 is E + 1,
    decompose(N,E1,Rez).

all_solutions(N,L):-
    findall(Rez, decompose(N,1,Rez), L).





























