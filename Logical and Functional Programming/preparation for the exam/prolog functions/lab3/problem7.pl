cls :- write('\33\[2J').

% 7. A player wants to choose the predictions for 4 games. The predictions can be 1, X, 2. Write a predicate
% to generate all possible variants considering that: last prediction can’t be 2 and no more than two
% possible predictions X.

candidat(1).
candidat(3). %instead of X
candidat(2).

all(4, R, R,_):-!.
all(Size, Col, Rez, Product):-
    candidat(I),
    Size1 is Size + 1,
    Product1 is Product * I,
    not(Product1 mod 27 =:= 0),
    all(Size1, [I|Col], Rez, Product1).

results(Rez):-
    all(1, [1], Rez, 1).
results(Rez):-
    all(1, [3], Rez, 3).

all_solutions(Rez):-
    findall(R, results(R), Rez).































