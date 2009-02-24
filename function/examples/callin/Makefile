OBJECTS		= ../../objects
IDC		= ../idc
OFLAGS		= -g

IDFLAGS		= $(OFLAGS) -k -I$(OBJECTS)
IDLIBS		= $(OBJECTS)/objects.a
LIBS		= Test.o

OS		= $(shell ../idc -C os)

ifeq ($(OS),win32)
CLIBS		= 
else
CLIBS		= 
endif

CFLAGS		= -g -Wall -I../../../object

callin : $(LIBS) callin.o
	gcc -o $@ $(LIBS) callin.o -lgc ../../../object/stage2/libid_g.o $(OBJECTS)/*.o


run : callin
	./callin

% : %.st $(LIBS)
	$(IDC) $(IDFLAGS) $< $(LIBS) $(IDLIBS) -o $@ $(CLIBS)

%.o : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%.so : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

clean : .FORCE
	rm -f *~ *.so *.so.c *.o *.o.c .gdb_history ex[0-9] *.exe callin

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :
