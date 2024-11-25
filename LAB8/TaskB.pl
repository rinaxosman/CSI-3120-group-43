% CSI 3120: LAB 8 - Group 43
% - Alex Clements (300237898)
% - Rina Osman (300222206)
% - Sameed Jafri (300253861)

:- dynamic mine/2.
:- dynamic revealed/2.
:- dynamic flagged/2.

% Initialize the game
initialize_game :-
    retractall(mine(_,_)),
    retractall(revealed(_,_)),
    retractall(flagged(_,_)),
    place_mines(6),
    write('Game initialized! use check(Row, Col), flag(Row, Col), or unflag(row, col) and check_win.'), nl,
    display_board.

% randomly place 6 mines 
place_mines(0).
place_mines(N) :-
    random_between(1, 6, Row),
    random_between(1, 6, Col),
    (\+ mine(Row, Col) -> asserta(mine(Row, Col)), N1 is N - 1 ; N1 = N),
    place_mines(N1).

% check if a cell is within grid boundaries
valid_cell(Row, Col) :-
    Row >= 1, Row =< 6,
    Col >= 1, Col =< 6.

% reveal a cell
check(Row, Col) :-
    \+ valid_cell(Row, Col), write('Invalid move: Out of bounds!'), nl.
check(Row, Col) :-
    revealed(Row, Col), write('Cell already revealed!'), nl.
check(Row, Col) :-
    flagged(Row, Col), write('Cell is flagged! Unflag it first to reveal.'), nl.
check(Row, Col) :-
    mine(Row, Col), !, write('Game Over! You hit a mine.'), nl, display_mines.
check(Row, Col) :-
    count_adjacent_mines(Row, Col, Count),
    asserta(revealed(Row, Col)),
    write('Cell revealed. Adjacent mines: '), write(Count), nl,
    (Count = 0 -> reveal_neighbors(Row, Col) ; true),
    display_board.

% Reveal all neighboring cells if the current cell is safe
reveal_neighbors(Row, Col) :-
    forall(adjacent(Row, Col, R, C), (valid_cell(R, C), \+ revealed(R, C), \+ flagged(R, C), check(R, C))).

% Count the number of adjacent mines
count_adjacent_mines(Row, Col, Count) :-
    findall((R, C), (adjacent(Row, Col, R, C), mine(R, C)), Mines),
    length(Mines, Count).

% Define adjacent cells
adjacent(Row, Col, R, C) :-
    between(-1, 1, DRow),
    between(-1, 1, DCol),
    R is Row + DRow,
    C is Col + DCol,
    (DRow \= 0; DCol \= 0).

% Flag a cell
flag(Row, Col) :-
    \+ valid_cell(Row, Col), write('Invalid move: Out of bounds!'), nl.
flag(Row, Col) :-
    revealed(Row, Col), write('Cannot flag a revealed cell!'), nl.
flag(Row, Col) :-
    flagged(Row, Col), write('Cell already flagged!'), nl.
flag(Row, Col) :-
    asserta(flagged(Row, Col)),
    write('Cell flagged.'), nl,
    display_board.

% Unflag a cell
unflag(Row, Col) :-
    \+ valid_cell(Row, Col), write('Invalid move: Out of bounds!'), nl.
unflag(Row, Col) :-
    \+ flagged(Row, Col), write('Cell is not flagged!'), nl.
unflag(Row, Col) :-
    retract(flagged(Row, Col)),
    write('Flag removed.'), nl,
    display_board.

% Display the game board
display_board :-
    forall(between(1, 6, Row), (display_row(Row), nl)).

display_row(Row) :-
    forall(between(1, 6, Col), display_cell(Row, Col)).

display_cell(Row, Col) :-
    revealed(Row, Col), count_adjacent_mines(Row, Col, Count), write(Count), write(' ').
display_cell(Row, Col) :-
    flagged(Row, Col), write('F ').
display_cell(Row, Col) :-
    write('# ').

% Display all mines (for game over scenario)
display_mines :-
    write('Mines were at:'), nl,
    forall(mine(Row, Col), (write('Mine: '), write(Row), write(','), write(Col), nl)).

% Game-winning condition: All non-mine cells are revealed, and all mines are flagged
check_win :-
    findall((Row, Col), mine(Row, Col), Mines),
    forall(member((Row, Col), Mines), flagged(Row, Col)),
    findall((Row, Col), (\+ mine(Row, Col), valid_cell(Row, Col)), NonMines),
    forall(member((Row, Col), NonMines), revealed(Row, Col)),
    write('Congratulations! You won the game!'), nl.




