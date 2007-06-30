JOLT = ../../jolt-burg/main

all : peg.k

peg.k :
	$(JOLT) boot.k yy-boot.k peg.peg
	$(JOLT) boot.k peg.peg.k -o peg.k peg.peg
	diff peg.peg.k peg.k

test : basic.peg.k
	$(JOLT) boot.k basic.peg.k examples/test.bas
#	$(JOLT) boot.k basic.peg.k examples/fibonacci.bas
	$(JOLT) boot.k basic.peg.k examples/bench.bas

basic.peg.k : peg.k examples/basic.peg
	$(JOLT) boot.k peg.k -o basic.peg.k examples/basic.peg

clean : .FORCE
	rm -f *~ *.so *.peg.k yy.tab.k

.FORCE :
