:- use_module(library(clpfd)).

in_language(Xs) :-
    automaton(Xs, _,
        Xs, [source(a), sink(a), sink(b)], 
        [arc(a, 0, a, [NumberOfBsToRemove + 1]), arc(a, 1, b, [NumberOfBsToRemove - 1]),
        arc(b, 1, b, [NumberOfBsToRemove - 1])], 
        [NumberOfBsToRemove], [0], [0]).
    