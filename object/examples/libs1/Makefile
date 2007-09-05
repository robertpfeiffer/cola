PROGRAM	= main

IDC = ../idc

all : $(PROGRAM)

run : all
	./$(PROGRAM)

main : main.st libs.a
	$(IDC) main.st libs.a
	rm libs.a

libs.a : lib1.o lib2.o
	ar rc $@.new lib1.o lib2.o
	mv $@.new $@
	-@ranlib $@

%.o : %.st
	$(IDC) -c $<

tidy: .FORCE
	rm -f *~

clean : tidy .FORCE
	rm -f $(PROGRAM) *.exe *.o *.a

spotless : clean .FORCE

.FORCE :
