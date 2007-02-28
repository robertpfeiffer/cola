SRCS	:= $(wildcard *.c)
OBJS	:= $(SRCS:.c=.o)
IDC	:= idc
CFLAGS	:= -I. $(shell $(IDC) -C MFLAGS) $(shell $(IDC) -C O3FLAGS)

mpint.a : $(wildcard *.[ch])

mpint.a : $(OBJS)
	ar rc $@.new $(OBJS)
	mv $@.new $@
	-ranlib $@

clean : .FORCE
	rm -f *.o *.a *~

.FORCE :
