JOLT = ../../jolt-burg/main boot.k

LIB = X11-Xlib.h

all : $(LIB).k

$(LIB).k : $(LIB).k-gen.c
	cc -o $@-gen $<
	./$@-gen > $@
	rm -f $@-gen

$(LIB).k-gen.c : $(LIB).defs
	$(JOLT) $< > $@

clean : .FORCE
	rm -f $(LIB).k $(LIB).k-gen.c
	rm -f *~ .*history

.FORCE :
