START  =	start-i386-elf

CFILES =	$(wildcard *.c)
OFILES =	$(CFILES:.c=.o) # $(START).o

CFLAGS =	-g -O2 -m32 -fno-strict-aliasing -fno-builtin -fno-stack-limit -fno-stack-protector -Wall -Werror -nostdinc -I. -Iinclude

all : libossage.a

test : main
	./main

main : main.o libossage.a
	cc $(CFLAGS) -nostdlib -o $@ $< /usr/lib/crt1.o -lgcc_s /usr/lib/crtn.o -L. -lossage

libossage.a : $(OFILES) fdlibm/libfdm.a
	ar rc $@.new $(OFILES) fdlibm/*.o
	mv $@.new $@

$(OFILES) : syscall.h

syscall.h :
	cc -o mksyscall util/mksyscall.c
	./mksyscall > $@
	rm mksyscall

fdlibm/libfdm.a :
	$(SHELL) -ec '( cd fdlibm; CFLAGS="$(CFLAGS) -I../include -Wno-all" ./configure; make )'

clean : .FORCE
	rm -f *~ syscall.h *.o *.a main
	find include util -name '*~' | xargs rm -f
	$(SHELL) -ec '( cd fdlibm; test -f Makefile && make distclean )'

.FORCE :
