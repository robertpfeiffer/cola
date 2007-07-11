/* jolt.h -- glue to jolt runtime compiler
 *
 * Copyright (c) 2006, 2007 Ian Piumarta
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the 'Software'),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, provided that the above copyright notice(s) and this
 * permission notice appear in all copies or substantial portions of the
 * Software.
 *
 * THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.
 *
 * If you use this software in a product, an acknowledgment in the product
 * documentation would be appreciated but is not required.
 *
 * Last edited: 2007-07-11 10:49:14 by piumarta on emilia
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <setjmp.h>
#include <string.h>
#include <ctype.h>
#include <fcntl.h>
#include <unistd.h>
#include <time.h>
#include <sys/time.h>
#include <sys/stat.h>
#include <sys/param.h>
#include <assert.h>
#define GC_DLL 1
#if defined(WIN32)
# include <malloc.h>
# include <windows.h>
  typedef HINSTANCE dlhandle_t;
# define dlopen(path, mode)	LoadLibrary(path)
# define dlsym(handle, name)	((void *)GetProcAddress(handle, name))
# define dlclose(handle)	FreeLibrary(handle)
#else
# include <dlfcn.h>
  typedef void *dlhandle_t;
#endif

typedef struct t__object *oop;

typedef oop (*_imp_t)(oop _thunk, oop receiver, ...);

struct __closure
{
  _imp_t method;
  oop	 data;
};

static oop  		  (*_local_intern  )(const char *string)= 0;
static oop  		  (*_local_import  )(const char *name)= 0;
static struct __closure  *(*_local_bind    )(oop selector, oop receiver)= 0;
static oop  		    _local_object= 0;

#define _send(MSG, RCV, ARG...) ({					\
  register oop _r= (RCV);						\
  struct __closure *_c= (struct __closure *)_local_bind((MSG), _r);	\
  (_c->method)((oop)_c, _r, _r, ##ARG);					\
})

#define _super(TYP, MSG, RCV, ARG...) ({				\
  register oop _r= (RCV);						\
  struct __closure *_c= (struct __closure *)_local_bind((MSG), (TYP));	\
  (_c->method)((oop)_c, _r, _r, ##ARG);					\
})

static oop s__5fimport_= 0;
static oop s_initialise= 0;
static oop s_size_5f_value_5f_= 0;

static oop v_String= 0;
static oop v_Jolt= 0;

extern oop __id__init__libjolt(void);
static void *__libjolt_ref= __id__init__libjolt;

oop __id__init__(void)
{
  if (_local_object) return;
  { 
    dlhandle_t global= dlopen(0, RTLD_LAZY);
    _local_object= *(oop *)dlsym(global, "_libid_object");
    _local_intern= dlsym(global, "_libid_intern");
    _local_import= dlsym(global, "_libid_import");
    _local_bind= dlsym(global, "_libid_bind");
    dlclose(global);
  }
  s__5fimport_		= _local_intern("_import:");
  s_initialise		= _local_intern("initialise");
  s_size_5f_value_5f_	= _local_intern("size_:value_:");
  _send(s__5fimport_, _local_object, "libjolt", "__id__init__libjolt");
  v_String= _local_import("String");
  v_Jolt= _local_import("Jolt");
  return _send(s_initialise, v_Jolt);
}

oop libjolt_init(int *argcp, char ***argvp, char ***envpp)
{
  dlhandle_t global= dlopen(0, RTLD_LAZY);
  void *_local_init= dlsym(global, "_libid_init");
  oop entry= 0;
  if (!_local_init) { fprintf(stderr, "id runtime not found\n");  abort(); }
  ((void (*)(int *, char ***, char ***))_local_init)(argcp, argvp, envpp);
  entry= __id__init__();
  dlclose(global);
  return entry;
}
