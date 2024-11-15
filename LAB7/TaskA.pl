% CSI 3120: LAB 7 - Group 43
% - Alex Clements (300237898)
% - Rina Osman (300222206)
% - Sameed Jafri (300253861)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Question 1: Right-Angled Triangle Pattern on Console
% Prompts the user for a height and prints a right-angled triangle with '#'.

% Main predicate to start the right-angled triangle generation
right_angle_triangle_console :-
    write('Enter the height of the right-angled triangle: '),
    read(Height),
    ( integer(Height), Height > 0 ->
        right_angle_triangle(1, Height)
    ; 
        write('ERROR: Height must be a positive integer.'), nl
    ).

% Recursive predicate to print each row of the triangle
right_angle_triangle(CurrentRow, MaxHeight) :-
    CurrentRow =< MaxHeight,
    print_row(CurrentRow),
    nl,
    NextRow is CurrentRow + 1,
    right_angle_triangle(NextRow, MaxHeight).
right_angle_triangle(_, _). % Base case: do nothing when CurrentRow > MaxHeight

% Helper predicate to print a row with the specified number of '#'
print_row(0).
print_row(N) :-
    N > 0,
    write('#'),
    N1 is N - 1,
    print_row(N1).


% Test case for Q1

% ?- right_angle_triangle_console.
% User inputs 4.
% Expected Output:
% #
% ##
% ###
% ####
% true .

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Question 2: Isosceles Triangle Pattern Written to a File
% Prompts for height and filename, writes an isosceles triangle with '*' to the file.

isosceles_triangle_pattern_file :-
    write('Enter the height of the isosceles triangle: '),
    read(Height),
    write('Enter the filename (without extension): '),
    read(Filename),
    atom_concat(Filename, '.txt', FullFilename),
    ( integer(Height), Height > 0 ->
        open(FullFilename, write, Stream),
        isosceles_triangle(Height, 1, Stream),
        close(Stream),
        write('Isosceles triangle pattern written to file: '), write(FullFilename), nl
    ;
        write('ERROR: Height must be a positive integer.'), nl
    ).

% Recursive predicate to write each row to the file
isosceles_triangle(Height, Row, _) :-
    Row > Height, !.  % Base case: stop when row exceeds height
isosceles_triangle(Height, Row, Stream) :-
    Row =< Height,
    Spaces is Height - Row,
    Stars is 2 * Row - 1,
    print_spaces(Spaces, Stream),
    print_stars(Stars, Stream),
    nl(Stream),
    NextRow is Row + 1,
    isosceles_triangle(Height, NextRow, Stream).

% Helper to write spaces in the file
print_spaces(0, _) :- !.
print_spaces(N, Stream) :-
    N > 0,
    write(Stream, ' '),
    N1 is N - 1,
    print_spaces(N1, Stream).

% Helper to write the stars inthe file
print_stars(0, _) :- !.
print_stars(N, Stream) :-
    N > 0,
    write(Stream, '*'),
    N1 is N - 1,
    print_stars(N1, Stream).

% Test case for Q2

% ?- isosceles_triangle_pattern_file.
% User inputs 5 for height and 'triangle.txt' for filename.
% Expected File Content:
%     *
%    ***
%   *****
%  *******
% *********