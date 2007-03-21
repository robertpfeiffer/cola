PROGRAM = interp

IDC = ../idc

all : $(PROGRAM)

run : all
	./$(PROGRAM)

% : %.st
	$(IDC) $<

tidy: .FORCE
	rm -f *~

clean : tidy .FORCE
	rm -f $(PROGRAM) *.exe

spotless : clean .FORCE

.FORCE :
