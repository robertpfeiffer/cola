/* generated by Id 1.1 at ,$ */
/* with the command: -I../stage1/ -c IdentityDictionary.st -o ../stage2/IdentityDictionary.o.c */

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

static oop s_new_5f_= 0;
static oop s_keys= 0;
static oop s_new_= 0;
static oop s_key= 0;
static oop s__5c_5c= 0;
static oop s_add_= 0;
static oop s_identityHash= 0;
static oop s__5fdebugName= 0;
static oop s_value_5f_= 0;
static oop s_function_5f_arity_5f_outer_state_nlr_5f_= 0;
static oop s__5fimport_= 0;
static oop s_or_= 0;
static oop s__5fslots= 0;
static oop s_to_do_= 0;
static oop s__2b= 0;
static oop s__2d= 0;
static oop s_ifTrue_= 0;
static oop s_at_= 0;
static oop s_size= 0;
static oop s_scanFor_= 0;
static oop s__3d_3d= 0;
static oop s__5fsizeof= 0;
static oop s_keysDo_= 0;
static struct _Selector { const char *name; oop *addr; } _Selectors[]= {
  { "new_:", &s_new_5f_ },
  { "keys", &s_keys },
  { "new:", &s_new_ },
  { "key", &s_key },
  { "\\\\", &s__5c_5c },
  { "add:", &s_add_ },
  { "identityHash", &s_identityHash },
  { "_debugName", &s__5fdebugName },
  { "value_:", &s_value_5f_ },
  { "function_:arity_:outer:state:nlr_:", &s_function_5f_arity_5f_outer_state_nlr_5f_ },
  { "_import:", &s__5fimport_ },
  { "or:", &s_or_ },
  { "_slots", &s__5fslots },
  { "to:do:", &s_to_do_ },
  { "+", &s__2b },
  { "-", &s__2d },
  { "ifTrue:", &s_ifTrue_ },
  { "at:", &s_at_ },
  { "size", &s_size },
  { "scanFor:", &s_scanFor_ },
  { "==", &s__3d_3d },
  { "_sizeof", &s__5fsizeof },
  { "keysDo:", &s_keysDo_ },
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
static oop l_2= 0;
static oop l_5= 0;
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
static oop v_LookupKey= 0;
static oop v_Dictionary= 0;
static oop v_IdentitySet= 0;
static oop v_IdentityDictionary= 0;
static size_t IdentityDictionary___5fsizeof(oop _closure, oop v_self) { return sizeof(struct t_IdentityDictionary); }
static char *IdentityDictionary___5fdebugName(oop _closure, oop v_self) { return "IdentityDictionary"; }
static struct __slotinfo *IdentityDictionary___5fslots(oop _closure, oop v_self) { static struct __slotinfo info[]= { { "tally", 0, 4 }, { "array", 4, 4 }, { 0, 0, 0 } };  return &info[0]; }
static struct __methodinfo __info3= { "[] scanFor:", "IdentityDictionary", "/Users/piumarta/src/idst/object/st80/IdentityDictionary.st", 0, 26, 47, 0 };
static oop b_3(oop v__closure, oop v__self, oop v_index)
 {
  _enter(&__info3);
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  _line(37);
  /* ifTrue: */
  _1= 0;
  /* or: */
  _2= ((struct t_IdentityDictionary *)((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[1])->v_array;  /* array */
  _3= v_index;
  _line(38);
  _2=_sendv(s_at_, 2, _2, _3);
  ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[2]= _2;  /* element */
  _3= v_nil;
  _2= (_2 == _3) ? v_true : v_false;
  if (_2) goto _l2;
 {
  _2= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[2];  /* element */
  _line(38);
  _2=_sendv(s_key, 1, _2);
  _3= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[3];  /* anObject */
  _2= (_2 == _3) ? v_true : v_false;
 }
 _l2:;
  if (!_2) goto _l1;
 {
  _1= v_index;
  _leave();
  return _libid->nlreturn(((struct t_BlockClosure *)v__self)->v__nlr, _1);
 }
 _l1:;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info4= { "[] scanFor:", "IdentityDictionary", "/Users/piumarta/src/idst/object/st80/IdentityDictionary.st", 0, 26, 47, &__info3 };
static oop b_4(oop v__closure, oop v__self, oop v_index)
 {
  _enter(&__info4);
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  _line(41);
  /* ifTrue: */
  _1= 0;
  /* or: */
  _2= ((struct t_IdentityDictionary *)((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[1])->v_array;  /* array */
  _3= v_index;
  _line(42);
  _2=_sendv(s_at_, 2, _2, _3);
  ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[2]= _2;  /* element */
  _3= v_nil;
  _2= (_2 == _3) ? v_true : v_false;
  if (_2) goto _l4;
 {
  _2= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[2];  /* element */
  _line(42);
  _2=_sendv(s_key, 1, _2);
  _3= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[3];  /* anObject */
  _2= (_2 == _3) ? v_true : v_false;
 }
 _l4:;
  if (!_2) goto _l3;
 {
  _1= v_index;
  _leave();
  return _libid->nlreturn(((struct t_BlockClosure *)v__self)->v__nlr, _1);
 }
 _l3:;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info1= { "scanFor:", "IdentityDictionary", "/Users/piumarta/src/idst/object/st80/IdentityDictionary.st", 0, 26, 47, &__info4 };
static oop IdentityDictionary__scanFor_(oop v__closure, oop v_stateful_self, oop v_self, oop v_anObject)
 {
  _enter(&__info1);
  oop _state1= _sendv(s_new_5f_, 2, v__vector, 6);
  oop v_start= 0;
  oop v_finish= 0;
  oop _1= 0;
  oop _2= 0;
  oop _3= 0;
  jmp_buf __nlr;
  oop _nlr;
  (void)v_start;
  (void)v_finish;
  ((oop *)_state1)[1]= v_stateful_self;
  ((oop *)_state1)[3]= v_anObject;
  _nlr= (oop)&__nlr;
  if (setjmp(__nlr)) { return _libid->nlresult(); }
  _line(26);
  _1= ((oop *)_state1)[3];  /* anObject */
  _line(34);
  _1=_sendv(s_identityHash, 1, _1);
  _2= ((struct t_IdentityDictionary *)((oop *)_state1)[1])->v_array;  /* array */
  _line(34);
  _2=_sendv(s_size, 1, _2);
  _1= _sendv(s__5c_5c, 2, _1, _2);
  _2= l_2;
  {
    int _l= (long)_1 >> 1;
    int _r= (long)_2 >> 1;
    int _s= _l + _r;
    if ((1 & (long)_1) && ((_s ^ (_s << 1)) >= 0))  _1= (oop)(long)(_s << 1 | 1);  else _1= _sendv(s__2b, 2, _1, _2);
  }
  v_start= _1;
  _1= ((struct t_IdentityDictionary *)((oop *)_state1)[1])->v_array;  /* array */
  _line(35);
  _1=_sendv(s_size, 1, _1);
  v_finish= _1;
  _1= v_start;
  _2= v_finish;
  /* Scope('index'->ArgumentVariableNode) */
  /* Scope('finish'->TemporaryVariableNode 'element'->TemporaryVariableNode 'tally'->SlotVariableNode 'start'->TemporaryVariableNode 'stateful_self'->ArgumentVariableNode 'array'->SlotVariableNode 'self'->ArgumentVariableNode 'anObject'->ArgumentVariableNode) */
  /* nil */
  /* 2 */
  /* 1 */
  _3= _sendv(s_function_5f_arity_5f_outer_state_nlr_5f_, 6, v_BlockClosure, (oop)b_3, 1, 0, ((oop *)_state1), _nlr);
  _line(37);
  _1=_sendv(s_to_do_, 3, _1, _2, _3);
  _1= l_2;
  _2= v_start;
  _3= l_2;
  {
    int _l= (long)_2 >> 1;
    int _r= (long)_3 >> 1;
    int _s= (_l - _r);
    if ((1 & (long)_2) && ((_s ^ (_s << 1)) >= 0))  _2= (oop)(long)(_s << 1 | 1);  else _2= _sendv(s__2d, 2, _2, _3);
  }
  /* Scope('index'->ArgumentVariableNode) */
  /* Scope('finish'->TemporaryVariableNode 'element'->TemporaryVariableNode 'tally'->SlotVariableNode 'start'->TemporaryVariableNode 'stateful_self'->ArgumentVariableNode 'array'->SlotVariableNode 'self'->ArgumentVariableNode 'anObject'->ArgumentVariableNode) */
  /* nil */
  /* 2 */
  /* 1 */
  _3= _sendv(s_function_5f_arity_5f_outer_state_nlr_5f_, 6, v_BlockClosure, (oop)b_4, 1, 0, ((oop *)_state1), _nlr);
  _line(41);
  _1=_sendv(s_to_do_, 3, _1, _2, _3);
  _1= l_5;
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info7= { "[] keys", "IdentityDictionary", "/Users/piumarta/src/idst/object/st80/IdentityDictionary.st", 0, 47, 54, &__info1 };
static oop b_7(oop v__closure, oop v__self, oop v_key)
 {
  _enter(&__info7);
  oop _1= 0;
  oop _2= 0;
  _line(51);
  _1= ((oop *)((struct t_BlockClosure *)((struct t_BlockClosure *)v__self)->v_state))[1];  /* keySet */
  _2= v_key;
  _line(51);
  _1=_sendv(s_add_, 2, _1, _2);
  _leave();
  return _1;
  _leave();
 }
static struct __methodinfo __info6= { "keys", "IdentityDictionary", "/Users/piumarta/src/idst/object/st80/IdentityDictionary.st", 0, 47, 54, &__info7 };
static oop IdentityDictionary__keys(oop v__closure, oop v_stateful_self, oop v_self)
 {
  _enter(&__info6);
  oop _state1= _sendv(s_new_5f_, 2, v__vector, 2);
  oop _1= 0;
  oop _2= 0;
  _line(47);
  _1= v_IdentitySet;
  _2= v_self;
  _line(50);
  _2=_sendv(s_size, 1, _2);
  _line(50);
  _1=_sendv(s_new_, 2, _1, _2);
  ((oop *)_state1)[1]= _1;  /* keySet */
  _1= v_self;
  /* Scope('key'->ArgumentVariableNode) */
  /* Scope('keySet'->TemporaryVariableNode 'self'->ArgumentVariableNode 'tally'->SlotVariableNode 'stateful_self'->ArgumentVariableNode 'array'->SlotVariableNode) */
  /* nil */
  /* 2 */
  /* 1 */
  _2= _sendv(s_function_5f_arity_5f_outer_state_nlr_5f_, 6, v_BlockClosure, (oop)b_7, 1, 0, ((oop *)_state1), 0);
  _line(51);
  _1=_sendv(s_keysDo_, 2, _1, _2);
  _1= ((oop *)_state1)[1];  /* keySet */
  _leave();
  return _1;
  _leave();
 }

static struct __methodinfo __info= { "__id__init__", "<initialisation>", "IdentityDictionary.st", 0, 0, 0, &__info6 };
void __id__init__IdentityDictionary(struct __libid *__libid)
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
  _libid->infos(&__info, &__info3);

  _sendv(s__5fimport_, 3, _libid->_object, "Dictionary", "__id__init__Dictionary");
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
  v_Set= _libid->import("Set");
  v_LookupKey= _libid->import("LookupKey");
  v_Dictionary= _libid->import("Dictionary");
  _sendv(s__5fimport_, 3, _libid->_object, "IdentitySet", "__id__init__IdentitySet");
  v_IdentitySet= _libid->import("IdentitySet");
  v_IdentityDictionary= _libid->proto2(v_Dictionary, IdentityDictionary___5fsizeof(0, 0));
  _libid->method(v_IdentityDictionary, s__5fsizeof, (_imp_t)IdentityDictionary___5fsizeof);
  _libid->method(v_IdentityDictionary, s__5fdebugName, (_imp_t)IdentityDictionary___5fdebugName);
  _libid->method(v_IdentityDictionary, s__5fslots, (_imp_t)IdentityDictionary___5fslots);
  _libid->export("IdentityDictionary", v_IdentityDictionary);
  l_2= _sendv(s_value_5f_, 2, v_SmallInteger, 1);
  l_5= _sendv(s_value_5f_, 2, v_SmallInteger, 0);
  _libid->method(v_IdentityDictionary, s_scanFor_, (_imp_t)IdentityDictionary__scanFor_);
  _libid->method(v_IdentityDictionary, s_keys, (_imp_t)IdentityDictionary__keys);
  _leave();
}
