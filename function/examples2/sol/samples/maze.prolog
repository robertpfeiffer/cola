/* a square: [<col#>,<row#>] */

robot_at([1,4]).
goal_at([3,4]).
block_at([2,2]).
block_at([2,4]).

next_down([Col,Row], [Col,RowDown]) :- RowDown is Row - 1, RowDown > 0.
next_up([Col,Row], [Col,RowUp]) :- RowUp is Row + 1, RowUp < 5.
next_left([Col,Row], [ColLeft,Row]) :- ColLeft is Col - 1, ColLeft > 0.
next_right([Col,Row], [ColRight,Row]) :- ColRight is Col + 1, ColRight < 4.

next(CurSq,down,NextSq) :- next_down(CurSq, NextSq).
next(CurSq,up,NextSq) :- next_up(CurSq, NextSq).
next(CurSq,left,NextSq) :- next_left(CurSq, NextSq).
next(CurSq,right,NextSq) :- next_right(CurSq, NextSq).
 
move(CurSq,Dir,NextSq) :- next(CurSq,Dir,NextSq), \+ block_at(NextSq).

moves_h(CurSq, [], CurSq, Visited).
moves_h(CurSq, [MovesFirst|MovesRest], DestSq, Visited) :- move(CurSq,MovesFirst,NextSq),
	                                                 \+ member(NextSq,Visited),
	                                                 moves_h(NextSq,MovesRest,DestSq, [CurSq|Visited]).

moves(CurSq,Moves,DestSq) :- moves_h(CurSq,Moves,DestSq,[]).

find_path(Moves) :- robot_at(RobotPos), 
	            goal_at(GoalPos),
	            moves(RobotPos,Moves,GoalPos).

/* 

 Maze:
-------------
| R | X | G | 4
-------------
|   |   |   | 3
-------------
|   | X |   | 2
-------------
|   |   |   | 1  
-------------
  1   2   3

*/