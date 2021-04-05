% 3.
% a. Merge two sorted lists with removing the double values.
% b. For a heterogeneous list, formed from integer numbers and list of numbers, merge all sublists with removing
% the double values.
% [1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5, [1, 1, 11], 8] =>
% [1, 2, 3, 4, 6, 7, 9, 10, 11].

% a)
% merge(L1: the first sorted list, L2: the second sorted list, Res: the resulting list)
% (i,i,o)

remove_doubles([],[]).
remove_doubles([H],[H]).
remove_doubles([H1,H2|T], Rez):-
    H1 =:= H2,!,
    remove_doubles([H1|T],Rez).
remove_doubles([H1,H2|T], [H1,H2|Rez]):-
    not(H1 =:= H2),
    remove_doubles(T,Rez).


mergel([],L2,L2).
mergel(L1,[],L1).
mergel([H1|T1],[H2|T2],[H1|Rez]):-
    H1 < H2,!,
    mergel(T1,[H2|T2],Rez).
mergel([H1|T1],[H2|T2],Rez):-
    H1 =:= H2,!,
    mergel([H1|T1],T2,Rez).
mergel([H1|T1],[H2|T2],[H2|Rez]):-
    mergel([H1|T1],T2,Rez).

merge(L1,L2,Rez):-
    remove_doubles(L1,L1New),
    remove_doubles(L2,L2New),
    mergel(L1New, L2New, Rez).

% merge_sub(L:the list, C: the partial result, Rez:the result)
% (i,i,o)
merge_sub([],Rez,Rez).
merge_sub([H|T],C,Rez):-
    number(H),!,
    merge([H],C,C1),
    merge_sub(T,C1,Rez).
merge_sub([H|T],C,Rez):-
    merge(H,C,C1),
    merge_sub(T,C1,Rez).

















