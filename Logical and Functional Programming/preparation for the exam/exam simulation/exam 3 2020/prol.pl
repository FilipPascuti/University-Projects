% f([],0).
% f([H|T], S):- f(T,S1), S1 is S - H.

member1([H|_], H):-!.
member1([_|T], I):-
    member1(T, I).

candidate([H|_],H).
candidate([_|T],I):-
    candidate(T,I).

arrang(L,N,P,Rez):-
    candidate(L,I),
    arrang_aux(L,N,P,1,I,[I],Rez).

arrang_aux(_,N,P,N,P,Rez,Rez).
arrang_aux(L,N,P,Len,Prod,Col,Rez):-
    Len < N,
    candidate(L, I),
    not(member(Col ,I)),
    Prod1 is Prod * I,
    Prod * I < P + 1,
    Len1 is Len + 1,
    arrang_aux(L,N,P,Len1,Prod1, [I|Col], Rez).

f([],-1).
f([H|T],S):-H>0,f(T,S1),S1<H,!,S is H.
f([_|T],S):-f(T,S1),S is S1.

% f([H|T],S):-f(T,S1), aux(H,S1, S).

% aux(H,S1,S):-
%     H>0,
%     S1<H,!,
%     S is H.
% aux(_,S,S).



