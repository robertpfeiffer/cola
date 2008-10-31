/* generated by Id 1.1 at ,$ */
/* with the command: -I../stage1/ -c Set.st -o ../stage2/Set.o.c */

#include <id/id.h>

static struct __libid *_libid= 0;

#ifdef ID_DEBUG
# define _enter(info) void *__id_debug= _libid->enter(info)
# define _line(lno)			_libid->line(lno)
# define _leave()			_libid->leave(__id_debug)
# define _backtrace()			_libid->backtrace()
#else
# define _enter(info)			(void)info
# define _line(lno)
# define _leave()
# define _backtrace()			"(no debugging information)\n"
#endif
#define _return			_leave(); return

#define _sendv(MSG, N, RCV, ARG...) ({					\
  struct __send _s= { (MSG), (N), (RCV) };				\
  ((_imp_t)(_libid->bindv(&_s)))(&_s, _s.receiver, _s.receiver, ##ARG);	\
})

#define _superv(TYP, MSG, N, RCV, ARG...) ({	\
  struct __send _s= { (MSG), (N), (TYP) };	\
  _imp_t _imp= _libid->bindv(&_s);		\
  _s.receiver= (RCV);				\
  _imp(&_s, _s.receiver, _s.receiver, ##ARG);	\
})

static oop s_new_= 0;
static oop s_new_5f_= 0;
static oop s_hash= 0;
static oop s_value_5f_= 0;
static oop s__5fimport_= 0;
static oop s_swap_with_= 0;
static oop s_do_= 0;
static oop s_ifFalse_= 0;
static oop s__5fslots= 0;
static oop s_ifTrue_= 0;
static oop s__2b= 0;
static oop s_isNil= 0;
static oop s_to_do_= 0;
static oop s__2d= 0;
static oop s_size= 0;
static oop s_scanFor_= 0;
static oop s__2f_2f= 0;
static oop s__3d_3d= 0;
static oop s_add_= 0;
static oop s__3d= 0;
static oop s__5c_5c= 0;
static oop s_initialize_= 0;
static oop s__5fdebugName= 0;
static oop s_size_5f_value_5f_= 0;
static oop s_new= 0;
static oop s_findElementOrNil_= 0;
static oop s_atNewIndex_put_= 0;
static oop s__3c= 0;
static oop s_function_5f_arity_5f_outer_state_nlr_5f_= 0;
static oop s_growSize= 0;
static oop s_noCheckAdd_= 0;
static oop s_remove_ifAbsent_= 0;
static oop s_fixCollisionsFrom_= 0;
static oop s_or_= 0;
static oop s_whileFalse_= 0;
static oop s_ifTrue_ifFalse_= 0;
static oop s_fullCheck= 0;
static oop s_at_= 0;
static oop s_keyAt_= 0;
static oop s_value_= 0;
static oop s_like_= 0;
static oop s_error_= 0;
static oop s_value= 0;
static oop s__5fsizeof= 0;
static oop s_grow= 0;
static oop s_at_put_= 0;
static oop s_max_= 0;
static struct _Selector { const char *name; oop *addr; } _Selectors[]= {
  { "new:", &s_new_ },
  { "new_:", &s_new_5f_ },
  { "hash", &s_hash },
  { "value_:", &s_value_5f_ },
  { "_import:", &s__5fimport_ },
  { "swap:with:", &s_swap_with_ },
  { "do:", &s_do_ },
  { "ifFalse:", &s_ifFalse_ },
  { "_slots", &s__5fslots },
  { "ifTrue:", &s_ifTrue_ },
  { "+", &s__2b },
  { "isNil", &s_isNil },
  { "to:do:", &s_to_do_ },
  { "-", &s__2d },
  { "size", &s_size },
  { "scanFor:", &s_scanFor_ },
  { "//", &s__2f_2f },
  { "==", &s__3d_3d },
  { "add:", &s_add_ },
  { "=", &s__3d },
  { "\\\\", &s__5c_5c },
  { "initialize:", &s_initialize_ },
  { "_debugName", &s__5fdebugName },
  { "size_:value_:", &s_size_5f_value_5f_ },
  { "new", &s_new },
  { "findElementOrNil:", &s_findElementOrNil_ },
  { "atNewIndex:put:", &s_atNewIndex_put_ },
  { "<", &s__3c },
  { "function_:arity_:outer:state:nlr_:", &s_function_5f_arity_5f_outer_state_nlr_5f_ },
  { "growSize", &s_growSize },
  { "noCheckAdd:", &s_noCheckAdd_ },
  { "remove:ifAbsent:", &s_remove_ifAbsent_ },
  { "fixCollisionsFrom:", &s_fixCollisionsFrom_ },
  { "or:", &s_or_ },
  { "whileFalse:", &s_whileFalse_ },
  { "ifTrue:ifFalse:", &s_ifTrue_ifFalse_ },
  { "fullCheck", &s_fullCheck },
  { "at:", &s_at_ },
  { "keyAt:", &s_keyAt_ },
  { "value:", &s_value_ },
  { "like:", &s_like_ },
  { "error:", &s_error_ },
  { "value", &s_value },
  { "_sizeof", &s__5fsizeof },
  { "grow", &s_grow },
  { "at:put:", &s_at_put_ },
  { "max:", &s_max_ },
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
static oop l_2= 0;
static oop l_5= 0;
static oop l_8= 0;
static oop l_10= 0;
static oop l_11= 0;
static oop l_13= 0;
static oop l_16= 0;
static oop l_18= 0;
static oop l_20= 0;
static oop l_21= 0;
static oop l_24= 0;
static oop l_27= 0;
static oop l_29= 0;
static oop l_31= 0;
static oop l_35= 0;
static oop l_38= 0;
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
static oop v_nil= 0;
static oop v_true= 0;
static oop v_false= 0;
static oop v_Set= 0;
static size_t Set___5fsizeof(oop _closure, oop v_self) { return sizeof(struct t_Set); }
static char *Set___5fdebugName(oop _closure, oop v_self) { return "Set"; }
static struct __slotinfo *Set___5fslots(oop _closure, oop v_self) { static struct __slotinfo info[]= { { "tally", 0, 4 }, { "array", 4, 4 }, { 0, 0, 0 } };  return &info[0]; }
static struct __methodinfo __info1= { "new", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 25, 26, 0 };
static oop Set__new(oop v__closure, oop v_stateful_self, oop v_self)
 {
  _enter(&__info1);
  oop _1= 0;
  oop _2= 0;
  _line(25);
  _1= v_self;
  _2= l_2;
  _line(25);
  _1=_sendv(s_new_, 2, _1, _2);
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info3= { "new:", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 26, 28, &__info1 };
static oop Set__new_(oop v__closure, oop v_stateful_self, oop v_self, oop v_size)
 {
  _enter(&__info3);
  oop _1= 0;
  oop _2= 0;
  _line(26);
  _1= v_self;
  _line(26);
  _1=_superv(v_Collection, s_new, 1, _1);
  _2= v_size;
  _line(26);
  _1=_sendv(s_initialize_, 2, _1, _2);
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info4= { "initialize:", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 28, 34, &__info3 };
static oop Set__initialize_(oop v__closure, oop v_stateful_self, oop v_self, oop v_size)
 {
  _enter(&__info4);
  oop _1= 0;
  oop _2= 0;
  _line(28);
  _1= l_5;
  ((struct t_Set *)v_stateful_self)->v_tally= _1;
  _1= v_Array;
  _2= v_size;
  _line(31);
  _1=_sendv(s_new_, 2, _1, _2);
  ((struct t_Set *)v_stateful_self)->v_array= _1;
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info6= { "size", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 34, 36, &__info4 };
static oop Set__size(oop v__closure, oop v_stateful_self, oop v_self)
 {
  _enter(&__info6);
  oop _1= 0;
  _line(34);
  _1= ((struct t_Set *)v_stateful_self)->v_tally;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info7= { "add:", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 36, 45, &__info6 };
static oop Set__add_(oop v__closure, oop v_stateful_self, oop v_self, oop v_newObject)
 {
  _enter(&__info7);
  oop v_index= 0;
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  (void)v_index;
  _line(36);
  /* ifTrue: */
  _1= 0;
  _2= v_newObject;
  _line(39);
  _2=_sendv(s_isNil, 1, _2);
  if (!_2) goto _l1;
 {
  _1= v_self;
  _2= l_8;
  _line(39);
  _1=_sendv(s_error_, 2, _1, _2);
 }
 _l1:;
  _1= v_self;
  _2= v_newObject;
  _line(40);
  _1=_sendv(s_findElementOrNil_, 2, _1, _2);
  v_index= _1;
  /* ifTrue: */
  _1= 0;
  _2= ((struct t_Set *)v_stateful_self)->v_array;
  _3= v_index;
  _line(41);
  _2=_sendv(s_at_, 2, _2, _3);
  _line(41);
  _2=_sendv(s_isNil, 1, _2);
  if (!_2) goto _l2;
 {
  _1= v_self;
  _2= v_index;
  _3= v_newObject;
  _line(41);
  _1=_sendv(s_atNewIndex_put_, 3, _1, _2, _3);
 }
 _l2:;
  _1= v_newObject;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info9= { "findElementOrNil:", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 45, 57, &__info7 };
static oop Set__findElementOrNil_(oop v__closure, oop v_stateful_self, oop v_self, oop v_anObject)
 {
  _enter(&__info9);
  oop v_index= 0;
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  (void)v_index;
  _line(45);
  _1= v_self;
  _2= v_anObject;
  _line(52);
  _1=_sendv(s_scanFor_, 2, _1, _2);
  v_index= _1;
  /* ifTrue: */
  _1= 0;
  _2= v_index;
  _3= l_10;
  if (1 & (long)_2) {
    _2= (((long)_2 < (long)_3) ? v_true : v_false);
  } else _2= _sendv(s__3c, 2, _2, _3);
  if (!_2) goto _l3;
 {
  _1= v_self;
  _2= l_11;
  _line(53);
  _1=_sendv(s_error_, 2, _1, _2);
 }
 _l3:;
  _1= v_index;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info14= { "[] scanFor:", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 57, 80, &__info9 };
static oop b_14(oop v__closure, oop v__self, oop v_index)
 {
  _enter(&__info14);
  oop v_element= 0;
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  (void)v_element;
  _line(68);
  /* ifTrue: */
  _1= 0;
  /* or: */
  _2= ((struct t_Set *)((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[1])->v_array;  /* array */
  _3= v_index;
  _line(70);
  _2=_sendv(s_at_, 2, _2, _3);
  v_element= _2;
  _line(70);
  _2=_sendv(s_isNil, 1, _2);
  if (_2) goto _l5;
 {
  _2= v_element;
  _3= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[2];  /* anObject */
  if (1 & (long)_2 & (long)_3) {
    _2= (((long)_2 == (long)_3) ? v_true : v_false);
  } else _2= _sendv(s__3d, 2, _2, _3);
 }
 _l5:;
  if (!_2) goto _l4;
 {
  _1= v_index;
  _leave();
  return _libid->nlreturn(((struct t_BlockClosure *)v__self)->v__nlr, _1);
 }
 _l4:;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info15= { "[] scanFor:", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 57, 80, &__info14 };
static oop b_15(oop v__closure, oop v__self, oop v_index)
 {
  _enter(&__info15);
  oop v_element= 0;
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  (void)v_element;
  _line(73);
  /* ifTrue: */
  _1= 0;
  /* or: */
  _2= ((struct t_Set *)((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[1])->v_array;  /* array */
  _3= v_index;
  _line(75);
  _2=_sendv(s_at_, 2, _2, _3);
  v_element= _2;
  _line(75);
  _2=_sendv(s_isNil, 1, _2);
  if (_2) goto _l7;
 {
  _2= v_element;
  _3= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[2];  /* anObject */
  if (1 & (long)_2 & (long)_3) {
    _2= (((long)_2 == (long)_3) ? v_true : v_false);
  } else _2= _sendv(s__3d, 2, _2, _3);
 }
 _l7:;
  if (!_2) goto _l6;
 {
  _1= v_index;
  _leave();
  return _libid->nlreturn(((struct t_BlockClosure *)v__self)->v__nlr, _1);
 }
 _l6:;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info12= { "scanFor:", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 57, 80, &__info15 };
static oop Set__scanFor_(oop v__closure, oop v_stateful_self, oop v_self, oop v_anObject)
 {
  _enter(&__info12);
  oop _state1= _sendv(s_new_5f_, 2, v__vector, 5);
  oop v_finish= 0;
  oop v_start= 0;
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  jmp_buf __nlr;
  oop _nlr;
  (void)v_finish;
  (void)v_start;
  ((oop *)_state1)[1]= v_stateful_self;
  ((oop *)_state1)[2]= v_anObject;
  _nlr= (oop)&__nlr;
  if (setjmp(__nlr)) { return _libid->nlresult(); }
  _line(57);
  _1= ((struct t_Set *)((oop *)_state1)[1])->v_array;  /* array */
  _line(65);
  _1=_sendv(s_size, 1, _1);
  v_finish= _1;
  _1= ((oop *)_state1)[2];  /* anObject */
  _line(66);
  _1=_sendv(s_hash, 1, _1);
  _2= v_finish;
  _1= _sendv(s__5c_5c, 2, _1, _2);
  _2= l_13;
  {
    int _l= (long)_1 >> 1;
    int _r= (long)_2 >> 1;
    int _s= _l + _r;
    if ((1 & (long)_1) && ((_s ^ (_s << 1)) >= 0))  _1= (oop)(long)(_s << 1 | 1);  else _1= _sendv(s__2b, 2, _1, _2);
  }
  v_start= _1;
  _1= v_start;
  _2= v_finish;
  /* Scope('element'->TemporaryVariableNode 'index'->ArgumentVariableNode) */
  /* Scope('finish'->TemporaryVariableNode 'start'->TemporaryVariableNode 'tally'->SlotVariableNode 'stateful_self'->ArgumentVariableNode 'array'->SlotVariableNode 'self'->ArgumentVariableNode 'anObject'->ArgumentVariableNode) */
  /* nil */
  /* 2 */
  /* 1 */
  _3= _sendv(s_function_5f_arity_5f_outer_state_nlr_5f_, 6, v_BlockClosure, (oop)b_14, 1, 0, ((oop *)_state1), _nlr);
  _line(68);
  _1=_sendv(s_to_do_, 3, _1, _2, _3);
  _1= l_13;
  _2= v_start;
  /* Scope('element'->TemporaryVariableNode 'index'->ArgumentVariableNode) */
  /* Scope('finish'->TemporaryVariableNode 'start'->TemporaryVariableNode 'tally'->SlotVariableNode 'stateful_self'->ArgumentVariableNode 'array'->SlotVariableNode 'self'->ArgumentVariableNode 'anObject'->ArgumentVariableNode) */
  /* nil */
  /* 2 */
  /* 1 */
  _3= _sendv(s_function_5f_arity_5f_outer_state_nlr_5f_, 6, v_BlockClosure, (oop)b_15, 1, 0, ((oop *)_state1), _nlr);
  _line(73);
  _1=_sendv(s_to_do_, 3, _1, _2, _3);
  _1= l_16;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info17= { "atNewIndex:put:", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 80, 87, &__info12 };
static oop Set__atNewIndex_put_(oop v__closure, oop v_stateful_self, oop v_self, oop v_index, oop v_anObject)
 {
  _enter(&__info17);
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  _line(80);
  _1= ((struct t_Set *)v_stateful_self)->v_array;
  _2= v_index;
  _3= v_anObject;
  _line(82);
  _1=_sendv(s_at_put_, 3, _1, _2, _3);
  _1= ((struct t_Set *)v_stateful_self)->v_tally;
  _2= l_18;
  {
    int _l= (long)_1 >> 1;
    int _r= (long)_2 >> 1;
    int _s= _l + _r;
    if ((1 & (long)_1) && ((_s ^ (_s << 1)) >= 0))  _1= (oop)(long)(_s << 1 | 1);  else _1= _sendv(s__2b, 2, _1, _2);
  }
  ((struct t_Set *)v_stateful_self)->v_tally= _1;
  _1= v_self;
  _line(84);
  _1=_sendv(s_fullCheck, 1, _1);
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info19= { "fullCheck", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 87, 93, &__info17 };
static oop Set__fullCheck(oop v__closure, oop v_stateful_self, oop v_self)
 {
  _enter(&__info19);
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  oop _4= 0;
  oop _5= 0;
  _line(87);
  /* ifTrue: */
  _1= 0;
  _2= ((struct t_Set *)v_stateful_self)->v_array;
  _line(90);
  _2=_sendv(s_size, 1, _2);
  _3= ((struct t_Set *)v_stateful_self)->v_tally;
  {
    int _l= (long)_2 >> 1;
    int _r= (long)_3 >> 1;
    int _s= (_l - _r);
    if ((1 & (long)_2 & (long)_3) && ((_s ^ (_s << 1)) >= 0))  _2= (oop)(long)(_s << 1 | 1);  else _2= _sendv(s__2d, 2, _2, _3);
  }
  _3= l_20;
  _4= ((struct t_Set *)v_stateful_self)->v_array;
  _line(90);
  _4=_sendv(s_size, 1, _4);
  _5= l_21;
  _4= _sendv(s__2f_2f, 2, _4, _5);
  _line(90);
  _3=_sendv(s_max_, 2, _3, _4);
  if (1 & (long)_2 & (long)_3) {
    _2= (((long)_2 < (long)_3) ? v_true : v_false);
  } else _2= _sendv(s__3c, 2, _2, _3);
  if (!_2) goto _l8;
 {
  _1= v_self;
  _line(90);
  _1=_sendv(s_grow, 1, _1);
 }
 _l8:;
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info22= { "growSize", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 93, 95, &__info19 };
static oop Set__growSize(oop v__closure, oop v_stateful_self, oop v_self)
 {
  _enter(&__info22);
  oop _1= 0;
  _line(93);
  _1= ((struct t_Set *)v_stateful_self)->v_array;
  _line(93);
  _1=_sendv(s_size, 1, _1);
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info25= { "[] grow", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 95, 106, &__info22 };
static oop b_25(oop v__closure, oop v__self, oop v_element)
 {
  _enter(&__info25);
  oop _1= 0;
  oop _2= 0;
  _line(103);
  /* ifFalse: */
  _1= 0;
  _2= v_element;
  _line(103);
  _2=_sendv(s_isNil, 1, _2);
  if (_2) goto _l9;
 {
  _1= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[1];  /* self */
  _2= v_element;
  _line(103);
  _1=_sendv(s_noCheckAdd_, 2, _1, _2);
 }
 _l9:;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info23= { "grow", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 95, 106, &__info25 };
static oop Set__grow(oop v__closure, oop v_stateful_self, oop v_self)
 {
  _enter(&__info23);
  oop _state1= _sendv(s_new_5f_, 2, v__vector, 5);
  oop v_oldElements= 0;
  oop v_oldSize= 0;
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  (void)v_oldElements;
  (void)v_oldSize;
  ((oop *)_state1)[2]= v_stateful_self;
  ((oop *)_state1)[1]= v_self;
  _line(95);
  _1= ((struct t_Set *)((oop *)_state1)[2])->v_array;  /* array */
  v_oldElements= _1;
  _1= ((struct t_Set *)((oop *)_state1)[2])->v_array;  /* array */
  _line(100);
  _1=_sendv(s_size, 1, _1);
  v_oldSize= _1;
  _1= v_Array;
  _2= v_oldSize;
  _3= ((oop *)_state1)[1];  /* self */
  _line(101);
  _3=_sendv(s_growSize, 1, _3);
  {
    int _l= (long)_2 >> 1;
    int _r= (long)_3 >> 1;
    int _s= _l + _r;
    if ((1 & (long)_2 & (long)_3) && ((_s ^ (_s << 1)) >= 0))  _2= (oop)(long)(_s << 1 | 1);  else _2= _sendv(s__2b, 2, _2, _3);
  }
  _line(101);
  _1=_sendv(s_new_, 2, _1, _2);
  ((struct t_Set *)((oop *)_state1)[2])->v_array= _1;  /* array */
  _1= l_24;
  ((struct t_Set *)((oop *)_state1)[2])->v_tally= _1;  /* tally */
  _1= v_oldElements;
  /* Scope('element'->ArgumentVariableNode) */
  /* Scope('array'->SlotVariableNode 'oldSize'->TemporaryVariableNode 'self'->ArgumentVariableNode 'tally'->SlotVariableNode 'oldElements'->TemporaryVariableNode 'stateful_self'->ArgumentVariableNode) */
  /* nil */
  /* 2 */
  /* 1 */
  _2= _sendv(s_function_5f_arity_5f_outer_state_nlr_5f_, 6, v_BlockClosure, (oop)b_25, 1, 0, ((oop *)_state1), 0);
  _line(103);
  _1=_sendv(s_do_, 2, _1, _2);
  _1= ((oop *)_state1)[1];  /* self */
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info26= { "noCheckAdd:", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 106, 112, &__info23 };
static oop Set__noCheckAdd_(oop v__closure, oop v_stateful_self, oop v_self, oop v_anObject)
 {
  _enter(&__info26);
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  _line(106);
  _1= ((struct t_Set *)v_stateful_self)->v_array;
  _2= v_self;
  _3= v_anObject;
  _line(108);
  _2=_sendv(s_findElementOrNil_, 2, _2, _3);
  _3= v_anObject;
  _line(108);
  _1=_sendv(s_at_put_, 3, _1, _2, _3);
  _1= ((struct t_Set *)v_stateful_self)->v_tally;
  _2= l_27;
  {
    int _l= (long)_1 >> 1;
    int _r= (long)_2 >> 1;
    int _s= _l + _r;
    if ((1 & (long)_1) && ((_s ^ (_s << 1)) >= 0))  _1= (oop)(long)(_s << 1 | 1);  else _1= _sendv(s__2b, 2, _1, _2);
  }
  ((struct t_Set *)v_stateful_self)->v_tally= _1;
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info28= { "remove:ifAbsent:", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 112, 123, &__info26 };
static oop Set__remove_ifAbsent_(oop v__closure, oop v_stateful_self, oop v_self, oop v_oldObject, oop v_aBlock)
 {
  _enter(&__info28);
  oop v_index= 0;
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  (void)v_index;
  _line(112);
  _1= v_self;
  _2= v_oldObject;
  _line(115);
  _1=_sendv(s_findElementOrNil_, 2, _1, _2);
  v_index= _1;
  /* ifTrue: */
  _1= 0;
  _2= ((struct t_Set *)v_stateful_self)->v_array;
  _3= v_index;
  _line(116);
  _2=_sendv(s_at_, 2, _2, _3);
  _3= v_nil;
  _2= (_2 == _3) ? v_true : v_false;
  if (!_2) goto _l10;
 {
  _1= v_aBlock;
  _line(116);
  _1=_sendv(s_value, 1, _1);
  _leave();
  return _1;
 }
 _l10:;
  _1= ((struct t_Set *)v_stateful_self)->v_array;
  _2= v_index;
  _3= v_nil;
  _line(117);
  _1=_sendv(s_at_put_, 3, _1, _2, _3);
  _1= ((struct t_Set *)v_stateful_self)->v_tally;
  _2= l_29;
  {
    int _l= (long)_1 >> 1;
    int _r= (long)_2 >> 1;
    int _s= (_l - _r);
    if ((1 & (long)_1) && ((_s ^ (_s << 1)) >= 0))  _1= (oop)(long)(_s << 1 | 1);  else _1= _sendv(s__2d, 2, _1, _2);
  }
  ((struct t_Set *)v_stateful_self)->v_tally= _1;
  _1= v_self;
  _2= v_index;
  _line(119);
  _1=_sendv(s_fixCollisionsFrom_, 2, _1, _2);
  _1= v_oldObject;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info30= { "fixCollisionsFrom:", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 123, 140, &__info28 };
static oop Set__fixCollisionsFrom_(oop v__closure, oop v_stateful_self, oop v_self, oop v_index)
 {
  _enter(&__info30);
  oop v_length= 0;
  oop v_oldIndex= 0;
  oop v_newIndex= 0;
  oop v_element= 0;
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  (void)v_length;
  (void)v_oldIndex;
  (void)v_newIndex;
  (void)v_element;
  _line(123);
  _1= v_index;
  v_oldIndex= _1;
  _1= ((struct t_Set *)v_stateful_self)->v_array;
  _line(130);
  _1=_sendv(s_size, 1, _1);
  v_length= _1;
  /* whileFalse: */
  goto _l12;
 _l11:;
 {
  _1= v_self;
  _2= v_element;
  _line(136);
  _1=_sendv(s_findElementOrNil_, 2, _1, _2);
  v_newIndex= _1;
  /* ifFalse: */
  _1= 0;
  _2= v_oldIndex;
  _3= v_newIndex;
  if (1 & (long)_2 & (long)_3) {
    _2= (((long)_2 == (long)_3) ? v_true : v_false);
  } else _2= _sendv(s__3d, 2, _2, _3);
  if (_2) goto _l13;
 {
  _1= v_self;
  _2= v_oldIndex;
  _3= v_newIndex;
  _line(137);
  _1=_sendv(s_swap_with_, 3, _1, _2, _3);
 }
 _l13:;
 }
 _l12:;
 {
  /* ifTrue:ifFalse: */
  _1= v_oldIndex;
  _2= v_length;
  if (1 & (long)_1 & (long)_2) {
    _1= (((long)_1 == (long)_2) ? v_true : v_false);
  } else _1= _sendv(s__3d, 2, _1, _2);
  if (!_1) goto _l14;
 {
  _1= l_31;
  v_oldIndex= _1;
 }
  goto _l15;
 _l14:;
 {
  _1= v_oldIndex;
  _2= l_31;
  {
    int _l= (long)_1 >> 1;
    int _r= (long)_2 >> 1;
    int _s= _l + _r;
    if ((1 & (long)_1) && ((_s ^ (_s << 1)) >= 0))  _1= (oop)(long)(_s << 1 | 1);  else _1= _sendv(s__2b, 2, _1, _2);
  }
  v_oldIndex= _1;
 }
 _l15:;
  _1= v_self;
  _2= v_oldIndex;
  _line(134);
  _1=_sendv(s_keyAt_, 2, _1, _2);
  v_element= _1;
  _2= v_nil;
  _1= (_1 == _2) ? v_true : v_false;
 }
  if (!_1) goto _l11;
  _1= 0;
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info32= { "keyAt:", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 140, 146, &__info30 };
static oop Set__keyAt_(oop v__closure, oop v_stateful_self, oop v_self, oop v_index)
 {
  _enter(&__info32);
  oop _1= 0;
  oop _2= 0;
  _line(140);
  _1= ((struct t_Set *)v_stateful_self)->v_array;
  _2= v_index;
  _line(143);
  _1=_sendv(s_at_, 2, _1, _2);
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info33= { "swap:with:", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 146, 152, &__info32 };
static oop Set__swap_with_(oop v__closure, oop v_stateful_self, oop v_self, oop v_oneIndex, oop v_otherIndex)
 {
  _enter(&__info33);
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  _line(146);
  _1= ((struct t_Set *)v_stateful_self)->v_array;
  _2= v_oneIndex;
  _3= v_otherIndex;
  _line(149);
  _1=_sendv(s_swap_with_, 3, _1, _2, _3);
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info36= { "[] do:", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 152, 157, &__info33 };
static oop b_36(oop v__closure, oop v__self, oop v_element)
 {
  _enter(&__info36);
  oop _1= 0;
  oop _2= 0;
  _line(154);
  /* ifFalse: */
  _1= 0;
  _2= v_element;
  _line(154);
  _2=_sendv(s_isNil, 1, _2);
  if (_2) goto _l16;
 {
  _1= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[1];  /* unaryBlock */
  _2= v_element;
  _line(154);
  _1=_sendv(s_value_, 2, _1, _2);
 }
 _l16:;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info34= { "do:", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 152, 157, &__info36 };
static oop Set__do_(oop v__closure, oop v_stateful_self, oop v_self, oop v_unaryBlock)
 {
  _enter(&__info34);
  oop _state1= _sendv(s_new_5f_, 2, v__vector, 2);
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  ((oop *)_state1)[1]= v_unaryBlock;
  _line(152);
  /* ifFalse: */
  _1= 0;
  _2= ((struct t_Set *)v_stateful_self)->v_tally;
  _3= l_35;
  if (1 & (long)_2) {
    _2= (((long)_2 == (long)_3) ? v_true : v_false);
  } else _2= _sendv(s__3d, 2, _2, _3);
  if (_2) goto _l17;
 {
  _1= ((struct t_Set *)v_stateful_self)->v_array;
  /* Scope('element'->ArgumentVariableNode) */
  /* Scope('array'->SlotVariableNode 'self'->ArgumentVariableNode 'tally'->SlotVariableNode 'unaryBlock'->ArgumentVariableNode 'stateful_self'->ArgumentVariableNode) */
  /* nil */
  /* 2 */
  /* 1 */
  _2= _sendv(s_function_5f_arity_5f_outer_state_nlr_5f_, 6, v_BlockClosure, (oop)b_36, 1, 0, ((oop *)_state1), 0);
  _line(154);
  _1=_sendv(s_do_, 2, _1, _2);
 }
 _l17:;
  _1= v_self;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info37= { "like:", "Set", "/Users/piumarta/src/idst/object/st80/Set.st", 0, 157, 163, &__info34 };
static oop Set__like_(oop v__closure, oop v_stateful_self, oop v_self, oop v_anObject)
 {
  _enter(&__info37);
  oop v_index= 0;
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  (void)v_index;
  _line(157);
  _1= v_self;
  _2= v_anObject;
  _line(160);
  _1=_sendv(s_scanFor_, 2, _1, _2);
  v_index= _1;
  /* ifFalse: */
  _1= 0;
  _2= v_index;
  _3= l_38;
  if (1 & (long)_2) {
    _2= (((long)_2 < (long)_3) ? v_true : v_false);
  } else _2= _sendv(s__3c, 2, _2, _3);
  if (_2) goto _l18;
 {
  _1= ((struct t_Set *)v_stateful_self)->v_array;
  _2= v_index;
  _line(161);
  _1=_sendv(s_at_, 2, _1, _2);
 }
 _l18:;
  _leave();
  return _1;
  _leave();
 }

static struct __methodinfo __info= { "__id__init__", "<initialisation>", "Set.st", 0, 0, 0, &__info37 };
void __id__init__Set(struct __libid *__libid)
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
  _enter(&__info);
  _libid->infos(&__info, &__info1);

  _sendv(s__5fimport_, 3, _libid->_object, "Collection", "__id__init__Collection");
  v__object= _libid->import("_object");
  v__vector= _libid->import("_vector");
  v_Object= _libid->import("Object");
  v_UndefinedObject= _libid->import("UndefinedObject");
  v_StaticBlockClosure= _libid->import("StaticBlockClosure");
  v_BlockClosure= _libid->import("BlockClosure");
  v_Magnitude= _libid->import("Magnitude");
  v_Number= _libid->import("Number");
  v_Integer= _libid->import("Integer");
  v_SmallInteger= _libid->import("SmallInteger");
  v_LargePositiveInteger= _libid->import("LargePositiveInteger");
  v_Collection= _libid->import("Collection");
  v_SequenceableCollection= _libid->import("SequenceableCollection");
  v_ArrayedCollection= _libid->import("ArrayedCollection");
  v_Array= _libid->import("Array");
  v_WordArray= _libid->import("WordArray");
  v_ByteArray= _libid->import("ByteArray");
  v_String= _libid->import("String");
  v_ImmutableString= _libid->import("ImmutableString");
  v_nil= _libid->import("nil");
  v_true= _libid->import("true");
  v_false= _libid->import("false");
  v_Set= _libid->proto2(v_Collection, Set___5fsizeof(0, 0));
  _libid->method(v_Set, s__5fsizeof, (_imp_t)Set___5fsizeof);
  _libid->method(v_Set, s__5fdebugName, (_imp_t)Set___5fdebugName);
  _libid->method(v_Set, s__5fslots, (_imp_t)Set___5fslots);
  _libid->export("Set", v_Set);
  l_2= _sendv(s_value_5f_, 2, v_SmallInteger, 2);
  _libid->method(v_Set, s_new, (_imp_t)Set__new);
  _libid->method(v_Set, s_new_, (_imp_t)Set__new_);
  l_5= _sendv(s_value_5f_, 2, v_SmallInteger, 0);
  _libid->method(v_Set, s_initialize_, (_imp_t)Set__initialize_);
  _libid->method(v_Set, s_size, (_imp_t)Set__size);
  l_8= _sendv(s_size_5f_value_5f_, 3, v_ImmutableString, 50, "Sets cannot meaningfully contain nil as an element");
  _libid->method(v_Set, s_add_, (_imp_t)Set__add_);
  l_10= _sendv(s_value_5f_, 2, v_SmallInteger, 0);
  l_11= _sendv(s_size_5f_value_5f_, 3, v_ImmutableString, 34, "there is no free space in this Set");
  _libid->method(v_Set, s_findElementOrNil_, (_imp_t)Set__findElementOrNil_);
  l_13= _sendv(s_value_5f_, 2, v_SmallInteger, 1);
  l_16= _sendv(s_value_5f_, 2, v_SmallInteger, 0);
  _libid->method(v_Set, s_scanFor_, (_imp_t)Set__scanFor_);
  l_18= _sendv(s_value_5f_, 2, v_SmallInteger, 1);
  _libid->method(v_Set, s_atNewIndex_put_, (_imp_t)Set__atNewIndex_put_);
  l_20= _sendv(s_value_5f_, 2, v_SmallInteger, 1);
  l_21= _sendv(s_value_5f_, 2, v_SmallInteger, 4);
  _libid->method(v_Set, s_fullCheck, (_imp_t)Set__fullCheck);
  _libid->method(v_Set, s_growSize, (_imp_t)Set__growSize);
  l_24= _sendv(s_value_5f_, 2, v_SmallInteger, 0);
  _libid->method(v_Set, s_grow, (_imp_t)Set__grow);
  l_27= _sendv(s_value_5f_, 2, v_SmallInteger, 1);
  _libid->method(v_Set, s_noCheckAdd_, (_imp_t)Set__noCheckAdd_);
  l_29= _sendv(s_value_5f_, 2, v_SmallInteger, 1);
  _libid->method(v_Set, s_remove_ifAbsent_, (_imp_t)Set__remove_ifAbsent_);
  l_31= _sendv(s_value_5f_, 2, v_SmallInteger, 1);
  _libid->method(v_Set, s_fixCollisionsFrom_, (_imp_t)Set__fixCollisionsFrom_);
  _libid->method(v_Set, s_keyAt_, (_imp_t)Set__keyAt_);
  _libid->method(v_Set, s_swap_with_, (_imp_t)Set__swap_with_);
  l_35= _sendv(s_value_5f_, 2, v_SmallInteger, 0);
  _libid->method(v_Set, s_do_, (_imp_t)Set__do_);
  l_38= _sendv(s_value_5f_, 2, v_SmallInteger, 1);
  _libid->method(v_Set, s_like_, (_imp_t)Set__like_);
  _leave();
}
