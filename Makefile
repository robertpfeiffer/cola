SUBDIRS = object function

all : .FORCE
	@echo "Sorry, you have to do this in two steps:"
	@echo ""
	@echo "  cd object"
	@echo "  make"
	@echo "  sudo make install"
	@echo "  cd ../function"
	@echo "  make"
	@echo ""
	@echo "(In particular I do not want to run the above 'sudo' on your behalf.)"

dist : install .FORCE
	$(SHELL) -ec '( cd dist; $(MAKE) dist )'

dist-src : .FORCE
	$(SHELL) -ec '( cd dist; $(MAKE) dist-src )'

config : .FORCE
	$(SHELL) -ec '( cd object; $(MAKE) config )'

tidy : .FORCE
	rm -f *~
	-$(SHELL) -ec 'for dir in $(SUBDIRS); do ( cd $$dir; $(MAKE) tidy ); done'

clean : .FORCE
	rm -f *~
	-$(SHELL) -ec 'for dir in $(SUBDIRS); do ( cd $$dir; $(MAKE) clean ); done'

distclean spotless : .FORCE
	-rm -f *~
	-$(SHELL) -c 'for dir in $(SUBDIRS); do ( cd $$dir; $(MAKE) distclean ); done'

.FORCE :
