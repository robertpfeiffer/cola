IDC		= ./idc $(OFLAGS)

OFLAGS		= $(shell ./idc -C OFLAGS)
OS		= $(shell ./idc -C os)

IDFLAGS		= -k -g
LDLIBS		= 

OBJEXT          = 
OBJEXT_O        = .o
OBJEXT_SO       = .so

MPFLAGS		= -Impint $(shell $(IDC) -C MFLAGS) $(shell $(IDC) -C O3FLAGS)
MPFILES_C	= $(wildcard mpint/*.c)
MPFILES_O	= $(MPFILES_C:mpint/%.c=%.o)

FILES		= _object.o Objects.o Object.o \
		  SmallInteger.o String.o Symbol.o BlockClosure.o ProfiledMethod.o \
		  Collection.o SequenceableCollection.o ArrayedCollection.o Array.o ByteArray.o \
		  IdentitySet.o Set.o Association.o Dictionary.o IdentityDictionary.o SlotDictionary.o MemoDictionary.o OrderedCollection.o \
		  File.o Stream.o Link.o LinkedList.o \
		  Magnitude.o Number.o OS.o Date.o Function.o Random.o Time.o debug.o deprecated.o \
		  $(MPFILES_O)

MPFLAGS_K	= -Impint $(shell $(IDC) -C MFLAGS) $(shell $(IDC) -C O3FLAGS) $(CCFLAGS_K) $(shell $(IDC) -C CCFLAGS_K)
FILES_K		= $(FILES:.o=_k.o)

ARCH		= $(shell $(IDC) -C arch)

all : objects.a

.SUFFIXES :

%$(OBJEXT_SO) : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

%$(OBJEXT_O) : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%_k$(OBJEXT_O) : %.st
	$(IDC) $(IDFLAGS) -XO -c $< -o $@

%$(OBJEXT) : %.st
	$(IDC) $(IDFLAGS) $< -o $@

Number$(OBJEXT_O) : Number.st
	$(IDC) -Jmpint $(IDFLAGS) -c $< -o $@

Number_k$(OBJEXT_O) : Number.st
	$(IDC) -Jmpint $(IDFLAGS) -XO -c $< -o $@

debug.o : _debug.c freedline.c

freedline.o : freedline.c
	$(CC) -O $(CFLAGS) -c $<

%.o : mpint/%.c
	$(CC) $(MPFLAGS) -c -o $@ $<

%_k.o : mpint/%.c
	$(CC) $(MPFLAGS_K) -c -o $@ $<

objects.a : $(FILES)
	ar rc $@.new $(FILES)
	mv $@.new $@

objects_k.a : $(FILES_K)
	ar rc $@.new $(FILES_K)
	mv $@.new $@

tidy : .FORCE
	-rm -f *.o *.d *~ .gdb* *.stackdump *.new
	-rm -f $(FILES:.o=.o.c)
	-rm -f $(FILES_K:.o=.o.c)

clean : tidy
	-rm -f $(FILES) objects.a
	-rm -f $(FILES_K) objects_k.a

distclean spotless : clean

.FORCE :
