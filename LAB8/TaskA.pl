% CSI 3120: LAB 8 - Group 43
% - Alex Clements (300237898)
% - Rina Osman (300222206)
% - Sameed Jafri (300253861)

:- use_module(library(dcg/basics)).
:- dynamic destination/4.
:- dynamic expense/3.

% Add a destination
add_destination(Name, StartDate, EndDate, Budget) :-
    assert(destination(Name, StartDate, EndDate, Budget)).

% Remove a destination
remove_destination(Name) :-
    retract(destination(Name, _, _, _)).

% Add an expense
add_expense(Destination, Category, Amount) :-
    assert(expense(Destination, Category, Amount)).

% Calculate total expenses for a destination
total_expenses(Destination, Total) :-
    findall(Amount, expense(Destination, _, Amount), Amounts),
    sum_list(Amounts, Total).

validate_budget(Destination) :-
    destination(Destination, _, _, Budget),
    total_expenses(Destination, Total),
    Total =< Budget,
    !, % Cut operator to stop backtracking
    writeln('Within budget').
validate_budget(_) :-
    writeln('Budget exceeded').

% Filter destinations by date range
filter_destinations_by_date(StartDate, EndDate, Destinations) :-
    findall(Name, (destination(Name, Start, End, _), Start >= StartDate, End =< EndDate), Destinations).

% Filter expenses by category
filter_expenses_by_category(Category, Expenses) :-
    findall((Destination, Amount), expense(Destination, Category, Amount), Expenses).

% DCG rules for parsing commands
command(add_destination(Name, Start, End, Budget)) -->
    "add destination ", string(NameCodes), " ",
    date(Start), " ", date(End), " ", integer(Budget),
    { atom_codes(Name, NameCodes) }.

date(date(Year, Month, Day)) -->
    integer(Year), "-", integer(Month), "-", integer(Day).

% predicate to handle parsed command
parse_and_execute(CommandString) :-
    string_codes(CommandString, Codes),
    phrase(command(Command), Codes),
    execute_command(Command).

execute_command(add_destination(Name, Start, End, Budget)) :-
    add_destination(Name, Start, End, Budget).

% Save journey to file
save_journey(File) :-
    open(File, write, Stream),
    forall(destination(Name, Start, End, Budget),
        write(Stream, destination(Name, Start, End, Budget)), nl(Stream)),
    forall(expense(Destination, Category, Amount),
        write(Stream, expense(Destination, Category, Amount)), nl(Stream)),
    close(Stream).

% Load journey from file
load_journey(File) :-
    exists_file(File),
    open(File, read, Stream),
    repeat,
    read(Stream, Term),
    ( Term == end_of_file -> !, close(Stream) ; assert(Term), fail ).
