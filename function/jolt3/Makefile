OS		= $(shell ./idc -C os)

OBJECTS		= ../objects
IDC		= ./idc
OFLAGS		= -g

IDFLAGS		= $(OFLAGS) -I$(OBJECTS)
IDLIBS		= $(OBJECTS)/objects.a

LIBS		= Token.o Parser.o COLAParser.o GrammarParser.o PepsiGrammarGenerator.o \
		  Expression.o

all : g2st main

boot : .FORCE
	$(MAKE) -j 3 -C boot

reboot : boot .FORCE
	cp -p boot/COLAParser.st .
	cp -p boot/GrammarParser.st .
	cp -p boot/PepsiGrammarGenerator.st .
	$(MAKE) all


main : $(LIBS) FunctionParser.o main.st
	$(IDC) $(IDFLAGS) main.st FunctionParser.o $(LIBS) $(IDLIBS) -o $@ $(CLIBS)

FunctionParser.st : FunctionParser.g
	./g2st $< > $@

timep : pepsi
	for i in $(OBJECTS)/*.st; do \time ./pepsi $$i; done # ; cat $(OBJECTS)/*.st | wc -l

pepsi : pepsi.st $(LIBS) ObjectParser.o
	$(IDC) $(IDFLAGS) pepsi.st ObjectParser.o $(LIBS) $(IDLIBS) -o $@ $(CLIBS)

ObjectParser.o : ObjectParser.st

ObjectParser.st : ObjectParser.g g2st
	./g2st $< > $@


test : test.st $(LIBS) TestParser.o
	$(IDC) $(IDFLAGS) test.st TestParser.o $(LIBS) $(IDLIBS) -o $@ $(CLIBS)

TestParser.o : TestParser.st

TestParser.st : TestParser.g g2st
	./g2st $< > $@


ecma : ecma.st $(LIBS) ECMA262_3.o profile.c
	$(IDC) $(IDFLAGS) ecma.st ECMA262_3.o $(LIBS) $(IDLIBS) -o $@ $(CLIBS)

ECMA262_3.o : ECMA262_3.st

ECMA262_3.st : ECMA262_3.g g2st
	./g2st $< > $@

T = COLAParser.g GrammarParser.g PepsiGrammarGenerator.g

time : g2st .FORCE
	wc $(T)
	time ./g2st $(T) $(T) $(T) $(T) $(T) $(T) $(T) $(T) $(T) $(T) > /dev/null

g2st : g2st.st $(LIBS)
	$(IDC) $(IDFLAGS) g2st.st $(LIBS) $(IDLIBS) -o $@ $(CLIBS)

LIBSC		= Token.o Parser.o COLAParser.o GrammarParser.o CGrammarGenerator.o

g2c : g2c.st $(LIBSC)
	$(IDC) $(IDFLAGS) $< $(LIBSC) $(IDLIBS) -o $@ $(CLIBS)

CGrammarGenerator.st : CGrammarGenerator.g g2st
	./g2st $< > $@

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

tester : tester.st Test.o
	$(IDC) $(IDFLAGS) tester.st Test.o $(LIBS) -o tester $(CLIBS) $(IDLIBS)

Test.st : Test.g
	./g2st Test.g > Test.st
