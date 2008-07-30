{ sol-program }

start-world chess.

;; CLASSES

create square col row contains.
create player pieces opponent turn.
create piece kind position color.

;; QUALIFICATIONS (DYNAMIC PROPERTIES)

;; INSTANCES

; squares:
for { a b c d e f g h } * { 3 4 5 6 } do make square (each first + each second) (each first) (each second) none.
for { a b c d e f g h } do make square (each + 2) each 2 (white-pawn- + each).
for { a h } do make square (each + 1) each 1 (white-rook- + each).
for { b g } do make square (each + 1) each 1 (white-knight- + each).
for { c f } do make square (each + 1) each 1 (white-bishop- + each).
make square d1 d 1 white-queen.
make square e1 e 1 white-king.
for { a b c d e f g h } do make square (each + 7) each 7 (black-pawn- + each).
for { a h } do make square (each + 8) each 8 (black-rook- + each).
for { b g } do make square (each + 8) each 8 (black-knight- + each).
for { c f } do make square (each + 8) each 8 (black-bishop- + each).
make square d8 d 8 black-queen.
make square e8 e 8 black-king.

; pieces:
for { a b c d e f g h } do make piece (white-pawn- + each) pawn (each + 2) white.
for { a h } do make piece (white-rook- + each) rook (each + 1) white.
for { b g } do make piece (white-knight- + each) knight (each + 1) white.
for { c f } do make piece (white-bishop- + each) bishop (each + 1) white.
make piece white-queen d1 queen white.
make piece white-king e1 king white.
for { a b c d e f g h } do make piece (black-pawn- + each) pawn (each + 2) black.
for { a h } do make piece (black-rook- + each) rook (each + 8) black.
for { b g } do make piece (black-knight- + each) knight (each + 8) black.
for { c f } do make piece (black-bishop- + each) bishop (each + 8) black.
make piece black-queen queen d8 black.
make piece black-king king d8 black.

; players:
make player white (all white color piece) black yes.
make player black (all black color piece) black no.

;; ACTIONS
/*
action player move from to consequence

rule player move is player turn = yes and
     	    	    from in 
		    not from contains = none and
		    from contains color = its color and
		     
*/
;; GOALS

;; QUERIES

end-file.


