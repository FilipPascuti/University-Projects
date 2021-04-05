cls :- write('\33\[2J').

% 9. Generate all permutation of N (N - given) respecting the property: for every 2<=i<=n exists an 1<=j<=i,
% so |v(i)-v(j)| = 1.

reverse([],Rez,Rez).
reverse([H|T], Col, Rez):-
    Col1 = [H|Col],
    reverse(T,Col1, Rez).

candidate(N, N).
candidate(N,I):-
    N > 1,
    N1 is N - 1,
    candidate(N1, I).

member1(H,[H|_]).
member1(I,[_|T]):- member1(I,T).

is_correct(I, [H|_]):- abs(I - H) =:= 1.
is_correct(I, [_|T]):- is_correct(I, T).

gener(N, Rez):-
    candidate(N, I),
    gener_aux(N, 1, [I], Rez).

gener_aux(N,N,Col,Rez):- reverse(Col, [], Rez).
gener_aux(N, Length, Col, Rez):-
    Length < N,
    candidate(N, I),
    not(member1(I, Col)),
    is_correct(I, Col),
    Length1 is Length + 1,
    gener_aux(N, Length1, [I|Col], Rez).


















