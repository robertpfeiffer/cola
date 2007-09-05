The static object compiler (codename Pepsi)
-------------------------------------------

To build in this directory:

    make

To install from this directory:

    sudo make install

Examples, relative to this directory:

    see indivdual subdirs in objects/examples


The dynamic function compiler (codename Jolt)
---------------------------------------------

Examples, relative to this directory:

    see indivdual subdirs in function/examples


The API library for 'embeddable Jolt' (libjolt)
-----------------------------------------------

To build and install, after building Pepsi and Jolt as above, relative
to this directory:

    cd function/examples/libjolt
    make
    make test
    sudo make install

Notes:

- The final step will copy libjolt.a to /usr/lib and jolt.h to
  /usr/include.  Edit the Makefile if you want them elsewhere.

- Use the output of `idc -C LDFLAGS` and `idc -C LDLIBS` when linking
  your program with this library; e.g:

    gcc `idc -C LDFLAGS` program.c -ljolt `idc -C LDLIBS` -o program


Resources
---------

The 'fundamentals of new computing' mailing list discusses all things
related to this work.  Subscribe here:

    http://vpri.org/mailman/listinfo/fonc
