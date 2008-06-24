IDC		= ./idc $(OFLAGS)

OFLAGS		= $(shell ./idc -C OFLAGS)
OS		= $(shell ./idc -C os)

IDFLAGS		= -k -g
LDLIBS		= 

OBJEXT          = 
OBJEXT_O        = .o
OBJEXT_SO       = .so

FILES		= _object.o Objects.o Object.o \
		  SmallInteger.o String.o Symbol.o BlockClosure.o ProfiledMethod.o \
		  Collection.o SequenceableCollection.o ArrayedCollection.o Array.o ByteArray.o \
		  IdentitySet.o Association.o IdentityDictionary.o SlotDictionary.o MemoDictionary.o OrderedCollection.o \
		  File.o Stream.o Link.o LinkedList.o \
		  Number.o OS.o Date.o Function.o Random.o Time.o debug.o deprecated.o

ARCH		= $(shell $(IDC) -C arch)

all : objects.a

test : objects.a test.st
	$(IDC) $(IDFLAGS) test.st objects.a $(LDLIBS)

.SUFFIXES :

%$(OBJEXT_SO) : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

%$(OBJEXT_O) : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%$(OBJEXT) : %.st
	$(IDC) $(IDFLAGS) $< -o $@

Number$(OBJEXT_O) : Number.st
	$(IDC) -Jmpint $(IDFLAGS) -c $< -o $@

debug.o : _debug.c freedline.c

freedline.o : freedline.c
	$(CC) -O $(CFLAGS) -c $<

objects.a : $(FILES) mpint/mpint.a
	ar rc $@.new $(FILES) mpint/*.o
	mv $@.new $@

mpint/mpint.a :
	$(SHELL) -ec 'cd mpint; $(MAKE)'

tidy : .FORCE
	-rm -f *.o *.d *~ .gdb* *.stackdump $(FILES:.o=.c) *.new

clean : tidy
	-rm -f $(FILES) objects.a test
	$(SHELL) -ec 'cd mpint;  $(MAKE) clean' 

distclean spotless : clean

.FORCE :
