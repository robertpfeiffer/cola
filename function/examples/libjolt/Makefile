IDC		= idc -k # -O
OBJECTS		= ../../objects
MPINT		= ../../objects/mpint
JOLT		= ../../jolt-burg
OBJ		= ../../../object/stage2
IDFLAGS		= -g -I../../objects -I$(JOLT)

OBJEXT          = 
OBJEXT_O        = .o
OBJEXT_SO       = .so

LDFLAGS  = $(shell $(IDC) -C LDFLAGS)
LDLIBS   = $(shell $(IDC) -C LDLIBS)

JOLT_OBJ_FILES	= $(filter-out $(JOLT)/readline.o, $(wildcard $(JOLT)/*.o))
JOLT_BOOT_FILES = boot.k quasiquote.k syntax.k number.k object.k
JOLT_BOOT_FILES := $(addprefix $(JOLT)/, $(JOLT_BOOT_FILES))

all : jest$(OBJEXT)

test : jest$(OBJEXT) .FORCE
	./jest$(OBJEXT)

.SUFFIXES :

%$(OBJEXT_SO) : %.st
	$(IDC) $(IDFLAGS) -s $< -o $@

%$(OBJEXT_O) : %.st
	$(IDC) $(IDFLAGS) -c $< -o $@

%$(OBJEXT) : %.st
	$(IDC) $(IDFLAGS) $< -o $@

# This rule concatenates the contents of the Jolt boot files together into
# one big C string and dumps it into boot.h. The first awk invocation is a
# hack meant to exclude the last section of boot.k. This is necessary because
# this section of boot.k calls "(load ...)" with the other boot files, which
# isn't what we want for libjolt, since the other boot files are already
# including in the C string. In addition, the last part of boot.k uses some
# features from the other boot files, which won't work in our case here
# because the other boot files are included after all of boot.k.
#
# The other parts of this rule are for stripping out blank lines, comment
# lines, removing semicolons in string literals, removing all comments
# (necessary because the final string will contain a single line, thus
# the first comment would then "commentify" the rest of the code),
# quoting special C string characters and packaging the result as a C
# string in the variable "boot".
#
boot.h : $(JOLT_BOOT_FILES)
	cat $(JOLT_BOOT_FILES) | \
		awk 'BEGIN {RS = "\(define herald.*contents\]\)\)\)\)"} {print $$0}' | \
		grep -Ev '^(;|$$)' | \
		sed -e 's/";/"/g' -e 's/;.*$$//' -e 's/\\/\\\\/g' -e 's/"/\\"/g' | \
		awk '{print "\"", $$0, "\""}' | \
		awk 'BEGIN {RS = "\7"} \
			{print "static const char boot[] = \n", $$0, ";"}' \
		> $@

libjolt.o : boot.h

libjolt.a : libjolt.o
	ld -r libjolt.o $(OBJECTS)/*.o $(MPINT)/*.o $(JOLT_OBJ_FILES) $(OBJ)/gc.a \
		$(OBJ)/libid.o -o $@.o
	ar rsc $@.new $@.o
	rm $@.o
	mv $@.new $@

# TODO this needs to be generalized for the various platforms
install: libjolt.a
	cp libjolt.a /usr/lib
	cp jolt.h /usr/include

test-libjolt : libjolt.a .FORCE
	gcc -o $@ $@.c $(LDFLAGS) libjolt.a $(LDLIBS)
	./$@

jest : jest.c libjolt.a jolt.h
	gcc -o $@ $@.c  $(LDFLAGS) libjolt.a $(LDLIBS)

tidy : .FORCE
	-rm -f *.o *.d *~ .gdb* *.stackdump *.o.c boot.h

clean : tidy
	-rm -f jest test-libjolt libjolt.a

distclean spotless : clean

.FORCE :
