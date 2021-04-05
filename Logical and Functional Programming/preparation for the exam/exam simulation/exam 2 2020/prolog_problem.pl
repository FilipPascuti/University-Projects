member1([H|_], H):-!.
member1([_|T], I):-
    member1(T, I).

candidate([H|_],H).
candidate([_|T],I):-
    candidate(T,I).

subsets(L,N,Rez):-
    candidate(L, I),
    subsets_aux(L,N,1,I,[I],Rez).

subsets_aux(_,N,Length,Sum,Rez,Rez):-
    Length > N - 1,
    mod(Sum,3) =:= 0,!.
subsets_aux(L,N,Length,Sum,[H|Col],Rez):-
    candidate(L,I),
    I < H,
    Length1 is Length + 1,
    Sum1 is Sum + I,
    subsets_aux(L,N,Length1,Sum1,[I|[H|Col]],Rez).

p(1).
p(2).
q(1).
q(2).
r(1).
r(2).

s:-!,p(X),q(Y),r(Z),write(X),write(Y),write(Z),nl.

f([],0).
% f([H|T], S):- f(T,S1), H<S1,!,S is H + S1.
% f([_|T], S):- f(T,S1), S is 2 + S1.
f([H|T], S):- f(T,S1), aux(H, S1, S).

aux(H,S1,S):-
    H<S1,!,
    S is H + S1.
aux(_,S1,S):-
    S is 2 + S1.































