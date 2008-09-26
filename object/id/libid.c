#include <stdio.h>					/* cum mortuis in lingua mortua */
#include <stdlib.h>
#include <stdarg.h>
#include <signal.h>
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
# define RTLD_DEFAULT	0
# define RTLD_LAZY	0
# define RTLD_GLOBAL	0
# define RTLD_NOW	0
  dlhandle_t  dlopen(const char *path, int mode);
  void	     *dlsym(dlhandle_t handle, const char *symbol);
  int	      dlclose(dlhandle_t handle);
# define      dlerror() "unknown error"
#else
# include <dlfcn.h>
  typedef void *dlhandle_t;
#endif

#include "gc/gc.h"

#define GLOBAL_MCACHE	1024
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

typedef struct t__object *oop;

struct __send;

typedef oop (*_imp_t)(struct __send *_send, ...);

#include <id/id.h>

struct __libid	  *_libid_init    (int *argcp, char ***argvp, char ***envp);
oop  		   _libid_intern  (const char *string);
oop  		   _libid_proto   (oop base);
oop  		   _libid_import  (const char *name);
oop  		   _libid_export  (const char *name, oop value);
void 		   _libid_method  (oop type, oop selector, _imp_t method);
oop  		   _libid_alloc   (oop type, size_t size);
oop  		  *_libid_palloc  (size_t size);
void  		  *_libid_balloc  (size_t size);
void		   _libid_flush   (oop selector);
struct __closure  *_libid_bind    (oop selector, oop receiver);
struct __lookup    _libid_bind2   (oop selector, oop receiver);
_imp_t		   _libid_bindv   (struct __send *send);
oop                _libid_nlreturn(oop nlr, oop result);
oop                _libid_nlresult(void);
void		  *_libid_enter(struct __methodinfo *info);
void		  *_libid_methodAt(int offset);
void		   _libid_line(int line);
void		   _libid_leave(void *cookie);
char		  *_libid_backtrace(void);
void		   _libid_infos(struct __methodinfo *first, struct __methodinfo *last);
void		  *_libid_infoList(void);

#define _sendv(MSG, N, RCV, ARG...) ({					\
  struct __send _s= { (MSG), (N), (RCV) };				\
  ((_imp_t)(_libid_bindv(&_s)))(&_s, _s.receiver, _s.receiver, ##ARG);	\
})

static int    id_argc= 0;
static char **id_argv= 0;
static char **id_envp= 0;

static oop s_methodAt_put_with_= 0;
static oop s__intern_= 0;
static oop s_init= 0;
static oop s_flush= 0;
static oop s_lookup_= 0;
static oop s_findKeyOrNil_= 0;
static oop s_delegated= 0;
static oop s__delegated= 0;
static oop s__delegated_= 0;
static oop s__vtable= 0;
static oop s__alloc_= 0;
static oop s__beTagType= 0;
static oop s__beNilType= 0;
static oop s__import_= 0;
static oop s_doesNotUnderstand_= 0;
static oop s__delegate= 0;

typedef struct t__object   _object_t;
typedef struct t__selector _selector_t;
typedef struct t__closure  _closure_t;
typedef struct t__assoc    _assoc_t;
typedef struct t__vector   _vector_t;
typedef struct t__vtable   _vtable_t;

static struct __libid _libid;

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

struct t__object
{
  union {
    oop		_vtable[0];
    _closure_t	 closure;
    _selector_t	 selector;
    _assoc_t	 assoc;
    _vector_t	 vector;
    _vtable_t	 vtable;
  };
};

static oop _object_vtable= 0;
static oop _object= 0;

oop _libid_nil_vtable= 0;
oop _libid_tag_vtable= 0;

static oop _selector_Table= 0;
static oop _object_Table= 0;

#if GLOBAL_MCACHE

struct __entry
{
  oop		 vtable;
  oop		 selector;
  _closure_t	*closure;
} *_libid_mcache[GLOBAL_MCACHE];

#endif

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
  fputs(_libid_backtrace(), stderr);
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
  self->vtable.bindings= new__(_vector, sizeof(oop) * 4, 4);
  self->vtable.delegate= 0;
  return self;
}

static oop _vtable__delegated(oop _thunk, oop state, oop self)
{
  oop vt= _vtable___alloc_(0, self->_vtable[-1], self->_vtable[-1], sizeof(_vtable_t));
  assert(isKindOf(self, _vtable));
  vt->vtable.tally= 0;
  vt->vtable.bindings= new__(_vector, sizeof(oop) * 4, 4);
  vt->vtable.delegate= self;
  return vt;
}

static oop _object___vtable(oop _thunk, oop state, oop self)
{
  return self ? (((long)self & 1) ? _libid_tag_vtable :  self->_vtable[-1]) : _libid_nil_vtable;
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

static oop _object___delegated_(oop _thunk, oop state, oop self, size_t size)
{
  oop obj= _vtable__delegated(0, self->_vtable[-1], self->_vtable[-1]);
  return _vtable___alloc_(0, obj, obj, size);
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
  if (assoc) return assoc;
  if (self->vtable.delegate)
    {
      if (self == self->vtable.delegate) fatal("delegation loop\n");
      return _vtable__lookup_(0, self->vtable.delegate, self->vtable.delegate, selector);
    }
  return 0;
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
#if 0
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
#else
  oop *table= _selector_Table->vtable.bindings->vector.elements;
  size_t low= 0;
  size_t high= _selector_Table->vtable.tally;
  assert(isMemberOf(self, _selector));
  dprintf("_selector___intern_(%p, %p, %p, \"%s\")\n", _thunk, self, state, string);
  while (low < high)
    {
      size_t mid= (low + high) / 2;
      if (strcmp(table[mid]->selector.elements, string) < 0)
	low= mid + 1; 
      else
	high= mid; 
    }
  if ((low < _selector_Table->vtable.tally) && !strcmp(table[low]->selector.elements, string))
    return table[low];
  if (_selector_Table->vtable.tally == _selector_Table->vtable.bindings->vector.size)
    {
      _selector_Table->vtable.bindings= _vector__grow(0, _selector_Table->vtable.bindings, _selector_Table->vtable.bindings);
      table= _selector_Table->vtable.bindings->vector.elements;
    }
  memmove(table + low + 1, table + low, sizeof(oop) * (_selector_Table->vtable.tally - low));
  _selector_Table->vtable.tally++;
  return table[low]= _selector__withCString_(0, _selector, _selector, string);
#endif
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
      if (!lib && !access(path, R_OK|X_OK)) fprintf(stderr, "%s: %s\n", path, dlerror());
      if (!lib)
	{
	  snprintf(path, MAXPATHLEN, "./%s.so", fileName);
	  lib= dlopen(path, ID_RTLD_FLAGS);
	  dprintf("4  dlopen %s -> %p\n", path, lib);
	  if (!lib && !access(path, R_OK|X_OK)) fprintf(stderr, "%s: %s\n", path, dlerror());
	}
      if (!lib)
	{
	  char *prefix;
	  if (!(prefix= getenv("IDC_LIBDIR"))) prefix= PREFIX;
	  snprintf(path, MAXPATHLEN, "%s%s.so", prefix, fileName);
	  lib= dlopen(path, ID_RTLD_FLAGS);
	  if (!lib && !access(path, R_OK|X_OK)) fprintf(stderr, "%s: %s\n", path, dlerror());
	  dprintf("5  dlopen %s -> %p\n", path, lib);
	}
#      if defined(WIN32)
      if (!lib)
	{
	  char *p;
	  for (p= path;  *p;  ++p)
	    if ('/' == *p) *p= '\\';
	  lib= dlopen(path, ID_RTLD_FLAGS);
	  if (!lib && !access(path, R_OK|X_OK)) fprintf(stderr, "%s: %s\n", path, dlerror());
	  dprintf("7  dlopen %s -> %p\n", path, lib);
	}
      if (!lib)
	{
	  snprintf(path, MAXPATHLEN, ".\\%s.so", fileName);
	  lib= dlopen(path, ID_RTLD_FLAGS);
	  if (!lib && !access(path, R_OK|X_OK)) fprintf(stderr, "%s: %s\n", path, dlerror());
	  dprintf("6  dlopen %s -> %p\n", path, lib);
	}
#      endif
      if (!lib) fatal("import: %s.so: No such file or directory\n", fileName);
      init= dlsym(lib, "__id__init__");
      dprintf("7  dlsym %p __id__init__ -> %p\n", lib, init);
      if (!init) fatal("%s: __id__init__: Undefined symbol\n", path);
    }
  dprintf("INIT %s %p %p\n", fileName, lib, init);
  ((void (*)(struct __libid *))init)(&_libid);
  return self;
}

static char *nameOf(oop object)
{
  static char buf[32];
  char *name= buf;
  oop vtable= 0;
  if      (object == 0)				 name= "(0x0)";
  else if ((long)object & 1)			 sprintf(buf, "(#%p=0x%lx=%ld)", object, (long)object >> 1, (long)object >> 1);
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

oop _libid_intern(const char *string)
{
  dprintf("_libid_intern(\"%s\")\n", string);
  return _sendv(s__intern_, 2, _selector, string);
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

#if defined(__MACH__) || defined(__CYGWIN__) || defined(__WIN32__)
# define _ "_"
#else
# define _
#endif

#if GLOBAL_MCACHE && defined(__GNUC__) && defined(__i386__)
asm (
"	.text					\n"
"	.align	4				\n"
"	.globl	"_"_libid_bind			\n"
_"_libid_bind:					\n"
"	movl	8(%esp), %eax			\n"	// eax = receiver
"	testb	$0x1, %al			\n"
"	jne	__t1				\n"	// tagged
"	testl	%eax, %eax			\n"
"	je	__t0				\n"	// nil
"	movl	-4(%eax), %edx			\n"	// edx = recevier.vtable
"__tok:	movl	4(%esp), %ecx			\n"	// ecx = selector
"	movl	%edx, %eax			\n"	// eax = vtable
"	shll	$2, %eax			\n"	// eax = vtable << 2
"	shrl	$3, %ecx			\n"	// ecx = selector >> 3
"	xorl	%ecx, %eax			\n"	// eax = (vtable << 2) ^ (selector >> 3)
"	andl	$1023, %eax			\n"	// eax = (vtable << 2) ^ (selector >> 3) & CacheSize
"	movl	"_"_libid_mcache(,%eax,4), %eax	\n"	// eax = mcache[eax * sizeof(entry)]
"	testl	%eax, %eax			\n"	// eax ?
"	je	"_"_libid_bind_fill		\n"
"	cmpl	(%eax), %edx			\n"	// eax.vtable == vtable ?
"	jne	"_"_libid_bind_fill		\n"
"	movl	4(%esp), %ecx			\n"	// ecx = selector
"	cmp	4(%eax), %ecx			\n"	// eax.selector == selector ?
"	jne	"_"_libid_bind_fill		\n"
"	movl	8(%eax), %eax			\n"	// ecx = closure
//"	addl	$1, "_"_libid_hits		\n"
"	ret					\n"	// hit
"__t0:	movl	"_"_libid_nil_vtable, %edx	\n"
"	jmp	__tok				\n"
"__t1:	movl	"_"_libid_tag_vtable, %edx	\n"
"	jmp	__tok				\n"
);
# define _libid_bind _libid_bind_fill
#endif

#if GLOBAL_MCACHExxx && defined(__GNUC__) && defined(__ppc__)	/* XXX FIX ME XXX */
asm (
"	.text						\n"
"	.align	4					\n"
"	.globl	"_"_libid_bind				\n"
_"_libid_bind:						\n"	// r3= selector, r4= receiver
"	andi.	r0, r4, 1				\n"
"	bne	__t1					\n"	// tagged
"	cmpwi	r4, 0					\n"
"	beq	__t0					\n"	// nil
"	lwz	r5, -4(r4)				\n"	// r5 = recevier.vtable
"__tok:	slwi	r6, r5, 4				\n"	// r6 = vtable << 4 (2+2)
"	srawi	r7, r3, 1				\n"	// r7 = selector >> 1 (3-2)
"	xor	r6, r6, r7				\n"	// r6 = (vtable << 2) ^ (selector >> 3)
"	andi.	r6, r6, 0xffc				\n"	// r6 = (vtable << 2) ^ (selector >> 3) & CacheSize
"	add	r7, r6, r6				\n"
"	add	r6, r6, r7				\n"
"	addis	r6, r6, ha16("_"_libid_mcache)		\n"
"	addi	r6, r6, lo16("_"_libid_mcache)		\n"
"	lwz	r7, 0(r6)				\n"	// line.vtable
"	cmpw	r5, r7					\n"	// line.vtable == receiver.vtable ?
"	bne	"_"_libid_bind_fill			\n"
"	lwz	r7, 4(r6)				\n"	// line.selector
"	cmpw	r3, r7					\n"	// line.selector == selector ?
"	bne	"_"_libid_bind_fill			\n"
"	lwz	r3, 8(r6)				\n"	// return line.closure
"	blr						\n"
"__t0:	lis	r5, ha16("_"_libid_nil_vtable)		\n"
"	lwz	r5, lo16("_"_libid_nil_vtable)(r5)	\n"
"	b	__tok					\n"
"__t1:	lis	r5, ha16("_"_libid_tag_vtable)		\n"
"	lwz	r5, lo16("_"_libid_tag_vtable)(r5)	\n"
"	b	__tok					\n"
);
# define _libid_bind _libid_bind_fill
#endif

#undef _

struct __closure *_libid_bind(oop selector, oop receiver)
#undef _libid_bind
{
  static int recursionGuard= 0;
#if GLOBAL_MCACHE
  unsigned int    probe= 0;
  struct __entry *entry= 0;
#endif
  oop assoc= 0;
  oop vtable= receiver ? (((long)receiver & 1) ? _libid_tag_vtable : receiver->_vtable[-1]) : _libid_nil_vtable;
  dprintf("_libid_bind(%p<%s>, %p\n", selector, selector->selector.elements, receiver);
  if (!vtable) fatal("panic: cannot send '%s' to %s: no vtable", selector->selector.elements, nameOf(receiver));

#if GLOBAL_MCACHE
# if 0
  putchar(' ');
# endif
  probe= (((unsigned long)vtable << 2) ^ ((unsigned long)selector >> 3)) & (GLOBAL_MCACHE - 1);
  entry= _libid_mcache[probe];
  if (entry && entry->selector == selector && entry->vtable == vtable)
    return (struct __closure *) entry->closure;
# if 0
  putchar('-');
# endif
#endif

  assoc= recursionGuard++ ? _vtable__lookup_(0, vtable, vtable, selector) : _sendv(s_lookup_, 2, vtable, selector);
/*assoc= _vtable__lookup_(0, vtable, selector);*/
  --recursionGuard;
  if (!assoc)
    {
      if (selector != s_doesNotUnderstand_)
	{
	  oop result= _sendv(s_doesNotUnderstand_, 2, receiver, selector);
	  if (_object___vtable(0, result, result) == _closure->_vtable[-1])
	    return (struct __closure *)result;
	}
      fatal("primitive error handling failed (%p %p)", receiver, selector);
    }
#if GLOBAL_MCACHE
# if USE_GC
  entry= GC_malloc(sizeof(struct __entry));
# else
  entry= malloc(sizeof(struct __entry));	/* lossage */
# endif
  entry->selector= selector;
  entry->vtable=   vtable;
  entry->closure= &assoc->assoc.value->closure;
  _libid_mcache[probe]= entry;
#endif
  return (struct __closure *)&assoc->assoc.value->closure;
}

struct __lookup _libid_bind2(oop selector, oop receiver)
{
  oop fragment= receiver;
  static int recursionGuard= 0;
#if GLOBAL_MCACHE
  unsigned int    probe= 0;
  struct __entry *entry= 0;
#endif
  oop assoc= 0;
  do {
    oop vtable= fragment ? (((long)fragment & 1) ? _libid_tag_vtable : fragment->_vtable[-1]) : _libid_nil_vtable;
    dprintf("_libid_bind(%p<%s>, %p\n", selector, selector->selector.elements, fragment);
    if (!vtable) fatal("panic: cannot send '%s' to %s: no vtable", selector->selector.elements, nameOf(fragment));
#  if GLOBAL_MCACHE
    probe= (((unsigned long)vtable << 2) ^ ((unsigned long)selector >> 3)) & (GLOBAL_MCACHE - 1);
    entry= _libid_mcache[probe];
    if (entry->selector == selector && entry->vtable == vtable)
      return (struct __lookup){ (struct __closure *)entry->closure, fragment };
#  endif
    assoc= recursionGuard++ ? _vtable__lookup_(0, vtable, vtable, selector) : _sendv(s_lookup_, 2, vtable, selector);
  /*assoc= _vtable__lookup_(0, vtable, selector);*/
    --recursionGuard;
    if (assoc)
      {
#      if GLOBAL_MCACHE
#	if USE_GC
	entry= GC_malloc(sizeof(struct __entry));
#	else
	entry= malloc(sizeof(struct __entry));	/* lossage */
#	endif
	entry->selector= selector;
	entry->vtable=   vtable;
	entry->closure= &assoc->assoc.value->closure;
	_libid_mcache[probe]= entry;
#      endif
	return (struct __lookup){ (struct __closure *)&assoc->assoc.value->closure, fragment };
      }
    fragment= _sendv(s__delegate, 1, fragment);
  } while (fragment);

  if (selector != s_doesNotUnderstand_)
    {
      oop result= _sendv(s_doesNotUnderstand_, 2, receiver, selector);
      if (_object___vtable(0, result, result) == _closure->_vtable[-1])
	return (struct __lookup){ (struct __closure *)result, receiver };
    }
  fatal("primitive error handling failed (%p %p)", receiver, selector);
  return (struct __lookup){ 0, 0 };
}

_imp_t _libid_bindv(struct __send *send)
{
  register oop selector= send->selector;
  register oop receiver= send->receiver;
  static int recursionGuard= 0;
#if GLOBAL_MCACHE
  unsigned int    probe= 0;
  struct __entry *entry= 0;
#endif
  oop assoc= 0;
  oop vtable= receiver ? (((long)receiver & 1) ? _libid_tag_vtable : receiver->_vtable[-1]) : _libid_nil_vtable;
  dprintf("_libid_bind(%p<%s>, %p\n", selector, selector->selector.elements, receiver);
  if (!vtable) fatal("panic: cannot send '%s' to %s: no vtable", selector->selector.elements, nameOf(receiver));

#if GLOBAL_MCACHE
# if 0
  putchar(' ');
# endif
  probe= (((unsigned long)vtable << 2) ^ ((unsigned long)selector >> 3)) & (GLOBAL_MCACHE - 1);
  entry= _libid_mcache[probe];
  if (entry && entry->selector == selector && entry->vtable == vtable)
    {
      send->state= receiver;
      return (send->closure= (struct __closure *)entry->closure)->method;
    }
# if 0
  putchar('-');
# endif
#endif

  assoc= recursionGuard++ ? _vtable__lookup_(0, vtable, vtable, selector) : _sendv(s_lookup_, 2, vtable, selector);
/*assoc= _vtable__lookup_(0, vtable, selector);*/
  --recursionGuard;
  if (!assoc)
    {
      if (selector != s_doesNotUnderstand_)
	{
	  oop result= _sendv(s_doesNotUnderstand_, 2, receiver, selector);
	  if (_object___vtable(0, result, result) == _closure->_vtable[-1])
	    {
	      send->state= receiver;
	      return (send->closure= (struct __closure *)result)->method;
	    }
	}
      fatal("primitive error handling failed (%p %p)", receiver, selector);
    }
#if GLOBAL_MCACHE
# if USE_GC
  entry= GC_malloc(sizeof(struct __entry));
# else
  entry= malloc(sizeof(struct __entry));	/* lossage */
# endif
  entry->selector= selector;
  entry->vtable=   vtable;
  entry->closure= &assoc->assoc.value->closure;
  _libid_mcache[probe]= entry;
#endif
  send->state= receiver;
  return (send->closure= (struct __closure *)&assoc->assoc.value->closure)->method;
}

void _libid_flush(oop selector)
{
#if GLOBAL_MCACHE
  unsigned int probe;
  if (selector)
    {
      for (probe= 0;  probe < GLOBAL_MCACHE;  ++probe)
	if (_libid_mcache[probe] && _libid_mcache[probe]->selector == selector)
	  _libid_mcache[probe]->selector=
	    _libid_mcache[probe]->vtable= 0;
    }
  else
    memset(_libid_mcache, 0, sizeof(_libid_mcache));
#endif
}

oop _libid_proto(oop base)
{
  return _sendv(s__delegated, 1, (base ? base : _object));
}

oop _libid_proto2(oop base, size_t size)
{
  return _sendv(s__delegated_, 2, (base ? base : _object), size);
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
  vt= _sendv(s__vtable, 1, type);
  _sendv(s_methodAt_put_with_, 4, vt, selector, method, 0);
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
    case -1:	return (void *)(long)errno;
    case  0:	return (void *)id_argc;
    case  1:	return (void *)id_argv;
    case  2:	return (void *)id_envp;
#  if USE_GC
    case  3:	return (void *)(long)(GC_gcollect(), 0);
    case  4:	return (void *)GC_get_free_bytes();
#  endif
    case  5:	return (void *)SYSARCH;
    case  6:	return (void *)SYSOS;
#  if defined(WIN32)
    case  7:	return (void *)'\\';
#  else
    case  7:	return (void *)'/';
#  endif
    }
  return 0;
}

/*----------------------------------------------------------------*/

struct position
{
  struct __methodinfo	*info;
  int			 line;
};

static struct position *positions= 0;
static int position= 0;
static int maxPosition= 0;
static struct __methodinfo *infoList= 0;
static struct __methodinfo *lastInfo= 0;

void _libid_infos(struct __methodinfo *first, struct __methodinfo *last)
{
  if (lastInfo)
    lastInfo->next= first;
  else
    infoList= first;
  lastInfo= last;
}

void *_libid_infoList(void)
{
  return infoList;
}

void *_libid_enter(struct __methodinfo *info)
{
  struct position *p= 0;
  if (position >= maxPosition)
    {
      if (positions)
	{
	  maxPosition *= 2;
	  positions= realloc(positions, sizeof(struct position) * maxPosition);
	}
      else
	{
	  maxPosition= 128;
	  positions= malloc(sizeof(struct position) * maxPosition);
	}
    }
  p= positions + position;
  p->info= info;
  p->line= info->sourceStart;
  return (void *)(long)position++;
}

void *_libid_methodAt(int offset)
{
  return ((0 <= offset) && (offset < position)) ? positions[position - offset - 1].info : 0;
}

int _libid_lineAt(int offset)
{
  return ((0 <= offset) && (offset < position)) ? positions[position - offset - 1].line : -1;
}

void _libid_line(int line)
{
  positions[position - 1].line= line;
}

void _libid_leave(void *cookie)
{
  position= (int)(long)cookie;
}

char *_libid_backtrace(void)
{
  int i, indent= 0, len= 0;
  int size= 2048;
  char *result;

 grow:
  size *= 2;
  {
    int offset= 0;
    result= _libid_balloc(size);
    for (i= position;  i--;)
      {
	char *base= strrchr(positions[i].info->file, '/');
	if (base) positions[i].info->file= base + 1;
	if (indent < (len= strlen(positions[i].info->file)))
	  indent= len;
      }
    indent += 9;
    for (i= position;  i--;)    /*for (i= 0;  i< position;  ++i)*/
      {
	int width= snprintf(result + offset, size - offset, "  %s:%-4d ", positions[i].info->file, positions[i].line);
	offset += width;
	if (indent < width)
	  indent= width;
	else
	  {
	    width= snprintf(result + offset, size - offset, "%*s", indent - width, "");
	    offset += width;
	  }
	width= snprintf(result + offset, size - offset, "%s %s\n", positions[i].info->type, positions[i].info->name);
	offset += width;
	if (offset >= size) goto grow;
      }
  }
  return result;
}

static void sigint(int signum)	{ fatal("\nInterrupt"); }
#if defined(SIGHUP)
static void sighup(int signum)	{ fprintf(stderr, "\nHangup\n");  fputs(_libid_backtrace(), stderr); }
#endif

struct __libid *_libid_init(int *argcp, char ***argvp, char ***envpp)
{
  dprintf("_libid_init()\n");

#if USE_GC
  GC_INIT();
#endif

  if (argcp)
    {
      id_argc= *argcp;
      id_argv= *argvp;
      id_envp= *envpp;
    }

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
  _sendv(s_methodAt_put_with_, 4, type##_vtable, s_##var, (_imp_t)type##__##var, 0);

  method(_selector, "_intern:",   	  _intern_);
  method(_object,   "_delegate", 	  _delegate);
  method(_object,   "_delegated", 	  _delegated);
  method(_object,   "_delegated:", 	  _delegated_);
  method(_object,   "_vtable",    	  _vtable);
  method(_vtable,   "init",		  init);
  method(_vtable,   "_alloc:",    	  _alloc_);
  method(_vtable,   "delegated",    	  delegated);
  method(_vtable,   "findKeyOrNil:",      findKeyOrNil_);
  method(_vtable,   "flush",		  flush);
  method(_object,   "_beTagType", 	  _beTagType);
  method(_object,   "_beNilType", 	  _beNilType);
  method(_object,   "_import:",   	  _import_);
# undef method

  s_doesNotUnderstand_= _selector___intern_(0, _selector, _selector, "doesNotUnderstand:");

# define export(type) _libid_export(#type, type)
  export(_object);
  export(_selector);
  export(_assoc);
  export(_closure);
  export(_vector);
  export(_vtable);
# undef export

  signal(SIGINT, sigint);
# if defined(SIGHUP)
  signal(SIGHUP, sighup);
# endif

  _libid.dlopen		= dlopen;
  _libid.dlsym		= dlsym;
  _libid.dlclose	= dlclose;

  _libid._object	= _object;
  _libid.nil_vtable	= _libid_nil_vtable;
  _libid.tag_vtable	= _libid_tag_vtable;

  _libid.intern		= _libid_intern;
  _libid.proto		= _libid_proto;
  _libid.method		= _libid_method;
  _libid.alloc		= _libid_alloc;
  _libid.palloc		= _libid_palloc;
  _libid.balloc		= _libid_balloc;
  _libid.proto2		= _libid_proto2;

  _libid.import		= _libid_import;
  _libid.export		= _libid_export;
  _libid.param		= _libid_param;

  _libid.bind		= _libid_bind;
  _libid.bind2		= _libid_bind2;
  _libid.bindv		= _libid_bindv;

  _libid.nlreturn	= _libid_nlreturn;
  _libid.nlresult	= _libid_nlresult;

  _libid.enter		= _libid_enter;
  _libid.line		= _libid_line;
  _libid.leave		= _libid_leave;
  _libid.backtrace	= _libid_backtrace;
  _libid.methodAt	= _libid_methodAt;
  _libid.lineAt		= _libid_lineAt;
  _libid.infos		= _libid_infos;
  _libid.infoList	= _libid_infoList;

  _libid.gc_addRoots			    = _libid.dlsym(RTLD_DEFAULT, "GC_add_roots");
  _libid.gc_gcollect			    = _libid.dlsym(RTLD_DEFAULT, "GC_gcollect");
  _libid.gc_unregisterDisappearingLink	    = _libid.dlsym(RTLD_DEFAULT, "GC_unregister_disappearing_link");
  _libid.gc_generalRegisterDisappearingLink = _libid.dlsym(RTLD_DEFAULT, "GC_general_register_disappearing_link");

  return &_libid;
}


#if defined(WIN32)

# include <tlhelp32.h>

struct dll
{
  char		*name;
  dlhandle_t	 handle;
  struct dll	*next;
};

static struct dll *dlls= 0;

static int dlinitialised= 0;

static void dlinit(void);

dlhandle_t dlopen(const char *path, int mode)
{
  dlhandle_t handle= 0;
  if (!dlinitialised) dlinit();
  {
    unsigned int errormode= SetErrorMode(SEM_FAILCRITICALERRORS);
    SetErrorMode(errormode | SEM_FAILCRITICALERRORS);
    handle= GetModuleHandle(path);
    if ((!handle) && path) handle= LoadLibrary(path);
    SetErrorMode(errormode);
  }
  if (handle)
    {
      struct dll *dll= (struct dll *)malloc(sizeof(struct dll));
      dll->handle= handle;
      dll->next= dlls;
      dlls= dll;
    }
  return handle;
}

static void dlinit(void)
{
  HANDLE snapshot;
  dlinitialised= 1;
  if ((HANDLE)-1 != (snapshot= CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, getpid())))
    {
      MODULEENTRY32 me32;
      me32.dwSize= sizeof(MODULEENTRY32);
      if (Module32First(snapshot, &me32))
	do
	  dlopen(me32.szModule, RTLD_NOW | RTLD_GLOBAL);
	while (Module32Next(snapshot, &me32));
      CloseHandle(snapshot);
    }
}

void *dlsym(dlhandle_t handle, const char *symbol)
{
  void *addr= 0;
  struct dll *dll;
  if (!dlinitialised) dlinit();
  if (handle)
    {
      addr= GetProcAddress(handle, symbol);
      dprintf("dlsym %p \"%s\" -> %p\n", handle, symbol, addr);
      return addr;
    }
  if ((addr= GetProcAddress(GetModuleHandle(0), symbol)))
    {
      dprintf("dlsym <main> \"%s\" -> %p\n", symbol, addr);
      return addr;
    }
  for (dll= dlls;  dll;  dll= dll->next)
    if ((addr= GetProcAddress(dll->handle, symbol)))
      {
	dprintf("dlsym dll %p \"%s\" -> %p\n", dll->handle, symbol, addr);
	return addr;
      }
  dprintf("dlsym 0 \"%s\" -> FAIL\n", symbol);
  return 0;
}

int dlclose(dlhandle_t handle)
{
  struct dll *dll, **dllp;
  for (dllp= &dlls;  (dll= *dllp);  dllp= &dll->next)
    if (dll->handle == handle)
      {
	*dllp= dll->next;
	free(dll);
	break;
      }
  FreeLibrary(handle);
  return 0;
}

#endif
