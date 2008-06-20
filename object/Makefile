SUBDIRS = id st80 idc

CONFIG = boot/Makefile id/Makefile idc/Makefile idc/idc st80/Makefile
TARGET =
PREFIX =


all : stage2/idc


stage3 : stage3/idc

stage3/idc : stage3/idc1 stage2/idc
	cp -p idc/idc $@

stage3/idc1 : .config-stamp stage3/st80.so stage2/idc
	$(SHELL) -ec '( cd idc; $(MAKE) IDC="../stage2/idc -B../stage2/ -O" BIN="../stage3/" )'

stage3/st80.so : .config-stamp stage3/libid.o stage2/idc
	$(SHELL) -ec '( cd st80; $(MAKE) IDC="../stage2/idc -B../stage2/ -O" BIN="../stage3/" )'

stage3/libid.o : .config-stamp id/libid.c id/id.h
	-$(SHELL) -ec '[ -d stage3 ] || mkdir stage3'
	$(SHELL) -ec '( cd id; $(MAKE) BIN="../stage3/" )'

stage3/gc.a : boot/gc.a
	-$(SHELL) -ec '[ -d stage3 ] || mkdir stage3 ; mkdir stage3/include ; mkdir stage3/include/gc ; mkdir stage3/include/id '
	cp -p $< $@
	-ranlinb -t $@


stage2/idc : stage1/idc stage2/idc1
	cp -p idc/idc $@

stage2/idc1 : .config-stamp stage1/idc stage2/st80.so
	$(SHELL) -ec '( cd idc; $(MAKE) IDC="../stage1/idc -B../stage1/ -O" BIN="../stage2/" )'

stage2/st80.so : .config-stamp stage1/idc stage2/libid.o
	$(SHELL) -ec '( cd st80; $(MAKE) IDC="../stage1/idc -B../stage1/ -O" BIN="../stage2/" )'

stage2/libid.o : .config-stamp id/libid.c id/id.h
	-$(SHELL) -ec '[ -d stage2 ] || mkdir stage2'
	$(SHELL) -ec '( cd id; $(MAKE) BIN="../stage2/" )'

stage2/gc.a : boot/gc.a
	-$(SHELL) -ec '[ -d stage2 ] || mkdir stage2 ; mkdir stage2/include ; mkdir stage2/include/gc ; mkdir stage2/include/id '
	cp -p $< $@
	-ranlinb -t $@


stage1/idc : stage1/idc1
	cp -p idc/idc $@

stage1/idc1 : .config-stamp boot/idc stage1/st80.so
	$(SHELL) -ec '( cd idc; $(MAKE) IDC="../boot/idc -B../boot/ -O" BIN="../stage1/" )'

stage1/st80.so : .config-stamp boot/idc stage1/libid.o
	$(SHELL) -ec '( cd st80; $(MAKE) IDC="../boot/idc -B../boot/ -O" BIN="../stage1/" )'

stage1/libid.o : .config-stamp id/libid.c id/id.h
	-$(SHELL) -ec '[ -d stage1 ] || mkdir stage1'
	$(SHELL) -ec '( cd id; $(MAKE) BIN="../stage1/" )'

stage1/gc.a : boot/gc.a
	-$(SHELL) -ec '[ -d stage1 ] || mkdir stage1 ; mkdir stage1/include ; mkdir stage1/include/gc ; mkdir stage1/include/id '
	cp -p $< $@
	-ranlinb -t $@


boot/idc : boot/Makefile
	-$(SHELL) -ec '( cd boot; $(MAKE) )'

$(CONFIG) : .config-stamp

.config-stamp : boot/configure
	./boot/configure $(TARGET) $(PREFIX) $(CONFIG) && touch .config-stamp


test : all .FORCE
	$(SHELL) -ec '( cd test; $(MAKE) run )'
	$(SHELL) -ec '( cd st80; $(MAKE) run )'

test2 : stage2/idc .FORCE
	-$(SHELL) -ec '( cd examples/hw; make clean; ../../stage2/idc -B../../stage2/ -I../../st80 -g -k hw.st; LD_LIBRARY_PATH=../../stage2 ./hw )'

test3 : stage3/idc .FORCE
	-$(SHELL) -ec '( cd examples/hw; make clean; ../../stage3/idc -B../../stage3/ -I../../st80 -g -k hw.st; LD_LIBRARY_PATH=../../stage3 ./hw )'


rebuild : .FORCE
	rm -rf stage*/include stage*/idc1
	$(MAKE)


install : all .FORCE
	$(SHELL) -ec 'for dir in $(SUBDIRS); do ( cd $$dir; $(MAKE) IDC="../stage1/idc -B../stage1/ -O" BIN="../stage2/" install ); done'

install-boot : boot .FORCE
	$(SHELL) -ec '( cd boot; $(MAKE) install )'


win32 : .FORCE
	$(MAKE) TARGET="i686-pc-mingw32"


newboot : all .FORCE
	rm -f boot/src/*
	cp -p idc/idc.in boot/.
	cp -p id/*.c stage2/*.c boot/src/.
	cp -p id/*.h boot/include/id/.


dist : .config-stamp .FORCE
	$(SHELL) -ec '( cd dist; $(MAKE) dist )'

dist-src : .config-stamp .FORCE
	$(SHELL) -ec '( cd dist; $(MAKE) dist-src )'


config : .FORCE
	./boot/configure $(TARGET) $(PREFIX) $(CONFIG) && touch .config-stamp
	cp -p idc/idc boot/.


clean distclean spotless : boot/Makefile .FORCE
	-rm -f *~ .config-stamp
	-$(SHELL) -c 'for dir in boot $(SUBDIRS) examples; do ( cd $$dir; $(MAKE) clean distclean ); done'
	-$(SHELL) -c 'for dir in stage1 stage2 stage3; do rm -rf $$dir; done'


.FORCE :
