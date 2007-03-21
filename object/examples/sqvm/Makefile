PROGRAM = main
o	= o
LDOBJS  = File.$o String-paths.$o \
	  SqueakImage.$o SqueakObject.$o SqueakBitBlt.$o SqueakIO.$o \
	  Squeak.$o Squeak-machine.$o Squeak-bytecodes.$o Squeak-primitives.$o Squeak-debug.$o \
	  SqueakProxy.$o
LDLIBS  = -L/usr/X11R6/lib -lX11
SHOBJS	= 

IDC = ../idc

all : $(SHOBJS) $(LDOBJS) $(PROGRAM) io-test

Surface.$o : Surface.st surface-imp.*
	$(IDC) -J/usr/X11R6/include -s $< -L/usr/X11R6/lib -lX11

SqueakProxy.$o : vmProxy.c

SqueakIO.$o : $(wildcard io*.c)

SqueakBitBlt.so : SqueakBitBlt.st BitBltPlugin.c
	$(IDC) -s -Wc,-w $<

SqueakBitBlt.o : SqueakBitBlt.st BitBltPlugin.c
	$(IDC) -c  -Wc,-w $<

%.so : %.st
	$(IDC) -s $<

%.o : %.st
	$(IDC) -c $<

% : %.st $(LDOBJS)
	$(IDC) $< $(LDOBJS) $(LDLIBS)

run : all
	./main mini.image

io-test : io-test.c
	$(CC) io-test.c -L/usr/X11R6/lib -lX11 -lm -o io-test

tidy: .FORCE
	rm -f *~

clean : tidy .FORCE
	rm -f $(PROGRAM) $(PROGRAM).c $(LIBS) *.exe *so.c *.so *.o LOG SqueakDebug.log .gdb* io io-test

spotless : clean .FORCE

.FORCE :
