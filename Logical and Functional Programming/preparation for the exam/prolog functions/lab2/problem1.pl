% 1.
% a. Sort a list with removing the double values. E.g.: [4 2 6 2 3 4] --> [2 3 4 6]
% b. For a heterogeneous list, formed from integer numbers and list of numbers, write a predicate to sort every
% sublist with removing the doubles.
% Eg.: [1, 2, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>
% [1, 2, [1, 4], 3, 6, [1, 3, 7, 9, 10], 5, [1], 7].


insert_sort(List,Sorted):-i_sort(List,[],Sorted).

i_sort([],Acc,Acc).
i_sort([H|T],Acc,Sorted):-insert(H,Acc,NAcc),i_sort(T,NAcc,Sorted).
   
insert(X,[],[X]).
insert(X,[Y|T],[X,Y|T]):-X<Y.
insert(X,[Y|T],[Y|T]):- X =:= Y.
insert(X,[Y|T],[Y|NT]):-X>Y,insert(X,T,NT).

% sort_sub(List: initial list, Rez: rezulting list)
% (i,o)
sort_sub([],[]).
sort_sub([H|T], [H|Rez]):-
    number(H),!,
    sort_sub(T,Rez).
sort_sub([H|T], [H1|Rez]):-
    insert_sort(H, H1),
    sort_sub(T,Rez).





























