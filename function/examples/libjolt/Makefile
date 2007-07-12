IDC		= idc -k # -O
OBJECTS		= ../../objects
MPINT		= ../../objects/mpint
JOLT		= ../../jolt-burg
OBJ		= ../../../object/stage2
IDFLAGS		= -g -I../../objects -I$(JOLT)

OBJEXT          = 
OBJEXT_O        = .o
OBJEXT_SO       = .so

LDFLAGS  = $(shell $(IDC) -C LDFLAGS)
LDLIBS   = $(shell $(IDC) -C LDLIBS)

JOLT_OBJ_FILES	= $(filter-out $(JOLT)/readline.o, $(wildcard $(JOLT)/*.o))

all : jest$(OBJEXT)

test : jest$(OBJEXT) .FORCE
	./jest$(OBJEXT)

.SUFFIXES :

%$(OBJEXT_SO) : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

%$(OBJEXT_O) : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%$(OBJEXT) : %.st
	$(IDC) $(IDFLAGS) $< -o $@

libjolt.a : libjolt.o
	ld -r libjolt.o $(OBJECTS)/*.o $(MPINT)/*.o $(JOLT_OBJ_FILES) $(OBJ)/gc.a \
		$(OBJ)/libid.o -o $@.o
	ar rsc $@.new $@.o
	rm $@.o
	mv $@.new $@

# TODO this needs to be generalized for the various platforms
install: libjolt.a
	cp libjolt.a /usr/lib
	cp jolt.h /usr/include

test-libjolt : libjolt.a .FORCE
	gcc -o $@ $@.c $(LDFLAGS) libjolt.a $(LDLIBS)
	./$@

jest : jest.c libjolt.a jolt.h
	gcc -o $@ $@.c  $(LDFLAGS) libjolt.a $(LDLIBS)

tidy : .FORCE
	-rm -f *.o *.d *~ .gdb* *.stackdump *.o.c

clean : tidy
	-rm -f jest test-libjolt libjolt.a

distclean spotless : clean

.FORCE :
