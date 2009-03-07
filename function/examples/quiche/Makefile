EXAMPLES := main

IDC := ../idc -g

ifeq ($(shell uname),Darwin)
  CFLAGS := -I/usr/local/include/SDL
  IDLIBS := -Wc,-framework -Wc,SDL -Wc,-framework -Wc,SDL_ttf -lSDLmain -Wc,-framework -Wc,Cocoa ../../objects/objects.a
else
  IDLIBS := -lSDL_ttf -lSDL ../../objects/objects.a
endif

FT2LIBS := -lSDL_ttf -lfreetype

LIBS	:= Surface.o Geometry.o Colour.o Font.o MacroState.o UTF8Stream.o # Layout.o Box.o

default: $(EXAMPLES)

main : main.st $(LIBS) $(SOLIBS) sampletext.st
	$(IDC) $(IDC_FLAGS) $(LIBS) $(IDLIBS) $< -o $@

%.o : %.st
	$(IDC) $(IDC_FLAGS) -c $<

%.so : %.st
	$(IDC) $(IDC_FLAGS) -s $<

run: main
	./main

clean:
	rm -rf *~ *.o *.so $(EXAMPLES) *.dSYM
