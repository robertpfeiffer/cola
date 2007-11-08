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

  Last edited: 2007-11-08 14:59:30 by piumarta on emilia.local
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

Object new			[ ^self _vtable _alloc: self _sizeof ]

" Object "

Object yourself			[ "^self" ]

Object identityHash		{ _return (oop)((long)self >> 3 | 1); }

Object = other			[ ^self == other ]
Object ~= other			[ ^(self = other) not ]

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

_vtable isKindOf:   family	[ ^self == family or: [delegate ~~ nil and: [delegate isKindOf: family]] ]
Object  isKindOf:   family	[ ^self _vtable isKindOf: family _vtable ]
Object  isMemberOf: family	[ ^self _vtable == family _vtable ]

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

Object ifTrue: aBlock			[ ^aBlock value ]
UndefinedObject ifTrue: aBlock		[ ^nil ]

Object ifFalse: aBlock			[ ^nil ]
UndefinedObject ifFalse: aBlock		[ ^aBlock value ]

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

Object perform: s
{
    struct __closure *c= _libid->bind(v_s, v_self);
    _return (c->method)((oop)c, v_self, v_self);
}

Object perform: s with: a
{
    struct __closure *c= _libid->bind(v_s, v_self);
    _return (c->method)((oop)c, v_self, v_self, v_a);
}

Object perform: s with: a with: b
{
    struct __closure *c= _libid->bind(v_s, v_self);
    _return (c->method)((oop)c, v_self, v_self, v_a, v_b);
}

Object perform: s with: a with: b with: c
{
    struct __closure *c= _libid->bind(v_s, v_self);
    _return (c->method)((oop)c, v_self, v_self, v_a, v_b, v_c);
}

Object perform: s with: a with: b with: c with: d
{
    struct __closure *c= _libid->bind(v_s, v_self);
    _return (c->method)((oop)c, v_self, v_self, v_a, v_b, v_c, v_d);
}

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
{ import: Association }
{ import: IdentityDictionary }
{ import: SlotDictionary }
{ import: MemoDictionary }
{ import: OrderedCollection }
{ import: File }
{ import: Stream }
{ import: Link }
{ import: LinkedList }
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

Object slotNameAt: index
[
    | _name |
    ^(_name := self _slotNameAt_: index _integerValue) ifTrue: [String value_: _name]
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
