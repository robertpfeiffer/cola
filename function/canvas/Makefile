OFLAGS	= -g
IDC	= ./idc -k $(MFLAGS) $(OFLAGS) $(XFLAGS) -I../objects -I../jolt-burg
SYSOS	= $(shell $(IDC) -C os)

ifeq ($(SYSOS),win32)
XFLAGS	= -Jcairo/cairo
MFLAGS	= -Wc,-mwindows
XOBJS	= WinWindow.o
XLIBS	= cairo/*.dll -lgdi32
else
XFLAGS	= -J/usr/local/include/cairo
XOBJS	= X11Window.o
XLIBS	= -L/usr/local/lib -L/usr/X11R6/lib -lX11 -lXext -lreadline -lcairo
endif

OBJS	= $(XOBJS) _cairo.o Cairo.o CharacterMap.o Colour.o \
	  Event.o EventHandler.o Font.o Geometry.o HostWindow.o \
	  Model.o Shape.o Text.o Transform.o View.o Views.o \
	  Views-button.o Views-drawing.o Views-events.o Views-layout.o \
	  Views-properties.o Views-scrolling.o Views-world.o

LIBS	= ../jolt-burg/jolt.a canvas.a $(XLIBS)

all : canvas.a hello # geystar fontsel world

.SUFFIXES :

canvas.a : $(OBJS)
	ar rc $@.new $(OBJS)
	mv $@.new $@

run : all
	./hello

X11Window.o : X11Window.st X11WindowUCS4.st
WinWindow.o : WinWindow.st winWindow.h

world : systemWorkspace.st

% : %.st $(OBJS) ../objects/objects.a canvas.a
	$(IDC) $< $(LIBS)

%.o : %.st
	$(IDC) -c $<

%.so : %.st
	$(IDC) -s $<

tidy: .FORCE
	rm -f *~

clean : tidy .FORCE
	rm -f $(OBJS) canvas.a *.exe *.o.c
	rm -f hello hello.c hello.o
	rm -f geystar geystar.c geystar.o
	rm -f fontsel fontsel.c fontsel.o
	rm -f world world.c world.o

spotless : clean .FORCE

.FORCE :
