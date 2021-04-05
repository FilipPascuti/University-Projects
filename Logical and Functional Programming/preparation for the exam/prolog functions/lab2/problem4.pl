cls :- write('\33\[2J').

% 4.
% a. Write a predicate to determine the sum of two numbers written in list representation.
% b. For a heterogeneous list, formed from integer numbers and list of digits, write a predicate to compute the
% sum of all numbers represented as sublists.
% Eg.: [1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] => [8, 2, 2].

reverse([],Rez,Rez).
reverse([H|T], Col, Rez):-
    Col1 = [H|Col],
    reverse(T,Col1, Rez).

% list_to_number(L:list, Col:partial result, Rez: the result)
% (i,i,o)

list_to_number([],Rez,Rez).
list_to_number([H|T],Col,Rez):-
    Col1 is Col * 10 + H,
    list_to_number(T,Col1,Rez).

% list_to_number(L:initial number, Col:partial result, Rez: the result)
% (i,i,o)
number_to_list(0, Rez, Rez):-!.
number_to_list(N, Col,Rez):-
    Rest is N mod 10,
    N1 is N//10,
    Col1 = [Rest|Col],
    number_to_list(N1, Col1, Rez).

% a)
% sum_of_lists(L1,L2,Rez):-
%     list_to_number(L1, 0, N1),
%     list_to_number(L2, 0, N2),
%     N3 is N1 + N2,
%     number_to_list(N3, [], Rez).

sum_of_lists([],[],Rez,_,Rez).
sum_of_lists([],[H2|T2],Col,_,Rez):-
    Col1 = [H2|Col],
    sum_of_lists([], T2, Col1, 1, Rez).
sum_of_lists([H1|T1],[],Col,_,Rez):-
    Col1 = [H1|Col],
    sum_of_lists(T1, [], Col1, 1, Rez).
sum_of_lists([H1|T1], [H2|T2], Col, Flag, Rez):-
    Flag =:= 0,
    Sum is H1 + H2,
    Sum > 9,
    Digit is mod(Sum,10),
    Col1 = [Digit|Col],
    sum_of_lists(T1, T2, Col1, 1, Rez).
sum_of_lists([H1|T1], [H2|T2], Col, Flag, Rez):-
    Flag =:= 0,
    Sum is H1 + H2,
    Sum < 10,
    Col1 = [Sum|Col],
    sum_of_lists(T1, T2, Col1, 0, Rez).
sum_of_lists([H1|T1], [H2|T2], Col, Flag, Rez):-
    Flag =:= 1,
    Sum is H1 + H2 + 1,
    Sum > 9,
    Digit is mod(Sum,10),
    Col1 = [Digit|Col],
    sum_of_lists(T1, T2, Col1, 1, Rez).
sum_of_lists([H1|T1], [H2|T2], Col, Flag, Rez):-
    Flag =:= 1,
    Sum is H1 + H2 + 1,
    Sum < 10,
    Col1 = [Sum|Col],
    sum_of_lists(T1, T2, Col1, 0, Rez).


sum_of_lists_wrapper(L1, L2, Rez):- 
    reverse(L1, [], Rez1),
    reverse(L2, [], Rez2),
    sum_of_lists(Rez1, Rez2, [], 0, Rez).


% b)

heter_sum([], Rez, Rez).
heter_sum([H|T], Col,Rez):-
    is_list(H),!,
    sum_of_lists_wrapper(H, Col, Rez1),
    heter_sum(T, Rez1, Rez).
heter_sum([_|T], Col, Rez):-
    heter_sum(T,Col,Rez).































