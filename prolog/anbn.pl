:- use_module(library(clpfd)).

in_language(Word) :-
    automaton(Word, _,
        Word, [source(a), sink(a), sink(b)], 
        [arc(a, 0, a, [C + 1]), arc(a, 1, b, [C - 1]),
        arc(b, 1, b, [C - 1])], 
        [C], [0], [0]).
    