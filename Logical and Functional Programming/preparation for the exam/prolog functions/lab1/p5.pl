% 5.
% a. Write a predicate to compute the union of two sets.
% b. Write a predicate to determine the set of all the pairs of elements in a list.
% Eg.: L = [a b c d] => [[a b] [a c] [a d] [b c] [b d] [c d]].

% Solution
% a)

union1([],M,M).
union1([H|T],M,R):-
    member(H,M),!,
    union1(T,M,R).
union1([H|T],M,[H|R]):-
    union1(T,M,R).

% b)

candidate(E,[E|_]).
candidate(E,[_|T]):-
    candidate(E,T).

pair(E,[B|_],[E,B]).
pair(E,[_|T],R):-
    pair(E,T,R).

pairs([H|T], R):-
    pair(H,T,R).
pairs([_|T], R):-
    pairs(T,R).

all_pairs(L,R):-
    findall(X, pairs(L, X), R).













