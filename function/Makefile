SUBDIRS = objects jolt

all : .FORCE
	$(SHELL) -ec 'for dir in $(SUBDIRS); do ( cd $$dir; $(MAKE) ); done'

tidy : .FORCE
	rm -f *~
	$(SHELL) -ec 'for dir in $(SUBDIRS); do ( cd $$dir; $(MAKE) tidy ); done'

clean : .FORCE
	rm -f *~
	$(SHELL) -ec 'for dir in $(SUBDIRS); do ( cd $$dir; $(MAKE) clean ); done'

distclean spotless : .FORCE
	rm -f *~
	$(SHELL) -ec 'for dir in $(SUBDIRS); do ( cd $$dir; $(MAKE) spotless ); done'

.FORCE :
