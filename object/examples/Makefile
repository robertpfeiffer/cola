SUBDIRS	= avl dispatch echo forward hw ignore interp libs1 libs2 libs3 prototype reflect serialise slots sqvm system this traits typename weak x11

all : .FORCE
	-$(SHELL) -ec 'for dir in $(SUBDIRS); do ( cd $$dir; $(MAKE) ); done'

run : .FORCE
	-$(SHELL) -ec 'for dir in $(SUBDIRS); do ( cd $$dir; $(MAKE) run ); done'

tidy : .FORCE
	-$(SHELL) -ec 'for dir in $(SUBDIRS); do ( cd $$dir; $(MAKE) tidy ); done'
	rm -f *~

clean : .FORCE
	rm -f *~
	-$(SHELL) -ec 'for dir in $(SUBDIRS); do ( cd $$dir; $(MAKE) clean ); done'

spotless : .FORCE
	rm -f *~
	-$(SHELL) -ec 'for dir in $(SUBDIRS); do ( cd $$dir; $(MAKE) spotless ); done'

.FORCE :
