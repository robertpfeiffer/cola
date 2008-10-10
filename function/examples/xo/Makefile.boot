include ../Makefile.conf

TFTPBOOT	= 10.0.1.2:/private/tftpboot/boot.elf
LDLIBS		= $(BOOTLIBS:lib%=../lib%)
IDC		= ../../idc

all : $(PROGRAM)

$(PROGRAM) : $(PROGRAM).st $(LIBS)
	$(IDC) -XO -XS -o $@ $(PROGRAM).st $(LIBS) $(LDLIBS) -lgcc

%.o : %.st
	$(IDC) -XO -o $@ -c $<

boot : $(PROGRAM)
	cp -p $(PROGRAM) $(PROGRAM).elf
	strip $(PROGRAM).elf
	scp -1 -p $(PROGRAM).elf $(TFTPBOOT)

tidy: .FORCE
	rm -f *~

clean : tidy .FORCE
	rm -rf *.exe *.o *.a *.dSYM $(PROGRAM)

spotless : clean .FORCE

.FORCE :
