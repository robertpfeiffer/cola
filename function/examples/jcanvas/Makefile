JOLT = ../../jolt-burg/main

test : _cairo.so cairo.so .FORCE
	$(JOLT) boot.k main.k

IDC		= ../idc -O
IDFLAGS		= -g -k -I../../objects -J/usr/local/include/cairo

%.so : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

clean : .FORCE
	rm -f *~ *.so *.so.c

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :
