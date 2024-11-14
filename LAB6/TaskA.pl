% CSI 3120: LAB 6 - Group 43
% - Alex Clements (300237898)
% - Rina Osman (300222206)
% - Sameed Jafri (300253861)


% Question 1: Factorial with Tail Recursion and Input Validation
% Computes factorial of non-negative integer

factorial(N, Acc, Result) :-
    integer(N),
    N >= 0, 
    factorial_tail(N, Acc, Result).

% Base case: factorial(0) is 1
factorial_tail(0, Result, Result).

% Recursive case: N > 0
factorial_tail(N, Acc, Result) :-
    N > 0,
    NewAcc is N * Acc,
    NewN is N - 1,
    factorial_tail(NewN, NewAcc, Result).

% Error handling for negative inputs
factorial(N, _, 'ERROR: Input must be a non-negative integer.') :-
    ( \+ integer(N) ; N < 0).

% Test Cases for Question 1
% ?- factorial(5, 1, Result).
% Expected Result = 120.
% ?- factorial(-2, 1, Result).
% Expected Result = 'Error: Input must be a non-negative integer.'.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Question 2: Filtering Elements Based on Multiple Conditions
% Filters elements from a list based on multiple conditions (greater_than/2, multiple_of/2).

greater_than(N, X) :- X > N.
multiple_of(N, X) :- X mod N =:= 0.

% filter based on conditions
filter_list([], _, []). % Base case
filter_list([H|T], Conditions, [H|Filtered]) :-
    satisfies_all_conditions(H, Conditions),
    filter_list(T, Conditions, Filtered).
filter_list([_|T], Conditions, Filtered) :-
    filter_list(T, Conditions, Filtered).

% Check if an element satisfies all theconditions
satisfies_all_conditions(_, []).
satisfies_all_conditions(X, [Condition|Conditions]) :-
    call(Condition, X),
    satisfies_all_conditions(X, Conditions).

% Test Cases for Q2

% ?- filter_list([1, 2, 3, 4, 5, 6, 7, 8], [greater_than(3), multiple_of(2)], Result).
% Expected Result = [4, 6, 8].
% ?- filter_list([1, 2, 3, 6, 9, 12], [greater_than(5), multiple_of(3)], Result).
% Expected Result = [6, 9, 12].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Question 3: Finding the Second Maximum Element
% Finds the 2nd max element in a list, handling duplicates and errors.

% Find the second maximum element in a list
second_max(List, SecondMax) :-
    sort(List, Sorted), % Remove duplicates and sort
    reverse(Sorted, [Max, SecondMax|_]). % Get the 2nd distinct element

% Handle cases with fewer than two distinct elements
second_max(List, 'Error: List must contain at least two distinct elements.') :-
    sort(List, Sorted), % remove duplicates
    length(Sorted, Len),
    Len < 2.

% Test Cases for Q3

% ?- second_max([5, 5, 3, 9, 9], SecondMax).
% Expected SecondMax = 5.
% ?- second_max([7, 7, 7, 7], SecondMax).
% Expected SecondMax = 'ERROR: List must contain at least 2 distinct elements.'.
