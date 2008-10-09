include Makefile.conf

IDC	= ../idc
IDST	= $(shell $(IDC) -C IDST)


all : $(BOOTLIBS)


libofw.a : libofw/libofw.a
	$(SHELL) -ec '( ln -s $< $@ )'

libofw/libofw.a :
	$(SHELL) -ec '( cd libofw; make )'


libossage.a : $(IDST)/system/libossage.a
	$(SHELL) -ec '( ln -s $< $@ )'

$(IDST)/system/libossage.a :
	$(SHELL) -ec '( cd $(IDST)/system; make )'


libobjects.a : $(IDST)/function/objects/objects_k.a
	$(SHELL) -ec '( ln -s $< $@ )'

$(IDST)/function/objects/objects_k.a :
	$(SHELL) -ec '( cd $(IDST)/function/objects; $(MAKE) objects_k.a )'


tidy: .FORCE
	-$(MAKE) -C libofw tidy
	rm -f *~

clean : tidy .FORCE
	rm -rf *.exe *.o *.a *.dSYM
	rm -f $(BOOTLIBS)
	-$(MAKE) -C libofw clean

spotless : clean .FORCE
	-$(MAKE) -C libofw spotless


.FORCE :
