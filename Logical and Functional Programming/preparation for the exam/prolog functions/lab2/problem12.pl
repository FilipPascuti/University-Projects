cls :- write('\33\[2J').

% 12.
% a. Define a predicate to add after every element from a list, the divisors of that number.
% b. For a heterogeneous list, formed from integer numbers and list of numbers, define a predicate to add in
% every sublist the divisors of every element.
% Eg.: [1, [2, 5, 7], 4, 5, [1, 4], 3, 2, [6, 2, 1], 4, [7, 2, 8, 1], 2] =>
% [1, [2, 5, 7], 4, 5, [1, 4, 2], 3, 2, [6, 2, 3, 2, 1], 4, [7, 2, 8, 2, 4, 1], 2]

% a)

concatenate([],L2,L2).
concatenate([H|T], L2, [H|Rez]):-
    concatenate(T,L2,Rez).

divisors_list(N,Div,[]):-
    Div > N // 2,!.
divisors_list(N, Div, [Div|Rez]):-
    N mod Div =:= 0,!,
    Div1 is Div + 1,
    divisors_list(N, Div1, Rez).
divisors_list(N, Div, Rez):-
    Div1 is Div + 1,
    divisors_list(N, Div1, Rez).

list_with_divs([],[]).
list_with_divs([H|T],Rez):-
    divisors_list(H, 2, Divs),
    list_with_divs(T, Rez1),
    concatenate(Divs, Rez1, Rez2),
    Rez = [H|Rez2].

% b)
heter_subst([],[]).
heter_subst([H|T],[Rez1|Rez]):-
    is_list(H),!,
    list_with_divs(H,Rez1),
    heter_subst(T,Rez).
heter_subst([H|T],[H|Rez]):-
    heter_subst(T,Rez).































