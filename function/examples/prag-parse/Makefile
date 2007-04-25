JOLT = ../../jolt-burg/main

run : .FORCE
	$(JOLT) boot.k parse.k
	$(JOLT) boot.k parse2.k

clean : .FORCE
	rm -f *~ .*history

.FORCE :
