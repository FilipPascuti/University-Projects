cls :- write('\33\[2J').

% 10.
% a. For a list of integer numbers, define a predicate to write twice in list every prime number.
% b. For a heterogeneous list, formed from integer numbers and list of numbers, define a predicate to write in
% every sublist twice every prime number.
% Eg.: [1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5] =>
% [1, [2, 2, 3, 3], 4, 5, [1, 4, 6], 3, [1, 3, 3, 7, 7, 9, 10], 5]

% a)

divisible(X,Y):- 
    X mod Y =:= 0,!.
divisible(X,Y):- 
    X > Y + 1,
    Y1 is Y + 1,
    divisible(X, Y1).

is_prime(2):-!.
is_prime(X):-
    X > 2,!,
    not(divisible(X,2)).

write_twice([],[]).
write_twice([H|T],[H,H|Rez]):-
    is_prime(H),!,
    write_twice(T,Rez).
write_twice([H|T],[H|Rez]):-
    write_twice(T,Rez).

% b)

heter_subst([],[]).
heter_subst([H|T],[Rez1|Rez]):-
    is_list(H),!,
    write_twice(H, Rez1),
    heter_subst(T,Rez).
heter_subst([H|T],[H|Rez]):-
    heter_subst(T,Rez).



























