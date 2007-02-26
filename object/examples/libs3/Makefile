PROGRAM	= main

IDC = idc

all : $(PROGRAM)

run : all
	./$(PROGRAM)

main : main.st libs.so
	$(IDC) main.st

libs.so : lib1.o lib2.o
	$(IDC) -s libs.st lib1.o lib2.o
	rm lib1.o lib2.o

%.o : %.st
	$(IDC) -c $<

tidy: .FORCE
	rm -f *~

clean : tidy .FORCE
	rm -f $(PROGRAM) *.exe *.o *.so

spotless : clean .FORCE

.FORCE :
