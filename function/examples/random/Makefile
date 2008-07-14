OS		= $(shell ../idc -C os)

OBJECTS		= ../../objects
IDC		= ../idc
OFLAGS		= -g

IDFLAGS		= $(OFLAGS) -k -I$(OBJECTS)
IDLIBS		= $(OBJECTS)/objects.a

LIBS		= 

all : $(LIBS) main

run : all
	./main

% : %.st $(LIBS)
	$(IDC) $(IDFLAGS) $< $(LIBS) $(IDLIBS) -o $@ $(CLIBS)

%.o : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%.so : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

clean : .FORCE
	rm -rf *~ *.so *.so.c *.o *.o.c *.c .gdb_history main main.exe *.dSYM

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :
