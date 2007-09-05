#ifndef __libid_h
#define __libid_h

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
#include <gc/gc.h>
#if defined(WIN32)
# include <malloc.h>
# include <windows.h>
# include <winbase.h>
  typedef HINSTANCE dlhandle_t;
# define dlopen(path, mode)	LoadLibrary(path)
# define dlsym(handle, name)	((void *)GetProcAddress(handle, name))
# define dlclose(handle)	FreeLibrary(handle)
# define RTLD_DEFAULT		GetModuleHandle(0)
#else
# include <dlfcn.h>
  typedef void *dlhandle_t;
#endif
#ifndef O_BINARY
# define O_BINARY 0
#endif

typedef struct t__object *oop;

typedef oop (*_imp_t)(oop closure, oop state, oop receiver, ...);
typedef oop (*_block_t)(oop closure, oop receiver, ...);

struct __closure
{
  _imp_t method;
  oop	 data;
};

struct __lookup
{
  struct __closure *closure;
  oop		    state;
};

struct _libid
{
  oop	object;
  oop  	tag_vtable;
  oop  	nil_vtable;

  struct __closure *(*bind )(oop selector, oop receiver);
  void		    (*bind2)(struct __lookup *lookup, oop selector, oop receiver);

  void	   *(*param   )(int index);
  oop  	    (*intern  )(const char *string);
  oop  	    (*proto   )(oop base);
  oop  	    (*import  )(const char *name);
  oop  	    (*export  )(const char *name, oop value);
  void 	    (*method  )(oop type, oop selector, _imp_t method);
  oop  	    (*alloc   )(oop type, size_t size);
  oop  	   *(*palloc  )(size_t size);
  void     *(*balloc  )(size_t size);
  oop	    (*nlreturn)(oop nlr, oop result);
  oop       (*nlresult)(void);

  void	*(*enter	)(char *name, char *type, char *file);
  void	 (*line		)(int line);
  void	 (*scope	)(void);
  void	 (*leave	)(void *);
  char	*(*backtrace	)(void);

  void	(*gc_gcollect				)(void);
  void	(*gc_addRoots				)(char *lo, char *hi);
  int	(*gc_generalRegisterDisappearingLink	)(void **link, void *ptr);
  int	(*gc_unregisterDisappearingLink		)(void **link);
};

static struct _libid *_libid= 0;

static void              *(*_local_param   )(int index)= 0;
static oop  		  (*_local_intern  )(const char *string)= 0;
static oop  		  (*_local_proto   )(oop base)= 0;
static oop  		  (*_local_import  )(const char *name)= 0;
static oop  		  (*_local_export  )(const char *name, oop value)= 0;
static void 		  (*_local_method  )(oop type, oop selector, _imp_t method)= 0;
static oop  		  (*_local_alloc   )(oop type, size_t size)= 0;
static oop  		 *(*_local_palloc  )(size_t size)= 0;
static void  		 *(*_local_balloc  )(size_t size)= 0;
static struct __closure  *(*_local_bind    )(oop selector, oop receiver)= 0;
static oop                (*_local_nlreturn)(oop nlr, oop result)= 0;
static oop                (*_local_nlresult)(void)= 0;
static oop  		    _local_object= 0;
static oop  		   *_local_tag_vtable= 0;
static oop  		   *_local_nil_vtable= 0;
static void               (*_local_gc_addRoots)(char *lo, char *hi)= 0;
static void	          (*_local_gc_unregisterDisappearingLink)(void *ptr)= 0;
static void		  (*_local_gc_generalRegisterDisappearingLink)(void *link, void *ptr)= 0;
static void		  (*_local_gc_gcollect)(void)= 0;
static void		 *(*_local_enter)(char *name, char *type, char *file)= 0;
static void		  (*_local_line)(int line)= 0;
static void		  (*_local_leave)(void *)= 0;
static char		 *(*_local_backtrace)(void)= 0;

#define _param(INDEX)		_libid->param(INDEX)
#define _selector(NAME)		_libid->intern(NAME)
#define _proto(BASE)		_libid->proto(BASE)
#define _id_import(NAME)	_libid->import(NAME)
#define _id_export(NAME, VAL)	_libid->export((NAME), (VAL))
#define _method(TYPE, SEL, IMP)	_libid->method((TYPE), (SEL), (_imp_t)(IMP))
#define _alloc(RCV, LBS)	_libid->alloc((RCV), (LBS))
#define _palloc(LBS)		_libid->palloc((LBS))
#define _balloc(LBS)		_libid->balloc((LBS))
#define _nlreturn(NLR, ARG)	_libid->nlreturn((NLR), (ARG))
#define _nlresult()		_libid->nlresult()
#define _backtrace()		_libid->backtrace()
#ifdef ID_DEBUG
# define _enter(NM, TYPE, FILE)	void *__id_debug= _libid->enter(NM, TYPE, FILE)
# define _line(line)		_libid->line(line)
# define _leave()		_libid->leave(__id_debug)
#else
# define _enter(NM, TYPE, FILE)
# define _line(line)
# define _leave()
#endif
#define _return			_leave(); return

#if (LIBID_POSIC == 1)
  struct __posic
  {
    oop		    vtable;
    struct __closure *closure;
  };
# define _send(MSG, RCV, ARG...) ({										\
    static struct __posic _e;											\
    register oop _r= (RCV);											\
    register oop _v= _r ? (((unsigned)_r & 1) ? *_local_tag_vtable : ((oop *)_r)[-1]) : *_local_nil_vtable;	\
    if (_v != _p.vtable) { _p.vtable= _v; _p.closure= _local_bind((MSG), _r); }					\
    (_p.closure->method)((oop)_p.closure, _r, _r, ##ARG);							\
  })
#else
# define _send(MSG, RCV, ARG...) ({						\
    register oop _r= (RCV);							\
    struct __closure *_c= (struct __closure *)_libid->bind((MSG), _r);		\
    (_c->method)((oop)_c, _r, _r, ##ARG);					\
  })
#endif

#define _super(TYP, MSG, RCV, ARG...) ({				\
  register oop _r= (RCV);						\
  struct __closure *_c= (struct __closure *)_libid->bind((MSG), (TYP));	\
  (_c->method)((oop)_c, _r, _r, ##ARG);					\
})

#endif /* __libid_h */
