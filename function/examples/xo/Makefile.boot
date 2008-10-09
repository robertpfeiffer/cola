include ../Makefile.conf

TFTPBOOT	= 10.0.1.2:/private/tftpboot/boot.elf
LDLIBS		= $(BOOTLIBS:lib%=../lib%)
IDC		= ../../idc

all : $(PROGRAM)

$(PROGRAM) : $(PROGRAM).o $(LIBS)
	$(IDC) -XO -XS -o $@ $(PROGRAM).o $(LIBS) $(LDLIBS) -lgcc

%.o : %.st
	$(IDC) -XO -o $@ -c $<

boot : $(PROGRAM)
	scp -1 -p $(PROGAM) $(TFTPBOOT)

tidy: .FORCE
	rm -f *~

clean : tidy .FORCE
	rm -rf *.exe *.o *.a *.dSYM $(PROGRAM)

spotless : clean .FORCE

.FORCE :
