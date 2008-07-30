{ sol-program }

start-world triples.

;; CLASSES

create col-obj number.
create square col row contains is-goal arrows.
create player opponent position goal-square turn.
create direction.

;; QUALIFICATIONS (DYNAMIC PROPERTIES)

qualify square next-up the select all square by of col = its col and of row = its row + 1.
qualify square next-down the select all square by of col = its col and of row = its row - 1.
qualify square next-right the select all square by of row = its row and of col number = its col number + 1.
qualify square next-left a select all square by of row = its row and of col number = its col number - 1.
qualify square next-up-open yes if not its next-up = no and its next-up contains = none.
qualify square next-down-open yes if not its next-down = no and its next-down contains = none.
qualify square next-right-open yes if not its next-right = no and its next-right contains = none.
qualify square next-left-open yes if not its next-left = no and its next-left contains = none.
qualify player move-up-valid yes if its position next-up-open = yes and up in its opponent position arrows.
qualify player move-down-valid yes if its position next-down-open = yes and down in its opponent position arrows.
qualify player move-right-valid yes if its position next-right-open = yes and right in its opponent position arrows.
qualify player move-left-valid yes if its position next-left-open = yes and left in its opponent position arrows.
qualify player stuck yes if its turn = yes and not ( its move-up-valid = yes or its move-down-valid = yes or its move-right-valid = yes or its move-left-valid = yes ).
qualify player goal-distance (its position col number - its goal-square col number) ** 2 +
	      		     (its position row - its goal-square row ) ** 2.

;; ACTIONS

action player move direction 
       consequence its position contains = none and 
       		   its position = its position next-down if direction = down and 
		   its position = its position next-right if direction = right and 
		   its position = its position next-up if direction = up and 
		   its position = its position next-left if direction = left and 
		   its position contains = it and
		   its turn = no and
		   its opponent turn = yes.

rule player move is its turn = yes.
rule player move is not direction = down or its move-down-valid = yes.
rule player move is not direction = right or its move-right-valid = yes.
rule player move is not direction = up or its move-up-valid = yes.
rule player move is not direction = left or its move-left-valid = yes.

;; GOAL

goal player win try its position = its goal-square or its opponent stuck = yes. 
heuristic player win minimize its goal-distance.

;; INSTANCES

for { down right up left } do make direction each.
make col-obj a 1.
make col-obj b 2.
make col-obj c 3.
make col-obj d 4.
make col-obj e 5.
make col-obj f 6.
make col-obj g 7.
make col-obj h 8.
for { a b c d e f g h } * { 1 2 3 4 5 6 7 8 } do make square (each first + each second) (each first) (each second) none no (3 random direction).
make square a1 a 1 white no (all direction).
make square h1 h 1 black no (all direction).
make square a8 a 8 none black (all direction).
make square h8 h 8 none white (all direction).
for { d e } * { 4 5 } do make square (each first + each second) (each first) (each second) block no none.
make player white black a1 h8 yes.
make player black white h1 a8 no.

;; QUERIES	
;for all square do each arrows.
;time.
;white position.
;black position.
;white do move left.
;is black win satisfiable.
;black satisfy win.
;white do move up.
;black do move.
; done.

end-file.
