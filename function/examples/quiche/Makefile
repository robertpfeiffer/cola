EXAMPLES := main paint

IDC := ../idc -g

ifeq ($(shell uname),Darwin)
  CFLAGS := -I/usr/local/include/SDL
  IDLIBS := -Wc,-framework -Wc,SDL -Wc,-framework -Wc,SDL_ttf -lSDLmain -Wc,-framework -Wc,Cocoa ../../objects/objects.a
else
  ifeq ($(findstring MINGW, $(shell uname)),MINGW)
    IDC_FLAGS := -J /usr/local/include
    IDLIBS := -L/usr/local/lib -lmingw32 -lSDL -lSDLmain SDL_ttf.dll ../../objects/objects.a -w
 else
    IDLIBS := -lSDL_ttf -lSDL ../../objects/objects.a
  endif
endif

FT2LIBS := -lSDL_ttf -lfreetype

LIBS	:= Surface.o Geometry.o Colour.o Font.o MacroState.o UTF8Stream.o PostScriptStream.o # Layout.o Box.o

default: $(EXAMPLES)

main : main.st $(LIBS) $(SOLIBS) sampletext.st
	$(IDC) $(IDC_FLAGS) $(LIBS) $(IDLIBS) $< -o $@

paint : paint.st $(LIBS) $(SOLIBS) sampletext.st
	$(IDC) $(IDC_FLAGS) $(LIBS) $(IDLIBS) $< -o $@

%.o : %.st
	$(IDC) $(IDC_FLAGS) -c $<

%.so : %.st
	$(IDC) $(IDC_FLAGS) -s $<

run: main
	./main

zip : default
	( cd .. ; zip -r quiche-win32.zip \
			quiche/main.exe quiche/paint.exe quiche/*.dll quiche/caret16.bmp quiche/fonts \
			quiche/file\ name.doq quiche/file\ name.bmp )

clean:
	rm -rf *~ *.o *.so $(EXAMPLES) *.dSYM
