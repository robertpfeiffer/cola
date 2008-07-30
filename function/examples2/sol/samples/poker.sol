{ sol-program }

start-world poker-hands.

;; CLASSES

create kinds.
create suits.
create card kind suit.
create hand cards.
create dealers cards.
create player hand.

;; INSTANCES

for { ace duece three four five six seven eight nine ten jack queen king } do make kinds each.
for { diamonds clubs hearts spades } do make suits each.
for all kinds * all suits do make card ( each first + -of- + each second ) ( each first ) ( each second ).
make dealers dealer (52 random card).
make hand my-hand { }.
make hand your-hand { }.
make player my my-hand.
make player your your-hand.

;;QUALIFICATIONS

qualify hand royal-flush yes if its flush = yes and its cards kind = { ten jack queen king ace }.
qualify hand straight-flush yes if its straight = yes and its flush = yes.
qualify hand four-of-a-kind yes if for any all kinds do (select its cards by of kind = each) size = 4.
qualify hand full-house yes if its cards kind size = 2 and its four-of-a-kind = no.
qualify hand flush yes if its cards suit size = 1.
qualify hand straight yes if its cards kind = { ace deuce three four five } or 
	      	    	     its cards kind = { deuce three four five six } or
	      	    	     its cards kind = { three four five six seven } or
	      	    	     its cards kind = { four five six seven eight } or
	      	    	     its cards kind = { five six seven eight nine } or
	      	    	     its cards kind = { six seven eight nine ten } or
	      	    	     its cards kind = { seven eight nine ten jack } or
	      	    	     its cards kind = { eight nine ten jack queen } or
	      	    	     its cards kind = { nine ten jack queen king } or
	      	    	     its cards kind = { ten jack queen king ace }.
qualify hand three-of-a-kind yes if for any all kinds do (select its cards by of kind = each) size = 3.
qualify hand two-pairs yes if its three-of-a-kind = no and its cards kind size = 3.
qualify hand one-pair yes if its cards kind size = 4.
qualify hand value royal-flush if its royal-flush = yes.
qualify hand value straight-flush if its straight-flush = yes and its royal-flush = no.
qualify hand value four-of-a-kind if its four-of-a-kind = yes.
qualify hand value full-house if its full-house = yes.
qualify hand value flush if its flush = yes and
	      	    	    its royal-flush = no and
		            its straight-flush = no.
qualify hand value straight if its straight = yes and 
	      	    	       its royal-flush = no and 
			       its straight-flush = no.
qualify hand value three-of-a-kind if its three-of-a-kind = yes and
	      	    		  its four-of-a-kind = no and
				  its full-house = no.
qualify hand value two-pairs if its two-pairs = yes.
qualify hand value one-pair if its one-pair = yes.
qualify hand value nothing if its flush = no and
	      	    	      its straight = no and
			      its three-of-a-kind = no and
			      its two-pairs = no and
			      its one-pair = no.
qualify hand worth 9 if its value = royal-flush.
qualify hand worth 8 if its value = straight-flush.
qualify hand worth 7 if its value = four-of-a-kind.
qualify hand worth 6 if its value = full-house.
qualify hand worth 5 if its value = flush.
qualify hand worth 4 if its value = straight.
qualify hand worth 3 if its value = three-of-a-kind.
qualify hand worth 2 if its value = two-pairs.
qualify hand worth 1 if its value = one-pair.
qualify hand worth 0 if its value = nothing.
rel-qualify handA better handB if handA worth > handB worth. 
rel-qualify handA worse handB if handA worth < handB worth. 

;; ACTIONS

action dealers deal consequence 
       my hand cards = 5 random its cards and
       its cards = its cards - my hand cards and
       your hand cards = 5 random its cards and
       its cards = its cards - your hand cards.
rule dealers deal is its cards size >= 10.

;; QUERIES
dealer do deal.
;is (my hand) better (your hand).

end-file.


