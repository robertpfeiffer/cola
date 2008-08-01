OBJECTS		= ../../objects
IDC		= ../idc
OFLAGS		= -g

IDFLAGS		= $(OFLAGS) -k -I$(OBJECTS)
IDLIBS		= $(OBJECTS)/objects.a
LIBS		= 

OS		= $(shell ../idc -C os)

ifeq ($(OS),win32)
CLIBS		= 
else
CLIBS		= 
endif

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
	rm -rf *~ *.so *.so.c *.o *.o.c .gdb_history ex[0-9] *.exe main.c *.dSYM main

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :
