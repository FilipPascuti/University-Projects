cls :- write('\33\[2J').

% 4. The list a1... an is given. Write a predicate to determine all sublists strictly ascending of this list a.

candidate([I|_], I).
candidate([_|T],I):-candidate(T,I).

increasing_sublists(L,Rez):-
    candidate(L, I),
    increasing_sublists_aux(L, Rez, [I]).

increasing_sublists_aux(_, Rez, Rez).
increasing_sublists_aux(L, Rez, [H|Col]):-
    candidate(L, I),
    I < H,
    increasing_sublists_aux(L, Rez, [I,H|Col]).






























