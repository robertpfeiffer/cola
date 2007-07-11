IDC		= idc -k # -O
OBJECTS		= ../../objects
MPINT		= ../../objects/mpint
JOLT		= ../../jolt-burg
OBJ		= ../../../object/stage2
IDFLAGS		= -g -I../../objects -I$(JOLT)

OBJEXT          = 
OBJEXT_O        = .o
OBJEXT_SO       = .so

ARCH		= $(shell $(IDC) -C arch)
LDFLAGS		= $(shell $(IDC) -C LDFLAGS)

LIBS		= $(JOLT)/jolt.a
LDLIBS		= jest.a -lreadline

all : jest$(OBJEXT)

test : jest$(OBJEXT) .FORCE
	./jest$(OBJEXT)

.SUFFIXES :

%$(OBJEXT_SO) : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

%$(OBJEXT_O) : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%$(OBJEXT) : %.st
	$(IDC) $(IDFLAGS) $< -o $@

libjolt.a : $(LIBS) libjolt.o
	ar rc $@.new libjolt.o $(OBJECTS)/*.o $(MPINT)/*.o $(JOLT)/*.o
	mv $@.new $@
	nm $@ | fgrep __id__init__ | awk '{print "-u " $$3}' > libjolt.nm

libjoltall.a : $(LIBS) libjolt.o
	ld -r libjolt.o $(OBJECTS)/*.o $(MPINT)/*.o $(JOLT)/*.o $(OBJ)/gc.a $(OBJ)/libid.o -o libjoltall.o
	ar rcs libjoltall.a libjoltall.o

test-libjolt : $(LIBS) libjoltall.a .FORCE
	gcc $(LDFLAGS) test-libjolt.c libjoltall.a -lreadline -lm
	./a.out

jest : jest.c libjolt.a jolt.h
	gcc -o $@ $(shell cat libjolt.nm) jest.c libjolt.a $(OBJ)/gc.a $(OBJ)/libid.o -lreadline

tidy : .FORCE
	-rm -f *.o *.d *~ .gdb* *.stackdump *.o.c main.c

clean : tidy
	-rm -f $(FILES) jest$(OBJEXT) libjolt.a libjolt.nm libjoltall.a a.out

distclean spotless : clean

.FORCE :
