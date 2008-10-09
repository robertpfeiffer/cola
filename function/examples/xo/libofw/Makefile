IDC = ../../idc

LIBO    = lib.o wrappers.o malloc.o strings.o printf.o debug.o main.o intprop.o regprop.o strprop.o mem.o callofw.o start.o missing.o
LIB     = libofw.a

CFLAGS	= $(shell $(IDC) -C CCFLAGS_K) -Wno-all

$(LIB) : $(LIBO)
	ar rcs $(LIB).new $(LIBO)
	mv $(LIB).new $(LIB)

clean spotless : .FORCE
	rm -rf *.exe *.o *.a *.dSYM $(LIBO) $(LIB)

.FORCE :
