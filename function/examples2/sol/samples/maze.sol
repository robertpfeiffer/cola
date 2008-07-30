{ sol-program }

start-world maze.

;; CLASSES

create square col row contains is-goal.
create col-obj letter number. 
create row-obj number.
create robot position goal-square.
create direction.

;; QUALIFICATIONS (DYNAMIC PROPERTIES)

qualify square next-up the select all square by of col = its col and of row number = its row number + 1.
qualify square next-down the select all square by of col = its col and of row number = its row number - 1.
qualify square next-right the select all square by of row number = its row number and of col number = its col number + 1.
qualify square next-left a select all square by of row number = its row number and of col number = its col number - 1.
qualify square next-up-open yes if not its next-up = no and its next-up contains = none.
qualify square next-down-open yes if not its next-down = no and its next-down contains = none.
qualify square next-right-open yes if not its next-right = no and its next-right contains = none.
qualify square next-left-open yes if not its next-left = no and its next-left contains = none.
qualify robot goal-distance (its position col number - its goal-square col number) ** 2 +
	      		    (its position row number - its goal-square row number) ** 2.

;; INSTANCES

for { down right up left } do make direction each.
for { 1 2 3 4 5 } do make row-obj ( row + each ) each.
make col-obj colA A 1.
make col-obj colB B 2.
make col-obj colC C 3.
make col-obj colD D 4.
make col-obj colE E 5.
make square A1 colA row1 roby no.
make square A2 colA row2 none no.
make square A3 colA row3 none no.
make square A4 colA row4 none no.
make square A5 colA row5 none no.
make square B1 colB row1 block no.
make square B2 colB row2 block no.
make square B3 colB row3 none no.
make square B4 colB row4 block no.
make square B5 colB row5 none no.
make square C1 colC row1 none no.
make square C2 colC row2 none no.
make square C3 colC row3 none no.
make square C4 colC row4 none no.
make square C5 colC row5 block no.
make square D1 colD row1 none no.
make square D2 colD row2 block no.
make square D3 colD row3 none no.
make square D4 colD row4 block no.
make square D5 colD row5 none no.
make square E1 colE row1 none no.
make square E2 colE row2 none no.
make square E3 colE row3 none no.
make square E4 colE row4 none no.
make square E5 colE row5 none yes.
make robot roby A1 E5.

;; ACTIONS

action robot move direction 
       consequence its position contains = block and 
       		   its position = its position next-down if direction = down and 
		   its position = its position next-right if direction = right and 
		   its position = its position next-up if direction = up and 
		   its position = its position next-left if direction = left and 
		   its position contains = it.

rule robot move is not direction = down or its position next-down-open = yes.
rule robot move is not direction = right or its position next-right-open = yes.
rule robot move is not direction = up or its position next-up-open = yes.
rule robot move is not direction = left or its position next-left-open = yes.

;; GOALS

goal robot find-goal try its position = its goal-square.
heuristic robot find-goal minimize its goal-distance.

;; QUERIES	
time.
roby position.
;at time 0 roby position.
;at time 1 roby position.
;at time 2 roby position.
;at time 3 roby position.
;at time 4 roby position.
;at time 5 roby position.
;is roby find-goal satisfiable.
;roby satisfy find-goal.
;roby satisfy find-goal.
;roby do move up.
;roby do move.
;is roby find-goal satisfiable.
;roby satisfy find-goal.
; done.

end-file.

;;             Maze
;;	      ---------------------
;;	      |   |   | X |   | G | 5
;;	      ---------------------
;;	      |   | X |   | X |   | 4
;;	      ---------------------
;;	      |   |   |   |   |   | 3
;;	      ---------------------
;;	      |   | X |   | X |   | 2
;;	      ---------------------
;;	      | R | X |   |   |   | 1
;;	      ---------------------
;;	        A   B   C   D   E
;;	       
;;
