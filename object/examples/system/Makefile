PROGRAM = system1 system2

IDC = ../idc

all : $(PROGRAM)

run : all
	./system1 ls
	./system2 pwd

% : %.st
	$(IDC) $<

tidy: .FORCE
	rm -f *~

clean : tidy .FORCE
	rm -f $(PROGRAM) *.exe

spotless : clean .FORCE

.FORCE :
