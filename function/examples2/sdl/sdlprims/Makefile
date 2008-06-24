CFLAGS = -I/usr/local/include -Wall -Wno-unused -Werror -g -O
LDLIBS = -L/usr/local/lib -lSDL -lSDLmain

OBJS = main.o SDL_prims.o

main : $(OBJS)
	gcc $(OBJS) $(LDLIBS) -o $@

clean : .FORCE
	rm -f *~ *.o main *.exe

.FORCE :
