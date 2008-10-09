// See license at end of file

// Purpose: Support OFW's libc on a Unix host.
//

// This file implements Just Enough of the Openfirmware client
// interface to run programs linked with OFW libc on a Unix host.

//#include "types.h"

#define STATIC static
#define VOID void
#define UCHAR unsigned char
#define ULONG unsigned long
#define LONG  long
#define NULL 0

VOID fatal(char *fmt, ...);

#include <sys/time.h>
#include "stdio.h"



void OFExit() {
  exit(0);
}

ULONG OFMilliseconds() {
  struct timeval tv;
  gettimeofday(&tv, NULL);
  return tv.tv_sec*1000 + tv.tv_usec/1000;
}

// File handling is passed directly onto Unix.

typedef FILE * ihandle;

ihandle OFOpen(char *devicename)   { return fopen(devicename, "r+"); }
ihandle OFCreate(char *devicename) { return fopen(devicename, "w"); }
long    OFClose(ihandle inst)      { return fclose(inst); }

long OFWrite(ihandle inst, char *addr, ULONG len) { fwrite(addr, len, 1, inst); }
long OFRead(ihandle inst, char* addr, ULONG len)  { return fread(addr, len, 1, inst); }

// Properties aren't bound to anything on Unix.

typedef int phandle;

phandle OFFinddevice(char *devicename) { return -1; }
long    OFGetproplen(phandle id, char *name, char *buf, ULONG buflen) { return -1; }
long    OFGetprop(phandle id, char *name, char *buf, ULONG buflen)    { return -1; }

// These would be tricky to support.

int OFInterpret0(char *cmd) { return -1; }
int call_firmware(void *arg) { return -1; }

ULONG OFClaim(char *addr, ULONG size, ULONG align) { return (ULONG)0; }

int _main(int argc, char **argv) {
  /* Using fdopen() to access the host stdin and stdout. */
  stdin->id = fdopen(0, "r");
  stdout->id = fdopen(1, "w");
  return main(argc, argv);
}

// The remaining OF* symbols are left unbound. They aren't used by libofw itself.

// LICENSE_BEGIN
// Copyright (c) 2008 Luke Gorrie
// 
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// LICENSE_END
