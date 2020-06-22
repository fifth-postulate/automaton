# automaton
Exploration of `automaton/8` of the clpfd Prolog library

## Contraint logic Programming over Finite Domains 
There is a wonderful Prolog library [`clpfd`][clpfd]. It allows one to constrain variables in various ways.

But it has a intriguing constraint [`automaton/8`][automaton/8]. It came up in the excellent pathway [tutorial on clpfd][tutorial] with the following phrase:

> `automaton/8` - on hold til I understand it 

This document is an attempt to do just that.

## `automaton/3`
The infamous `automaton/8` has a sibling constraint `automaton/3`. We will first take a look at that to get a feel for the problem domain.

[`automaton/3`][automaton/3] is described as:

> Describes a list of finite domain variables with a finite automaton

Now finite automaton and regular languages are closely related. In fact for every regular language there is a finite automaton that accepts it. Furthermore, the words that a finite automaton accepts are a regular language.

### Regular Language
An example of a regular language are the strings that consists of the characters 0 and 1, contain at least a single 1 and avoids two consecutive 1s.

We should be able to construct a finite automaton that accepts this language.

![Automaton that accepts a regular language](http://fifth-postulate.nl/automaton/regular.svg)

In the above automaton `a` is our source node, i.e. the automaton starts at node `a`. For each character that we encounter we follow the corresponding edge to the next node. Double circled nodes indicate sinks. A sequence of characters is accepted if we end up in one of the sink nodes after all characters are processed.

The following [code][code:regular] is a direct translation of our finite automaton.

```prolog
in_language(Cs) :-
    automaton(Cs, [source(a), sink(b), sink(c)], 
    [arc(a, 0, a), arc(a, 1, b),
    arc(b, 0, c),
    arc(c, 0, c), arc(c, 1, b)]).
```

We can use it to check that `[1, 0, 0, 1]` is in our language and `[1, 0, 1, 1]` is not.

```plain
?- in_language([1, 0, 0, 1]).
true

?- in_language([1, 0, 1, 1]).
false
```

We can even ask Prolog to generate all words in our language of length 5.

```plain
?- length(Word, 5), in_language(Word), label(Word).
Word = [0, 0, 0, 0, 1] ;
Word = [0, 0, 0, 1, 0] ;
Word = [0, 0, 1, 0, 0] ;
Word = [0, 0, 1, 0, 1] ;
Word = [0, 1, 0, 0, 0] ;
Word = [0, 1, 0, 0, 1] 
```

## Context Free Language
Let's say we wanted an automaton that would accept words over the alphabet `0` and `1`, that start with a run of `0`s and finish with a run of `1`s of the same length.

The following words are in the language `[]`, `[0, 1]`, `[0, 0, 1, 1]` etcetera.

If you thinkg hard about design an automaton, you could come to the conclusion that it would not work. One could reason as follows

We need a state to represent that we haven't seen a zero yet. If we encounter a '0' we should transition to a state that represents that we have seen 1 zero. If we encountered an other zero in that state we should transition to a state that represented that we have seen 2 zeroes.

Since the number of zeroes can grow without bounds in a word of our language we can't settle for a finite number of nodes for our automaton. There are never enough nodes.

### `automaton/8` to the resque
This is where `automaton/8` comes in. Take a look at the following automaton.

![Automaton that accepts a context-free language](http://fifth-postulate.nl/automaton/context-free.svg)

Note that the edges have a special kind of label. For example the edge between node `a` and `b` is labeled `1/C-1`.

`C` refers to a counter and the label should be interpreted as follows. When in state `a`, if you encounter the character `1`, decrement counter `C`, and transition to node `b`.

`C` counts the number of `0` it has seen. If we start out with our counter `C` at zero, increment it when we see an `0`, decrement it when we see an `1` then we can accept the word when we and up in a sink state with counter `C` back at zero.

```prolog
in_language(Word) :-
    automaton(Word, _,
        Word, [source(a), sink(a), sink(b)], 
        [arc(a, 0, a, [C + 1]), arc(a, 1, b, [C - 1]),
        arc(b, 1, b, [C - 1])], 
        [C], [0], [0]).
```

The above [code][code:free] is our automaton. There is a lot of information so let's unpack it. For now we are going to ignore the first two arguments.

The second `Word` argument, the sources and sinks are familiar. They play the same part in `automaton/3`.

The next argument looks familiar. It describes the edges in our automaton. But for `automaton/8` you are allowed to have a fourth argument to arc. This argument will be used to update a list of counters.

Variable in that list refer to terms defined in the next argument of `automaton/8`. In our case we have only one counter `[C]`.


[clpfd]: https://www.swi-prolog.org/pldoc/man?section=clpfd
[automaton/8]: https://www.swi-prolog.org/pldoc/doc_for?object=automaton/8
[automaton/3]: https://www.swi-prolog.org/pldoc/doc_for?object=automaton/3
[tutorial]: http://pathwayslms.com/swipltuts/clpfd/clpfd.html
[code:regular]: https://github.com/fifth-postulate/automaton/blob/master/prolog/regular.pl
[code:free]: https://github.com/fifth-postulate/automaton/blob/master/prolog/anbn.pl