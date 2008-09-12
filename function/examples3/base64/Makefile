OS		= $(shell ./idc -C os)

OBJECTS		= ../../objects
JOLT3		= ../../jolt3
IDC		= ./idc
OFLAGS		= -g

IDFLAGS		= $(OFLAGS) -I$(OBJECTS)
IDLIBS		= $(OBJECTS)/objects.a

LIBS		= Token.o Parser.o

all : b64

b64 : $(LIBS) B64Decoder.o b64.st Token.st Parser.st
	$(IDC) $(IDFLAGS) b64.st B64Decoder.o $(LIBS) $(IDLIBS) -o $@ $(CLIBS)

test : b64
	./b64 b64text.txt

B64Decoder.o : B64Decoder.st

B64Decoder.st : B64Decoder.g
	$(JOLT3)/g2st $< > $@

% : %.st $(LIBS)
	$(IDC) $(IDFLAGS) $< $(LIBS) $(IDLIBS) -o $@ $(CLIBS)

%.o : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%.so : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

%.st : $(JOLT3)/%.st
	cp -p $< $@

clean : .FORCE
	rm -rf *~ *.so *.so.c *.o *.o.c .gdb_history b64 *.exe *.dSYM Token.st Parser.st

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :
