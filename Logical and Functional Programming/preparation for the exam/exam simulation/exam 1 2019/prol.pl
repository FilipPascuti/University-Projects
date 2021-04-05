reverse_heter([],Rez,Rez).
reverse_heter([H|T],Col,Rez):-
    number(H),!,
    Col1 = [H|Col],
    reverse_heter(T,Col1, Rez).
reverse_heter([H|T],Col,Rez):-
    reverse_heter(H,[],R),
    Col1 = [R|Col],
    reverse_heter(T,Col1, Rez).

candidate([H|_],H).
candidate([_|T], I):- candidate(T,I).

subsets(L,N,Rez):-
    candidate(L,I),
    subsets_aux(L,N,1,[I],Rez).

subsets_aux(_,N,N,Rez,Rez):-!.
subsets_aux(L,N,Len,[H|Col],Rez):-
    Len < N,
    candidate(L,I),
    I < H,
    Len1 is Len + 1,
    subsets_aux(L,N,Len1,[I|[H|Col]], Rez).










