/* generated by Id 1.1 at 2007-09-03 20:38:21 Z */
/* with the command: -I../stage1/ -I../st80 -c WordArrayNode.st -o ../stage2/WordArrayNode.o.c */

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
#else
# include <dlfcn.h>
  typedef void *dlhandle_t;
#endif
#ifndef O_BINARY
# define O_BINARY 0
#endif

typedef struct t__object *oop;

typedef oop (*_imp_t)(oop _thunk, oop receiver, ...);

#include <id/id.h>

static struct __libid *_libid= 0;

#ifdef ID_DEBUG
# define _enter(NM, TYPE, FILE)	void *__id_debug= _libid->enter(NM, TYPE, FILE)
# define _line(lno)		_libid->line(lno)
# define _leave()		_libid->leave(__id_debug)
# define _backtrace()		_libid->backtrace()
#else
# define _enter(NM, TYPE, FILE)
# define _line(lno)
# define _leave()
# define _backtrace()		"(no debugging information)"
#endif
#define _return			_leave(); return

#define _send(MSG, RCV, ARG...) ({					\
  register oop _r= (RCV);						\
  struct __closure *_c= (struct __closure *)_libid->bind((MSG), _r);	\
  (_c->method)((oop)_c, _r, _r, ##ARG);					\
})

#define _super(TYP, MSG, RCV, ARG...) ({				\
  register oop _r= (RCV);						\
  struct __closure *_c= (struct __closure *)_libid->bind((MSG), (TYP));	\
  (_c->method)((oop)_c, _r, _r, ##ARG);					\
})

static oop s_function_5f_arity_5f_= 0;
static oop s_genDefinition_= 0;
static oop s_size_5f_value_5f_= 0;
static oop s_asWordArray= 0;
static oop s_requireType_at_= 0;
static oop s__5fimport_= 0;
static oop s__5fdebugName= 0;
static oop s_encodeLiteral_= 0;
static oop s_collect_= 0;
static oop s_defineWordArray_withElements_= 0;
static oop s_genInitialisation_= 0;
static oop s_initialiseWordArray_constructor_with_= 0;
static oop s_push= 0;
static oop s_println_= 0;
static oop s_printIndent_= 0;
static oop s_print= 0;
static oop s_do_= 0;
static oop s_encode_= 0;
static oop s_value= 0;
static oop s__5fsizeof= 0;
static oop s_println= 0;
static struct _Selector { const char *name; oop *addr; } _Selectors[]= {
  { "function_:arity_:", &s_function_5f_arity_5f_ },
  { "genDefinition:", &s_genDefinition_ },
  { "size_:value_:", &s_size_5f_value_5f_ },
  { "asWordArray", &s_asWordArray },
  { "requireType:at:", &s_requireType_at_ },
  { "_import:", &s__5fimport_ },
  { "_debugName", &s__5fdebugName },
  { "encodeLiteral:", &s_encodeLiteral_ },
  { "collect:", &s_collect_ },
  { "defineWordArray:withElements:", &s_defineWordArray_withElements_ },
  { "genInitialisation:", &s_genInitialisation_ },
  { "initialiseWordArray:constructor:with:", &s_initialiseWordArray_constructor_with_ },
  { "push", &s_push },
  { "println:", &s_println_ },
  { "printIndent:", &s_printIndent_ },
  { "print", &s_print },
  { "do:", &s_do_ },
  { "encode:", &s_encode_ },
  { "value", &s_value },
  { "_sizeof", &s__5fsizeof },
  { "println", &s_println },
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
struct t_ParseNode {
  struct _vtable *_vtable[0];
  oop v_position;
  oop v_location;
};
struct t_LiteralNode {
  struct _vtable *_vtable[0];
  oop v_position;
  oop v_location;
  oop v_value;
  oop v_tag;
  oop v_constructor;
};
struct t_ArrayLiteralNode {
  struct _vtable *_vtable[0];
  oop v_position;
  oop v_location;
  oop v_value;
  oop v_tag;
  oop v_constructor;
};
struct t_WordArrayNode {
  struct _vtable *_vtable[0];
  oop v_position;
  oop v_location;
  oop v_value;
  oop v_tag;
  oop v_constructor;
};
static oop l_1= 0;
static oop l_2= 0;
static oop l_3= 0;
static oop l_5= 0;
static oop l_6= 0;
static oop l_4= 0;
static oop v__object= 0;
static oop v_Object= 0;
static oop v_UndefinedObject= 0;
static oop v_StaticBlockClosure= 0;
static oop v_Magnitude= 0;
static oop v_Number= 0;
static oop v_Integer= 0;
static oop v_LargePositiveInteger= 0;
static oop v_Collection= 0;
static oop v_SequenceableCollection= 0;
static oop v_ArrayedCollection= 0;
static oop v_Array= 0;
static oop v_WordArray= 0;
static oop v_ByteArray= 0;
static oop v_String= 0;
static oop v_ImmutableString= 0;
static oop v_ParseNode= 0;
static oop v_LiteralNode= 0;
static oop v_ArrayLiteralNode= 0;
static oop v_WordArrayNode= 0;
static size_t WordArrayNode___5fsizeof(oop _closure, oop v_self) { return sizeof(struct t_WordArrayNode); }
static char *WordArrayNode___5fdebugName(oop _closure, oop v_self) { return "WordArrayNode"; }
static oop b_2(oop v__closure, oop v__self, oop v_word)
 {
  _enter("[]", "?", "/home/piumarta/src/idst/object/idc/WordArrayNode.st");
  oop _1= 0;
  _line(29);
  _1= v_word;
  _line(29);
  _1=_send(s_value, _1);
  _leave();
  return _1;
  _leave();
 }
static oop WordArrayNode__encode_(oop v__closure, oop v_stateful_self, oop v_self, oop v_encoder)
 {
  _enter("encode:", "WordArrayNode", "/home/piumarta/src/idst/object/idc/WordArrayNode.st");
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  _line(26);
  _1= v_encoder;
  _2= l_1;
  _3= ((struct t_WordArrayNode *)v_stateful_self)->v_position;
  _line(28);
  _1=_send(s_requireType_at_, _1, _2, _3);
  ((struct t_WordArrayNode *)v_stateful_self)->v_constructor= _1;
  _1= ((struct t_WordArrayNode *)v_stateful_self)->v_value;
  _2= l_2;
  _line(29);
  _1=_send(s_collect_, _1, _2);
  _line(29);
  _1=_send(s_asWordArray, _1);
  ((struct t_WordArrayNode *)v_stateful_self)->v_value= _1;
  _1= v_encoder;
  _2= v_self;
  _line(30);
  _1=_send(s_encodeLiteral_, _1, _2);
  ((struct t_WordArrayNode *)v_stateful_self)->v_tag= _1;
  _1= v_encoder;
  _line(31);
  _1=_send(s_push, _1);
  ((struct t_WordArrayNode *)v_stateful_self)->v_location= _1;
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static oop WordArrayNode__genDefinition_(oop v__closure, oop v_stateful_self, oop v_self, oop v_gen)
 {
  _enter("genDefinition:", "WordArrayNode", "/home/piumarta/src/idst/object/idc/WordArrayNode.st");
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  _line(34);
  _1= v_self;
  _2= v_gen;
  _line(36);
  _1=_super(v_ArrayLiteralNode, s_genDefinition_, _1, _2);
  _1= v_gen;
  _2= ((struct t_WordArrayNode *)v_stateful_self)->v_tag;
  _3= ((struct t_WordArrayNode *)v_stateful_self)->v_value;
  _line(37);
  _1=_send(s_defineWordArray_withElements_, _1, _2, _3);
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static oop WordArrayNode__genInitialisation_(oop v__closure, oop v_stateful_self, oop v_self, oop v_gen)
 {
  _enter("genInitialisation:", "WordArrayNode", "/home/piumarta/src/idst/object/idc/WordArrayNode.st");
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  oop _4= 0;
  _line(40);
  _1= v_gen;
  _2= ((struct t_WordArrayNode *)v_stateful_self)->v_tag;
  _3= ((struct t_WordArrayNode *)v_stateful_self)->v_constructor;
  _4= ((struct t_WordArrayNode *)v_stateful_self)->v_value;
  _line(42);
  _1=_send(s_initialiseWordArray_constructor_with_, _1, _2, _3, _4);
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static oop b_4(oop v__closure, oop v__self, oop v_elt)
 {
  _enter("[]", "?", "/home/piumarta/src/idst/object/idc/WordArrayNode.st");
  oop _1= 0;
  _line(49);
  _1= v_elt;
  _line(49);
  _1=_send(s_value, _1);
  _line(49);
  _1=_send(s_print, _1);
  _1= l_6;
  _line(49);
  _1=_send(s_print, _1);
  _leave();
  return _1;
  _leave();
 }
static oop WordArrayNode__println_(oop v__closure, oop v_stateful_self, oop v_self, oop v_indent)
 {
  _enter("println:", "WordArrayNode", "/home/piumarta/src/idst/object/idc/WordArrayNode.st");
  oop _1= 0;
  oop _2= 0;
  _line(45);
  _1= v_self;
  _2= v_indent;
  _line(47);
  _1=_send(s_printIndent_, _1, _2);
  _1= l_3;
  _line(48);
  _1=_send(s_print, _1);
  _1= ((struct t_WordArrayNode *)v_stateful_self)->v_value;
  _2= l_4;
  _line(49);
  _1=_send(s_do_, _1, _2);
  _1= l_5;
  _line(50);
  _1=_send(s_println, _1);
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }

void __id__init__WordArrayNode(struct __libid *__libid)
{
  if (_libid) return;
  if (!(_libid= __libid)) { fprintf(stderr, "init _libid %p\n", __libid);  abort(); }
# define GC_add_roots _libid->gc_addRoots
  GC_INIT();
  {
    struct _Selector *s= 0;
    for (s= _Selectors;  s->name;  ++s)
      *s->addr= _libid->intern(s->name);
  }
  _enter("__id__init__", "<initialisation>", "WordArrayNode.st");

  _send(s__5fimport_, _libid->_object, "ArrayLiteralNode", "__id__init__ArrayLiteralNode");
  v__object= _libid->import("_object");
  v_Object= _libid->import("Object");
  v_UndefinedObject= _libid->import("UndefinedObject");
  v_StaticBlockClosure= _libid->import("StaticBlockClosure");
  v_Magnitude= _libid->import("Magnitude");
  v_Number= _libid->import("Number");
  v_Integer= _libid->import("Integer");
  v_LargePositiveInteger= _libid->import("LargePositiveInteger");
  v_Collection= _libid->import("Collection");
  v_SequenceableCollection= _libid->import("SequenceableCollection");
  v_ArrayedCollection= _libid->import("ArrayedCollection");
  v_Array= _libid->import("Array");
  v_WordArray= _libid->import("WordArray");
  v_ByteArray= _libid->import("ByteArray");
  v_String= _libid->import("String");
  v_ImmutableString= _libid->import("ImmutableString");
  v_ParseNode= _libid->import("ParseNode");
  v_LiteralNode= _libid->import("LiteralNode");
  v_ArrayLiteralNode= _libid->import("ArrayLiteralNode");
  v_WordArrayNode= _libid->proto(v_ArrayLiteralNode);
  _libid->method(v_WordArrayNode, s__5fsizeof, (_imp_t)WordArrayNode___5fsizeof);
  _libid->method(v_WordArrayNode, s__5fdebugName, (_imp_t)WordArrayNode___5fdebugName);
  _libid->export("WordArrayNode", v_WordArrayNode);
  l_1= _send(s_size_5f_value_5f_, v_ImmutableString, 9, "wordArray");
  l_2= _send(s_function_5f_arity_5f_, v_StaticBlockClosure, b_2, 1);
  _libid->method(v_WordArrayNode, s_encode_, (_imp_t)WordArrayNode__encode_);
  _libid->method(v_WordArrayNode, s_genDefinition_, (_imp_t)WordArrayNode__genDefinition_);
  _libid->method(v_WordArrayNode, s_genInitialisation_, (_imp_t)WordArrayNode__genInitialisation_);
  l_3= _send(s_size_5f_value_5f_, v_ImmutableString, 3, "#{ ");
  l_5= _send(s_size_5f_value_5f_, v_ImmutableString, 1, "}");
  l_6= _send(s_size_5f_value_5f_, v_ImmutableString, 1, " ");
  l_4= _send(s_function_5f_arity_5f_, v_StaticBlockClosure, b_4, 1);
  _libid->method(v_WordArrayNode, s_println_, (_imp_t)WordArrayNode__println_);
  _leave();
}
