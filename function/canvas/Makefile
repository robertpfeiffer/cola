OBJS =	Cairo.o \
	CharacterMap.o \
	Colour.o \
	Event.o \
	Font.o \
	Geometry.o \
	HostWindow.o \
	Shape.o \
	Text.o \
	View.o \
	Views.o \
	Views-drawing.o \
	Views-events.o \
	Views-properties.o \
	XCairo.o \
	XWindow.o \
	_cairo.o

LIBS =  ../objects/objects.a canvas.a -L/usr/X11R6/lib -lX11 -lXext -lreadline -lcairo

IDC = ./idc -k $(OFLAGS) -I../objects -J/usr/local/include/cairo -L/usr/local/lib
OFLAGS = -g

all : canvas.a world fontsel geystar

.SUFFIXES :

canvas.a : $(OBJS)
	ar rc $@.new $(OBJS)
	mv $@.new $@

run : all
	./world

% : %.st $(OBJS) ../objects/objects.a canvas.a
	$(IDC) $< $(OBJS) $(LIBS)

%.o : %.st
	$(IDC) -c $<

%.so : %.st
	$(IDC) -s $<

tidy: .FORCE
	rm -f *~

clean : tidy .FORCE
	rm -f $(OBJS) canvas.a *.exe *.o.c
	rm -f geystar geystar.c geystar.o
	rm -f fontsel fontsel.c fontsel.o
	rm -f world world.c world.o

spotless : clean .FORCE

.FORCE :
