% CSI 3120: LAB 7 - Group 43
% - Alex Clements (300237898)
% - Rina Osman (300222206)
% - Sameed Jafri (300253861)

% dynamic declarations
:- dynamic book/4.
:- dynamic borrowed/4.

% predicate adds a book to the library and ensures no duplicates
add_book(Title, Author, Year, Genre) :-
    \+ book(Title, Author, Year, Genre),
    assertz(book(Title, Author, Year, Genre)).

% predicate removes a book from the library and the borrowed status of said book
remove_book(Title, Author, Year, Genre) :-
    retract(book(Title, Author, Year, Genre)),
    retractall(borrowed(Title, Author, Year, Genre)).

% checks to see if a book is available (in library and not borrowed)
is_available(Title, Author, Year, Genre) :-
    book(Title, Author, Year, Genre),
    \+ borrowed(Title, Author, Year, Genre).

% predicate that lets the user borrow a book from the library
borrow_book(Title, Author, Year, Genre) :-
    is_available(Title, Author, Year, Genre), % Ensure the book is available.
    assertz(borrowed(Title, Author, Year, Genre)).

% predicate to return a book to the library
return_book(Title, Author, Year, Genre) :-
    retract(borrowed(Title, Author, Year, Genre)).

% predicate to find a book by its author
find_by_author(Author, Books) :-
    findall(Title, book(Title, Author, _, _), Books).

% predicate to find a book by its genre
find_by_genre(Genre, Books) :-
    findall(Title, book(Title, _, _, Genre), Books).

% predicate to find a book by its year
find_by_year(Year, Books) :-
    findall(Title, book(Title, _, Year, _), Books).

% predicate that recommends books based on genre
recommend_by_genre(Genre, Recommendations) :-
    find_by_genre(Genre, Recommendations).

% predicate that recommends books based on author
recommend_by_author(Author, Recommendations) :-
    find_by_author(Author, Recommendations).
