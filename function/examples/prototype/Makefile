PROGRAM = prototype

all : $(PROGRAM) .FORCE
	./$(PROGRAM)

IDC		= ../idc -O
IDFLAGS		= -g -k -I../../objects -I../../jolt-burg
IDLIBS		= ../../objects/objects.a ../../jolt-burg/jolt.a ../../jolt-burg/readline.o -lreadline

% : %.st
	$(IDC) $(IDFLAGS) $< $(IDLIBS) -o $@

%.o : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%.so : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

clean : .FORCE
	rm -rf *~ *.so *.so.c $(PROGRAM) $(PROGRAM).o $(PROGRAM).c $(PROGRAM).o.c *.dSYM

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :
