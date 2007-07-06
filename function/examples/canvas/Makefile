JOLT = ../../jolt-burg/main

test : _cairo.so cairo.so .FORCE
	$(JOLT) boot.k main.k

IDC		= ../idc -O
IDFLAGS		= -k -I../../objects -J/usr/local/include/cairo

%.so : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

clean : .FORCE
	rm -f *~ *.so

.FORCE :
