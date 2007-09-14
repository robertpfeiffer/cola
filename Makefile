SUBDIRS = object function

all : .FORCE
	$(SHELL) -ec 'for dir in $(SUBDIRS); do ( cd $$dir; $(MAKE) ); done'

dist : .FORCE
	$(SHELL) -ec '( cd dist; $(MAKE) dist )'

install : .FORCE
	$(SHELL) -ec '( cd object; $(MAKE) install )'

dist-src : .FORCE
	$(SHELL) -ec '( cd dist; $(MAKE) dist-src )'

config : .FORCE
	$(SHELL) -ec '( cd object; $(MAKE) config )'

win32 : .FORCE
	$(MAKE) TARGET="i686-pc-mingw32"

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
