% CSI 3120: LAB 5 - Group 43
% - Alex Clements (300237898)
% - Rina Osman (300222206)
% - Sameed Jafri (300253861)

/* Parent-child relationships */
parent(john, mary).
parent(john, tom).
parent(mary, ann).
parent(mary, fred).
parent(tom, liz).

/* Genders */
male(john).
male(tom).
male(fred).
female(mary).
female(ann).
female(liz).

/* Rules */

/* Siblings share at least one parent and are not the same person. */
sibling(X, Y) :-
    parent(Parent, X),
    parent(Parent, Y),
    X \= Y.

/* Grandparent is a parent of a parent. */
grandparent(GP, Grandchild) :-
    parent(GP, Parent),
    parent(Parent, Grandchild).

/* Ancestors: A person is an ancestor if they are a parent or if they are a parent of an ancestor. */
ancestor(Anc, Descendant) :-
    parent(Anc, Descendant).
ancestor(Anc, Descendant) :-
    parent(Parent, Descendant),
    ancestor(Anc, Parent).
