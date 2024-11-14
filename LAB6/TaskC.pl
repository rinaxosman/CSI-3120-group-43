% CSI 3120: LAB 5 - Group 43
% - Alex Clements (300237898)
% - Rina Osman (300222206)
% - Sameed Jafri (300253861)

% references: stackOverflow, chatGPT

% Wrapper for reverse_digits/3
reverse_digits(N, R) :- reverse_digits(N, 0, R).

% Helper function to reverse the digits of a number
reverse_digits(0, Acc, Acc) :- !.
reverse_digits(N, Acc, R) :-
    N > 0,
    Digit is N mod 10,
    NewAcc is Acc * 10 + Digit,
    NewN is N // 10,
    reverse_digits(NewN, NewAcc, R).

% helper function check if a number is divisible by another number
divisible(X,Y) :- X mod Y =:= 0.
has_divisor(X,Y) :- 
    Y*Y =< X,
    (divisible(X,Y); 
    Next is Y + 1,
    has_divisor(X, Next)).

% helper function to check if a number is prime
isPrime(2).
isPrime(X) :- 
    X > 2, \+ has_divisor(X, 2).

% main predicate: filter and transform with the accumulator
filter_and_transform(L,R) :- 
    filter_and_transform(L, [], RevResult), 
    reverse(RevResult, R).

% Base case: stop after exactly 5 primes are processed
filter_and_transform(_, Acc, Result) :- 
    length(Acc, 5), !,
    reverse(Acc, Result).

% Base case: empty list
filter_and_transform([], Acc, Acc) :- !.

% Recursive case: if H is prime, reverse its digits and add to the accumulator
filter_and_transform([H|T], Acc, Result) :-
    isPrime(H),
    reverse_digits(H, Reversed),
    filter_and_transform(T, [Reversed|Acc], Result).

% Recursive case: if H is not prime, skip it
filter_and_transform([H|T], Acc, Result) :-
    \+ isPrime(H),
    filter_and_transform(T, Acc, Result).


    