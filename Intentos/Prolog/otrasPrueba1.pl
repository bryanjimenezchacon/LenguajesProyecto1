% Solve N queen problem.
% お勉強中です
% queenの置き順も区別しちゃってるのでむちゃくちゃ解がでてくる
nlist(1,[1]).
nlist(N,L) :-
	N > 1,
	N1 is N-1,
	nlist(N1,L1),
	append(L1,[N],L).
on_nboard(N,[X,Y]) :-
	nlist(N,Ln),
	member(X,Ln),
	member(Y,Ln).
isoseles([X1,Y1],[X2,Y2]) :-
	((X1-X2)*(X1-X2)) =:= ((Y1-Y2)*(Y1-Y2)).
can_put(N,P,[]) :-
	on_nboard(N,P).
can_put(N,P,[A|L]) :-
	on_nboard(N,P),
	\+ isoseles(P,A),
	can_put(N,P,L).

nqueen(N,L) :-
	nqueen(N,N,[],L).
nqueen(_,0,L1,L1).
nqueen(N,M,L1,L) :-
	M1 is M-1,
	can_put(N,P,L1),
	nqueen(N,M1,[P|L1],L).
