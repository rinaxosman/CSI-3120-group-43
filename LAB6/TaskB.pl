% CSI 3120: LAB 6 - Group 43
% - Alex Clements (300237898)
% - Rina Osman (300222206)
% - Sameed Jafri (300253861)

% Predicate that checks if the given age is in the range
age_in_range(Age, Min, Max) :-
    Age >= Min,
    Age < Max.

% Main predicate
taller_than([], _, _, 'No match found.') :- !.  % Handle empty list case
taller_than([person(Name, Height, Age) | _], MinHeight, age_in_range(MinAge, MaxAge), person(Name, Height, Age)) :-
    Height > MinHeight,
    age_in_range(Age, MinAge, MaxAge), 
    !.  % Stops backtracking
taller_than([_| Rest], MinHeight, AgeRange, Result) :-
    taller_than(Rest, MinHeight, AgeRange, Result).
