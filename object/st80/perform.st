" perform.st -- explicit message sends

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

  Last edited: 2008-02-14 08:41:11 by piumarta on emilia
"

{ import: Symbol }
{ import: IdentityDictionary }


SelectorTable : IdentityDictionary ()
[
    SelectorTable := SelectorTable new
]

SelectorTable at: aSymbol
[
    ^self at: aSymbol ifAbsent: [self at: aSymbol put: (_selector size_: aSymbol _size value_: aSymbol _stringValue)]
]

Symbol asSelector
[
    ^SelectorTable at: self
]

Object respondsTo: aSymbol
[
    ^nil ~~ (self _vtable findKeyOrNil: (SelectorTable at: aSymbol))
]

Object perform: aSymbol						[ ^self _perform: (SelectorTable at: aSymbol) ]
Object perform: aSymbol with: a					[ ^self _perform: (SelectorTable at: aSymbol) w: a ]
Object perform: aSymbol with: a with: b				[ ^self _perform: (SelectorTable at: aSymbol) w: a w: b ]
Object perform: aSymbol with: a with: b with: c			[ ^self _perform: (SelectorTable at: aSymbol) w: a w: b w: c ]
Object perform: aSymbol with: a with: b with: c with: d		[ ^self _perform: (SelectorTable at: aSymbol) w: a w: b w: c w: d ]
Object perform: aSymbol with: a with: b with: c with: d with: e	[ ^self _perform: (SelectorTable at: aSymbol) w: a w: b w: c w: d w: e ]

Object _perform: s
{
#ifdef _sendv
# define V_SEND (struct __send *)v__closure
#else
# define V_SEND v__closure
#endif
#ifdef STAGE1
# define V_SELF v_self
#else
# define V_SELF v_self, v_self
#endif
  struct __closure *c= _libid->bind(v_s, v_self);
  return (c->method)(V_SEND, V_SELF);
}

Object _perform: s w: a				{ struct __closure *c= _libid->bind(v_s, v_self);  return (c->method)(V_SEND, V_SELF, v_a); }
Object _perform: s w: a w: b			{ struct __closure *c= _libid->bind(v_s, v_self);  return (c->method)(V_SEND, V_SELF, v_a, v_b); }
Object _perform: s w: a w: b w: c		{ struct __closure *c= _libid->bind(v_s, v_self);  return (c->method)(V_SEND, V_SELF, v_a, v_b, v_c); }
Object _perform: s w: a w: b w: c w: d		{ struct __closure *c= _libid->bind(v_s, v_self);  return (c->method)(V_SEND, V_SELF, v_a, v_b, v_c, v_d); }
Object _perform: s w: a w: b w: c w: d w: e	{ struct __closure *c= _libid->bind(v_s, v_self);  return (c->method)(V_SEND, V_SELF, v_a, v_b, v_c, v_d, v_e); }

Object in: aType perform: aSymbol	[ ^self in: aType _perform: (SelectorTable at: aSymbol) ]
Object in: aType  perform: s with: a	[ ^self in: aType _perform: (SelectorTable at: s) with: a ]

Object in: aType _perform: s		{ struct __closure *c= _libid->bind(v_s, v_aType);  return (c->method)(V_SEND, V_SELF); }

Object in: aType _perform: s with: a	{ struct __closure *c= _libid->bind(v_s, v_aType);  return (c->method)(V_SEND, V_SELF, v_a); }

PerformWithArgumentsSelectors : Array ()
[
    PerformWithArgumentsSelectors :=
	#( perform:with0Arguments:
	   perform:with1Arguments:
	   perform:with2Arguments:
	   perform:with3Arguments:
	   perform:with4Arguments:
	   perform:with5Arguments: ).
]

Object perform: aSymbol withArguments: arguments
[
    | size |
    ^((size := arguments size) < 6)
	ifTrue:  [self perform: (PerformWithArgumentsSelectors at: 1 + size) with: aSymbol with: arguments]
	ifFalse: [self error: 'perform:withArguments: does not support more than 5 arguments']
]

Object perform: aSymbol with0Arguments: arguments	[ ^self perform: aSymbol ]
Object perform: aSymbol with1Arguments: arguments	[ ^self perform: aSymbol with: (arguments at: 1) ]
Object perform: aSymbol with2Arguments: arguments	[ ^self perform: aSymbol with: (arguments at: 1) with: (arguments at: 2) ]
Object perform: aSymbol with3Arguments: arguments	[ ^self perform: aSymbol with: (arguments at: 1) with: (arguments at: 2) with: (arguments at: 3) ]
Object perform: aSymbol with4Arguments: arguments	[ ^self perform: aSymbol with: (arguments at: 1) with: (arguments at: 2) with: (arguments at: 3)
										 with: (arguments at: 4) ]
Object perform: aSymbol with5Arguments: arguments	[ ^self perform: aSymbol with: (arguments at: 1) with: (arguments at: 2) with: (arguments at: 3)
										 with: (arguments at: 4) with: (arguments at: 5) ]
