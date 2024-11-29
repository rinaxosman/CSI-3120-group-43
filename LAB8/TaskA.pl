% CSI 3120: LAB 8 - Group 43
% - Alex Clements (300237898)
% - Rina Osman (300222206)
% - Sameed Jafri (300253861)

% ChatGPT assistance used for saving and loading implementation
% other sources used:
% - https://stackoverflow.com/questions/72836302/how-to-use-assert-and-retract-in-swi-prolog
% - https://www.swi-prolog.org/pldoc/man?predicate=retract/1

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
    findall(Name, 
        (
            destination(Name, Start, End, _),
            date_to_number(Start, StartNum),
            date_to_number(End, EndNum),
            date_to_number(StartDate, QueryStartNum),
            date_to_number(EndDate, QueryEndNum),
            StartNum >= QueryStartNum,
            EndNum =< QueryEndNum
        ), 
        Destinations).

% Helper predicate: Convert a date (Year-Month-Day) to a numeric value for comparison
date_to_number(date(Year, Month, Day), Number) :-
    Number is Year * 10000 + Month * 100 + Day.

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
        (
            write_term(Stream, destination(Name, Start, End, Budget), [fullstop(true)]),
            nl(Stream)
        )),
    forall(expense(Destination, Category, Amount),
        (
            write_term(Stream, expense(Destination, Category, Amount), [fullstop(true)]),
            nl(Stream)
        )),
    close(Stream).

% Load journey from file
load_journey(File) :-
    exists_file(File),
    open(File, read, Stream),
    repeat,
    read_term(Stream, Term, []),
    ( Term == end_of_file -> 
        close(Stream), !
    ; 
        assertz(Term), 
        fail ).

% Error handling for missing file
load_journey(File) :-
    \+ exists_file(File),
    writeln('Error: File does not exist.').
