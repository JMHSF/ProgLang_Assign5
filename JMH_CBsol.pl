/*
Student: Jonathan Hilgendorf
Class: Programming languages
Duedate: Nov. 4, 2019

Description:

This program computes a solution for the cracker barrel peg puzzle,
such that only one peg remains, and all moves have one peg "jump"
over a neighboring peg into an empty place, removing the jumped peg
from play.

It works by defining the possible moves to make and the cells
associated with them, then recursively calling the jump command
while passing a changing list of occupied and unoccuplied cells to
make further jump calls on.

It uses the following layout for the board:
           1
        2    3
      4    5    6
   7    8    9    10
11   12   13   14    15
  
  To run, type: "solve(X)."
  
  
% Solution based off work of Denver Jayroe, from: 
% https://gist.github.com/denverj23/5e6de0bc4b90c88a304ce7cf6d693d8f
*/

/* check moves possible and recursively go until completed */
jump(_, [_], Lst, Moves):-
    reverse(Lst, Moves).
jump(Free, Occupied, Lst, Moves):-
	/* finds a starting peg (S) such that when removed from Occupied, results in Oc1 */
    select(S, Occupied, Oc1),
	/* find a middle peg (M) from the occupied list remaining from the above */
    select(M, Oc1, Oc2),
	/* finds an ending cell (E) that is listed in the free cells */
    select(E, Free, F1),
	/* Move such that S jumps M to land on E */
    move(S, M, E),
	/* Retests jump with S and M in free ... E is added to Occupied ... add "move(S,M,E)" to the list of moves to get to the solution ...  */
    jump([S, M | F1], [E | Oc2], [move(S,M,E) | Lst], Moves).

/* Call for running solution check; initial move */
solve(P):-
	/* 1 = only unoccupied slot, 2-15 are occupied ...  initial list of moves is empty*/
    jump([1], [2,3,4,5,6,7,8,9,10,11,12,13,14,15], [], P).
	
/* Rules: List of moves possible */
move(S,2,E):- member([S,E], [[1,4], [4,1]]). /* 1>2>4 or 4>2>1 */
move(S,3,E):- member([S,E], [[1,6], [6,1]]). /* 1>3>6 or 6>3>1 */
move(S,4,E):- member([S,E], [[2,7], [7,2]]). /* ... and so on */
move(S,5,E):- member([S,E], [[2,9], [9,2]]).
move(S,5,E):- member([S,E], [[3,8], [8,3]]).
move(S,6,E):- member([S,E], [[3,10], [10,3]]).
move(S,5,E):- member([S,E], [[4,6], [6,4]]).
move(S,7,E):- member([S,E], [[4,11], [11,4]]).
move(S,8,E):- member([S,E], [[4,13], [13,4]]).
move(S,8,E):- member([S,E], [[5,12], [12,5]]).
move(S,9,E):- member([S,E], [[5,14], [14,5]]).
move(S,9,E):- member([S,E], [[6,13], [13,6]]).
move(S,10,E):- member([S,E], [[6,15], [15,6]]).
move(S,8,E):- member([S,E], [[9,7], [7,9]]).
move(S,9,E):- member([S,E], [[10,8], [8,10]]).
move(S,12,E):- member([S,E], [[11,13], [13,11]]).
move(S,13,E):- member([S,E], [[12,14], [14,12]]).
move(S,14,E):- member([S,E], [[15,13], [13,15]]).
