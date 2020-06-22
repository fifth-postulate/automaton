:- use_module(library(clpfd)).

in_language(Word) :-
    automaton(Word, [source(a), sink(b), sink(c)], 
    [arc(a, 0, a), arc(a, 1, b),
    arc(b, 0, c),
    arc(c, 0, c), arc(c, 1, b)]).
    
