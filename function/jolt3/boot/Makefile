OS		= $(shell ./idc -C os)

OBJECTS		= ../../objects
IDC		= ./idc
OFLAGS		= -g

IDFLAGS		= $(OFLAGS) -I$(OBJECTS) -I..
IDLIBS		= $(OBJECTS)/objects.a

LIBS		= Token.o Parser.o PrettyPrint.o
LIBS0		= $(LIBS) GrammarParser0.o PEGPepsiGenerator.o PEGIterator.o
LIBS1		= $(LIBS) GrammarParser1.o PEGPepsiGenerator.o PEGIterator.o
LIBS2		= $(LIBS) GrammarParser2.o PepsiGrammarGenerator2.o
LIBS3		= $(LIBS) GrammarParser3.o PepsiGrammarGenerator3.o
LIBSM		= $(LIBS) GrammarParser.o PepsiGrammarGenerator.o

all : main

run : all .FORCE
	./main GrammarParser.g > test.st
	diff GrammarParser.st test.st

time : all .FORCE
	time ./main GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g GrammarParser.g > /dev/null
	wc GrammarParser.g

cmp : .FORCE
	diff -Bbd GrammarParser3.st GrammarParser2.st
	diff -Bbd PepsiGrammarGenerator3.st PepsiGrammarGenerator2.st

cmp2 : .FORCE
	diff -Bbd GrammarParser2.st GrammarParser.st
	diff -Bbd PepsiGrammarGenerator2.st PepsiGrammarGenerator.st

main : main.st $(LIBSM)
	$(IDC) $(IDFLAGS) main.st $(LIBSM) $(IDLIBS) -o main $(CLIBS)

GrammarParser.o : GrammarParser.st
PepsiGrammarGenerator.o : PepsiGrammarGenerator.st

GrammarParser.st : ../GrammarParser.g main3
	./main3 $< > $@

PepsiGrammarGenerator.st : ../PepsiGrammarGenerator.g main3
	./main3 $< > $@

main3 : main3.st $(LIBS3)
	$(IDC) $(IDFLAGS) $< $(LIBS3) $(IDLIBS) $(CLIBS) -o $@

GrammarParser3.o : GrammarParser3.st
PepsiGrammarGenerator3.o : PepsiGrammarGenerator3.st

GrammarParser3.st : ../GrammarParser.g main2
	./main2 $< > $@

PepsiGrammarGenerator3.st : ../PepsiGrammarGenerator.g main2
	./main2 $< > $@.tmp
	sed 's/import: GrammarParser/import: GrammarParser3/' < $@.tmp > $@

main2 : main2.st $(LIBS2)
	$(IDC) $(IDFLAGS) $< $(LIBS2) $(IDLIBS) $(CLIBS) -o $@

GrammarParser2.o : GrammarParser2.st
PepsiGrammarGenerator2.o : PepsiGrammarGenerator2.st

GrammarParser2.st : ../GrammarParser.g main1
	./main1 $< > $@

PepsiGrammarGenerator2.st : ../PepsiGrammarGenerator.g main1
	./main1 $< > $@.tmp
	sed 's/import: GrammarParser/import: GrammarParser2/' < $@.tmp > $@

main1 : main1.st $(LIBS1)
	$(IDC) $(IDFLAGS) $< $(LIBS1) $(IDLIBS) $(CLIBS) -o $@

GrammarParser1.st : ../GrammarParser.g main0
	./main0 $< > $@

main0 : main0.st $(LIBS0)
	$(IDC) $(IDFLAGS) $< $(LIBS0) $(IDLIBS) $(CLIBS) -o $@

%.o : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%.o : ../%.st
	$(IDC) $(IDFLAGS) -c $< -o $@

clean : .FORCE
	rm -rf *~ *.so *.so.c *.o *.o.c .gdb_history main test *.exe *.dSYM *.tmp
	rm -rf main0 main0.exe
	rm -rf main1 main1.exe GrammarParser1.st PepsiGrammarGenerator1.st
	rm -rf main2 main2.exe GrammarParser2.st PepsiGrammarGenerator2.st
	rm -rf main3 main3.exe GrammarParser3.st PepsiGrammarGenerator3.st
	rm -rf main  main

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :
