/* generated by Id 1.0 at 2007-04-24 00:11:26 Z */
/* with the command: -I../stage1/ -I. -I../st80 -c CodeGenerator.st -o ../stage2/CodeGenerator.o.c */

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
static oop s_encoder= 0;
static oop s_withCompiler_encoder_= 0;
static oop s_at_ifAbsent_= 0;
static oop s_value_5f_= 0;
static oop s_forExecutionModel_= 0;
static oop s__5fdebugName= 0;
static oop s_new= 0;
static oop s__5fimport_= 0;
static oop s_size_5f_value_5f_= 0;
static oop s_function_5f_arity_5f_outer_state_nlr_5f_= 0;
static oop s__2c= 0;
static oop s_error_= 0;
static oop s__5fsizeof= 0;
static struct _Selector { const char *name; oop *addr; } _Selectors[]= {
  { "new_:", &s_new_5f_ },
  { "encoder", &s_encoder },
  { "withCompiler:encoder:", &s_withCompiler_encoder_ },
  { "at:ifAbsent:", &s_at_ifAbsent_ },
  { "value_:", &s_value_5f_ },
  { "forExecutionModel:", &s_forExecutionModel_ },
  { "_debugName", &s__5fdebugName },
  { "new", &s_new },
  { "_import:", &s__5fimport_ },
  { "size_:value_:", &s_size_5f_value_5f_ },
  { "function_:arity_:outer:state:nlr_:", &s_function_5f_arity_5f_outer_state_nlr_5f_ },
  { ",", &s__2c },
  { "error:", &s_error_ },
  { "_sizeof", &s__5fsizeof },
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
struct t_IdentitySet {
  struct _vtable *_vtable[0];
  oop v_tally;
  oop v_array;
};
struct t_IdentityDictionary {
  struct _vtable *_vtable[0];
  oop v_tally;
  oop v_array;
};
struct t_SlotVariableNode {
  struct _vtable *_vtable[0];
  oop v_name;
  oop v_position;
  oop v_scope;
  oop v_receiver;
  oop v_type;
};
struct t_EncodedVariableNode {
  struct _vtable *_vtable[0];
  oop v_name;
  oop v_position;
  oop v_scope;
  oop v_offset;
};
struct t_LocalVariableNode {
  struct _vtable *_vtable[0];
  oop v_name;
  oop v_position;
  oop v_scope;
  oop v_offset;
  oop v_index;
};
struct t_ArgumentVariableNode {
  struct _vtable *_vtable[0];
  oop v_name;
  oop v_position;
  oop v_scope;
  oop v_offset;
  oop v_index;
  oop v_tied;
};
struct t_TemporaryVariableNode {
  struct _vtable *_vtable[0];
  oop v_name;
  oop v_position;
  oop v_scope;
  oop v_offset;
  oop v_index;
};
struct t_Scope {
  struct _vtable *_vtable[0];
  oop v_tally;
  oop v_array;
  oop v_argumentCount;
  oop v_temporaryCount;
  oop v_stackSize;
  oop v_outer;
  oop v_blocks;
  oop v_tag;
  oop v_level;
  oop v_lastOffset;
  oop v_encodings;
  oop v_exportFlag;
  oop v_importFlag;
  oop v_nlrFlag;
};
struct t_ParseNode {
  struct _vtable *_vtable[0];
  oop v_position;
  oop v_location;
};
struct t_VariableNode {
  struct _vtable *_vtable[0];
  oop v_position;
  oop v_location;
  oop v_name;
  oop v_variable;
  oop v_level;
};
struct t_LiteralNode {
  struct _vtable *_vtable[0];
  oop v_position;
  oop v_location;
  oop v_value;
  oop v_tag;
  oop v_constructor;
};
struct t_IntegerNode {
  struct _vtable *_vtable[0];
  oop v_position;
  oop v_location;
  oop v_value;
  oop v_tag;
  oop v_constructor;
};
struct t_SendNode {
  struct _vtable *_vtable[0];
  oop v_position;
  oop v_location;
  oop v_receiver;
  oop v_selector;
  oop v_arguments;
  oop v_cascades;
  oop v_superedType;
  oop v_specialGenerator;
};
struct t_GlobalVariableNode {
  struct _vtable *_vtable[0];
  oop v_name;
  oop v_position;
  oop v_scope;
  oop v_offset;
};
struct t_Encoder {
  struct _vtable *_vtable[0];
  oop v_globalContext;
  oop v_globals;
  oop v_scope;
  oop v_tempCount;
  oop v_tempMax;
  oop v_outerCount;
  oop v_selectors;
  oop v_literals;
  oop v_literalMap;
  oop v_literalTag;
  oop v_methodType;
  oop v_specialEncoders;
  oop v_implementations;
};
struct t_NameManglingTable {
  struct _vtable *_vtable[0];
  oop v_size;
  oop v__pointers;
};
struct t_Smalltalk {
  struct _vtable *_vtable[0];
  oop v_argumentCount;
  oop v_argumentVector;
};
struct t_CodeGenerator {
  struct _vtable *_vtable[0];
  oop v_compiler;
  oop v_encoder;
  oop v_nextLabel;
};
static oop l_2= 0;
static oop l_3= 0;
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
static oop v_Set= 0;
static oop v_LookupKey= 0;
static oop v_Dictionary= 0;
static oop v_IdentityDictionary= 0;
static oop v_EncodedVariableNode= 0;
static oop v_LocalVariableNode= 0;
static oop v_ParseNode= 0;
static oop v_LiteralNode= 0;
static oop v_CodeGenerator= 0;
static oop v_CodeGenerators= 0;
static size_t CodeGenerator___5fsizeof(oop _closure, oop v_self) { return sizeof(struct t_CodeGenerator); }
static char *CodeGenerator___5fdebugName(oop _closure, oop v_self) { return "CodeGenerator"; }
static oop b_1(oop v__closure, oop v__self)
 {
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  _1= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[1];  /* self */
  _2= l_2;
  _3= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[3];  /* modelSymbol */
  _2=_send(s__2c, _2, _3);
  _1=_send(s_error_, _1, _2);
  return _1;
 }
static oop CodeGenerator__forExecutionModel_(oop v__closure, oop v_stateful_self, oop v_self, oop v_modelSymbol)
 {
  oop _state1= _send(s_new_5f_, v__vector, 7);
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  ((oop *)_state1)[2]= v_stateful_self;
  ((oop *)_state1)[1]= v_self;
  ((oop *)_state1)[3]= v_modelSymbol;
  _1= v_CodeGenerators;
  _2= ((oop *)_state1)[3];  /* modelSymbol */
  /* Scope() */
  /* Scope('compiler'->SlotVariableNode 'encoder'->SlotVariableNode 'self'->ArgumentVariableNode 'nextLabel'->SlotVariableNode 'modelSymbol'->ArgumentVariableNode 'stateful_self'->ArgumentVariableNode) */
  /* nil */
  /* 2 */
  /* 1 */
  _3= _send(s_function_5f_arity_5f_outer_state_nlr_5f_, v_BlockClosure, (oop)b_1, 0, 0, ((oop *)_state1), 0);
  _1=_send(s_at_ifAbsent_, _1, _2, _3);
  return _1;
 }
static oop CodeGenerator__withCompiler_encoder_(oop v__closure, oop v_stateful_self, oop v_self, oop v_aCompiler, oop v_anEncoder)
 {
  oop _1= 0;
  _1= v_self;
  _1=_send(s_new, _1);
  v_self= _1;
  v_stateful_self= _1;
  _1= v_aCompiler;
  ((struct t_CodeGenerator *)v_stateful_self)->v_compiler= _1;
  _1= v_anEncoder;
  ((struct t_CodeGenerator *)v_stateful_self)->v_encoder= _1;
  _1= l_3;
  ((struct t_CodeGenerator *)v_stateful_self)->v_nextLabel= _1;
  _1= v_self;
  return _1;
 }
static oop CodeGenerator__encoder(oop v__closure, oop v_stateful_self, oop v_self)
 {
  oop _1= 0;
  _1= ((struct t_CodeGenerator *)v_stateful_self)->v_encoder;
  return _1;
 }

void __id__init__CodeGenerator(void)
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
  _send(s__5fimport_, _local_object, "BlockClosure", "__id__init__BlockClosure");
  _send(s__5fimport_, _local_object, "SmallInteger", "__id__init__SmallInteger");
  _send(s__5fimport_, _local_object, "Integer", "__id__init__Integer");
  _send(s__5fimport_, _local_object, "Number", "__id__init__Number");
  _send(s__5fimport_, _local_object, "Magnitude", "__id__init__Magnitude");
  _send(s__5fimport_, _local_object, "Array", "__id__init__Array");
  _send(s__5fimport_, _local_object, "ArrayedCollection", "__id__init__ArrayedCollection");
  _send(s__5fimport_, _local_object, "SequenceableCollection", "__id__init__SequenceableCollection");
  _send(s__5fimport_, _local_object, "Collection", "__id__init__Collection");
  _send(s__5fimport_, _local_object, "Character", "__id__init__Character");
  _send(s__5fimport_, _local_object, "String", "__id__init__String");
  _send(s__5fimport_, _local_object, "ByteArray", "__id__init__ByteArray");
  _send(s__5fimport_, _local_object, "WordArray", "__id__init__WordArray");
  _send(s__5fimport_, _local_object, "Symbol", "__id__init__Symbol");
  _send(s__5fimport_, _local_object, "Dictionary", "__id__init__Dictionary");
  _send(s__5fimport_, _local_object, "Set", "__id__init__Set");
  v_Set= _id_import("Set");
  _send(s__5fimport_, _local_object, "Association", "__id__init__Association");
  _send(s__5fimport_, _local_object, "LookupKey", "__id__init__LookupKey");
  v_LookupKey= _id_import("LookupKey");
  _send(s__5fimport_, _local_object, "OrderedCollection", "__id__init__OrderedCollection");
  v_Dictionary= _id_import("Dictionary");
  _send(s__5fimport_, _local_object, "IdentityDictionary", "__id__init__IdentityDictionary");
  _send(s__5fimport_, _local_object, "IdentitySet", "__id__init__IdentitySet");
  v_IdentityDictionary= _id_import("IdentityDictionary");
  _send(s__5fimport_, _local_object, "Encoder", "__id__init__Encoder");
  _send(s__5fimport_, _local_object, "Scope", "__id__init__Scope");
  _send(s__5fimport_, _local_object, "SlotVariableNode", "__id__init__SlotVariableNode");
  _send(s__5fimport_, _local_object, "ArgumentVariableNode", "__id__init__ArgumentVariableNode");
  _send(s__5fimport_, _local_object, "LocalVariableNode", "__id__init__LocalVariableNode");
  _send(s__5fimport_, _local_object, "EncodedVariableNode", "__id__init__EncodedVariableNode");
  v_EncodedVariableNode= _id_import("EncodedVariableNode");
  v_LocalVariableNode= _id_import("LocalVariableNode");
  _send(s__5fimport_, _local_object, "TemporaryVariableNode", "__id__init__TemporaryVariableNode");
  _send(s__5fimport_, _local_object, "SendNode", "__id__init__SendNode");
  _send(s__5fimport_, _local_object, "ParseNode", "__id__init__ParseNode");
  v_ParseNode= _id_import("ParseNode");
  _send(s__5fimport_, _local_object, "VariableNode", "__id__init__VariableNode");
  _send(s__5fimport_, _local_object, "IntegerNode", "__id__init__IntegerNode");
  _send(s__5fimport_, _local_object, "LiteralNode", "__id__init__LiteralNode");
  v_LiteralNode= _id_import("LiteralNode");
  _send(s__5fimport_, _local_object, "GlobalVariableNode", "__id__init__GlobalVariableNode");
  _send(s__5fimport_, _local_object, "Smalltalk", "__id__init__Smalltalk");
  v_CodeGenerator= _proto(v_Object);
  _method(v_CodeGenerator, s__5fsizeof, CodeGenerator___5fsizeof);
  _method(v_CodeGenerator, s__5fdebugName, CodeGenerator___5fdebugName);
  _id_export("CodeGenerator", v_CodeGenerator);
 {
  oop _1= 0;
  _1= v_IdentityDictionary;
  _1=_send(s_new, _1);
  v_CodeGenerators= _1;
  _id_export("CodeGenerators", v_CodeGenerators);
 }
  l_2= _send(s_size_5f_value_5f_, v_ImmutableString, 38, "no code generator available for model ");
  _method(v_CodeGenerator, s_forExecutionModel_, CodeGenerator__forExecutionModel_);
  l_3= _send(s_value_5f_, v_SmallInteger, 0);
  _method(v_CodeGenerator, s_withCompiler_encoder_, CodeGenerator__withCompiler_encoder_);
  _method(v_CodeGenerator, s_encoder, CodeGenerator__encoder);
}
