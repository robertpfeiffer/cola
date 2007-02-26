/* generated by Id 1.0 at 2007-02-22 05:39:45 Z */
/* with the command: -I../stage1/ -I. -c Symbol.st -o ../stage2/Symbol.o.c */

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

static oop s_new_5f_= 0;
static oop s__5fclone= 0;
static oop s_nextPut_= 0;
static oop s_initialize_= 0;
static oop s_at_ifAbsent_= 0;
static oop s__5fdebugName= 0;
static oop s_size_5f_value_5f_= 0;
static oop s_new= 0;
static oop s__5fimport_= 0;
static oop s_basicNewFromString_= 0;
static oop s_function_5f_arity_5f_outer_state_nlr_5f_= 0;
static oop s_value_5f_= 0;
static oop s_byteAt_put_= 0;
static oop s_byteAt_= 0;
static oop s_nextPutAll_= 0;
static oop s_printOn_= 0;
static oop s_to_do_= 0;
static oop s__2c= 0;
static oop s_size= 0;
static oop s_asSymbol= 0;
static oop s__5fsizeof= 0;
static oop s_intern_= 0;
static oop s_at_put_= 0;
static struct _Selector { const char *name; oop *addr; } _Selectors[]= {
  { "new_:", &s_new_5f_ },
  { "_clone", &s__5fclone },
  { "nextPut:", &s_nextPut_ },
  { "initialize:", &s_initialize_ },
  { "at:ifAbsent:", &s_at_ifAbsent_ },
  { "_debugName", &s__5fdebugName },
  { "size_:value_:", &s_size_5f_value_5f_ },
  { "new", &s_new },
  { "_import:", &s__5fimport_ },
  { "basicNewFromString:", &s_basicNewFromString_ },
  { "function_:arity_:outer:state:nlr_:", &s_function_5f_arity_5f_outer_state_nlr_5f_ },
  { "value_:", &s_value_5f_ },
  { "byteAt:put:", &s_byteAt_put_ },
  { "byteAt:", &s_byteAt_ },
  { "nextPutAll:", &s_nextPutAll_ },
  { "printOn:", &s_printOn_ },
  { "to:do:", &s_to_do_ },
  { ",", &s__2c },
  { "size", &s_size },
  { "asSymbol", &s_asSymbol },
  { "_sizeof", &s__5fsizeof },
  { "intern:", &s_intern_ },
  { "at:put:", &s_at_put_ },
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
struct t_Set {
  struct _vtable *_vtable[0];
  oop v_tally;
  oop v_array;
};
struct t_LookupKey {
  struct _vtable *_vtable[0];
  oop v_key;
};
struct t_Association {
  struct _vtable *_vtable[0];
  oop v_key;
  oop v_value;
};
struct t_OrderedCollection {
  struct _vtable *_vtable[0];
  oop v_array;
  oop v_firstIndex;
  oop v_lastIndex;
};
struct t_Dictionary {
  struct _vtable *_vtable[0];
  oop v_tally;
  oop v_array;
};
struct t_SymbolTable {
  struct _vtable *_vtable[0];
  oop v_tally;
  oop v_array;
};
static oop l_2= 0;
static oop l_4= 0;
static oop l_5= 0;
static oop v__object= 0;
static oop v__vector= 0;
static oop v_Object= 0;
static oop v_UndefinedObject= 0;
static oop v_StaticBlockClosure= 0;
static oop v_BlockClosure= 0;
static oop v_Magnitude= 0;
static oop v_Character= 0;
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
static oop v_Symbol= 0;
static oop v_Set= 0;
static oop v_LookupKey= 0;
static oop v_Dictionary= 0;
static oop v_SymbolTable= 0;
static oop Symbol__size_5f_value_5f_(oop v__closure, oop v_stateful_self, oop v_self, oop v__size, oop v__value)
 {
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  oop _4= 0;
  _1= v_self;
  _2= v_String;
  _3= v__size;
  _4= v__value;
  _2=_send(s_size_5f_value_5f_, _2, _3, _4);
  _1=_send(s_intern_, _1, _2);
  return _1;
 }
static size_t SymbolTable___5fsizeof(oop _closure, oop v_self) { return sizeof(struct t_SymbolTable); }
static char *SymbolTable___5fdebugName(oop _closure, oop v_self) { return "SymbolTable"; }
static oop b_1(oop v__closure, oop v__self)
 {
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  oop _4= 0;
  _1= v_SymbolTable;
  _2= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[1];  /* aString */
  _3= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[2];  /* self */
  _4= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[1];  /* aString */
  _3=_send(s_basicNewFromString_, _3, _4);
  _1=_send(s_at_put_, _1, _2, _3);
  return _1;
 }
static oop Symbol__intern_(oop v__closure, oop v_stateful_self, oop v_self, oop v_aString)
 {
  oop _state1= _send(s_new_5f_, v__vector, 6);
  oop v_symbol= 0;
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  (void)v_symbol;
  ((oop *)_state1)[3]= v_stateful_self;
  ((oop *)_state1)[2]= v_self;
  ((oop *)_state1)[1]= v_aString;
  _1= v_SymbolTable;
  _2= ((oop *)_state1)[1];  /* aString */
  /* Scope() */
  /* Scope('size'->SlotVariableNode 'symbol'->TemporaryVariableNode 'aString'->ArgumentVariableNode 'self'->ArgumentVariableNode '_bytes'->SlotVariableNode 'stateful_self'->ArgumentVariableNode) */
  /* nil */
  /* 2 */
  /* 1 */
  _3= _send(s_function_5f_arity_5f_outer_state_nlr_5f_, v_BlockClosure, (oop)b_1, 0, 0, ((oop *)_state1), 0);
  _1=_send(s_at_ifAbsent_, _1, _2, _3);
  v_symbol= _1;
  _1= v_symbol;
  return _1;
 }
static oop b_3(oop v__closure, oop v__self, oop v_index)
 {
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  oop _4= 0;
  _1= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[1];  /* self */
  _2= v_index;
  _3= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[3];  /* aString */
  _4= v_index;
  _3=_send(s_byteAt_, _3, _4);
  _1=_send(s_byteAt_put_, _1, _2, _3);
  return _1;
 }
static oop Symbol__basicNewFromString_(oop v__closure, oop v_stateful_self, oop v_self, oop v_aString)
 {
  oop _state1= _send(s_new_5f_, v__vector, 6);
  oop v_length= 0;
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  (void)v_length;
  ((oop *)_state1)[2]= v_stateful_self;
  ((oop *)_state1)[1]= v_self;
  ((oop *)_state1)[3]= v_aString;
  _1= ((oop *)_state1)[3];  /* aString */
  _1=_send(s_size, _1);
  v_length= _1;
  _1= ((oop *)_state1)[1];  /* self */
  _1=_send(s__5fclone, _1);
  _2= v_length;
  _1=_send(s_initialize_, _1, _2);
  ((oop *)_state1)[1]= _1;  /* self */
  ((oop *)_state1)[2]= _1;  /* stateful_self */
  _1= l_2;
  _2= v_length;
  /* Scope('index'->ArgumentVariableNode) */
  /* Scope('size'->SlotVariableNode 'self'->ArgumentVariableNode 'aString'->ArgumentVariableNode 'length'->TemporaryVariableNode '_bytes'->SlotVariableNode 'stateful_self'->ArgumentVariableNode) */
  /* nil */
  /* 2 */
  /* 1 */
  _3= _send(s_function_5f_arity_5f_outer_state_nlr_5f_, v_BlockClosure, (oop)b_3, 1, 0, ((oop *)_state1), 0);
  _1=_send(s_to_do_, _1, _2, _3);
  _1= ((oop *)_state1)[1];  /* self */
  return _1;
 }
static oop Symbol___2c(oop v__closure, oop v_stateful_self, oop v_self, oop v_aSymbolOrString)
 {
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  _1= v_self;
  _2= v_self;
  _3= v_aSymbolOrString;
  _2=_super(v_ImmutableString, s__2c, _2, _3);
  _1=_send(s_intern_, _1, _2);
  return _1;
 }
static oop Symbol__printOn_(oop v__closure, oop v_stateful_self, oop v_self, oop v_aStream)
 {
  oop _1= 0;
  oop _2= 0;
  _1= v_aStream;
  _2= l_4;
  _send(s_nextPutAll_, _1, _2);
  _2= v_self;
  _send(s_nextPutAll_, _1, _2);
  _2= l_5;
  _1=_send(s_nextPut_, _1, _2);
  _1= v_self;
  return _1;
 }
static oop String__asSymbol(oop v__closure, oop v_stateful_self, oop v_self)
 {
  oop _1= 0;
  oop _2= 0;
  _1= v_Symbol;
  _2= v_self;
  _1=_send(s_intern_, _1, _2);
  return _1;
 }

void __id__init__Symbol(void)
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

  _send(s__5fimport_, _local_object, "String", "__id__init__String");
  _send(s__5fimport_, _local_object, "ByteArray", "__id__init__ByteArray");
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
  v_Character= _id_import("Character");
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
  v_Symbol= _id_import("Symbol");
  _send(s__5fimport_, _local_object, "BlockClosure", "__id__init__BlockClosure");
  _send(s__5fimport_, _local_object, "SmallInteger", "__id__init__SmallInteger");
  _send(s__5fimport_, _local_object, "Integer", "__id__init__Integer");
  _send(s__5fimport_, _local_object, "Number", "__id__init__Number");
  _send(s__5fimport_, _local_object, "Magnitude", "__id__init__Magnitude");
  _send(s__5fimport_, _local_object, "Array", "__id__init__Array");
  _send(s__5fimport_, _local_object, "Character", "__id__init__Character");
  _send(s__5fimport_, _local_object, "WordArray", "__id__init__WordArray");
  _send(s__5fimport_, _local_object, "Dictionary", "__id__init__Dictionary");
  _send(s__5fimport_, _local_object, "Set", "__id__init__Set");
  v_Set= _id_import("Set");
  _send(s__5fimport_, _local_object, "Association", "__id__init__Association");
  _send(s__5fimport_, _local_object, "LookupKey", "__id__init__LookupKey");
  v_LookupKey= _id_import("LookupKey");
  _send(s__5fimport_, _local_object, "OrderedCollection", "__id__init__OrderedCollection");
  v_Dictionary= _id_import("Dictionary");
  _method(v_Symbol, s_size_5f_value_5f_, Symbol__size_5f_value_5f_);
  v_SymbolTable= _proto(v_Dictionary);
  _method(v_SymbolTable, s__5fsizeof, SymbolTable___5fsizeof);
  _method(v_SymbolTable, s__5fdebugName, SymbolTable___5fdebugName);
  _id_export("SymbolTable", v_SymbolTable);
 {
  oop _1= 0;
  _1= v_SymbolTable;
  _1=_send(s_new, _1);
  v_SymbolTable= _1;
  _id_export("SymbolTable", v_SymbolTable);
 }
  _method(v_Symbol, s_intern_, Symbol__intern_);
  l_2= _send(s_value_5f_, v_SmallInteger, 1);
  _method(v_Symbol, s_basicNewFromString_, Symbol__basicNewFromString_);
  _method(v_Symbol, s__2c, Symbol___2c);
  l_4= _send(s_size_5f_value_5f_, v_ImmutableString, 2, "#'");
  l_5= _send(s_value_5f_, v_Character, 39);
  _method(v_Symbol, s_printOn_, Symbol__printOn_);
  _method(v_String, s_asSymbol, String__asSymbol);
}