:- use_module(library(clpfd)).

/**
 * # Wolf Goat Cabbage Puzzle
 * This is the famous Farmer, Wolf, Goat, Cabbage puzzle solved with `automaton/3`.
 *
 * ## Model
 * ### Nodes
 * For each legal state in the puzzle we will have a node in our automaton.
 * The nodes in our automaton are atoms written with the letters:
 * 
 * * `f` for farmer
 * * `w` for wolf
 * * `g` for goat
 * * `c` for cabbage
 * * `r` for river
 * 
 * So `fwgcr` has all the participants on the left bank while `wcrfg` would have the
 * wolf and the cabbage on the left bank and and the farmer and the goat on the right
 * bank.
 * 
 * We will make sure only to have valid nodes.
 *
 * ### Edges
 * For the labels we have signed integers. The following association between numbers
 * and participants is made
 * 
 * * `w` = 3
 * * `g` = 2
 * * `c` = 1
 * 
 * Furthermore, the numbers are positive when a participant moves from the left bank to
 * the right bank and are negative when a participant moves from the right bank to the
 * left bank.
 * 
 * ### Convenience
 * In order to help a describe a candidat solution we introduce a terms `lr(Participant)`
 * that represents that `Participant` moves from the left bank to the right bank and
 * `rl(Participant)` representing the opposite move. We can convert between the two with
 * `move_number`
 */

move_number(lr(Participant), ParticipantNumber) :-
    participant_number(Participant, ParticipantNumber).
move_number(rl(Participant), MoveNumber) :-
    participant_number(Participant, ParticipantNumber),
    MoveNumber is -1 * ParticipantNumber.

participant_number(f, 4).
participant_number(w, 3).
participant_number(g, 2).
participant_number(c, 1).

valid(Moves) :-
    move_numbers(Moves, Numbers),
    automaton(Numbers, [source(fwgcr), sink(rfwgc)],
    [arc(fwgcr, 2, wcrfg),
     arc(fgcrw, 2, crfwg), arc(fgcrw, 1, grfwc),
     arc(fwcrg, 3, crfwg), arc(fwcrg, 1, wrfgc), arc(fwcrg, 4, wcrfg),
     arc(fwgrc, 3, grfwc), arc(fwgrc, 2, wrfgc),
     arc(fgrwc, 2, rfwgc), arc(fgrwc, 4, grfwc),
     arc(wcrfg, -2, fwgcr), arc(wcrfg, -4, fwcrg),
     arc(crfwg, -3, fwcrg), arc(crfwg, -2, fgcrw),
     arc(grfwc, -3, fwgrc), arc(grfwc, -1, fgcrw), arc(grfwc, -4, fgrwc),
     arc(wrfgc, -2, fwgrc), arc(wrfgc, -1, fwcrg),
     arc(rfwgc, -2, fgrwc)]).

move_numbers([], []).
move_numbers([Move|Moves], [Number|Numbers]) :-
    move_number(Move, Number),
    move_numbers(Moves, Numbers).

go(Moves, N) :-
    length(Moves, L),
    L #=< N,
    valid(Moves).