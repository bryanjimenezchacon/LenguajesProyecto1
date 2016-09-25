solution(_, []).
solution(N, [X/Y|Others]) :-
    solution(N, Others),
    between(1, N, Y),
    noattack(X/Y, Others).

noattack(_,[]).
noattack(X/Y, [X1/Y1 | Others]) :-
    Y =\= Y1,
    Y1-Y =\= X1-X,
    Y1-Y =\= X-X1,
    noattack( X/Y, Others).

template(N, L) :-

    findall(I/_, between(1,N,I), L).%Imprime la solucion
    %print_queens([1/3,2/1,3/4,4/5,5/3,6/6], 6).
% Uso:  N=4, template(N, L), solution(N, L).

%Prueba de impresion
%
%
print_queens(Queens, N):-
    forall(member(_/Col, Queens),
           ( Col1 is Col-1, format('~|~`#t~*+Q~`#t~*|~n',[Col1,N]) )
          ).
%Uso: print_queens([1/3,2/1,3/4,4/5,5/3,6/6], 6).

%Prueba de automatica
%
%

queen(X, Y, N):-
    template(N, L),    % Build the template of the solution
    member(X/Y, L),    % Unify given value for Y with its corresponding variable in L
    !,                 % Green cut

    % Count solutions while printing them
    findall(s, (solution(N, L), print_queens(L, N)), All),

    % Print total number of solutions
    length(All, Len),
    format('Total Output is ~w.~n', [Len]).
%Uso:  queen(1,2,5).
