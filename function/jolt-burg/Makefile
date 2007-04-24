IDC		= idc -O
IDFLAGS		= -k -I../objects

OBJEXT          = 
OBJEXT_O        = .o
OBJEXT_SO       = .so

ARCH		= $(shell $(IDC) -C arch)

LIBS		= ../objects/objects.a jolt.a

FILES		= Expression.o Scanner.o CompilerOptions.o Compiler.o Instruction.o Grammar.o \
		  Resource.o CodeGenerator.o CodeGenerator-local.o

LDLIBS		= jolt.a -lreadline -ltermcap # -lopcodes -lintl

all : main$(OBJEXT)

test : main$(OBJEXT) .FORCE
	./main$(OBJEXT) boot.k sanaras.k

.SUFFIXES :

%$(OBJEXT_SO) : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

%$(OBJEXT_O) : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%$(OBJEXT) : %.st
	$(IDC) $(IDFLAGS) $< -o $@

main$(OBJEXT) : main.st $(LIBS)
	$(IDC) $(IDFLAGS) main.st $(LDLIBS) -o $@

jolt.a : $(FILES) ../objects/objects.a
	ar rc $@.new $(FILES) ../objects/*.o ../objects/mpint/*.o
	mv $@.new $@

../objects/objects.a : .FORCE
	$(SHELL) -ec 'cd ../objects;  $(MAKE)'

CodeGenerator-local.st : .FORCE
	-rm -f $@
	ln -s CodeGenerator-$(ARCH).st $@

tidy : .FORCE
	-rm -f *.o *.d *~ .gdb* *.stackdump *.o.c main.c

clean : tidy
	-rm -f $(FILES) jolt.a main$(OBJEXT) CodeGenerator-local.st
	-rm -f bench-id bench-c

distclean spotless : clean

stats : .FORCE
	$(SHELL) -ec 'for i in *.st; do printf "%8d %s\n" `sort -u $$i | wc -l` $$i; done'
	sort -u Expression.st Scanner.st CompilerOptions.st Compiler.st Instruction.st Resource.st CodeGenerator.st CodeGenerator-i386.st CodeGenerator-ppc.st | wc -l

bench : main bench-c bench-id .FORCE
	-time ./bench-id
	-time ../../lambda/jolt/jolt bench-k.k
	-time ./main bench-k.k
	-time ./bench-c

bench-c : bench-c.c
	cc -O -o $@ $<

bench-id : bench-id.st
	idc -O -k -g -I../objects bench-id.st -o bench-id ../objects/objects.a  -lreadline

.FORCE :
