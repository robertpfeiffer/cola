" _object.st -- essential behaviour and state required to support messaging

  Copyright (c) 2005 Ian Piumarta
  All rights reserved.

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the 'Software'),
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, provided that the above copyright notice(s) and this
  permission notice appear in all copies of the Software and that both the
  above copyright notice(s) and this permission notice appear in supporting
  documentation.

  THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.

  Last edited: 2007-04-22 19:58:09 by piumarta on emilia
"

{ external }

_object ()
  _selector : _object ( _size _elements )
  _assoc    : _object ( key value )
  _closure  : _object ( _method data )
  _vector   : _object ( _size "indexable..." )
  _vtable   : _object ( _tally bindings delegate )

_object   _vtable		[]	"answer the vtable for the receiver"
_vtable   _alloc: _size		[]	"answer a new object in the receiver's clone family"
_vtable   _delegated		[]	"answer a new clone family delegating to the receiver"
_object   _delegated		[]	"answer a new object in a new clone family delegating to the receiver's family"
_object   _beTagType		[]	"make the receiver's family be the implemention for tagged object pointers"
_object   _beNilType		[]	"make the receiver's family be the implemention for nil (zero) pointers"
_selector _import		[]	"answer the value named by the receiver in the global namespace"
_selector _export: anObject	[]	"export a value named by the receiver to the global namespace"
_selector _intern: _cString	[]	"answer a unique selector with the given name"
_object   _import: _libName	[]	"import (load and initialise) the named library (dynamic shared object file)"

_vtable methodAt: aSelector		"install aMethod as the response to sending aSelector"
        put:      aMethod		"to any member of the receiver's family, remembering"
	with:	  closureData	[]	"closureData in the vtable's closure.data field"

{ internal }

"Support for debugging and cloning."

_object   _debugName { return (oop)"_object";   }  _object   _sizeof { return (oop)sizeof(struct t__object  ); }
_selector _debugName { return (oop)"_selector"; }  _selector _sizeof { return (oop)sizeof(struct t__selector); }
_assoc    _debugName { return (oop)"_assoc";    }  _assoc    _sizeof { return (oop)sizeof(struct t__assoc   ); }
_closure  _debugName { return (oop)"_closure";  }  _closure  _sizeof { return (oop)sizeof(struct t__closure ); }
_vector   _debugName { return (oop)"_vector";   }  _vector   _sizeof { return (oop)sizeof(struct t__vector  ); }
_vtable   _debugName { return (oop)"_vtable";   }  _vtable   _sizeof { return (oop)sizeof(struct t__vtable  ); }

"Primitive error handling -- #doesNotUnderstand:"

_object doesNotUnderstand: aSelector
[
    self _typeName: self _debugName doesNotUnderstand: aSelector _stringValue
]

_object _typeName: _cName doesNotUnderstand: _cSelector
{
  fprintf(stderr, "%s does not understand '%s'\n", (char *)v__cName, (char *)v__cSelector);
  exit(1);
}

_selector size_: _stringSize value_: _stringValue
{
  char *buf= alloca((size_t)v__stringSize + 1);
  memcpy((void *)buf, (void *)v__stringValue, (size_t)v__stringSize);
  buf[(size_t)v__stringSize]= '\0';
  return _local_intern(buf);
}

_selector _stringValue
[
    ^_elements
]

"Compiler support: state vectors for free variables."

_vector new_: _newSize
{
  v_self= v_stateful_self= _alloc(v_self, sizeof(struct t__vector) + sizeof(oop) * (size_t)v__newSize);
  ((struct t__vector *)v_self)->v__size= v__newSize;
}

"Introspection"

_object _methodAt: aSelector
[
    ^(self _bind: aSelector) _method
]

_object _bind: aSelector
{
  return (oop)_local_bind(v_aSelector, self);
}

_closure _method	[ ^_method ]

_object performMethod_: _aMethod with: anArgument
{
    return ((_imp_t)v__aMethod)(0, v_stateful_self, v_self, v_anArgument);
}
