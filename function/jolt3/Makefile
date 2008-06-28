OS		= $(shell ../idc -C os)

OBJECTS		= ../objects
IDC		= ./idc
OFLAGS		= -g

IDFLAGS		= $(OFLAGS) -I$(OBJECTS)
IDLIBS		= $(OBJECTS)/objects.a

LIBS		= Parser.o PEGParser.o PEGInterpreter.o PEGPepsiGenerator.o

all : $(LIBS) main

run : all
	./main test.g < test.g | tee test.st
	$(MAKE) test
	time ./test < test.g

% : %.st $(LIBS)
	$(IDC) $(IDFLAGS) $< $(LIBS) $(IDLIBS) -o $@ $(SDLLIB) $(FT2LIB) $(CLIBS)

%.o : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%.so : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

clean : .FORCE
	rm -rf *~ *.so *.so.c *.o *.o.c .gdb_history main *.exe *.dSYM

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :


model : model.c
	cc -Wall -Werror -Wno-unused -g -O2 -o $@ $<
