cls :- write('\33\[2J').

% 6. Generate the list of all arrangements of K elements of a given list.
% Eg: [2, 3, 4] K=2 => [[2,3], [3,2], [2,4], [4,2], [3,4], [4,3]] (not necessary in this order)

member1(H,[H|_]).
member1(I, [_|T]):- member1(I, T).

candidat([H|_],H).
candidat([_|T],I):-candidat(T,I).

arrangements(L,K,Rez):-
    candidat(L, I),
    arrangements_aux(L, K, Rez, 1, [I]).

arrangements_aux(_,K,Rez,K,Rez).
arrangements_aux(L, K, Rez, Size, Col):-
    Size < K,
    candidat(L, I),
    not(member1(I, Col)),
    Size1 is Size + 1,
    arrangements_aux(L, K, Rez, Size1, [I|Col]).





























