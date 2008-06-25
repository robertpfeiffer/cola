OS		= $(shell ../idc -C os)

SDLINC		= -J/usr/local/include -Jsdlprims
SDLLIB		= -L/usr/local/lib -lSDLmain -lSDL

ifeq ($(OS),darwin)
CLIBS		= -Wc,-framework -Wc,Cocoa
else
endif

FT2INC		= -J/usr/local/include/freetype2
FT2LIB		= -L/usr/local/lib -lfreetype

OBJECTS		= ../../objects
IDC		= ../idc
OFLAGS		= -g

IDFLAGS		= $(OFLAGS) -k -I$(OBJECTS) $(SDLINC) $(FT2INC)
IDLIBS		= $(OBJECTS)/objects.a

LIBS		= Box.o Color.o Geometry.o Surface.o SDLSurface.o Event.o events.o SDL_prims.o \
		  Text.o Layout.o TextLayout.o TextLayout2.o Script.o

all : $(LIBS) main

run : all
	./main

% : %.st $(LIBS)
	$(IDC) $(IDFLAGS) $< $(LIBS) $(IDLIBS) -o $@ $(SDLLIB) $(FT2LIB) $(CLIBS)

%.o : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%.so : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

SDL_prims.o : sdlprims/SDL_prims.c
	$(CC) -I/usr/local/include -g -Wall -O2 -c $< -o $@

fonts : .FORCE
	cc -Ifonts -I/usr/X11R6/include -o stroke fonts/strokeRoman.c -L/usr/X11R6/lib -lX11
	./stroke > FontStrokeRoman.st
	cc -Ifonts -I/usr/X11R6/include -o stroke fonts/strokeMonoRoman.c -L/usr/X11R6/lib -lX11
	./stroke > FontStrokeMonoRoman.st
	rm stroke

clean : .FORCE
	rm -f *~ *.so *.so.c *.o *.o.c *.c .gdb_history main main.exe

spotless : clean
	rm -rf .gdb_history NONE

.FORCE :
