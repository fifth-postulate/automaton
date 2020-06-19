:- use_module(library(clpfd)).

in_language(Xs) :-
    automaton(Xs, _,
        Xs, [source(a), sink(a), sink(c)], 
        [arc(a, 0, a, [NumberOfBsToRemove + 1, NumberOfCsToRemove]), arc(a, 1, b, [NumberOfBsToRemove - 1, NumberOfCsToRemove + 1]),
        arc(b, 1, b, [NumberOfBsToRemove - 1, NumberOfCsToRemove + 1]), arc(b, 2, c, [NumberOfBsToRemove, NumberOfCsToRemove - 1]),
        arc(c, 2, c, [NumberOfBsToRemove, NumberOfCsToRemove - 1])], 
        [NumberOfBsToRemove, NumberOfCsToRemove], [0, 0], [0, 0]).
 