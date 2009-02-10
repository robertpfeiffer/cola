EXAMPLE := macro-state
LIBS := ../../objects/objects.a

IDC := ../idc -g

default: $(EXAMPLE)

run : $(EXAMPLE)
	./$(EXAMPLE)

macro-state : macro-state.st $(LIBS) $(SOLIBS)
	$(IDC) $(IDC_FLAGS) $(LIBS) $(IDLIBS) $< -o $@

%.o : %.st
	$(IDC) $(IDC_FLAGS) -c $<

%.so : %.st
	$(IDC) $(IDC_FLAGS) -s $<

clean:
	rm -rf *~ *.o *.so $(EXAMPLE) *.dSYM
