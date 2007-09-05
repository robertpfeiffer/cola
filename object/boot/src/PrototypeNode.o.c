/* generated by Id 1.1 at 2007-09-03 20:38:12 Z */
/* with the command: -I../stage1/ -I../st80 -c PrototypeNode.st -o ../stage2/PrototypeNode.o.c */

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

static oop s_printIndent_= 0;
static oop s_println= 0;
static oop s_printString= 0;
static oop s_slots_= 0;
static oop s_addType_= 0;
static oop s__5fimport_= 0;
static oop s_ifFalse_= 0;
static oop s_beExternal= 0;
static oop s_isExternal= 0;
static oop s_println_= 0;
static oop s_slots= 0;
static oop s_ifTrue_= 0;
static oop s__2c= 0;
static oop s_noteUsed= 0;
static oop s__3d= 0;
static oop s_withName_base_slots_position_= 0;
static oop s_withPosition_= 0;
static oop s_isPrototypeNode= 0;
static oop s__5fdebugName= 0;
static oop s_and_= 0;
static oop s_base= 0;
static oop s_encode_position_= 0;
static oop s_addSelector_= 0;
static oop s_notNil= 0;
static oop s_size_5f_value_5f_= 0;
static oop s_noteImplementation_in_at_= 0;
static oop s_genDeclaration_= 0;
static oop s_declareType_= 0;
static oop s_genDefinition_= 0;
static oop s_addTo_= 0;
static oop s_defineType_= 0;
static oop s_genImplementation_= 0;
static oop s_name= 0;
static oop s_encode_= 0;
static oop s_not= 0;
static oop s_implementType_= 0;
static oop s_genInitialisation_= 0;
static oop s__5fsizeof= 0;
static oop s_ifTrue_ifFalse_= 0;
static oop s_initialiseExternal_= 0;
static oop s_initialiseType_in_= 0;
static struct _Selector { const char *name; oop *addr; } _Selectors[]= {
  { "printIndent:", &s_printIndent_ },
  { "println", &s_println },
  { "printString", &s_printString },
  { "slots:", &s_slots_ },
  { "addType:", &s_addType_ },
  { "_import:", &s__5fimport_ },
  { "ifFalse:", &s_ifFalse_ },
  { "beExternal", &s_beExternal },
  { "isExternal", &s_isExternal },
  { "println:", &s_println_ },
  { "slots", &s_slots },
  { "ifTrue:", &s_ifTrue_ },
  { ",", &s__2c },
  { "noteUsed", &s_noteUsed },
  { "=", &s__3d },
  { "withName:base:slots:position:", &s_withName_base_slots_position_ },
  { "withPosition:", &s_withPosition_ },
  { "isPrototypeNode", &s_isPrototypeNode },
  { "_debugName", &s__5fdebugName },
  { "and:", &s_and_ },
  { "base", &s_base },
  { "encode:position:", &s_encode_position_ },
  { "addSelector:", &s_addSelector_ },
  { "notNil", &s_notNil },
  { "size_:value_:", &s_size_5f_value_5f_ },
  { "noteImplementation:in:at:", &s_noteImplementation_in_at_ },
  { "genDeclaration:", &s_genDeclaration_ },
  { "declareType:", &s_declareType_ },
  { "genDefinition:", &s_genDefinition_ },
  { "addTo:", &s_addTo_ },
  { "defineType:", &s_defineType_ },
  { "genImplementation:", &s_genImplementation_ },
  { "name", &s_name },
  { "encode:", &s_encode_ },
  { "not", &s_not },
  { "implementType:", &s_implementType_ },
  { "genInitialisation:", &s_genInitialisation_ },
  { "_sizeof", &s__5fsizeof },
  { "ifTrue:ifFalse:", &s_ifTrue_ifFalse_ },
  { "initialiseExternal:", &s_initialiseExternal_ },
  { "initialiseType:in:", &s_initialiseType_in_ },
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
struct t_PrototypeNode {
  struct _vtable *_vtable[0];
  oop v_position;
  oop v_location;
  oop v_name;
  oop v_base;
  oop v_slots;
  oop v_used;
  oop v_external;
};
static oop l_1= 0;
static oop l_2= 0;
static oop l_3= 0;
static oop l_4= 0;
static oop l_5= 0;
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
static oop v_true= 0;
static oop v_false= 0;
static oop v_ParseNode= 0;
static oop v_PrototypeNode= 0;
static size_t PrototypeNode___5fsizeof(oop _closure, oop v_self) { return sizeof(struct t_PrototypeNode); }
static char *PrototypeNode___5fdebugName(oop _closure, oop v_self) { return "PrototypeNode"; }
static oop Object__isPrototypeNode(oop v__closure, oop v_stateful_self, oop v_self)
 {
  _enter("isPrototypeNode", "Object", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  _line(34);
  _1= v_false;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode__isPrototypeNode(oop v__closure, oop v_stateful_self, oop v_self)
 {
  _enter("isPrototypeNode", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  _line(35);
  _1= v_true;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode__withName_base_slots_position_(oop v__closure, oop v_stateful_self, oop v_self, oop v_nameString, oop v_baseString, oop v_slotStrings, oop v_aPosition)
 {
  _enter("withName:base:slots:position:", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  oop _2= 0;
  _line(37);
  _1= v_self;
  _2= v_aPosition;
  _line(39);
  _1=_send(s_withPosition_, _1, _2);
  v_self= _1;
  v_stateful_self= _1;
  _1= v_nameString;
  ((struct t_PrototypeNode *)v_stateful_self)->v_name= _1;
  _1= v_baseString;
  ((struct t_PrototypeNode *)v_stateful_self)->v_base= _1;
  _1= v_slotStrings;
  ((struct t_PrototypeNode *)v_stateful_self)->v_slots= _1;
  _1= v_false;
  ((struct t_PrototypeNode *)v_stateful_self)->v_used= _1;
  _1= v_false;
  ((struct t_PrototypeNode *)v_stateful_self)->v_external= _1;
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode__name(oop v__closure, oop v_stateful_self, oop v_self)
 {
  _enter("name", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  _line(47);
  _1= ((struct t_PrototypeNode *)v_stateful_self)->v_name;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode__base(oop v__closure, oop v_stateful_self, oop v_self)
 {
  _enter("base", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  _line(48);
  _1= ((struct t_PrototypeNode *)v_stateful_self)->v_base;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode__slots(oop v__closure, oop v_stateful_self, oop v_self)
 {
  _enter("slots", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  _line(49);
  _1= ((struct t_PrototypeNode *)v_stateful_self)->v_slots;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode__noteUsed(oop v__closure, oop v_stateful_self, oop v_self)
 {
  _enter("noteUsed", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  _line(51);
  _1= v_true;
  ((struct t_PrototypeNode *)v_stateful_self)->v_used= _1;
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode__beExternal(oop v__closure, oop v_stateful_self, oop v_self)
 {
  _enter("beExternal", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  _line(52);
  _1= v_true;
  ((struct t_PrototypeNode *)v_stateful_self)->v_external= _1;
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode__isExternal(oop v__closure, oop v_stateful_self, oop v_self)
 {
  _enter("isExternal", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  _line(53);
  _1= ((struct t_PrototypeNode *)v_stateful_self)->v_external;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode__slots_(oop v__closure, oop v_stateful_self, oop v_self, oop v_slotCollection)
 {
  _enter("slots:", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  _line(55);
  _1= v_slotCollection;
  ((struct t_PrototypeNode *)v_stateful_self)->v_slots= _1;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode___3d(oop v__closure, oop v_stateful_self, oop v_self, oop v_aPrototypeNode)
 {
  _enter("=", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  oop _2= 0;
  _line(57);
  /* and: */
  _1= v_aPrototypeNode;
  _line(57);
  _1=_send(s_isPrototypeNode, _1);
  if (!_1) goto _l1;
 {
  _1= ((struct t_PrototypeNode *)v_stateful_self)->v_slots;
  _2= v_aPrototypeNode;
  _line(57);
  _2=_send(s_slots, _2);
  if (1 & (int)_1 & (int)_2) {
    _1= (((int)_1 == (int)_2) ? v_true : v_false);
  } else _1= _send(s__3d, _1, _2);
 }
 _l1:;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode__addTo_(oop v__closure, oop v_stateful_self, oop v_self, oop v_client)
 {
  _enter("addTo:", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  oop _2= 0;
  _line(59);
  _1= v_client;
  _2= v_self;
  _line(59);
  _1=_send(s_addType_, _1, _2);
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode__encode_(oop v__closure, oop v_stateful_self, oop v_self, oop v_encoder)
 {
  _enter("encode:", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  oop _4= 0;
  _line(61);
  /* ifTrue: */
  _1= 0;
  _2= ((struct t_PrototypeNode *)v_stateful_self)->v_base;
  _line(64);
  _2=_send(s_notNil, _2);
  if (!_2) goto _l2;
 {
  _1= v_encoder;
  _2= ((struct t_PrototypeNode *)v_stateful_self)->v_base;
  _3= ((struct t_PrototypeNode *)v_stateful_self)->v_position;
  _line(64);
  _1=_send(s_encode_position_, _1, _2, _3);
 }
 _l2:;
  /* ifFalse: */
  _1= 0;
  _2= ((struct t_PrototypeNode *)v_stateful_self)->v_external;
  if (_2) goto _l3;
 {
  _1= v_true;
  ((struct t_PrototypeNode *)v_stateful_self)->v_used= _1;
  _1= v_encoder;
  _2= l_1;
  _line(70);
  _send(s_addSelector_, _1, _2);
  _2= l_1;
  _3= ((struct t_PrototypeNode *)v_stateful_self)->v_name;
  _4= ((struct t_PrototypeNode *)v_stateful_self)->v_position;
  _send(s_noteImplementation_in_at_, _1, _2, _3, _4);
  _2= l_2;
  _send(s_addSelector_, _1, _2);
  _2= l_2;
  _3= ((struct t_PrototypeNode *)v_stateful_self)->v_name;
  _4= ((struct t_PrototypeNode *)v_stateful_self)->v_position;
  _1=_send(s_noteImplementation_in_at_, _1, _2, _3, _4);
 }
 _l3:;
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode__genDeclaration_(oop v__closure, oop v_stateful_self, oop v_self, oop v_gen)
 {
  _enter("genDeclaration:", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  oop _2= 0;
  _line(78);
  _1= v_gen;
  _2= v_self;
  _line(78);
  _1=_send(s_declareType_, _1, _2);
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode__genDefinition_(oop v__closure, oop v_stateful_self, oop v_self, oop v_gen)
 {
  _enter("genDefinition:", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  oop _2= 0;
  _line(79);
  /* ifTrue: */
  _1= 0;
  _2= ((struct t_PrototypeNode *)v_stateful_self)->v_used;
  if (!_2) goto _l4;
 {
  _1= v_gen;
  _2= v_self;
  _line(79);
  _1=_send(s_defineType_, _1, _2);
 }
 _l4:;
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode__genImplementation_(oop v__closure, oop v_stateful_self, oop v_self, oop v_gen)
 {
  _enter("genImplementation:", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  oop _2= 0;
  _line(80);
  /* ifTrue: */
  _1= 0;
  /* and: */
  _2= ((struct t_PrototypeNode *)v_stateful_self)->v_used;
  if (!_2) goto _l6;
 {
  _2= ((struct t_PrototypeNode *)v_stateful_self)->v_external;
  _line(80);
  _2=_send(s_not, _2);
 }
 _l6:;
  if (!_2) goto _l5;
 {
  _1= v_gen;
  _2= v_self;
  _line(80);
  _1=_send(s_implementType_, _1, _2);
 }
 _l5:;
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode__genInitialisation_(oop v__closure, oop v_stateful_self, oop v_self, oop v_gen)
 {
  _enter("genInitialisation:", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  _line(82);
  /* ifTrue: */
  _1= 0;
  _2= ((struct t_PrototypeNode *)v_stateful_self)->v_used;
  if (!_2) goto _l7;
 {
  /* ifTrue:ifFalse: */
  _1= ((struct t_PrototypeNode *)v_stateful_self)->v_external;
  if (!_1) goto _l8;
 {
  _1= v_gen;
  _2= ((struct t_PrototypeNode *)v_stateful_self)->v_name;
  _line(87);
  _1=_send(s_initialiseExternal_, _1, _2);
 }
  goto _l9;
 _l8:;
 {
  _1= v_gen;
  _2= v_self;
  _line(88);
  _2=_send(s_name, _2);
  _3= ((struct t_PrototypeNode *)v_stateful_self)->v_base;
  _line(88);
  _1=_send(s_initialiseType_in_, _1, _2, _3);
 }
 _l9:;
 }
 _l7:;
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static oop PrototypeNode__println_(oop v__closure, oop v_stateful_self, oop v_self, oop v_indent)
 {
  _enter("println:", "PrototypeNode", "/home/piumarta/src/idst/object/idc/PrototypeNode.st");
  oop _1= 0;
  oop _2= 0;
  _line(91);
  _1= v_self;
  _2= v_indent;
  _line(93);
  _1=_send(s_printIndent_, _1, _2);
  _1= l_3;
  _2= ((struct t_PrototypeNode *)v_stateful_self)->v_name;
  _line(94);
  _2=_send(s_printString, _2);
  _line(94);
  _1=_send(s__2c, _1, _2);
  _2= l_4;
  _line(94);
  _1=_send(s__2c, _1, _2);
  _2= ((struct t_PrototypeNode *)v_stateful_self)->v_base;
  _line(94);
  _2=_send(s_printString, _2);
  _line(94);
  _1=_send(s__2c, _1, _2);
  _2= l_5;
  _line(94);
  _1=_send(s__2c, _1, _2);
  _2= ((struct t_PrototypeNode *)v_stateful_self)->v_slots;
  _line(94);
  _2=_send(s_printString, _2);
  _line(94);
  _1=_send(s__2c, _1, _2);
  _line(94);
  _1=_send(s_println, _1);
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }

void __id__init__PrototypeNode(struct __libid *__libid)
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
  _enter("__id__init__", "<initialisation>", "PrototypeNode.st");

  _send(s__5fimport_, _libid->_object, "ParseNode", "__id__init__ParseNode");
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
  v_true= _libid->import("true");
  v_false= _libid->import("false");
  v_ParseNode= _libid->import("ParseNode");
  v_PrototypeNode= _libid->proto(v_ParseNode);
  _libid->method(v_PrototypeNode, s__5fsizeof, (_imp_t)PrototypeNode___5fsizeof);
  _libid->method(v_PrototypeNode, s__5fdebugName, (_imp_t)PrototypeNode___5fdebugName);
  _libid->export("PrototypeNode", v_PrototypeNode);
  _libid->method(v_Object, s_isPrototypeNode, (_imp_t)Object__isPrototypeNode);
  _libid->method(v_PrototypeNode, s_isPrototypeNode, (_imp_t)PrototypeNode__isPrototypeNode);
  _libid->method(v_PrototypeNode, s_withName_base_slots_position_, (_imp_t)PrototypeNode__withName_base_slots_position_);
  _libid->method(v_PrototypeNode, s_name, (_imp_t)PrototypeNode__name);
  _libid->method(v_PrototypeNode, s_base, (_imp_t)PrototypeNode__base);
  _libid->method(v_PrototypeNode, s_slots, (_imp_t)PrototypeNode__slots);
  _libid->method(v_PrototypeNode, s_noteUsed, (_imp_t)PrototypeNode__noteUsed);
  _libid->method(v_PrototypeNode, s_beExternal, (_imp_t)PrototypeNode__beExternal);
  _libid->method(v_PrototypeNode, s_isExternal, (_imp_t)PrototypeNode__isExternal);
  _libid->method(v_PrototypeNode, s_slots_, (_imp_t)PrototypeNode__slots_);
  _libid->method(v_PrototypeNode, s__3d, (_imp_t)PrototypeNode___3d);
  _libid->method(v_PrototypeNode, s_addTo_, (_imp_t)PrototypeNode__addTo_);
  l_1= _send(s_size_5f_value_5f_, v_ImmutableString, 7, "_sizeof");
  l_2= _send(s_size_5f_value_5f_, v_ImmutableString, 10, "_debugName");
  _libid->method(v_PrototypeNode, s_encode_, (_imp_t)PrototypeNode__encode_);
  _libid->method(v_PrototypeNode, s_genDeclaration_, (_imp_t)PrototypeNode__genDeclaration_);
  _libid->method(v_PrototypeNode, s_genDefinition_, (_imp_t)PrototypeNode__genDefinition_);
  _libid->method(v_PrototypeNode, s_genImplementation_, (_imp_t)PrototypeNode__genImplementation_);
  _libid->method(v_PrototypeNode, s_genInitialisation_, (_imp_t)PrototypeNode__genInitialisation_);
  l_3= _send(s_size_5f_value_5f_, v_ImmutableString, 5, "Type ");
  l_4= _send(s_size_5f_value_5f_, v_ImmutableString, 3, " = ");
  l_5= _send(s_size_5f_value_5f_, v_ImmutableString, 3, " + ");
  _libid->method(v_PrototypeNode, s_println_, (_imp_t)PrototypeNode__println_);
  _leave();
}
