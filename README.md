# automaton
Exploration of `automaton/8` of the clpfd Prolog library

## Constraining `a^nb^n`
There is a wonderful Prolog library [`clpfd`][clpfd]. It allows one to contrain variables in various ways.

But it has a intriguing constraint [`automaton/8`][automaton/8]. It came up in the excellent pathway [tutorial on clpfd][tutorial] with the following phrase:

> `automaton/8` - on hold til I understand it 

This repository is an attempt to do just that.

## `automaton/3`
The infamous `automaton/8` has a sibling constraint `automaton/3`. We will first take a look at that to get a feel for the problem domain.

[`automaton/3`][automaton/3] is described as: Describes a list of finite domain variables with a finite automaton

Now finite automaton and regular languages are closely related. In fact for every regular language there is a finite automaton that accepts it. Furthermore, the words that a finite automaton accepts are a regular language.

## Example
An example of a regular language are the strings that consists of the characters 0 and 1, contain at least a single 1 and avoids two consecutive 1s.

We should be able to construct a finite automaton that accepts this language.

![Example Automaton](http://fifth-postulate.nl/automaton/automaton.svg)

The finite automaton above accepts our regular language. Red lines are 0-transitions and blue lines are 1-transitions. 

[clpfd]: https://www.swi-prolog.org/pldoc/man?section=clpfd
[automaton/8]: https://www.swi-prolog.org/pldoc/doc_for?object=automaton/8
[automaton/3]: https://www.swi-prolog.org/pldoc/doc_for?object=automaton/3
[tutorial]: http://pathwayslms.com/swipltuts/clpfd/clpfd.html