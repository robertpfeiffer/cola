" Object.st -- behaviour common to all objects

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

  Last edited: 2008-02-13 14:09:51 by piumarta on emilia
"

{ import: _object }

"Bring up minimal kernel types for compiler literals and debugging."

Object ()
  UndefinedObject : Object ()
  StaticBlockClosure : Object ( _function _arity )		{ pragma: type staticClosure StaticBlockClosure }
    BlockClosure : StaticBlockClosure ( outer state _nlr )	{ pragma: type fullClosure BlockClosure }
  Magnitude : Object ()
    Character : Magnitude ( value )				{ pragma: type character Character }
    Number : Magnitude ()
      Fraction : Number ( numerator denominator )
      Float : Number ()						{ pragma: type float Float }
      Integer : Number ()
        SmallInteger : Integer ()				{ pragma: type integer SmallInteger }
        LargePositiveInteger : Integer ( bytes )		{ pragma: type largePositiveInteger LargePositiveInteger }
          LargeNegativeInteger : LargePositiveInteger ()	{ pragma: type largeNegativeInteger LargeNegativeInteger }
  Collection : Object ()
    SequenceableCollection : Collection ()
      ArrayedCollection : SequenceableCollection ( size )
        Array : ArrayedCollection ( _pointers )
          ImmutableArray : Array ()				{ pragma: type objectArray ImmutableArray }
        WordArray : ArrayedCollection ( _words )
          ImmutableWordArray : WordArray ()			{ pragma: type wordArray ImmutableWordArray }
        ByteArray : ArrayedCollection ( _bytes )
          ImmutableByteArray : ByteArray ()			{ pragma: type byteArray ImmutableByteArray }
          String  : ByteArray ()
            ImmutableString  : String ()			{ pragma: type string ImmutableString }
              Symbol : ImmutableString ()			{ pragma: type symbol Symbol }

Object _nil { return 0; }

nil   : UndefinedObject ()	[ nil   := Object _nil ]	{ pragma: type nil   nil   }
true  : Object ()		[ true  := Object ]		{ pragma: type true  true  }
false : Object ()		[ false := nil ]		{ pragma: type false false }

[ UndefinedObject _beNilType ]
[ SmallInteger    _beTagType ]

Object _clone		[ ^self _vtable _alloc: self _sizeof ]
Object _clone: size	[ ^self _vtable _alloc: size _integerValue ]

Object new		[ ^self _clone initialize ]
Object initialize	[]

Object _newPointers: anInteger	{ return (oop)_libid->palloc(((size_t)v_anInteger >> 1) * sizeof(oop)); }
Object _newWords: anInteger	{ return (oop)_libid->balloc(((size_t)v_anInteger >> 1) * sizeof(int)); }
Object _newBytes: anInteger	{ return (oop)_libid->balloc(((size_t)v_anInteger >> 1) * sizeof(char)); }

SmallInteger value_: _int	{ return (oop)((((int)v__int) << 1) | 1); }
SmallInteger _integerValue	{ return (oop)(((int)self) >> 1); }

SmallInteger print		{ return (oop)(fprintf(stdout, "%d", (int)self >> 1) << 1 | 1); }

Object yourself	[]

"The following are needed early to initialise the Character table."

StaticBlockClosure function_: _implementationAddress arity_: _argumentCount
[
    {
#     ifndef STAGE1
	v_stateful_self=
#     endif
	v_self= _libid->alloc(v_self, sizeof(*self));
    }.
    _arity    := _argumentCount.
    _function := _implementationAddress.
]

BlockClosure function_: _implementationAddress arity_: _argumentCount
	     outer: outerBlock state: variableArray nlr_: _dynamicEnvironment
[
    {
#     ifndef STAGE1
	v_stateful_self=
#     endif
	v_self= _libid->alloc(v_self, sizeof(*self));
    }.
    _function := _implementationAddress.
    _arity    := _argumentCount.
    outer     := outerBlock.
    state     := variableArray.
    _nlr      := _dynamicEnvironment.
]

StaticBlockClosure value
[
    { if ((int)self->v__arity == 0) return ((_imp_t)(self->v__function))(0, v_self); }.
    ^self errorArgumentCount: 0
]

StaticBlockClosure value: a
[
    { if ((int)self->v__arity == 1) return ((_imp_t)(self->v__function))(0, v_self, v_a); }.
    ^self errorArgumentCount: 1
]

StaticBlockClosure errorArgumentCount: actual
{
    printf("block %p expected %ld args, invoked with %ld\n", self, (long)self->v__arity, (long)v_actual >> 1);
    abort();
}

ArrayedCollection new: anInteger
[
    ^super new initialize: anInteger
]

Collection initialize: anInteger []

ArrayedCollection initialize: anInteger
[
    super initialize: anInteger.
    size := anInteger.
]

Array initialize: anInteger
[
    super initialize: anInteger.
    _pointers := self _newPointers: anInteger
]

Array at: anInteger put: anObject
[
    { if (((int)v_anInteger & 1) && ((int)v_anInteger > 1) && ((int)v_anInteger <= (int)self->v_size))
        return ((oop *)self->v__pointers)[((int)v_anInteger >> 1) - 1]= v_anObject; }.
    ^self primitiveFailed
]

Array at: anInteger
[
    { if (((int)v_anInteger & 1) && ((int)v_anInteger > 1) && ((int)v_anInteger <= (int)self->v_size))
        return ((oop *)self->v__pointers)[((int)v_anInteger >> 1) - 1]; }.
    ^self primitiveFailed
]

ByteArray size_: _size value_: _value	"ByteArray and String constructor"
[
    self := self _clone.
    size := SmallInteger value_: _size.
    _bytes := _value.
]

ImmutableArray size_: _size value_: _value
[
    self := self _clone.
    size := SmallInteger value_: _size.
    _pointers := _value.
    {
      int i;
      for (i= 0;  i < (int)v__size;  ++i)
        ((oop *)self->v__pointers)[i]= *((oop **)v__value)[i];
    }.
]

Object ifNil: aBlock			[ ^self ]
Object ifTrue: aBlock			[ ^aBlock value ]
Object ifFalse: aBlock			[ ^nil ]
Object ifTrue: aBlock ifFalse: bBlock	[ ^aBlock value ]
Object ifFalse: aBlock ifTrue: bBlock	[ ^bBlock value ]

UndefinedObject ifNil: aBlock			[ ^aBlock value ]
UndefinedObject ifTrue: aBlock			[ ^nil ]
UndefinedObject ifFalse: aBlock			[ ^aBlock value ]
UndefinedObject ifTrue: aBlock ifFalse: bBlock	[ ^bBlock value ]
UndefinedObject ifFalse: aBlock ifTrue: bBlock	[ ^aBlock value ]

StaticBlockClosure whileTrue: aBlock
[
    self value
	ifTrue:
	   [aBlock value.
	    self whileTrue: aBlock].
]

SmallInteger to: anInteger do: unaryBlock
[
    | index |
    index := self.
    [index <= anInteger]
	whileTrue:
	   [unaryBlock value: index.
	    index := index + 1].
]

SmallInteger <= aNumber
[
    { if ((int)v_aNumber & 1) return ((int)v_self <= (int)v_aNumber) ? v_true : v_false; }.
    ^super <= aNumber
]

SmallInteger + aNumber
[
    { if ((int)v_aNumber & 1) return (oop)((int)v_self + (int)v_aNumber - 1); }.
    ^super + aNumber
]

Character _value: anInteger
[
    self := super new.
    value := anInteger.
]

CharacterTable : Array ()
[
    CharacterTable := Array new: 256.
    0 to: 255 do: [:i | CharacterTable at: i + 1 put: (Character _value: i)]
]

Character value: anInteger	[ ^CharacterTable at: anInteger + 1 ]
Character value_: _int		[ ^self value: (SmallInteger value_: _int) ]

{ import: BlockClosure }	"control structures"
{ import: Character }		"program literals, debug printing and error handling"
{ import: SmallInteger }	"ubiquitous"
{ import: Array }		"program literals and the global Character table"
{ import: String }		"ditto -- loads ByteArray for us"
{ import: WordArray }		"program literals"

Character put	{ fputc((int)self->v_value >> 1, stdout);  fflush(stdout);  return (oop)(1 << 1 | 1); }
Character print	[ $$ put.  self put.  ^2 ]

Object debugName	[ ^ImmutableString value_: self _debugName ]

Object println		[  self print.  $\n put.  ^0 ]
Object print		[ ^self debugName put ]
Object putln		[  self put.    $\n put.  ^0 ]

UndefinedObject print	[ ^'nil' put ]

String print	[ $' put.  self put.  $' put.  ^2 + size ]
String put	[ { fwrite((void *)(self->v__bytes), (size_t)(self->v_size) >> 1, 1, stdout);  fflush(stdout); }.  ^size ]

Symbol print	[ $# put.  ^1 + super print ]

Collection print
[
    | n |
    n := super print.
    $( put.
    n := n + self printElements.
    $) put.
    ^2 + n
]

Collection printElements
[
    | n first |
    n := 0.
    first := true.
    self do: [:elt | first ifTrue: [first := false] ifFalse: [n := n + $  put].  n := n + elt print].
    ^n
]

Array print
[
    | n |
    '#(' put.
    n := self printElements.
    $) put.
    ^2 + n
]

ByteArray print
[
    | n |
    '#[' put.
    n := self printElements.
    $] put.
    ^2 + n
]

WordArray print
[
    | n |
    '#{' put.
    n := self printElements.
    $} put.
    ^2 + n
]

Object error: reason
[
    reason putln.
    { abort(); }.
]

Object primitiveFailed			[ ^self error: 'a primitive has failed' ]
Object errorImmutable			[ ^self error: 'this object is immutable' ]
Object errorImproperStore		[ ^self error: 'improper store into indexable object' ]
Object subclassResponsibility: name	[ ^self error: (self debugName, ' should override ', name) ]
Object shouldNotImplement: name		[ ^self error: (name, ' is not appropriate for ', self debugName) ]
Object errorNotFound			[ ^self error: 'object is not in the collection' ]
Object errorNotFound: oldObject		[ ^self error: 'object is not in the collection' ]
Object errorEmptyCollection		[ ^self error: 'this collection is empty' ]
Object errorNoSuchElement		[ ^self error: 'attempt to index non-existent element' ]
Object errorArgumentCount: argCount	[ ^self error: 'wrong number of block arguments' ]

Object hash		[ ^self identityHash ]
Object identityHash	{ return (oop)((((unsigned int)self >> 2) & 0x01FFFFFE) | 1); }

_object identityHash	{ return (oop)((((unsigned int)self >> 2) & 0x01FFFFFE) | 1); }	"so we can put vtables in dictionaries"

Object == anObject	{ return (v_self == v_anObject) ? v_true : v_false; }
Object ~~ anObject	{ return (v_self != v_anObject) ? v_true : v_false; }

Object  = anObject	[ ^self == anObject ]
Object ~= anObject	[ ^(self = anObject) not ]

Object not		[ ^false ]
UndefinedObject not	[ ^true ]

Object eqv: anObject		[ ^anObject ]
UndefinedObject eqv: anObject	[ ^anObject not ]

Object and: aBlock		[ ^aBlock value ]
Object or: aBlock		[ ^true ]

UndefinedObject and: aBlock	[ ^false ]
UndefinedObject or: aBlock	[ ^aBlock value ]

_object == anObject	{ return (v_self == v_anObject) ? v_true : v_false; }
_object ~~ anObject	{ return (v_self != v_anObject) ? v_true : v_false; }

_object dump { printf("[%p]", self); }

Object family			[ ^self _vtable ]

_vtable isKindOf:   family	[ ^self == family or: [delegate ~~ nil and: [delegate isKindOf: family]] ]
Object  isKindOf:   family	[ ^self _vtable isKindOf: family _vtable ]
Object  isMemberOf: family	[ ^self _vtable == family _vtable ]

Object isNil		[ ^false ]
UndefinedObject isNil	[ ^true ]

Object notNil		[ ^true ]
UndefinedObject notNil	[ ^false ]

Object assert		[ "$+ put" ]
UndefinedObject assert	[ self error: 'assertion failed' ]

Object printString
[
    | stream |
    stream := (String new: 32) writeStream.
    self printOn: stream.
    ^stream contents
]

Object printStringRadix: radix
[
    | stream |
    stream := (String new: 32) writeStream.
    self printOn: stream radix: radix.
    ^stream contents
]

Object printOn: aStream
[
    aStream nextPutAll: self debugName
]

UndefinedObject printOn: aStream
[
    aStream nextPutAll: 'nil'
]

Character printOn: aStream
[
    aStream nextPut: $$.
    (self < $\040 or: [self > $\176])
        ifTrue:
           [aStream nextPut: $\\.
            self printOctalOn: aStream]
        ifFalse:
           [aStream nextPut: self]
]

String printOn: aStream
[
    aStream nextPut: $'; nextPutAll: self; nextPut: $'
]

Array printOn: aStream
[
    aStream nextPutAll: '#('.
    self do: [:elt | elt printOn: aStream] separatedBy: [aStream space].
    aStream nextPut: $).
]

ByteArray printOn: aStream
[
    aStream nextPutAll: '#['.
    self do: [:elt | elt printOn: aStream] separatedBy: [aStream space].
    aStream nextPut: $].
]

WordArray printOn: aStream
[
    aStream nextPutAll: '#{'.
    self do: [:elt | elt printOn: aStream] separatedBy: [aStream space].
    aStream nextPut: $}.
]
