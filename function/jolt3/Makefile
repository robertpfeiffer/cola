OS		= $(shell ../idc -C os)

OBJECTS		= ../objects
IDC		= ./idc
OFLAGS		= -g

IDFLAGS		= $(OFLAGS) -I$(OBJECTS)
IDLIBS		= $(OBJECTS)/objects.a

LIBS		= Parser.o PEGParser.o PEGInterpreter.o PEGPepsiGenerator.o

all : $(LIBS) main

run : all
	./main test.g < test.g > test.st
	$(IDC) $(IDFLAGS) test.st Parser.o $(IDLIBS) -o test $(CLIBS)
	time ./test < /dev/null
	time ./test < test.g

% : %.st $(LIBS)
	$(IDC) $(IDFLAGS) $< $(LIBS) $(IDLIBS) -o $@ $(CLIBS)

%.o : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%.so : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

clean : .FORCE
	rm -rf *~ *.so *.so.c *.o *.o.c .gdb_history main test *.exe *.dSYM

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :


model : model.c
	cc -Wall -Werror -Wno-unused -g -O2 -o $@ $<
