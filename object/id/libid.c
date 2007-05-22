#include <stdio.h>					/* cum mortuis in lingua mortua */
#include <stdlib.h>
#include <stdarg.h>
#include <setjmp.h>
#include <string.h>
#include <ctype.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <sys/time.h>
#include <sys/stat.h>
#include <sys/param.h>
#include <assert.h>
#if defined(WIN32)
# include <windows.h>
  typedef HINSTANCE dlhandle_t;
# define dlopen(path, mode)	LoadLibrary(path)
# define dlsym(handle, name)	((void *)GetProcAddress(handle, name))
# define dlclose(handle)	FreeLibrary(handle)
#else
# include <dlfcn.h>
  typedef void *dlhandle_t;
#endif

#include "gc/gc.h"

#define GLOBAL_MCACHE	1
#define USE_GC		1
#define DEBUG_ALL	0

#if EMULATION
# undef	 USE_GC
# define USE_GC		0
#endif

#if DEBUG_ALL
# define dprintf(fmt, args...)  fprintf(stdout, fmt, ##args)
#else
# define dprintf(fmt, args...)
#endif

typedef union t__object *oop;

typedef oop (*_imp_t)(oop closure, oop state, oop receiver, ...);

struct __closure
{
  _imp_t method;
  oop	 data;
};

struct __lookup
{
  struct t__closure *closure;
  oop		     state;
};

void 		   _libid_init    (int *argcp, char ***argvp, char ***envp);
oop  		   _libid_intern  (const char *string);
oop  		   _libid_proto   (oop base);
oop  		   _libid_import  (const char *name);
oop  		   _libid_export  (const char *name, oop value);
void 		   _libid_method  (oop type, oop selector, _imp_t method);
oop  		   _libid_alloc   (oop type, size_t size);
oop  		  *_libid_palloc  (size_t size);
void  		  *_libid_balloc  (size_t size);
void		   _libid_flush   (oop selector);
struct t__closure *_libid_bind    (oop selector, oop receiver);
struct  __lookup   _libid_bind2   (oop selector, oop receiver);
oop                _libid_nlreturn(oop nlr, oop result);
oop                _libid_nlresult(void);

#define _send(MSG, RCV, ARG...) ({					\
  oop _r= (RCV);							\
  struct __closure *_c= (struct __closure *)_libid_bind((MSG), _r);	\
  (_c->method)((oop)_c, _r, _r, ##ARG);					\
})

static int    _argc= 0;
static char **_argv= 0;
static char **_envp= 0;

oop _libid_object= 0;

static oop s_methodAt_put_with_= 0;
static oop s__intern_= 0;
static oop s_init= 0;
static oop s_flush= 0;
static oop s_lookup_= 0;
static oop s_findKeyOrNil_= 0;
static oop s__delegated= 0;
static oop s__vtable= 0;
static oop s__alloc_= 0;
static oop s__beTagType= 0;
static oop s__beNilType= 0;
static oop s__import_= 0;
static oop s_doesNotUnderstand_= 0;
static oop s__delegate= 0;
static oop s__backtrace= 0;

typedef union  t__object   _object_t;
typedef struct t__selector _selector_t;
typedef struct t__closure  _closure_t;
typedef struct t__assoc    _assoc_t;
typedef struct t__vector   _vector_t;
typedef struct t__vtable   _vtable_t;

struct t__selector
{
  size_t	 size;
  char	 	*elements;
};

static oop _selector_vtable= 0;
static oop _selector= 0;

struct t__assoc
{
  oop		 key;
  oop		 value;
};

static oop _assoc_vtable= 0;
static oop _assoc= 0;

struct t__closure
{
  oop		 method;
  oop		 data;
};

static oop _closure_vtable= 0;
static oop _closure= 0;

struct t__vector
{
  size_t	 size;
  oop		 elements[0];	/* INLINE */
};

static oop _vector_vtable= 0;
static oop _vector= 0;

struct t__vtable
{
  size_t	 tally;
  oop		 bindings;
  oop		 delegate;
};

static oop _vtable_vtable= 0;
static oop _vtable= 0;

union t__object
{
  oop		_vtable[0];
  _closure_t	 closure;
  _selector_t	 selector;
  _assoc_t	 assoc;
  _vector_t	 vector;
  _vtable_t	 vtable;
};

static oop _object_vtable= 0;
static oop _object= 0;

oop _libid_nil_vtable= 0;
oop _libid_tag_vtable= 0;

static oop _selector_Table= 0;
static oop _object_Table= 0;

struct __entry
{
  oop		 vtable;
  oop		 selector;
  _closure_t	*closure;
} _libid_mcache[1024];

#define isMemberOf(obj, type)	((0 == (obj)) || ((obj)->_vtable[-1] == type##_vtable))
#define isKindOf(obj, type)	((0 == (obj)) || ((obj)->_vtable[-1] == type##_vtable) || (_libid_isKindOf(obj, type##_vtable)))

#if !defined(NDEBUG)
static int _libid_isKindOf(oop obj, oop family)
{
  oop vt= obj->_vtable[-1];
  assert(vt);
  while ((vt= ((struct t__vtable *)vt)->delegate))
    if (vt == family) return 1;
  return 0;
}
#endif

static void fatal(const char *fmt, ...)
{
  va_list ap;
  va_start(ap, fmt);
  fflush(stdout);
  fputs("\n", stderr);
  vfprintf(stderr, fmt, ap);
  fputs("\n", stderr);
  va_end(ap);
  exit(1);
}

static oop _object__init(oop _thunk, oop state, oop self)
{
  assert(isMemberOf(self, _object));
  return self;
}

static oop _vector__init_(oop _thunk, oop state, oop self, size_t size)
{
  assert(isMemberOf(self, _vector));
  dprintf("_vector__init_(%p, %d)\n", self, (int)size);
  self->vector.size= size;
  return self;
}

static oop _assoc__init(oop _thunk, oop state, oop self)
{
  assert(isMemberOf(self, _assoc));
  self->assoc.key= 0;
  self->assoc.value= 0;
  return self;
}

static oop _closure__init(oop _thunk, oop state, oop self)
{
  assert(isMemberOf(self, _closure));
  self->closure.method= 0;
  self->closure.data= 0;
  return self;
}

static oop _selector__init_(oop _thunk, oop state, oop self, size_t size)
{
  assert(isMemberOf(self, _selector));
  self->selector.size= size;
  self->selector.elements= (char *)_libid_balloc(size);
  return self;
}

static oop _vtable___alloc_(oop _thunk, oop state, oop self, size_t size)
{
  oop *object= _libid_palloc(sizeof(_vtable_t *) + (size ? size : 1));
  assert(isKindOf(self, _vtable));
  dprintf("_vtable___alloc_(%p, %p, %p, %d) -> %p\n", _thunk, self, state, (int)size, object);
  if (!object) fatal("out of memory");
  *object++= self;
  dprintf("  object %p\n", object);
  return (oop)object;
}

// #define new(type)		type##__init(0, _vtable___alloc_(0, type##_vtable, sizeof(type##_t)))
// #define new__(type, xs, sz)	type##__init_(0, _vtable___alloc_(0, type##_vtable, sizeof(type##_t) + (xs)), sz)

#define new(type) ({									\
      oop obj= _vtable___alloc_(0, type##_vtable, type##_vtable, sizeof(type##_t));	\
      type##__init(0, obj, obj);							\
      obj;										\
})

#define new__(type, xs, sz) ({									\
      oop obj= _vtable___alloc_(0, type##_vtable, type##_vtable, sizeof(type##_t) + (xs));	\
      type##__init_(0, obj, obj, sz);								\
      obj;											\
})

static oop _vector__grow(oop _thunk, oop state, oop self)
{
  oop newVector= 0;
  int newSize= 0;
  assert(isMemberOf(self, _vector));
  dprintf("_vector__grow(%p, %p, %p)\n", _thunk, self, state);
  newSize= self->vector.size * 2;
  newVector= new__(_vector, sizeof(oop) * newSize, newSize);
  memcpy(newVector->vector.elements, self->vector.elements, sizeof(oop) * self->vector.size);
  return newVector;
}

static oop _vtable__init(oop _thunk, oop state, oop self)
{
  assert(isKindOf(self, _vtable));
  self->vtable.tally= 0;
  self->vtable.bindings= new__(_vector, 16, 4);
  self->vtable.delegate= 0;
  return self;
}

static oop _vtable__delegated(oop _thunk, oop state, oop self)
{
  oop vt= _vtable___alloc_(0, self->_vtable[-1], self->_vtable[-1], sizeof(_vtable_t));
  assert(isKindOf(self, _vtable));
  vt->vtable.tally= 0;
  vt->vtable.bindings= new__(_vector, 16, 4);
  vt->vtable.delegate= self;
  return vt;
}

static oop _object___vtable(oop _thunk, oop state, oop self)
{
  return self ? (((unsigned)self & 1) ? _libid_tag_vtable :  self->_vtable[-1]) : _libid_nil_vtable;
}

static oop _object___delegate(oop _thunk, oop state, oop self)
{
  return 0;
}

static oop _object___delegated(oop _thunk, oop state, oop self)
{
  oop obj= _vtable__delegated(0, self->_vtable[-1], self->_vtable[-1]);
  return _vtable___alloc_(0, obj, obj, 0);
}

static oop _vtable__findKeyOrNil_(oop _thunk, oop state, oop self, oop key)
{
  oop *assocs= self->vtable.bindings->vector.elements;
  size_t       i, tally= self->vtable.tally;
  assert(isKindOf(self, _vtable));
  for (i= tally;  i--;)
    if (assocs[i]->assoc.key == key)
      return assocs[i];
  return 0;
}

static oop _vtable__lookup_(oop _thunk, oop state, oop self, oop selector)
{
  oop assoc= 0;
  dprintf("_vtable__lookup_(%p, %p, %p, %p<%s>)\n", _thunk, self, state, selector, selector->selector.elements);
  assoc= _vtable__findKeyOrNil_(0, self, self, selector);
  assert(isKindOf(self, _vtable));
  return assoc ? assoc : (self->vtable.delegate ? _vtable__lookup_(0, self->vtable.delegate, self->vtable.delegate, selector) : 0);
}

static oop _vtable__add_(oop _thunk, oop state, oop self, oop object)
{
  assert(isKindOf(self, _vtable));
  if (self->vtable.tally == self->vtable.bindings->vector.size)
    self->vtable.bindings= _vector__grow(0, self->vtable.bindings, self->vtable.bindings);
  return self->vtable.bindings->vector.elements[self->vtable.tally++]= object;
}

static oop _vtable__methodAt_put_with_(oop _thunk, oop state, oop self, oop selector, oop method, oop data)
{
  oop assoc= _vtable__findKeyOrNil_(0, self, self, selector);
  dprintf("_vtable__methodAt_put_with_(%p, %p, %p, %p<%s>, %p, %p)\n", _thunk, self, state, selector, selector->selector.elements, method, data);
  assert(isKindOf(self, _vtable));
  if (!assoc)
    {
      assoc= new(_assoc);
      assoc->assoc.key= selector;
      assoc->assoc.value= new(_closure);
      _vtable__add_(0, self, self, assoc);
    }
  assoc->assoc.value->closure.method= method;
  assoc->assoc.value->closure.data= data;
  _libid_flush(selector);
  return assoc->assoc.value;
}

static oop _vtable__flush(oop _thunk, oop state, oop self)
{
#if GLOBAL_MCACHE
  memset(_libid_mcache, 0, sizeof(_libid_mcache));
#endif
  return self;
}

static oop _selector__withCString_(oop _thunk, oop state, oop self, const char *string)
{
  assert(isMemberOf(self, _selector));
  self= new__(_selector, 0, strlen(string) + 1);
  memcpy(self->selector.elements, string, self->selector.size);
  self->selector.size -= 1; /* crop the NUL */
  return self;
}

static oop _selector___intern_(oop _thunk, oop state, oop self, const char *string)
{
  oop *table= _selector_Table->vtable.bindings->vector.elements;
  size_t i= 0;
  assert(isMemberOf(self, _selector));
  dprintf("_selector___intern_(%p, %p, %p, \"%s\")\n", _thunk, self, state, string);
  for (i= 0;  i < _selector_Table->vtable.tally;  ++i)
    {
      /*dprintf("compare %s %s -> %d\n", string, table[i]->selector.elements, !strcmp(string, table[i]->selector.elements));*/
      if (!strcmp(string, table[i]->selector.elements))
	return table[i];
    }
  return _vtable__add_(0, _selector_Table, _selector_Table, _selector__withCString_(0, _selector, _selector, string));
}

static oop _object___beTagType(oop _thunk, oop state, oop self)
{
  return _libid_tag_vtable= _object___vtable(0, self, self);
}

static oop _object___beNilType(oop _thunk, oop state, oop self)
{
  return _libid_nil_vtable= _object___vtable(0, self, self);
}

#define ID_RTLD_FLAGS	RTLD_LAZY | RTLD_GLOBAL

static oop _object___import_(oop _thunk, oop state, oop self, char *fileName, char *initName)
{
  dlhandle_t lib= 0;
  void *init= 0;
  init= dlsym(RTLD_DEFAULT, initName);
  dprintf("dlsym RTLD_DEFAULT %s -> %p\n", initName, init);
  if (!init)
    {
      lib= dlopen(0, ID_RTLD_FLAGS);
      dprintf("1  dlopen 0 -> %p\n", lib);
      init= dlsym(lib, initName);
      dprintf("2  dlsym %p %s -> %p\n", lib, initName, init);
      dlclose(lib);
    }
  if (init)
    {
      dprintf("INTERNAL IMPORT <%s>\n", initName);
    }
  else
    {
      char  path[MAXPATHLEN];
      snprintf(path, MAXPATHLEN, "%s.so", fileName);
      lib= dlopen(path, ID_RTLD_FLAGS);
      dprintf("3  dlopen %s -> %p\n", path, lib);
      if (!lib)
	{
	  snprintf(path, MAXPATHLEN, "./%s.so", fileName);
	  lib= dlopen(path, ID_RTLD_FLAGS);
	  dprintf("4  dlopen %s -> %p\n", path, lib);
	}
      if (!lib)
	{
	  char *prefix;
	  if (!(prefix= getenv("IDC_LIBDIR"))) prefix= PREFIX;
	  snprintf(path, MAXPATHLEN, "%s%s.so", prefix, fileName);
	  lib= dlopen(path, ID_RTLD_FLAGS);
	  dprintf("5  dlopen %s -> %p\n", path, lib);
#        if defined(WIN32)
	  if (!lib)
	    {
	      char *p;
	      for (p= path;  *p;  ++p)
		if ('/' == *p) *p= '\\';
	      lib= dlopen(path, ID_RTLD_FLAGS);
	      dprintf("6  dlopen %s -> %p\n", path, lib);
	      if (!lib)
		{
		  perror(path);
		}
	    }
#        endif
	}
      if (!lib) fatal("import: %s.so: No such file or directory\n", fileName);
      init= dlsym(lib, "__id__init__");
      dprintf("7  dlsym %p __id__init__ -> %p\n", lib, init);
      if (!init) fatal("%s: __id__init__: Undefined symbol\n", path);
    }
  dprintf("INIT %s %p %p\n", fileName, lib, init);
  ((void (*)(void))init)();
  return self;
}

static void *topLevelFP= 0;

static oop _object___backtrace(oop _thunk, oop state, oop self)
{
#if defined(__GNUC__)

  void *fp= 0;
  
#if defined(__i386__)
  asm("movl %%ebp, %0" :"=r"(fp));
#elif defined(__PPC__) || defined(__ppc__) || defined(_POWER) || defined(_IBMR2)
  asm("lwz %0, 0(r1)" :"=r"(fp));
#endif

  while (fp && fp < topLevelFP)
    {
      void *ip= 0;

#    if defined(__i386__)
      asm("movl 4(%1), %0" : "=r"(ip) : "r"(fp));
#    elif defined(__PPC__) || defined(__ppc__) || defined(_POWER) || defined(_IBMR2)
      asm("lwz %0, 8(%1)" : "=r"(ip) : "r"(fp));
#    endif

      if (ip)
	{
	  Dl_info dli;
	  if (dladdr(ip, &dli) && dli.dli_sname)
	    printf("%08lx %08lx %s (%s)\n", (long)fp, (long)ip, dli.dli_sname, dli.dli_fname);
	  else
	    printf("%08lx %08lx ?\n",       (long)fp, (long)ip);
	}
      else
	break;

#    if defined(__i386__)
      asm("movl (%1), %0" : "=r"(fp) : "r"(fp));
#    elif defined(__PPC__) || defined(__ppc__) || defined(_POWER) || defined(_IBMR2)
      asm("lwz %0, 0(%1)" : "=r"(fp) : "r"(fp));
#    endif
    }

#endif
  return self;
}

static char *nameOf(oop object)
{
  static char buf[32];
  char *name= buf;
  oop vtable= 0;
  if      (object == 0)			     name= "(0x0)";
  else if ((unsigned)object & 1)	     sprintf(buf, "(#%p=0x%x=%d)", object, (int)object >> 1, (int)object >> 1);
  else
    {
      vtable= object->_vtable[-1];
      if     (!vtable)				 sprintf(buf, "(%p,%p)", object, vtable);
      else if (vtable == _object  ->_vtable[-1]) name= "(_object)";
      else if (vtable == _selector->_vtable[-1]) name= "(_selector)";
      else if (vtable == _closure ->_vtable[-1]) name= "(_closure)";
      else if (vtable == _assoc   ->_vtable[-1]) name= "(_assoc)";
      else if (vtable == _vtable  ->_vtable[-1]) name= "(_vtable)";
      else if (vtable == _libid_tag_vtable)	 name= "(SmallInteger)";
      else if (vtable == _libid_nil_vtable)	 name= "(UndefinedObject)";
      else					 sprintf(buf, "(%p,%p)", object, vtable);
    }
  dprintf("NAME OF %p = %s\n", object, name);
  return name;
}

void _libid_init(int *argcp, char ***argvp, char ***envpp)
{
  dprintf("_libid_init()\n");

#if USE_GC
  GC_INIT();
#endif

  topLevelFP= &argcp;

  _argc= *argcp;  _argv= *argvp;  _envp= *envpp;

  _vtable_vtable= new(_vtable);
  _vtable_vtable->_vtable[-1]= _vtable_vtable;

  _vector_vtable= new(_vtable);
  _vtable_vtable->vtable.bindings->_vtable[-1]= _vector_vtable;
  _vector_vtable->vtable.bindings->_vtable[-1]= _vector_vtable;

  _object_vtable= new(_vtable);
  _vtable_vtable->vtable.delegate= _object_vtable;
  _vector_vtable->vtable.delegate= _object_vtable;

  _selector_Table= new(_vtable);
  _object_Table= new(_vtable);

  _object= new(_object);
  _vtable= new(_vtable);
  _vector= new__(_vector, 0, 0);

  _assoc=    _object___delegated(0, _object, _object);  _assoc_vtable=    _assoc->_vtable[-1];
  _selector= _object___delegated(0, _object, _object);  _selector_vtable= _selector->_vtable[-1];
  _closure=  _object___delegated(0, _object, _object);  _closure_vtable=  _closure->_vtable[-1];

# define check(type)						\
  dprintf("type %s %p\n", #type, type);				\
  assert(type);							\
  dprintf("%s->_vtable[-1] %p\n", #type, type->_vtable[-1]);	\
  dprintf("%s_vtable %p\n", #type, type##_vtable);		\
  assert(type->_vtable[-1] == type##_vtable);			\
  assert(type##_vtable);					\
  assert(type##_vtable->_vtable[-1]= _vtable_vtable);
  check(_vtable);
  check(_vector);
  check(_object);
  check(_selector);
  check(_assoc);
  check(_closure);
# undef check

  s_methodAt_put_with_= _selector___intern_(0, _selector, _selector, "methodAt:put:with:");
  _vtable__methodAt_put_with_(0, _vtable_vtable, _vtable_vtable, s_methodAt_put_with_, (oop)_vtable__methodAt_put_with_, 0);

  s_lookup_= _selector___intern_(0, _selector, _selector, "lookup:");
  _vtable__methodAt_put_with_(0, _vtable_vtable, _vtable_vtable, s_lookup_, (oop)_vtable__lookup_, 0);

# define method(type, sel, var)								\
  s_##var= _selector___intern_(0, _selector, _selector, sel);				\
  _send(s_methodAt_put_with_, type##_vtable, s_##var, (_imp_t)type##__##var, 0);

  method(_selector, "_intern:",   	  _intern_);
  method(_object,   "_delegate", 	  _delegate);
  method(_object,   "_delegated", 	  _delegated);
  method(_object,   "_vtable",    	  _vtable);
  method(_vtable,   "init",		  init);
  method(_vtable,   "_alloc:",    	  _alloc_);
  method(_vtable,   "findKeyOrNil:",      findKeyOrNil_);
  method(_vtable,   "flush",		  flush);
  method(_object,   "_beTagType", 	  _beTagType);
  method(_object,   "_beNilType", 	  _beNilType);
  method(_object,   "_import:",   	  _import_);
  method(_object,   "_backtrace",   	  _backtrace);
# undef method

  s_doesNotUnderstand_= _selector___intern_(0, _selector, _selector, "doesNotUnderstand:");

  _libid_object= _object;

# define export(type) _libid_export(#type, type)
  export(_object);
  export(_selector);
  export(_assoc);
  export(_closure);
  export(_vector);
  export(_vtable);
# undef export
}

oop _libid_intern(const char *string)
{
  dprintf("_libid_intern(\"%s\")\n", string);
  return _send(s__intern_, _selector, string);
}

#if 0
static void binary(void *p)
{
  unsigned long l= (unsigned long)p;
  int i;
  for (i= 0;  i < 32;  ++i)
    {
      putchar('0' + (l >> 31));
      l <<= 1;
    }
}
#endif

_closure_t *_libid_bind(oop selector, oop receiver)
{
  static int recursionGuard= 0;
#if GLOBAL_MCACHE
  struct __entry *entry= 0;
#endif
  oop assoc= 0;
  oop vtable= receiver ? (((unsigned)receiver & 1) ? _libid_tag_vtable : receiver->_vtable[-1]) : _libid_nil_vtable;
  dprintf("_libid_bind(%p<%s>, %p\n", selector, selector->selector.elements, receiver);
  if (!vtable) fatal("panic: cannot send '%s' to %s: no vtable", selector->selector.elements, nameOf(receiver));

#if GLOBAL_MCACHE
# if 0
  binary(vtable); putchar(' '); binary(selector); putchar('\n');
# endif
  entry= _libid_mcache + ((((unsigned)vtable << 2) ^ ((unsigned)selector >> 3)) & ((sizeof(_libid_mcache) / sizeof(struct __entry)) - 1));
  if (entry->selector == selector && entry->vtable == vtable)
    return entry->closure;
#endif

  assoc= recursionGuard++ ? _vtable__lookup_(0, vtable, vtable, selector) : _send(s_lookup_, vtable, selector);
/*assoc= _vtable__lookup_(0, vtable, selector);*/
  --recursionGuard;
  if (!assoc)
    {
      if (selector != s_doesNotUnderstand_)
	{
	  oop result= _send(s_doesNotUnderstand_, receiver, selector);
	  if (_object___vtable(0, result, result) == _closure->_vtable[-1])
	    return (_closure_t *)result;
	}
      fatal("primitive error handling failed (%p %p)", receiver, selector);
    }
#if GLOBAL_MCACHE
  entry->selector= selector;
  entry->vtable=   vtable;
  entry->closure= &assoc->assoc.value->closure;
#endif
  return &assoc->assoc.value->closure;
}

struct __lookup _libid_bind2(oop selector, oop receiver)
{
  oop fragment= receiver;
  static int recursionGuard= 0;
#if GLOBAL_MCACHE
  struct __entry *entry= 0;
#endif
  oop assoc= 0;
  do {
    oop vtable= fragment ? (((unsigned)fragment & 1) ? _libid_tag_vtable : fragment->_vtable[-1]) : _libid_nil_vtable;
    dprintf("_libid_bind(%p<%s>, %p\n", selector, selector->selector.elements, fragment);
    if (!vtable) fatal("panic: cannot send '%s' to %s: no vtable", selector->selector.elements, nameOf(fragment));
#  if GLOBAL_MCACHE
    entry= _libid_mcache + ((((unsigned)vtable << 2) ^ ((unsigned)selector >> 3)) & ((sizeof(_libid_mcache) / sizeof(struct __entry)) - 1));
    if (entry->selector == selector && entry->vtable == vtable)
      return (struct __lookup){ entry->closure, fragment };
#  endif
    assoc= recursionGuard++ ? _vtable__lookup_(0, vtable, vtable, selector) : _send(s_lookup_, vtable, selector);
  /*assoc= _vtable__lookup_(0, vtable, selector);*/
    --recursionGuard;
    if (assoc)
      {
#      if GLOBAL_MCACHE
	entry->selector= selector;
	entry->vtable=   vtable;
	entry->closure= &assoc->assoc.value->closure;
#      endif
	return (struct __lookup){ &assoc->assoc.value->closure, fragment };
      }
    fragment= _send(s__delegate, fragment);
  } while (fragment);

  if (selector != s_doesNotUnderstand_)
    {
      oop result= _send(s_doesNotUnderstand_, receiver, selector);
      if (_object___vtable(0, result, result) == _closure->_vtable[-1])
	return (struct __lookup){ (_closure_t *)result, receiver };
    }
  fatal("primitive error handling failed (%p %p)", receiver, selector);
  return (struct __lookup){ 0, 0 };
}

void _libid_flush(oop selector)
{
#if GLOBAL_MCACHE
  struct __entry *entry;
  if (selector)
    {
      for (entry= _libid_mcache;  entry < _libid_mcache + (sizeof(_libid_mcache) / sizeof(struct __entry));  ++entry)
	if (entry->selector == selector)
	  entry->selector= entry->vtable= 0;
    }
  else
    for (entry= _libid_mcache;  entry < _libid_mcache + (sizeof(_libid_mcache) / sizeof(struct __entry));  ++entry)
      entry->selector= entry->vtable= 0;
#endif
}

oop _libid_proto(oop base)
{
  return _send(s__delegated, (base ? base : _object));
}

oop _libid_import(const char *key)
{
  oop name= _selector___intern_(0, _selector, _selector, key);
  oop assoc= _vtable__findKeyOrNil_(0, _object_Table, _object_Table, name);
  if (!assoc) fatal("import: '%s' is undefined", key);
  dprintf("IMPORT %s -> %p\n", key, assoc->assoc.value);
  return assoc->assoc.value;
}

oop _libid_export(const char *key, oop value)
{
  oop name= _selector___intern_(0, _selector, _selector, key);
  oop assoc= _vtable__findKeyOrNil_(0, _object_Table, _object_Table, name);
  if (!assoc)
    {
      assoc= new(_assoc);
      assoc->assoc.key= name;
    }
  assoc->assoc.value= value;
  _vtable__add_(0, _object_Table, _object_Table, assoc);
  dprintf("EXPORT %s -> %p\n", key, assoc->assoc.value);
  return value;
}

void _libid_method(oop type, oop selector, _imp_t method)
{
  oop vt= 0;
  dprintf("_libid_method(%p, %p<%s>, %p)\n", type, selector, selector->selector.elements, method);
  vt= _send(s__vtable, type);
  _send(s_methodAt_put_with_, vt, selector, method, 0);
}

oop _libid_alloc(oop type, size_t size)
{
  oop vt= type->_vtable[-1];
  dprintf("LIBID_ALLOC %p [%p] %ld\n", type, type->_vtable[-1], (long)size);
  return _vtable___alloc_(0, vt, vt, size);
}

oop *_libid_palloc(size_t size)
{
  dprintf("LIBID_PALLOC %ld\n", (long)size);
#if USE_GC
  return GC_malloc(size);
#else
  return calloc(1, size);
#endif
}

void *_libid_balloc(size_t size)
{
  dprintf("LIBID_BALLOC %4ld\n", (long)size);
#if USE_GC
  return GC_malloc_atomic(size);
#else
  return calloc(1, size);
#endif
}

static oop nlresult= 0;

oop _libid_nlresult(void)
{
  return nlresult;
}

oop _libid_nlreturn(oop nlr, oop result)
{
  nlresult= result;
  longjmp(*((jmp_buf *)nlr), 1);
  return 0;
}

void *_libid_param(int index)
{
  switch (index)
    {
    case -1:	return (void *)errno;
    case  0:	return (void *)_argc;
    case  1:	return (void *)_argv;
    case  2:	return (void *)_envp;
#  if USE_GC
    case  3:	return (void *)(GC_gcollect(), 0);
    case  4:	return (void *)GC_get_free_bytes();
#  endif
    case  5:	return (void *)SYSARCH;
    case  6:	return (void *)SYSOS;
    }
  return 0;
}
