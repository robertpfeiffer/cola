TFTPBOOT = 10.0.1.2:/private/tftpboot/boot.elf
PROGRAM  =  hw

IDC = ../idc

LIBO    = lib.o wrappers.o malloc.o strings.o printf.o debug.o main.o intprop.o regprop.o strprop.o mem.o callofw.o start.o missing.o
LIB     = lib.a
SYSTEM  = ../../../system
LIBSYS  = $(SYSTEM)/libossage.a
OBJECT  = ../../objects
LIBOBJ  = $(OBJECT)/objects_k.a

all : $(PROGRAM)

run : all
	./$(PROGRAM)

boot : $(PROGRAM)
	scp -1 -p $(PROGRAM) $(TFTPBOOT)

hw : $(LIB) $(LIBSYS) $(LIBOBJ) missing.o hw.st
	../idc -XO -XS hw.st missing.o $(LIBOBJ) $(LIBSYS) $(LIB) -lgcc

$(LIB) : $(LIBO)
	ar rc $@ $(LIBO)

%.o : lib/%.c
	gcc -g -m32 -fno-builtin -fno-stack-limit -fno-stack-protector -o $@ -c $<

%.o : lib/%.s
	gcc -g -m32 -fno-builtin -fno-stack-limit -fno-stack-protector -o $@ -c $<

$(LIBSYS) :
	$(MAKE) -C $(SYSTEM) 

$(LIBOBJ) :
	$(MAKE) -C $(OBJECT) objects_k.a

tidy: .FORCE
	rm -f *~

clean : tidy .FORCE
	rm -rf $(PROGRAM) *.exe *.o *.a *.dSYM

spotless : clean .FORCE

.FORCE :
