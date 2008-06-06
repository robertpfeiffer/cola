JOLT = ../../jolt2
OBJECTS = ../../objects

PROGRAM = main

LIBS = NetworkPseudoInterface.o

all : $(LIBS) $(PROGRAM)

test : $(LIBS) $(PROGRAM) .FORCE
	./$(PROGRAM) $(JOLT)/boot.k tcp.k

.SUFFIXES :

IDC		= ../idc -O
IDFLAGS		= -g -k -I$(OBJECTS) -I$(JOLT)
IDLIBS		= $(OBJECTS)/objects.a $(JOLT)/jolt.a $(JOLT)/readline.o -lreadline

% : %.st $(LIBS)
	$(IDC) $(IDFLAGS) $< $(LIBS) $(IDLIBS) -o $@

main : $(JOLT)/main.st $(LIBS)
	$(IDC) $(IDFLAGS) $< $(LIBS) $(IDLIBS) -o $@ -L/usr/X11R6/lib -lX11 -lXext

%.o : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%.so : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

clean : .FORCE
	rm -f *~ *.so *.so.c *.o *.o.c *.c $(PROGRAM) $(LIBS)

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :
