JOLT = ../../jolt-burg/main

test : cairolib.so .FORCE
	$(JOLT) boot.k main.k

cairolib.so : cairolib.st
	idc -J/usr/local/include/cairo -I../../objects -s $<

clean : .FORCE
	rm -f *~ *.so *.o

.FORCE :
