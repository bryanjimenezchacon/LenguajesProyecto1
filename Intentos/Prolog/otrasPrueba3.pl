% This program finds a solution to the 8 queens problem.  That is, the problem of placing 8
% queens on an 8x8 chessboard so that no two queens attack each other.  The prototype
% board is passed in as a list with the rows instantiated from 1 to 8, and a corresponding
% variable for each column.  The Prolog program instantiates those column variables as it
%  finds the solution.

% Programmed by Ron Danielson, from an idea by Ivan Bratko.

% 2/17/00


queens([]).                                 % when place queen in empty list, solution found

queens([ Row/Col | Rest]) :-                % otherwise, for each row
            queens(Rest),                   % place a queen in each higher numbered row
            member(Col, [1,2,3,4,5,6,7,8]), % pick one of the possible column positions
            safe( Row/Col, Rest).           % and see if that is a safe position
                                            % if not, fail back and try another column, until
                                            % the columns are all tried, when fail back to
                                            % previous row

safe(Anything, []).                         % the empty board is always safe

safe(Row/Col, [Row1/Col1 | Rest]) :-        % see if attack the queen in next row down
            Col =\= Col1,                   % same column?
            Col1 - Col =\= Row1 - Row,      % check diagonal
            Col1 - Col =\= Row - Row1,
            safe(Row/Col, Rest).            % no attack on next row, try the rest of board

member(X, [X | Tail]).                      % member will pick successive column values

member(X, [Head | Tail]) :-
            member(X, Tail).

board([1/C1, 2/C2, 3/C3, 4/C4, 5/C5, 6/C6, 7/C7, 8/C8]). % prototype board
