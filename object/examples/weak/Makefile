PROGRAM = main

IDC = ../idc

all : $(PROGRAM)

% : %.st
	$(IDC) $<

run : all
	./$(PROGRAM)

tidy: .FORCE
	rm -f *~

clean : tidy .FORCE
	rm -f $(PROGRAM) *.exe

spotless : clean .FORCE

.FORCE :
