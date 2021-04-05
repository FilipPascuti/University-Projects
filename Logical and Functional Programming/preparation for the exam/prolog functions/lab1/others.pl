% 7 b. Write a predicate to create a list (m, ..., n) 
% of all integer numbers from the interval [m, n].


% create_list(M,M,R,[M|R]).
% create_list(M,N,R,Rez):-
%     M < N,
%     R1 = [M|R],
%     M1 is M + 1,
%     create_list(M1, N, R1, Rez).


create_list(M,M,[M]).
create_list(M,N,[M|R]):-
    M < N,
    M1 is M + 1,
    create_list(M1, N, R).
















