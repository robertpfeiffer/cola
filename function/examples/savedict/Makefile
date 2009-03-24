OBJECTS		= ../../objects
IDC		= ../idc
OFLAGS		= -g

IDFLAGS		= $(OFLAGS) -k -I$(OBJECTS)
IDLIBS		= $(OBJECTS)/objects.a
LIBS		= 

OS		= $(shell ../idc -C os)

ifeq ($(OS),win32)
CLIBS		= 
else
CLIBS		= 
endif

all : $(LIBS) store load

run : all
	./store
	./load

% : %.st $(LIBS)
	$(IDC) $(IDFLAGS) $< $(LIBS) $(IDLIBS) -o $@ $(CLIBS)

%.o : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%.so : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

clean : .FORCE
	rm -f *~ *.so *.so.c *.o *.o.c .gdb_history ex[0-9] *.c *.exe store load
	rm -rf *.dSYM

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :
