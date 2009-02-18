" Object.st -- behaviour common to all objects

  Copyright (c) 2006, 2007 Ian Piumarta
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

  Last edited: 2009-02-18 04:07:53 by piumarta on emilia.local
"

{ import: Objects }
{ include "tag.h" }


[ Object := _object ]	"alias"
[ Symbol := _selector ]	"alias"

[ UndefinedObject _beNilType ]
[ SmallInteger    _beTagType ]

" literals "

SmallInteger value_: _value		{ _return _O(v__value); }
SmallInteger _integerValue		{ _return (oop)_I(v_self); }

ByteArray size_: _size value_: _value
[
    self := self new.
    size := SmallInteger value_: _size.
    _bytes := _value.
]

Object new			[ | _vt | { v__vt= (oop)self->_vtable[-1]; }.  ^_vt _alloc: self _sizeof ]

Object shallowCopy
[
    | copy _size |
    copy := self new.
    _size := self _sizeof.
    { memcpy(v_copy, v_self, (long)v__size); }.
    ^copy
]

" Object "

Object yourself			[ "^self" ]

Object identityHash		{ _return (oop)((long)self >> 3 | 1); }

Object = other			[ ^self == other ]
Object ~= other			[ ^(self = other) not ]
Object == other			[ ^self == other ]
Object ~~ other			[ ^self ~~ other ]

Object _palloc: size		{ _return (oop)_libid->palloc(sizeof(oop) * _I(v_size)); }
Object _balloc: size		{ _return (oop)_libid->balloc(              _I(v_size)); }

UndefinedObject _nil		{ _return 0; }

[ nil   := UndefinedObject _nil ]		{ pragma: type nil   nil   }
[ true  := Object ]				{ pragma: type true  true  }
[ false := nil ]				{ pragma: type false false }

UndefinedObject not		[ ^true ]
Object not			[ ^false ]

UndefinedObject isNil		[ ^true ]
Object isNil			[ ^false ]

UndefinedObject notNil		[ ^false ]
Object notNil			[ ^true ]

UndefinedObject | nilOrObject   [ ^nilOrObject ]
Object		| nilOrObject   [ ^true ]

UndefinedObject & nilOrObject   [ ^true ]
Object		& nilOrObject   [ ^nilOrObject ]

_vtable isKindOf:   family	[ ^self == family or: [delegate ~~ nil and: [delegate isKindOf: family]] ]
Object  isKindOf:   family	[ ^self _vtable isKindOf: family _vtable ]
Object  isMemberOf: family	[ ^self _vtable == family _vtable ]

Object respondsTo: aSelector	[ ^self _vtable lookup: aSelector ]

Object debugName			[ ^String value_: self _debugName ]
Object printOn: aStream			[ ^aStream nextPutAll: self debugName ]
UndefinedObject printOn: aStream	[ ^aStream nextPutAll: 'nil' ]

Object printString
[
    | stream |
    stream := WriteStream on: (String new: 8).
    self printOn: stream.
    ^stream contents
]

Object ifNil: nilBlock			[ ^self ]
UndefinedObject ifNil: nilBlock		[ ^nilBlock value ]

Object ifNotNil: notNilBlock		[ ^notNilBlock value ]
UndefinedObject ifNotNil: notNilBlock	[ ^nil ]

Object		ifNil: nilBlock ifNotNil: notNilBlock	[ ^notNilBlock value ]
UndefinedObject ifNil: nilBlock ifNotNil: notNilBlock	[ ^nilBlock value ]

Object ifTrue: aBlock			[ ^aBlock value ]
UndefinedObject ifTrue: aBlock		[ ^nil ]

Object ifFalse: aBlock			[ ^nil ]
UndefinedObject ifFalse: aBlock		[ ^aBlock value ]

Object ifTrue: aBlock ifFalse: bBlock		[ ^aBlock value ]
UndefinedObject ifTrue: aBlock ifFalse: bBlock	[ ^bBlock value ]

Object ifFalse: aBlock ifTrue: bBlock		[ ^bBlock value ]
UndefinedObject ifFalse: aBlock ifTrue: bBlock	[ ^aBlock value ]

Object abort		{ abort(); }
Object exit		{ exit(0); }

Object backtrace
{
    fputs(_backtrace(), stderr);
}

Object halt
[
    StdErr cr.
    StdErr backtrace.
    StdErr cr; nextPutAll: 'halt'; cr.
    { exit(1); }.
]

Object perform: s					{ _return(_sendv(v_s, 1, v_self)); }
Object perform: s with: a				{ _return(_sendv(v_s, 2, v_self, v_a)); }
Object perform: s with: a with: b			{ _return(_sendv(v_s, 3, v_self, v_a, v_b)); }
Object perform: s with: a with: b with: c		{ _return(_sendv(v_s, 4, v_self, v_a, v_b, v_c)); }
Object perform: s with: a with: b with: c with: d	{ _return(_sendv(v_s, 5, v_self, v_a, v_b, v_c, v_d)); }

Object error: reason
[
    StdErr cr.
    StdErr backtrace.
    StdErr cr; nextPutAll: reason; cr.
    { exit(1); }.
]

Object shouldNotImplement: aSelector
[
    StdErr cr.
    StdErr backtrace.
    StdErr cr; nextPutAll: self debugName; nextPutAll: ' should not implement '; print: aSelector; cr.
    { exit(1); }.
]

Object subtypeResponsibility: aSelector
[
    StdErr cr.
    StdErr backtrace.
    StdErr cr; nextPutAll: self debugName; nextPutAll: ' did not override '; print: aSelector; cr.
    { exit(1); }.
]

Object errorOutOfBounds: anIndex
[
    StdErr cr.
    StdErr backtrace.
    StdErr cr;
	print: anIndex; nextPutAll: ' is out of bounds in ';
	nextPutAll: self debugName; nextPut: $(; print: self size; nextPut: $);
	cr.
    { exit(1); }.
]

Object errorKeyNotFound: aKey
[
    StdErr cr.
    StdErr backtrace.
    StdErr cr;
	print: aKey; nextPutAll: ' is not a key in ';
	nextPutAll: self debugName;
	cr.
    { exit(1); }.
]

{ import: SmallInteger }
{ import: String }
{ import: Symbol }
{ import: BlockClosure }
{ import: Collection }
{ import: SequenceableCollection }
{ import: ArrayedCollection }
{ import: Array }
{ import: ByteArray }
{ import: IdentitySet }
{ import: Set }
{ import: Association }
{ import: IdentityDictionary }
{ import: Dictionary }
{ import: SlotDictionary }
{ import: MemoDictionary }
{ import: OrderedCollection }
{ import: File }
{ import: Stream }
{ import: Link }
{ import: LinkedList }
{ import: Magnitude }
{ import: Number }
{ import: OS }
{ import: Function }
{ import: Time }
{ import: Date }
{ import: Random }

{ import: deprecated }

[ StdIn  := SharedFile	withFd: 0 name: '<stdin>'  ]
[ StdOut := File	withFd: 1 name: '<stdout>' ]
[ StdErr := File	withFd: 2 name: '<stderr>' ]

Object print		[ StdOut print: self ]
Object println		[ StdOut print: self; cr ]
SmallInteger put	[ StdOut nextPut: self ]
SmallInteger putln	[ StdOut nextPut: self; cr ]
String put		[ StdOut nextPutAll: self ]
String putln		[ StdOut nextPutAll: self; cr ]

PerformSelectors := [
    #(	perform:with0arguments:	perform:with1arguments:	perform:with2arguments:	perform:with3arguments:
	perform:with4arguments:	perform:with5arguments:	perform:with6arguments:	perform:with7arguments:
	perform:with8arguments: )
]

Object perform: s withArguments: a	[ ^self perform: (PerformSelectors at: a size) with: s with: a ]

Object perform: s with0arguments: a	[ ^self perform: s ]
Object perform: s with1arguments: a	[ ^self perform: s with: (a at: 0) ]
Object perform: s with2arguments: a	[ ^self perform: s with: (a at: 0) with: (a at: 1) ]
Object perform: s with3arguments: a	[ ^self perform: s with: (a at: 0) with: (a at: 1) with: (a at: 2) ]
Object perform: s with4arguments: a	[ ^self perform: s with: (a at: 0) with: (a at: 1) with: (a at: 2) with: (a at: 3) ]
Object perform: s with5arguments: a	[ ^self perform: s with: (a at: 0) with: (a at: 1) with: (a at: 2) with: (a at: 3) with: (a at: 4) ]
Object perform: s with6arguments: a	[ ^self perform: s with: (a at: 0) with: (a at: 1) with: (a at: 2) with: (a at: 3) with: (a at: 4) with: (a at: 5) ]
Object perform: s with7arguments: a	[ ^self perform: s with: (a at: 0) with: (a at: 1) with: (a at: 2) with: (a at: 3) with: (a at: 4) with: (a at: 5) with: (a at: 6) ]
Object perform: s with8arguments: a	[ ^self perform: s with: (a at: 0) with: (a at: 1) with: (a at: 2) with: (a at: 3) with: (a at: 4) with: (a at: 5) with: (a at: 6) with: (a at: 7) ]

{ import: ProfiledMethod }

Object slotNameAt: index
[
    | _name |
    ^(_name := self _slotNameAt_: index _integerValue) ifTrue: [Symbol intern_: _name]
]

Object _slotNameAt_: _index
[
    | _slots |
    _slots := self _slots.
    {
	long index= (long)v__index;
	struct __slotinfo *info= (struct __slotinfo *)v__slots;
	return (oop)(info[index].name);
    }
]

Object slotOffsetAt: index	[ ^SmallInteger value_: (self _slotOffsetAt_: index _integerValue) ]

Object _slotOffsetAt_: _index
[
    | _slots |
    _slots := self _slots.
    {
	long index= (long)v__index;
	struct __slotinfo *info= (struct __slotinfo *)v__slots;
	return (oop)(info[index].offset);
    }
]

Object slotSizeAt: index	[ ^SmallInteger value_: (self _slotSizeAt_: index _integerValue) ]

Object _slotSizeAt_: _index
[
    | _slots |
    _slots := self _slots.
    {
	long index= (long)v__index;
	struct __slotinfo *info= (struct __slotinfo *)v__slots;
	return (oop)(info[index].size);
    }
]

Object slots
[
    | index slots name |
    index := 0.
    slots := IdentityDictionary new.
    [name := self slotNameAt: index]
	whileTrue:
	   [slots at: name put: ((self slotOffsetAt: index) -> (self slotSizeAt: index)).
	    index := index + 1].
    ^slots
]

Object allSlotNames
[
    | index slots name |
    index := 0.
    slots := OrderedCollection new.
    [name := self slotNameAt: index]
	whileTrue:
	   [slots add: name.
	    index := index + 1].
    ^slots asArray
]

Object _oopAt: index
{
    long index= (long)v_index >> 1;
    return ((oop *)(v_self))[index];
}

Object _slotAt: index put: anObject
{
    long index= (long)v_index >> 1;
    return ((oop *)(v_self))[index]= v_anObject;
}



_object _vtable: aVtable	{ _return (((oop *)self)[-1]= v_aVtable); }

_object _delegated		[ ^self _vtable delegated _alloc: self _sizeof ]

_vtable bindings		[ ^bindings ]
_vtable delegate: aVtable	[ delegate := aVtable ]

_vtable copy: selectors from: aVtable
[
    selectors do: [:sel | self methodAt: sel put: (aVtable lookup: sel)	value _method with: nil ]
]

_vtable _clone		[ ^self _vtable _alloc: self _sizeof ]
_vtable _clone: size	[ ^self _vtable _alloc: size _integerValue ]
_vtable new		[ ^self _clone init ]

_vtable copyEmpty
[
    ^self new copyEmpty: self
]

_vtable copyEmpty: aVT
[
    self
	delegate: aVT delegate;
	copy: #(_sizeof _debugName _slots) from: aVT
]

"----------------------------------------------------------------"

String putEscaped	[ self do: [:c | c putEscaped] ]

SmallInteger putEscaped
[
    self == $\\			ifTrue: [^'\\\\' put].
    self == $'			ifTrue: [^'\\''' put].
    (self between: 32 and: 126)	ifTrue: [^self put].
    $\\ put.
    (self // 64 \\ 8 + $0) put.
    (self //  8 \\ 8 + $0) put.
    (self       \\ 8 + $0) put.
]

String escaped
[
    | out |
    out := WriteStream on: (self new: self size * 2).
    self do: [:c |
	(c < 32 or: [c == 127])
	    ifTrue:  [out nextPut: $\\; print: c base: 8 width: 3]
	    ifFalse: [out nextPut: c]].
    ^out contents
]

StringEscapes := [ IdentityDictionary new
	at: $a  put: $\a; "bel"
	at: $b  put: $\b; "bs"
	at: $e  put: $\e; "esc"
	at: $f  put: $\f; "ff"
	at: $n  put: $\n; "nl"
	at: $r  put: $\r; "cr"
	at: $t  put: $\t; "ht"
	at: $v  put: $\v; "vt"
	yourself
]

String unescaped
[
    | in out c d |
    in := self readStream.
    out := WriteStream on: (self new: self size).
    [in atEnd]
	whileFalse:
	   [(c := in next) == $\\
		ifTrue:
		   [((c := in next) between: $0 and: $7)
			ifTrue:
			    [d := c digitValue.
			     ((c := in peek) between: $0 and: $7) ifTrue: [in next.  d := d * 8 + c digitValue].
			     ((c := in peek) between: $0 and: $7) ifTrue: [in next.  d := d * 8 + c digitValue].
			     out nextPut: d]
			ifFalse:
			    [(d := StringEscapes at: c ifAbsent: [])
				 ifTrue:  [out nextPut: d]
				 ifFalse: [out nextPut: c]]]
		ifFalse: [out nextPut: c]].
    ^out contents
]

