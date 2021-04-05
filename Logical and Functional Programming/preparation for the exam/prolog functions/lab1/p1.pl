cls :- write('\33\[2J').

% 1.
% a. Write a predicate to determine the lowest common multiple of a 
% list formed from integer numbers.
% b. Write a predicate to add a value v after 
% 1-st, 2-nd, 4-th, 8-th, … element in a list.
% Solution:

% gcd(a: first number, b: second number, r: the result)
%(i,i,o)
gcd(R,0,R):-!.

gcd(A,B,R):-B1 is A mod B,
            gcd(B, B1, R).

%lcm(L: the list, R: the result)
%(i,o)
lcm([],1).
lcm([H|T], R):- lcm(T,R1),
                gcd(R1, H, Div),
                R is R1*H / Div.

%b.
% insert(L: the initial list, El: the element to insert, N: current possition, M: valid possition, R: the resulting list)
%(i,i,i,i,o)

insert([],_,_,_,[]).
insert([H|T],El,N,M,[H,El|R]):- N =:= M,
                                N1 is N + 1,
                                M1 is M * 2,
                                insert(T,El,N1,M1,R). 
insert([H|T],El,N,M,[H|R]):-not(N =:= M),
                            N1 is N + 1,
                            insert(T,El,N1,M,R).

