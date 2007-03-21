LIBS	= xwin.so Event.so Surface.so
PROGRAM = events main

IDC = ../idc

all : $(LIBS) $(PROGRAM)

run : all
	./main

%.so : %.st
	$(IDC) -J/usr/X11R6/include -s $< -L/usr/X11R6/lib -lX11

%.o : %.st
	$(IDC) -J/usr/X11R6/include -c $<

% : %.st
	$(IDC) $< -L/usr/X11R6/lib -lX11

tidy: .FORCE
	rm -f *~

clean : tidy .FORCE
	rm -f $(PROGRAM) $(LIBS) *.exe

spotless : clean .FORCE

.FORCE :
