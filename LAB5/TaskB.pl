% CSI 3120: LAB 5 - Group 43
% - Alex Clements (300237898)
% - Rina Osman (300222206)
% - Sameed Jafri (300253861)

% Base case
sum_odd_numbers([], 0).

% Recursive case (Odd head)
sum_odd_numbers([Head | Tail], Sum) :-
    Head mod 2 =:= 1,  % Check if Head is odd
    sum_odd_numbers(Tail, TailSum),  % Recursively sum the tail
    Sum is Head + TailSum.  % Add Head to the tail sum

% Recursive case (Even head)
sum_odd_numbers([Head | Tail], Sum) :-
    Head mod 2 =:= 0,  % Check if Head is even
    sum_odd_numbers(Tail, Sum).  % Continue with the tail
