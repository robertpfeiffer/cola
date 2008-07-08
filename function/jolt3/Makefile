OS		= $(shell ./idc -C os)

OBJECTS		= ../objects
IDC		= ./idc
OFLAGS		= -g

IDFLAGS		= $(OFLAGS) -I$(OBJECTS)
IDLIBS		= $(OBJECTS)/objects.a

LIBS		= Token.o Parser.o GrammarParser.o PepsiGrammarGenerator.o

all : g2st

T = GrammarParser.g PepsiGrammarGenerator.g

time : g2st .FORCE
	wc $(T)
	time ./g2st $(T) $(T) $(T) $(T) $(T) $(T) $(T) $(T) $(T) $(T) > /dev/null

g2st : g2st.st $(LIBS)
	$(IDC) $(IDFLAGS) g2st.st $(LIBS) $(IDLIBS) -o g2st $(CLIBS)

% : %.st $(LIBS)
	$(IDC) $(IDFLAGS) $< $(LIBS) $(IDLIBS) -o $@ $(CLIBS)

%.o : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%.so : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

clean : .FORCE
	rm -rf *~ *.so *.so.c *.o *.o.c .gdb_history g2st test *.exe *.dSYM

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :


model : model.c
	cc -Wall -Werror -Wno-unused -g -O2 -o $@ $<
