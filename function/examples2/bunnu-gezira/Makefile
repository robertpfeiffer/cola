OBJECTS = ../../objects
JOLT = ../../jolt2
GEZIRA = ../../../../gezira-0.6.3

PROGRAM = main

LIBS =	gezira-pixmap-window.o Window.o
DLIBS =	libgezira-pixmap-pepsi.so

all : $(LIBS) $(DLIBS) $(PROGRAM)

test : $(LIBS) $(PROGRAM) $(DLIBS) .FORCE
	time ./$(PROGRAM) $(JOLT)/boot.k ../bunnu/bunnu.k bunnu-test.k

.SUFFIXES :

IDC		= ../idc
OFLAGS		= -g
IDFLAGS		= $(OFLAGS) -k -I$(OBJECTS) -I$(JOLT)
IDLIBS		= $(OBJECTS)/objects.a $(JOLT)/jolt.a $(JOLT)/readline.o -lreadline

main : $(JOLT)/main.st $(LIBS)
	$(IDC) $(IDFLAGS) $< $(LIBS) $(IDLIBS) -o $@ -L/usr/X11R6/lib -lX11 -lXext

% : %.st $(LIBS)
	$(IDC) $(IDFLAGS) $< $(LIBS) $(IDLIBS) -o $@ -L/usr/X11R6/lib -lX11 -lXext

%.o : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%.so : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

libgezira-pixmap-pepsi.so : $(GEZIRA)/gezira-pixmap/examples/pepsi/libgezira-pixmap-pepsi.so
	ln -s $< $@

gezira-pixmap-window.o : $(GEZIRA)/gezira-pixmap/examples/window.o
	ln -s $< $@

Window.o : $(GEZIRA)/gezira-pixmap/examples/pepsi/Window.o
	ln -s $< $@

clean : .FORCE
	rm -f *~ *.so *.so.c *.o *.o.c *.c $(PROGRAM) $(LIBS) .gdb_history

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :
