IDC		= idc -O
IDFLAGS		= -g

OBJEXT          = 
OBJEXT_O        = .o
OBJEXT_SO       = .so

FILES		= mpint/mpint.a \
		  _object.o Objects.o Object.o \
		  SmallInteger.o String.o Symbol.o BlockClosure.o \
		  Collection.o SequenceableCollection.o ArrayedCollection.o Array.o ByteArray.o \
		  IdentitySet.o Association.o IdentityDictionary.o SlotDictionary.o MemoDictionary.o OrderedCollection.o \
		  File.o Stream.o Link.o LinkedList.o \
		  Number.o OS.o Date.o Function.o Random.o Time.o deprecated.o \
		  Expression.o Scanner.o Compiler.o VPU.o

LDLIBS		= mpint/mpint.a -lreadline

ARCH		= $(shell $(IDC) -C arch)


all : VPU.st main$(OBJEXT)

test : all
	./main$(OBJEXT) boot.k sanaras.k

.SUFFIXES :

%$(OBJEXT_SO) : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

%$(OBJEXT_O) : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%$(OBJEXT) : %.st
	$(IDC) $(IDFLAGS) $< -o $@

Number$(OBJEXT_O) : Number.st
	$(IDC) -Jmpint $(IDFLAGS) -c $< -o $@

main$(OBJEXT) : main.st $(FILES)
	$(IDC) $(IDFLAGS) main.st $(FILES) $(LDLIBS) -o $@
	./mksyms $@

VPU.st : VPU-$(ARCH).st
	ln -s VPU-$(ARCH).st VPU.st


mpint/mpint.a :
	$(SHELL) -ec 'cd mpint; $(MAKE)'

tidy : .FORCE
	-rm -f *.o *.d *~ .gdb* *.stackdump *.c

clean : tidy
	-rm -f $(FILES) main$(OBJEXT) VPU.st *.sym
	$(SHELL) -ec 'cd mpint;  $(MAKE) clean' 

distclean spotless : clean

.FORCE :
