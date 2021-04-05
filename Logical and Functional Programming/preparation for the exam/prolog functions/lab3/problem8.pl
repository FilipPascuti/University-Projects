cls :- write('\33\[2J').

% 8. Generate all strings of n parenthesis correctly closed.
%  Eg: n=4 => (()) and () ()

% public class Parenthesis {
%     static void brackets(int openStock, int closeStock, String s) {
%         if (openStock == 0 && closeStock == 0) {
%             System.out.println(s);
%         }
%         if (openStock > 0) {
%             brackets(openStock-1, closeStock+1, s + "<");
%         }
%         if (closeStock > 0) {
%             brackets(openStock, closeStock-1, s + ">");
%         }
%     }
%     public static void main(String[] args) {
%         brackets(3, 0, "");
%     }
% }

reverse([],Rez,Rez).
reverse([H|T], Col, Rez):-
    Col1 = [H|Col],
    reverse(T,Col1, Rez).

generate_brackets(0,0,Col,Rez):-reverse(Col, [], Rez).
generate_brackets(Open, Close, Col, Rez):-
    Open > 0,
    Open1 is Open - 1,
    Close1 is Close + 1,
    Col1 = ["("|Col],
    generate_brackets(Open1, Close1, Col1, Rez).
generate_brackets(Open, Close, Col, Rez):-
    Close > 0,
    Close1 is Close - 1,
    Col1 = [")"|Col],
    generate_brackets(Open, Close1, Col1, Rez).

generate_brackets_wrapper(N, Rez):-
    findall(X, generate_brackets(N,0,[],X), Rez).





























