{ import: Objects }
{ include "tag.h" }

[ Object := _object ]	"alias"
[ Symbol := _selector ]	"alias"

[ UndefinedObject _beNilType ]
[ SmallInteger    _beTagType ]

" literals "

SmallInteger value_: _value		{ return _O(v__value); }
SmallInteger _integerValue		{ return (oop)_I(v_self); }

ByteArray size_: _size value_: _value
[
    self := self new.
    size := SmallInteger value_: _size.
    _bytes := _value.
]

" Object "

Object new			[ ^self _vtable _alloc: self _sizeof ]

Object yourself			[ "^self" ]

Object identityHash		{ return (oop)((long)self >> 3 | 1); }

Object = other			[ ^self == other ]

Object _palloc: size		{ return (oop)_palloc(sizeof(oop) * _I(v_size)); }
Object _balloc: size		{ return (oop)_balloc(              _I(v_size)); }

UndefinedObject _nil		{ return 0; }

[ nil   := UndefinedObject _nil ]		{ pragma: type nil   nil   }
[ true  := Object ]				{ pragma: type true  true  }
[ false := nil ]				{ pragma: type false false }

UndefinedObject not		[ ^true ]
Object not			[ ^false ]

UndefinedObject isNil		[ ^true ]
Object isNil			[ ^false ]

UndefinedObject notNil		[ ^false ]
Object notNil			[ ^true ]

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
Object halt		[ StdErr cr; nextPutAll: 'halt'; cr.  { exit(1); } ]

Object perform: s
{
    struct __closure *c= _local_bind(v_s, v_self);
    return (c->method)((oop)c, v_self, v_self);
}

Object perform: s with: a
{
    struct __closure *c= _local_bind(v_s, v_self);
    return (c->method)((oop)c, v_self, v_self, v_a);
}

Object perform: s with: a with: b
{
    struct __closure *c= _local_bind(v_s, v_self);
    return (c->method)((oop)c, v_self, v_self, v_a, v_b);
}

Object perform: s with: a with: b with: c
{
    struct __closure *c= _local_bind(v_s, v_self);
    return (c->method)((oop)c, v_self, v_self, v_a, v_b, v_c);
}

Object perform: s with: a with: b with: c with: d
{
    struct __closure *c= _local_bind(v_s, v_self);
    return (c->method)((oop)c, v_self, v_self, v_a, v_b, v_c, v_d);
}

Object error: reason
[
    StdErr cr; nextPutAll: reason; cr.
    { exit(1); }.
]

Object shouldNotImplement: aSelector
[
    StdErr cr; nextPutAll: self debugName; nextPutAll: ' should not implement '; print: aSelector; cr.
    { exit(1); }.
]

Object errorOutOfBounds: anIndex
[
    StdErr cr;
	print: anIndex; nextPutAll: ' is out of bounds in ';
	nextPutAll: self debugName; nextPut: $(; print: self size; nextPut: $);
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
