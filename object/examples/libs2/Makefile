LIBS	= lib1.so lib2.so
PROGRAM	= $(LIBS) main

IDC = ../idc

all : $(PROGRAM)

run : all
	./main

%.so : %.st
	$(IDC) -s $<

% : %.st
	$(IDC) $<

tidy: .FORCE
	rm -f *~

clean : tidy .FORCE
	rm -f $(PROGRAM) *.exe

spotless : clean .FORCE

.FORCE :
