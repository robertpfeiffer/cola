JOLT = ../../jolt-burg/main

PROGRAM = parse

LIBS = Match.o Match-printing.o ParseStream.o NetworkPseudoInterface.o

all : $(LIBS) $(PROGRAM)

test : $(LIBS) $(PROGRAM) .FORCE
	time ./$(PROGRAM) < test.k
#	$(JOLT) boot.k $(PROGRAM).k

.SUFFIXES :

IDC		= ../idc # -O
IDFLAGS		= -g -k -I../../objects -I../../jolt-burg
IDLIBS		= ../../objects/objects.a ../../jolt-burg/jolt.a ../../jolt-burg/readline.o -lreadline

% : %.st $(LIBS)
	$(IDC) $(IDFLAGS) $< $(LIBS) $(IDLIBS) -o $@

%.o : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%.so : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

clean : .FORCE
	rm -f *~ *.so *.so.c *.o *.o.c *.c $(PROGRAM) $(LIBS)

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :
