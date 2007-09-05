SUBDIRS = id st80 idc

CONFIG = boot/Makefile id/Makefile idc/Makefile idc/idc st80/Makefile
TARGET =
PREFIX =

all : boot stage1 stage2

boot : .config-stamp .FORCE
	-$(SHELL) -ec '( cd boot; $(MAKE) )'

stage1 : .FORCE
	-$(SHELL) -ec '[ -d stage1 ] || mkdir stage1'
	$(SHELL) -ec 'for dir in $(SUBDIRS); do ( echo $$dir; cd $$dir; $(MAKE) IDC="../boot/idc -B../boot/ -O" BIN="../stage1/" ); done'

stage2 : .FORCE
	-$(SHELL) -ec '[ -d stage2 ] || mkdir stage2'
	$(SHELL) -ec 'for dir in $(SUBDIRS); do ( echo $$dir; cd $$dir; $(MAKE) IDC="../stage1/idc -B../stage1/ -O" BIN="../stage2/" ); done'

stage3 : .FORCE
	-$(SHELL) -ec '[ -d stage3 ] || mkdir stage3'
	$(SHELL) -ec 'for dir in $(SUBDIRS); do ( echo $$dir; cd $$dir; $(MAKE) IDC="../stage2/idc -B../stage2/ -O" BIN="../stage3/" ); done'

test2 : stage2 .FORCE
	-$(SHELL) -ec '( cd examples/hw; make clean; ../../stage2/idc -B../../stage2/ -I../../st80 -g -k hw.st; LD_LIBRARY_PATH=../../stage2 ./hw )'

test3 : stage3 .FORCE
	-$(SHELL) -ec '( cd examples/hw; make clean; ../../stage3/idc -B../../stage3/ -I../../st80 -g -k hw.st; LD_LIBRARY_PATH=../../stage3 ./hw )'

rebuild : .FORCE
	rm -rf stage*/include stage*/idc1
	$(MAKE)

install : all .FORCE
	$(SHELL) -ec 'for dir in $(SUBDIRS); do ( cd $$dir; $(MAKE) IDC="../stage1/idc -B../stage1/ -O" BIN="../stage2/" install ); done'

install-boot : boot .FORCE
	$(SHELL) -ec '( cd boot; $(MAKE) install )'

newboot : all .FORCE
	rm -f boot/src/*
	cp -p id/*.c stage2/*.c idc/idc boot/src/.
	cp -p id/*.h boot/include/id/.

dist : .config-stamp .FORCE
	$(SHELL) -ec '( cd dist; $(MAKE) dist )'

dist-src : .config-stamp .FORCE
	$(SHELL) -ec '( cd dist; $(MAKE) dist-src )'

.config-stamp : boot/configure */*.in
	./boot/configure $(TARGET) $(PREFIX) $(CONFIG) && touch .config-stamp
	cp -p idc/idc boot/.

config : .FORCE
	./boot/configure $(TARGET) $(PREFIX) $(CONFIG) && touch .config-stamp
	cp -p idc/idc boot/.

test : all .FORCE
	$(SHELL) -ec '( cd test; $(MAKE) run )'
	$(SHELL) -ec '( cd st80; $(MAKE) run )'

tidy : .config-stamp .FORCE
	rm -f *~
	-$(SHELL) -ec 'for dir in boot dist $(SUBDIRS); do ( cd $$dir; $(MAKE) tidy ); done'

clean : .config-stamp .FORCE
	rm -f *~ .config-stamp
	-$(SHELL) -ec 'for dir in boot dist $(SUBDIRS) examples; do ( cd $$dir; $(MAKE) clean ); done'

clean3 : .FORCE
	rm -rf stage3

distclean spotless : .config-stamp .FORCE
	-rm -f *~ .config-stamp
	-$(SHELL) -c 'for dir in boot $(SUBDIRS) examples; do ( cd $$dir; $(MAKE) clean distclean ); done'
	-$(SHELL) -c 'for dir in stage1 stage2 stage3; do rm -rf $$dir; done'

.FORCE :
