OBJECTS = ../../objects
JOLT = ../../jolt2
GEZIRA = ../../../../gezira-0.6.3

PROGRAM = $(JOLT)/main

all :

test : $(LIBS) $(PROGRAM) .FORCE
	time ./$(PROGRAM) $(JOLT)/boot.k bunnu.k bunnu-test.k

.SUFFIXES :

IDC		= ../idc
OFLAGS		= -g
IDFLAGS		= $(OFLAGS) -k -I$(OBJECTS) -I$(JOLT)
IDLIBS		= $(OBJECTS)/objects.a $(JOLT)/jolt.a $(JOLT)/readline.o -lreadline

% : %.st $(LIBS)
	$(IDC) $(IDFLAGS) $< $(LIBS) $(IDLIBS) -o $@ -L/usr/X11R6/lib -lX11 -lXext

%.o : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%.so : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

clean : .FORCE
	rm -f *~ *.so *.so.c *.o *.o.c *.c .gdb_history

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :
