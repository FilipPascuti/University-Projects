cls :- write('\33\[2J').

% fact1(N:integer, F:integer)
% (i, i) (i, o)
% fact1(0, 1).
% fact1(N, F) :-N > 0,  
%               N1 is N-1,
%               fact1(N1, F1),
%               F is N * F1.
% go1 :-fact1(3, 6).

% sum1(0,0).
% sum1(N, F)  :-  N>0,
%                 N1 is N-1,
%                 sum1(N1,F1),
%                 F is N + F1.

% member1(E,[E|_]).
% member1(E,[_|L]) :-member1(E,L).

% union([],[],[]).
% union(List1,[],List1).
% union(List1, [Head2|Tail2], [Head2|Output]):-
%     \+(member(Head2,List1)), 
%     union(List1,Tail2,Output).
% union(List1, [Head2|Tail2], Output):-
%     member(Head2,List1),
%     union(List1,Tail2,Output). 

%-----------------------------------------------
%-----------------------------------------------
%-----------------------------------------------
%-----------------------------------------------
%-----------------------------------------------
%-----------------------------------------------

% Homework lab 2
% 5.
% a. Write a predicate to compute the union of two sets.
% b. Write a predicate to determine the set of all the pairs of elements in a list.
% Eg.: L = [a b c d] => [[a b] [a c] [a d] [b c] [b d] [c d]].
% Solutions:

% % a)
% %member1(E: element, L:list)
% %(i,i) - determinist
% member1(E, [E|_]):- !.
% member1(E, [_|T]):- member1(E, T).

% %union(L1: list, L2:list, R: list)
% %(i,i,o) - nedeterminist
% union([],List2,List2).
% union([Head1|Tail1], List2, [Head1|Output]):-
%     not(member1(Head1,List2)),!, 
%     union(Tail1,List2,Output).
% union([_|Tail1], List2, Output):-
%     % member1(Head1,List2),
%     union(Tail1,List2,Output).

% % b)
%pair(A: element, L: list, LRez: list)
%(i,i,o) - nedeterminist
% pair(A, [B|_], [A, B]).
% pair(A, [_|T], P) :-
%     pair(A, T, P).

% %pairs(L: list, LRez: list)
% %(i,o) - nedeterminist
% pairs([H|T], P) :-
%     pair(H, T, P).
% pairs([_|T], P) :-
%     pairs(T, P).

% %allPairs(L: list, LRez: list)
% %(i, o) - determinist
% allPairs(L,LRez) :-
%     findall(X, pairs(L, X), LRez).

















% myMod(NR, DIV, NR) :-
%     NR < DIV.
% myMod(NR, DIV, R) :- 
%     NR > DIV,
%     NR1 is NR-DIV,
%     myMod(NR1, DIV, R).

% sterge([],[]).
% sterge([H|T],[H|Output]):-
%     myMod(H,2,1),
%     sterge(T,Output).
% sterge([H|T], Output):-
%     not(myMod(H,2,1)),
%     sterge(T,Output).

% isSet([]).
% isSet([H|T]):-
%     not(member(H,T)),
%     isSet(T).


% p([],0).
% p([H|T], S):-
%     H > 0,
%     !,
%     p(T, S1),
%     S is S1 + H.

% apears(X,[H|T], R):-


% % remove(L: list, R: list)
% % (i,o)
% remove([],[]).
% remove([H|T],[H|O]):-
%     member(H, T),
%     delete(T,H,R),
%     remove(R,O).
% remove([H|T], O):-
%     not(member(H,T)),
%     remove(T,O).

% % delete(L:list, E: element, R:list)
% % (i,i,o)
% delete([],_,[]).
% delete([H|T],E,[H|O]):-
%     H=\=E,
%     delete(T,E,O).
% delete([H|T],E,O):-
%     H=:=E,
%     delete(T,E,O).




% ----------------------------------------------------------
% ----------------------------P2----------------------------
% ----------------------------------------------------------

% 9.
% a. For a list of integer number,
% write a predicate to add in list after
% 1-st, 3-rd, 7-th, 15-th element a given value e.
% Sol:

% add(L: list, E: element, M: number, M2: number, Rez: list)
% (i,i,i,i,o)
% add([],_,_,_,[]).
% add([H|T],E,M,M2,[H,E|R]):-
%     M is M2,!,
%     M3 is M + 1,
%     M4 is M2*2 + 1,
%     add(T,E,M3,M4,R).
% add([H|T],E,M,M2,[H|R]):-
%     M1 is M + 1,
%     add(T,E,M1,M2,R).

% % addc(L: list, E: element, R: list)
% % (i, i, o)
% addc(L, E, R):-add(L, E, 1, 1, R).

% b. For a heterogeneous list,
% formed from integer numbers and list of numbers;
% add in every sublist after 1-st, 3-rd, 7-th, 15-th
% element the value found before the sublist in the 
% heterogenous list. The list has the particularity
% that starts with a number and there aren’t two consecutive
% elements lists.
% Eg.: [1, [2, 3], 7, [4, 1, 4], 3, 6, [7, 5, 1, 3, 9, 8, 2, 7], 5] =>
% [1, [2, 1, 3], 7, [4, 7, 1, 4, 7], 3, 6, 
% [7, 6, 5, 1, 6, 3, 9, 8, 2, 6, 7], 5]

% transform(L: list, Rez: list)
% (i,o)
% transform([],[]).
% % transform([H1],[H1]):- not(is_list(H1)),!.
% transform([H1,H2|T],[H1,T1|R]):-
%     is_list(H2),!,
%     addc(H2, H1, T1),
%     transform(T,R).
% transform([H|T],[H|R]):-
%     transform(T,R).

% %apare(I:element, L:list)
% apare(I,[I|_]):-!.
% apare(I,[_|T]):-apare(I,T).


% ---------------seminar 3---------------

% delete_odd([],[]).
% delete_odd([H|T],[H|Rez]):-
%     H mod 2 =:= 0,!,
%     delete_odd(T,Rez).
% delete_odd([_|T], Rez):-
%     delete_odd(T,Rez).

% trim_left([L1,L2,L3|T], [L1,L2,L3|T]):-
%     L1 < L2, 
%     L2 > L3.
% trim_left([L1,L2,L3|T], Rez):-
%     L1 < L2,
%     L2 < L3,
%     trim_left([L2,L3|T], Rez).

% trim_right([H,L1,L2], [H,L1,L2]):-
%     H < L1,
%     L1 > L2.
% trim_right([H, L1, L2, L3|T], Rez):-
%     L1 > L2,
%     L2 > L3,
%     trim_right([H,L1,L3|T], Rez).

% is_mountain(L):-
%     trim_left(L, Rez1),
%     trim_right(Rez1, _).

% f([],[]).
% f([H|T], [R1| Rez]):-
%     is_list(H),
%     is_mountain(H),!,
%     delete_odd(H, R1),
%     f(T,Rez).
% f([H|T], [H|Rez]):-
%     f(T,Rez).

% %Remove_odd(L: list, Rez: list)
% %(i,o)
% remove_odd([],[]).
% remove_odd([H|T],Rez):-
%     H mod 2 =:= 1,!,
%     remove_odd(T,Rez).
% remove_odd([H|T], [H|Rez]):-
%     remove_odd(T,Rez).


% invert([],Rez, Rez).
% invert([H|T], Rez, R):-
%     invert(T,[H|Rez], R).

% candidat(E,[E|_]).
% candidat(E,[_|T]):-
%     candidat(E,T).

% combSuma(L,K,S,C):-
%     candidat(E,L),
%     E=<S,
%     combaux(L,K,S,C,1,E,[E]).

% combaux(_,K,S,C,K,S,C):-!.
% combaux(L,K,S,C,Lg,Sum,[H|T]):-
%     Lg<K,
%     candidat(E,L),
%     E<H,
%     Sum1 is Sum+E,
%     Sum1=<S,
%     Lg1 is Lg+1,
%     combaux(L,K,S,C,Lg1,Sum1,[E|[H|T]]).


% ----------------------------------------------------------
% ----------------------------P3----------------------------
% ----------------------------------------------------------

% 11. “Colouring” a map. 
% n countries are given; 
% write a predicate to determine all possibilities of colouring n
% countries with m colours, 
% such that two adjacent countries not having the same colour.

% %candidat(N:integer, I:integer)
% %(i,o)- nedeterminist
% candidat(N,N).
% candidat(N,I):-
%     N>1,
%     N1 is N-1,
%     candidat(N1,I).

% %colorare(N:integer,M:intiger,LRez:list)
% % N- number of colors
% % M- number of countries
% %(i,i,o)- nedeterminist
% colorare(N,M,LRez):-
%     candidat(N,I),
%     colorare_aux(N,M,LRez,1,[I]).

% %colorare_aux(N: integer, M: integer, L: list, Lg: integer, Col: list)
% % N- number of colors
% % M- number of countries
% % L - the resulting list
% % Lg- the current length of Col
% % Col - the partial solution list
% %(i,i,o,i,i)- nedeterminist
% colorare_aux(_,M,Col,M,Col):-!.
% colorare_aux(N,V,L,Lg,[H|T]):-
%     candidat(N,I),
%     I \= H,
%     Lg1 is Lg+1,
%     colorare_aux(N,V,L,Lg1,[I|[H|T]]).

% colorare_toate(N, M, LRez):-
%     findall(X, colorare(N,M,X), LRez).


% ---------------------------------------------------------
% ---------------------------------------------------------
% -----------------------Seminar4--------------------------
% ---------------------Backtracking------------------------
% ---------------------------------------------------------
% ---------------------------------------------------------

% Given a list of distinct number generate all the subsequences 
% which have a valley aspect. Example: [5,3,4,2,7,11,1,8,6]
% some solutions would be: [5,3,4], [5,3,2,7,8], [11,6,4,2,3,5,8]
% (8828 solutions out of 986328 possibilities)


% % candidate(L:list, E:element)
% % (i, o) - nedeterministic
% candidate([H|_], H).
% candidate([_|T], E):-
%     candidate(T, E).

% iterate2([H|T], H,T). 

% iterate2([H|T], E, [H|R]):- 
%     iterate2(T,E,R). 


% % valley(L:list, Dir: direction, R:colector list, Rez:resulting list)
% % (i, i, i, o) - non-deterministic

% valley(_,0,R,R).

% valley(L, Dir, [C1|T], R):-
%     iterate2(L, E, List),
%     E < C1,
%     Dir =:= 1,
%     valley(List, Dir, [E,C1|T], R).

% valley(L, Dir, [C1|T], R):-
%     iterate2(L, E, List),
%     E > C1,
%     Dir =:= 0,
%     valley(List, Dir, [E,C1|T], R).

% valley(L, Dir, [C1,C2|T], R):-
%     iterate2(L, E, List),
%     E > C1,
%     Dir =:= 1,
%     valley(List, 0, [E,C1,C2|T], R).

% valley(L,Dir,[],R):-
%     iterate2(L, E1, List),
%     valley(List, Dir, [E1], R).


% valleyWrapper(L, LRez):-
%     findall(X, valley(L,1,[],X),LRez).