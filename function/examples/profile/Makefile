PROGRAM = profile profile2
o	= .o
LDOBJS  = 
LDLIBS  = ../../objects/objects.a
SHOBJS	= 

IDC = ../idc -k -g

all : $(SHOBJS) $(LDOBJS) $(PROGRAM)

%.so : %.st
	$(IDC) -s $<

%.o : %.st
	$(IDC) -c $<

%.a : $(ARCH)/%.a
	cp $< $@
	ranlib $@

% : %.st $(LDOBJS)
	$(IDC) $< $(LDOBJS) $(LDLIBS)

run : all
	./$(PROGRAM)

stats : .FORCE
	sort -u $(LDOBJS:$o=.st) | wc -l

tidy: .FORCE
	rm -f *~

clean : tidy .FORCE
	rm -f $(PROGRAM) $(PROGRAM).c $(LIBS) *.exe *.so.c *.so *.o.c *.o .gdb* *.a

spotless : clean .FORCE

.FORCE :
