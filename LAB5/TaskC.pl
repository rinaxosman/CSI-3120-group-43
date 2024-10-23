% CSI 3120: LAB 5 - Group 43
% - Alex Clements (300237898)
% - Rina Osman (300222206)
% - Sameed Jafri (300253861)

% Define the main predicate to solve the puzzle.
solve_puzzle(Houses, GreenIndex) :-
    % Define the possible house colors.
    Houses = [H1, H2, H3, H4],
    % The possible house colors
    member(H1, [red, blue, green, yellow]),
    member(H2, [red, blue, green, yellow]),
    member(H3, [red, blue, green, yellow]),
    member(H4, [red, blue, green, yellow]),
    % Ensure all houses are unique
    all_different(Houses),

    % Clue 1: The red house is immediately to the left of the blue house.
    next_to(red, blue, Houses),

    % Clue 2: The treasure is in the green house (Green is in Houses).
    member(green, Houses),

    % Clue 3: The yellow house is not next to the green house.
    not_next_to(yellow, green, Houses),

    % Clue 4: The green house is not in the second position from the left.
    nth1(GreenIndex, Houses, green),
    GreenIndex \= 2.

% Helper predicate to ensure all elements in a list are different.
all_different(List) :- \+ (select(X, List, Rest), member(X, Rest)).

% Helper predicate to check if two elements are next to each other in a list.
next_to(X, Y, List) :- 
    append(_, [X, Y | _], List).  % X is next to Y

next_to(X, Y, List) :- 
    append(_, [Y, X | _], List).  % Y is next to X

% Helper predicate to check if two elements are not next to each other in a list.
not_next_to(X, Y, List) :- 
    \+ next_to(X, Y, List).  % X is not next to Y
