PROGRAM = interpreter

.SUFFIXES :

all : $(PROGRAM)
	./$(PROGRAM)

IDC		= ../idc -O
IDFLAGS		= -g -k -I../../objects -I../../jolt-burg
IDLIBS		= ../../objects/objects.a ../../jolt-burg/jolt.a ../../jolt-burg/readline.o -lreadline
LIBS		= interpret.o

$(PROGRAM) : $(PROGRAM).st

% : %.st $(LIBS)
	$(IDC) $(IDFLAGS) $< $(IDLIBS) $(LIBS) -o $@

%.o : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%.so : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

clean : .FORCE
	rm -rf *~ *.so *.so.c $(PROGRAM) $(PROGRAM).o $(LIBS) $(PROGRAM).c $(PROGRAM).o.c *.dSYM

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :
