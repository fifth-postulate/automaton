:- use_module(library(clpfd)).

valid_instructions(Instructions) :-
    commands(Instructions, Commands),
    automaton(Instructions, instruction(_, FuelCost), Commands,
        [source(north), sink(north), sink(east), sink(south), sink(west)], 
        [arc(north, 0, north, [X, Y+1, Fuel-FuelCost]), arc(north, 1, east, [X, Y, Fuel-FuelCost]), arc(north, -1, west, [X, Y, Fuel-FuelCost]),
         arc(east, 0, east, [X+1, Y, Fuel-FuelCost]), arc(east, 1, south, [X, Y, Fuel-FuelCost]), arc(east, -1, north, [X, Y, Fuel-FuelCost]),
         arc(south, 0, south, [X, Y-1, Fuel-FuelCost]), arc(south, 1, west, [X, Y, Fuel-FuelCost]), arc(south, -1, east, [X, Y, Fuel-FuelCost]),
         arc(west, 0, west, [X-1, Y, Fuel-FuelCost]), arc(west, 1, north, [X, Y, Fuel-FuelCost]), arc(west, -1, south, [X, Y, Fuel-FuelCost])],
        [X, Y, Fuel], [0, 0, 5], [2, 1, 0]).

commands([], []).
commands([Instruction|Instructions], [Command|Commands]) :-
    command(Instruction, Command),
    commands(Instructions, Commands).

command(instruction(forward, _), 0).
command(instruction(right, _), 1).
command(instruction(left, _), -1).

some_instructions([instruction(forward, 2), instruction(right, 1), instruction(forward, 1), instruction(forward, 1)]).
