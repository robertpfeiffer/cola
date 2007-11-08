{ import: st80 }	"Gets the built-in types (SmallInteger, Symbol, etc.)"

FooBar : Object ( x y z )

Object slotNameAt: index
[
    | _name |
    ^(_name := self _slotNameAt_: (index - 1) _integerValue) ifTrue: [String value_: _name]
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

Object slotOffsetAt: index
[
    ^SmallInteger value_: (self _slotOffsetAt_: (index - 1) _integerValue)
]

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

Object slotSizeAt: index
[
    ^SmallInteger value_: (self _slotSizeAt_: (index - 1) _integerValue)
]

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
    index := 1.
    slots := IdentityDictionary new.
    [name := self slotNameAt: index]
	whileTrue:
	   [slots at: name put: ((self slotOffsetAt: index) -> (self slotSizeAt: index)).
	    index := index + 1].
    index println.
    ^slots
]

[
    | x |
    []  slots printString putln.
    [x] slots printString putln.
]
