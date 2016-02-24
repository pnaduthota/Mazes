# Mazes
PA3 in COSI166b

Carve_path algorithm:
Each direction is assigned a number. North is 1, south is 2, east is
4, and west is 8. If a coordinate can go a particular direction, that direction
is added to that coordinate. Basically, if at (0,0) we can go north, (0,0) is
assigned the number 1. If we can go (0,0) we can go north and south, (0,0) is
assigned the number 3. A full table is below. Carving a path means that if you
can go from (0,0) to (0,1), (0,0) is assigned 4 (you can go east) and (0,1) is
assigned 8 (you can go west).

The algorithm is implemented this way is so as to better print the table.

solve:
When solving the maze, recursively backtrack from the beginning point, trying
each direction (N, S, E, W)

Table of values indicating directions

Coordinate can go:

no direction => 0

N => 1
S => 2
E => 4
W => 8

N, S => 3
N, E => 5
N, W => 9
N, S, E => 7
N, S, W => 11
N, E, W => 13

S, E => 6
S, W => 10
S, E, W => 14

E, W => 12
N, S, E, W => 15



Note: I lost my free trial to Code Climate, or I would have added the link.
