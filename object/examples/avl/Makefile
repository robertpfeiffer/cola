PROGRAM	= avl

IDC = idc

all : $(PROGRAM)

run : all
	./$(PROGRAM)

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
