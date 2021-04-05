cls :- write('\33\[2J').

candidate([I|_], I).
candidate([_|T], I):- candidate(T,I).

arangements(L,N,V,Rez):-
    candidate(L, I),
    I < V,
    arangements_aux(L,N,V,1,1,[I],Rez).

arangements_aux(_,N,_,_,N,Rez,Rez).
arangements_aux(L,N,V,Product,Length,[H|Col],Rez):-
    Length < N,
    candidate(L, I),
    not(I =:= H), 
    Product1 is Product * I,
    Product1 < V,
    Length1 is Length + 1,
    arangements_aux(L,N,V,Product1,Length1,[I|[H|Col]],Rez).

f(1, 1):-!.
% f(K, X):- K1 is K -1, f(K1, Y), Y> 1,!,K2 is K1 - 1, X is K2.
% f(K, X):- K1 is K -1, f(K1, Y), Y > 0.5, !, X is Y.
% f(K, X):- K1 is K -1, f(K1, Y), X is Y - 1.
f(K, X):- K1 is K -1, f(K1, Y), aux(K1,Y,X).

aux(K,Y,X):-
    Y> 1,!,
    K2 is K - 1,
    X is K2.
aux(_,Y,X):-
    Y > 0.5, !,
    X is Y.
aux(_,Y,X):-
    X is Y - 1.


















