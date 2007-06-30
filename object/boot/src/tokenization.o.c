/* generated by Id 1.0 at 2007-04-24 00:11:22 Z */
/* with the command: -I../stage1/ -I. -c tokenization.st -o ../stage2/tokenization.o.c */

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
  typedef HINSTANCE dlhandle_t;
# define dlopen(path, mode)	LoadLibrary(path)
# define dlsym(handle, name)	((void *)GetProcAddress(handle, name))
# define dlclose(handle)	FreeLibrary(handle)
# include <winbase.h>
  inline int gettimeofday(struct timeval *tp, void *tzp)
  {
     union {
       long long ns100;
       FILETIME ft;
     } _now;
     GetSystemTimeAsFileTime(&_now.ft);
     tp->tv_usec= (long)((_now.ns100 / 10LL) % 1000000LL);
     tp->tv_sec= (long)((_now.ns100 - (116444736000000000LL)) / 10000000LL);
     return 0;
   }
#else
# include <dlfcn.h>
  typedef void *dlhandle_t;
#endif
#ifndef O_BINARY
# define O_BINARY 0
#endif

typedef struct t__object *oop;

typedef oop (*_imp_t)(oop _thunk, oop receiver, ...);

struct __closure
{
  _imp_t method;
  oop	 data;
};

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

#define _param(INDEX)		_local_param(INDEX)
#define _selector(NAME)		_local_intern(NAME)
#define _proto(BASE)		_local_proto(BASE)
#define _id_import(NAME)	_local_import(NAME)
#define _id_export(NAME, VAL)	_local_export((NAME), (VAL))
#define _method(TYPE, SEL, IMP)	_local_method((TYPE), (SEL), (_imp_t)(IMP))
#define _alloc(RCV, LBS)	_local_alloc((RCV), (LBS))
#define _palloc(LBS)		_local_palloc((LBS))
#define _balloc(LBS)		_local_balloc((LBS))
#define _nlreturn(NLR, ARG)	_local_nlreturn((NLR), (ARG))
#define _nlresult()		_local_nlresult()

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

static oop s_next= 0;
static oop s_new_5f_= 0;
static oop s_new_= 0;
static oop s_value_5f_= 0;
static oop s_species= 0;
static oop s__5fimport_= 0;
static oop s_atEnd= 0;
static oop s_ifFalse_= 0;
static oop s_do_= 0;
static oop s_emptyCheck= 0;
static oop s_flattened= 0;
static oop s__2b= 0;
static oop s_size= 0;
static oop s_first= 0;
static oop s_nextPut_= 0;
static oop s_add_= 0;
static oop s_isEmpty= 0;
static oop s_firstToken_= 0;
static oop s_writeStream= 0;
static oop s_readStream= 0;
static oop s_new= 0;
static oop s_and_= 0;
static oop s_peek= 0;
static oop s_whileFalse_= 0;
static oop s_resetToStart= 0;
static oop s_delimited_= 0;
static oop s_ifTrue_ifFalse_= 0;
static oop s_function_5f_arity_5f_outer_state_nlr_5f_= 0;
static oop s_nextPutAll_= 0;
static oop s_not= 0;
static oop s_whileTrue_= 0;
static oop s_includes_= 0;
static oop s_tokenized_= 0;
static oop s_contents= 0;
static struct _Selector { const char *name; oop *addr; } _Selectors[]= {
  { "next", &s_next },
  { "new_:", &s_new_5f_ },
  { "new:", &s_new_ },
  { "value_:", &s_value_5f_ },
  { "species", &s_species },
  { "_import:", &s__5fimport_ },
  { "atEnd", &s_atEnd },
  { "ifFalse:", &s_ifFalse_ },
  { "do:", &s_do_ },
  { "emptyCheck", &s_emptyCheck },
  { "flattened", &s_flattened },
  { "+", &s__2b },
  { "size", &s_size },
  { "first", &s_first },
  { "nextPut:", &s_nextPut_ },
  { "add:", &s_add_ },
  { "isEmpty", &s_isEmpty },
  { "firstToken:", &s_firstToken_ },
  { "writeStream", &s_writeStream },
  { "readStream", &s_readStream },
  { "new", &s_new },
  { "and:", &s_and_ },
  { "peek", &s_peek },
  { "whileFalse:", &s_whileFalse_ },
  { "resetToStart", &s_resetToStart },
  { "delimited:", &s_delimited_ },
  { "ifTrue:ifFalse:", &s_ifTrue_ifFalse_ },
  { "function_:arity_:outer:state:nlr_:", &s_function_5f_arity_5f_outer_state_nlr_5f_ },
  { "nextPutAll:", &s_nextPutAll_ },
  { "not", &s_not },
  { "whileTrue:", &s_whileTrue_ },
  { "includes:", &s_includes_ },
  { "tokenized:", &s_tokenized_ },
  { "contents", &s_contents },
  { 0, 0 }
};
struct t__object {
  struct _vtable *_vtable[0];
};
struct t__selector {
  struct _vtable *_vtable[0];
  oop v__size;
  oop v__elements;
};
struct t__assoc {
  struct _vtable *_vtable[0];
  oop v_key;
  oop v_value;
};
struct t__closure {
  struct _vtable *_vtable[0];
  oop v__method;
  oop v_data;
};
struct t__vector {
  struct _vtable *_vtable[0];
  oop v__size;
};
struct t__vtable {
  struct _vtable *_vtable[0];
  oop v__tally;
  oop v_bindings;
  oop v_delegate;
};
struct t_Object {
  struct _vtable *_vtable[0];
};
struct t_UndefinedObject {
  struct _vtable *_vtable[0];
};
struct t_StaticBlockClosure {
  struct _vtable *_vtable[0];
  oop v__function;
  oop v__arity;
};
struct t_BlockClosure {
  struct _vtable *_vtable[0];
  oop v__function;
  oop v__arity;
  oop v_outer;
  oop v_state;
  oop v__nlr;
};
struct t_Magnitude {
  struct _vtable *_vtable[0];
};
struct t_Character {
  struct _vtable *_vtable[0];
  oop v_value;
};
struct t_Number {
  struct _vtable *_vtable[0];
};
struct t_Fraction {
  struct _vtable *_vtable[0];
  oop v_numerator;
  oop v_denominator;
};
struct t_Float {
  struct _vtable *_vtable[0];
};
struct t_Integer {
  struct _vtable *_vtable[0];
};
struct t_SmallInteger {
  struct _vtable *_vtable[0];
};
struct t_LargePositiveInteger {
  struct _vtable *_vtable[0];
  oop v_bytes;
};
struct t_LargeNegativeInteger {
  struct _vtable *_vtable[0];
  oop v_bytes;
};
struct t_Collection {
  struct _vtable *_vtable[0];
};
struct t_SequenceableCollection {
  struct _vtable *_vtable[0];
};
struct t_ArrayedCollection {
  struct _vtable *_vtable[0];
  oop v_size;
};
struct t_Array {
  struct _vtable *_vtable[0];
  oop v_size;
  oop v__pointers;
};
struct t_ImmutableArray {
  struct _vtable *_vtable[0];
  oop v_size;
  oop v__pointers;
};
struct t_WordArray {
  struct _vtable *_vtable[0];
  oop v_size;
  oop v__words;
};
struct t_ImmutableWordArray {
  struct _vtable *_vtable[0];
  oop v_size;
  oop v__words;
};
struct t_ByteArray {
  struct _vtable *_vtable[0];
  oop v_size;
  oop v__bytes;
};
struct t_ImmutableByteArray {
  struct _vtable *_vtable[0];
  oop v_size;
  oop v__bytes;
};
struct t_String {
  struct _vtable *_vtable[0];
  oop v_size;
  oop v__bytes;
};
struct t_ImmutableString {
  struct _vtable *_vtable[0];
  oop v_size;
  oop v__bytes;
};
struct t_Symbol {
  struct _vtable *_vtable[0];
  oop v_size;
  oop v__bytes;
};
struct t_nil {
  struct _vtable *_vtable[0];
};
struct t_true {
  struct _vtable *_vtable[0];
};
struct t_false {
  struct _vtable *_vtable[0];
};
struct t_CharacterTable {
  struct _vtable *_vtable[0];
  oop v_size;
  oop v__pointers;
};
struct t_OrderedCollection {
  struct _vtable *_vtable[0];
  oop v_array;
  oop v_firstIndex;
  oop v_lastIndex;
};
struct t_Stream {
  struct _vtable *_vtable[0];
};
struct t_PositionableStream {
  struct _vtable *_vtable[0];
  oop v_collection;
  oop v_position;
  oop v_readLimit;
};
struct t_WriteStream {
  struct _vtable *_vtable[0];
  oop v_collection;
  oop v_position;
  oop v_readLimit;
  oop v_writeLimit;
};
static oop l_2= 0;
static oop v__object= 0;
static oop v__vector= 0;
static oop v_Object= 0;
static oop v_UndefinedObject= 0;
static oop v_StaticBlockClosure= 0;
static oop v_BlockClosure= 0;
static oop v_Magnitude= 0;
static oop v_Number= 0;
static oop v_Integer= 0;
static oop v_SmallInteger= 0;
static oop v_LargePositiveInteger= 0;
static oop v_Collection= 0;
static oop v_SequenceableCollection= 0;
static oop v_ArrayedCollection= 0;
static oop v_Array= 0;
static oop v_WordArray= 0;
static oop v_ByteArray= 0;
static oop v_String= 0;
static oop v_ImmutableString= 0;
static oop v_true= 0;
static oop v_false= 0;
static oop v_OrderedCollection= 0;
static oop v_Stream= 0;
static oop v_PositionableStream= 0;
static oop SequenceableCollection__firstToken_(oop v__closure, oop v_stateful_self, oop v_self, oop v_delimiters)
 {
  oop v_in= 0;
  oop v_out= 0;
  oop _1= 0;
  oop _2= 0;
  (void)v_in;
  (void)v_out;
  _1= v_self;
  _1=_send(s_readStream, _1);
  v_in= _1;
  _1= v_self;
  _1=_send(s_species, _1);
  _1=_send(s_new, _1);
  _1=_send(s_writeStream, _1);
  v_out= _1;
  /* whileTrue: */
  goto _l2;
 _l1:;
 {
  _1= v_in;
  _1=_send(s_next, _1);
 }
 _l2:;
 {
  /* and: */
  _1= v_in;
  _1=_send(s_atEnd, _1);
  _1=_send(s_not, _1);
  if (!_1) goto _l3;
 {
  _1= v_delimiters;
  _2= v_in;
  _2=_send(s_peek, _2);
  _1=_send(s_includes_, _1, _2);
 }
 _l3:;
 }
  if (_1) goto _l1;
  _1= 0;
  /* whileTrue: */
  goto _l5;
 _l4:;
 {
  _1= v_out;
  _2= v_in;
  _2=_send(s_next, _2);
  _1=_send(s_nextPut_, _1, _2);
 }
 _l5:;
 {
  /* and: */
  _1= v_in;
  _1=_send(s_atEnd, _1);
  _1=_send(s_not, _1);
  if (!_1) goto _l6;
 {
  _1= v_delimiters;
  _2= v_in;
  _2=_send(s_peek, _2);
  _1=_send(s_includes_, _1, _2);
  _1=_send(s_not, _1);
 }
 _l6:;
 }
  if (_1) goto _l4;
  _1= 0;
  _1= v_out;
  _1=_send(s_contents, _1);
  return _1;
 }
static oop SequenceableCollection__tokenized_(oop v__closure, oop v_stateful_self, oop v_self, oop v_delimiters)
 {
  oop v_in= 0;
  oop v_out= 0;
  oop v_tokens= 0;
  oop _1= 0;
  oop _2= 0;
  (void)v_in;
  (void)v_out;
  (void)v_tokens;
  _1= v_self;
  _1=_send(s_readStream, _1);
  v_in= _1;
  _1= v_self;
  _1=_send(s_species, _1);
  _1=_send(s_new, _1);
  _1=_send(s_writeStream, _1);
  v_out= _1;
  _1= v_OrderedCollection;
  _1=_send(s_new, _1);
  v_tokens= _1;
  /* whileFalse: */
  goto _l8;
 _l7:;
 {
  /* whileTrue: */
  goto _l10;
 _l9:;
 {
  _1= v_in;
  _1=_send(s_next, _1);
 }
 _l10:;
 {
  /* and: */
  _1= v_in;
  _1=_send(s_atEnd, _1);
  _1=_send(s_not, _1);
  if (!_1) goto _l11;
 {
  _1= v_delimiters;
  _2= v_in;
  _2=_send(s_peek, _2);
  _1=_send(s_includes_, _1, _2);
 }
 _l11:;
 }
  if (_1) goto _l9;
  _1= 0;
  /* whileTrue: */
  goto _l13;
 _l12:;
 {
  _1= v_out;
  _2= v_in;
  _2=_send(s_next, _2);
  _1=_send(s_nextPut_, _1, _2);
 }
 _l13:;
 {
  /* and: */
  _1= v_in;
  _1=_send(s_atEnd, _1);
  _1=_send(s_not, _1);
  if (!_1) goto _l14;
 {
  _1= v_delimiters;
  _2= v_in;
  _2=_send(s_peek, _2);
  _1=_send(s_includes_, _1, _2);
  _1=_send(s_not, _1);
 }
 _l14:;
 }
  if (_1) goto _l12;
  _1= 0;
  /* ifFalse: */
  _1= 0;
  _2= v_out;
  _2=_send(s_isEmpty, _2);
  if (_2) goto _l15;
 {
  _1= v_tokens;
  _2= v_out;
  _2=_send(s_contents, _2);
  _1=_send(s_add_, _1, _2);
 }
 _l15:;
  _1= v_out;
  _1=_send(s_resetToStart, _1);
 }
 _l8:;
 {
  _1= v_in;
  _1=_send(s_atEnd, _1);
 }
  if (!_1) goto _l7;
  _1= 0;
  _1= v_tokens;
  return _1;
 }
static oop b_1(oop v__closure, oop v__self, oop v_element)
 {
  oop _1= 0;
  oop _2= 0;
  /* ifTrue:ifFalse: */
  _1= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[1];  /* first */
  if (!_1) goto _l16;
 {
  _1= v_false;
  ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[1]= _1;  /* first */
 }
  goto _l17;
 _l16:;
 {
  _1= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[2];  /* out */
  _2= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[3];  /* delimiter */
  _1=_send(s_nextPut_, _1, _2);
 }
 _l17:;
  _1= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[2];  /* out */
  _2= v_element;
  _1=_send(s_nextPut_, _1, _2);
  return _1;
 }
static oop SequenceableCollection__delimited_(oop v__closure, oop v_stateful_self, oop v_self, oop v_delimiter)
 {
  oop _state1= _send(s_new_5f_, v__vector, 4);
  oop _1= 0;
  oop _2= 0;
  ((oop *)_state1)[3]= v_delimiter;
  _1= v_self;
  _1=_send(s_species, _1);
  _1=_send(s_new, _1);
  _1=_send(s_writeStream, _1);
  ((oop *)_state1)[2]= _1;  /* out */
  _1= v_true;
  ((oop *)_state1)[1]= _1;  /* first */
  _1= v_self;
  /* Scope('element'->ArgumentVariableNode) */
  /* Scope('delimiter'->ArgumentVariableNode 'first'->TemporaryVariableNode 'self'->ArgumentVariableNode 'out'->TemporaryVariableNode 'stateful_self'->ArgumentVariableNode) */
  /* nil */
  /* 2 */
  /* 1 */
  _2= _send(s_function_5f_arity_5f_outer_state_nlr_5f_, v_BlockClosure, (oop)b_1, 1, 0, ((oop *)_state1), 0);
  _1=_send(s_do_, _1, _2);
  _1= ((oop *)_state1)[2];  /* out */
  _1=_send(s_contents, _1);
  return _1;
 }
static oop b_3(oop v__closure, oop v__self, oop v_element)
 {
  oop _1= 0;
  oop _2= 0;
  _1= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[1];  /* len */
  _2= v_element;
  _2=_send(s_size, _2);
  {
    int _l= (int)_1 >> 1;
    int _r= (int)_2 >> 1;
    int _s= _l + _r;
    if ((1 & (int)_1 & (int)_2) && ((_s ^ (_s << 1)) >= 0))  _1= (oop)(_s << 1 | 1);  else _1= _send(s__2b, _1, _2);
  }
  ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[1]= _1;  /* len */
  return _1;
 }
static oop b_4(oop v__closure, oop v__self, oop v_element)
 {
  oop _1= 0;
  oop _2= 0;
  _1= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[2];  /* out */
  _2= v_element;
  _1=_send(s_nextPutAll_, _1, _2);
  return _1;
 }
static oop SequenceableCollection__flattened(oop v__closure, oop v_stateful_self, oop v_self)
 {
  oop _state1= _send(s_new_5f_, v__vector, 3);
  oop _1= 0;
  oop _2= 0;
  _1= v_self;
  _1=_send(s_emptyCheck, _1);
  _1= l_2;
  ((oop *)_state1)[1]= _1;  /* len */
  _1= v_self;
  /* Scope('element'->ArgumentVariableNode) */
  /* Scope('out'->TemporaryVariableNode 'self'->ArgumentVariableNode 'len'->TemporaryVariableNode 'stateful_self'->ArgumentVariableNode) */
  /* nil */
  /* 2 */
  /* 1 */
  _2= _send(s_function_5f_arity_5f_outer_state_nlr_5f_, v_BlockClosure, (oop)b_3, 1, 0, ((oop *)_state1), 0);
  _1=_send(s_do_, _1, _2);
  _1= v_self;
  _1=_send(s_first, _1);
  _1=_send(s_species, _1);
  _2= ((oop *)_state1)[1];  /* len */
  _1=_send(s_new_, _1, _2);
  _1=_send(s_writeStream, _1);
  ((oop *)_state1)[2]= _1;  /* out */
  _1= v_self;
  /* Scope('element'->ArgumentVariableNode) */
  /* Scope('out'->TemporaryVariableNode 'self'->ArgumentVariableNode 'len'->TemporaryVariableNode 'stateful_self'->ArgumentVariableNode) */
  /* nil */
  /* 2 */
  /* 1 */
  _2= _send(s_function_5f_arity_5f_outer_state_nlr_5f_, v_BlockClosure, (oop)b_4, 1, 0, ((oop *)_state1), 0);
  _1=_send(s_do_, _1, _2);
  _1= ((oop *)_state1)[2];  /* out */
  _1=_send(s_contents, _1);
  return _1;
 }

void __id__init__tokenization(void)
{
  if (_local_object) return;
  { 
    dlhandle_t global= dlopen(0, RTLD_LAZY);
    _local_object= *(oop *)dlsym(global, "_libid_object");
    _local_param= dlsym(global, "_libid_param");
    _local_intern= dlsym(global, "_libid_intern");
    _local_proto= dlsym(global, "_libid_proto");
    _local_import= dlsym(global, "_libid_import");
    _local_export= dlsym(global, "_libid_export");
    _local_method= dlsym(global, "_libid_method");
    _local_alloc= dlsym(global, "_libid_alloc");
    _local_palloc= dlsym(global, "_libid_palloc");
    _local_balloc= dlsym(global, "_libid_balloc");
    _local_bind= dlsym(global, "_libid_bind");
    _local_nlreturn= dlsym(global, "_libid_nlreturn");
    _local_nlresult= dlsym(global, "_libid_nlresult");
    _local_tag_vtable= dlsym(global, "_libid_tag_vtable");
    _local_nil_vtable= dlsym(global, "_libid_nil_vtable");
    _local_gc_addRoots= dlsym(global, "GC_add_roots");
    _local_gc_unregisterDisappearingLink= dlsym(global, "GC_unregister_disappearing_link");
    _local_gc_generalRegisterDisappearingLink= dlsym(global, "GC_general_register_disappearing_link");
    _local_gc_gcollect= dlsym(global, "GC_gcollect");
    dlclose(global);
  }
# define GC_add_roots _local_gc_addRoots
  GC_INIT();
  {
    struct _Selector *s= 0;
    for (s= _Selectors;  s->name;  ++s)
      *s->addr= _selector(s->name);
  }

  _send(s__5fimport_, _local_object, "Array", "__id__init__Array");
  _send(s__5fimport_, _local_object, "ArrayedCollection", "__id__init__ArrayedCollection");
  _send(s__5fimport_, _local_object, "SequenceableCollection", "__id__init__SequenceableCollection");
  _send(s__5fimport_, _local_object, "Collection", "__id__init__Collection");
  _send(s__5fimport_, _local_object, "Object", "__id__init__Object");
  _send(s__5fimport_, _local_object, "_object", "__id__init___5fobject");
  v__object= _id_import("_object");
  v__vector= _id_import("_vector");
  v_Object= _id_import("Object");
  v_UndefinedObject= _id_import("UndefinedObject");
  v_StaticBlockClosure= _id_import("StaticBlockClosure");
  v_BlockClosure= _id_import("BlockClosure");
  v_Magnitude= _id_import("Magnitude");
  v_Number= _id_import("Number");
  v_Integer= _id_import("Integer");
  v_SmallInteger= _id_import("SmallInteger");
  v_LargePositiveInteger= _id_import("LargePositiveInteger");
  v_Collection= _id_import("Collection");
  v_SequenceableCollection= _id_import("SequenceableCollection");
  v_ArrayedCollection= _id_import("ArrayedCollection");
  v_Array= _id_import("Array");
  v_WordArray= _id_import("WordArray");
  v_ByteArray= _id_import("ByteArray");
  v_String= _id_import("String");
  v_ImmutableString= _id_import("ImmutableString");
  v_true= _id_import("true");
  v_false= _id_import("false");
  _send(s__5fimport_, _local_object, "BlockClosure", "__id__init__BlockClosure");
  _send(s__5fimport_, _local_object, "SmallInteger", "__id__init__SmallInteger");
  _send(s__5fimport_, _local_object, "Integer", "__id__init__Integer");
  _send(s__5fimport_, _local_object, "Number", "__id__init__Number");
  _send(s__5fimport_, _local_object, "Magnitude", "__id__init__Magnitude");
  _send(s__5fimport_, _local_object, "Character", "__id__init__Character");
  _send(s__5fimport_, _local_object, "String", "__id__init__String");
  _send(s__5fimport_, _local_object, "ByteArray", "__id__init__ByteArray");
  _send(s__5fimport_, _local_object, "WordArray", "__id__init__WordArray");
  _send(s__5fimport_, _local_object, "OrderedCollection", "__id__init__OrderedCollection");
  v_OrderedCollection= _id_import("OrderedCollection");
  _send(s__5fimport_, _local_object, "WriteStream", "__id__init__WriteStream");
  _send(s__5fimport_, _local_object, "PositionableStream", "__id__init__PositionableStream");
  _send(s__5fimport_, _local_object, "Stream", "__id__init__Stream");
  v_Stream= _id_import("Stream");
  v_PositionableStream= _id_import("PositionableStream");
  _method(v_SequenceableCollection, s_firstToken_, SequenceableCollection__firstToken_);
  _method(v_SequenceableCollection, s_tokenized_, SequenceableCollection__tokenized_);
  _method(v_SequenceableCollection, s_delimited_, SequenceableCollection__delimited_);
  l_2= _send(s_value_5f_, v_SmallInteger, 0);
  _method(v_SequenceableCollection, s_flattened, SequenceableCollection__flattened);
}
