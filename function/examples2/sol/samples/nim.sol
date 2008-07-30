{ sol-program }
start-world nim.
create board number-stones.
create player opponent turn.
create number-take-stones number.
make number-take-stones one 1.
make number-take-stones two 2.
make board nim-board 9.
make player player1 player2 yes.
make player player2 player1 no.

qualify player status won if its turn = no and nim-board number-stones = 0.
action player take number-take-stones 
       consequence nim-board number-stones = nim-board number-stones - number-take-stones number and
		   its turn = no and
		   its opponent turn = yes.
rule player take is its turn = yes.
rule player take is number-take-stones number <= nim-board number-stones.
goal player win try its status = won.

end-file.
