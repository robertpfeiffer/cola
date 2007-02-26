{ import: st80 }
{ import: Squeak }

{ include "vmProxy.c" }

SqueakProxy : Object ( vm )

SqueakProxy withVM: squeak
[
    self := self new.
    vm := squeak.
]

SqueakProxy pop: nItems				[ ^vm drop: nItems ]
SqueakProxy stackValue: offset			[ ^vm stackValue: offset ]

SqueakProxy byteSizeOf: obj			[ ^obj isSmallInteger ifTrue: [0] ifFalse: [obj byteSize] ]

SqueakProxy fetchInteger: idx ofObject: obj
[
    | result |
    (obj isSmallInteger not and: [(result := obj instVarAt: idx) isSmallInteger]) ifFalse: [vm primitiveFail].
    ^result
]

SqueakProxy fetchPointer: idx ofObject: obj
[
    obj isSmallInteger ifTrue: [^vm primitiveFailed].
    ^obj instVarAt: idx
]

SqueakProxy firstIndexableField: obj	[ ^obj fields _elements ]

SqueakProxy methodArgumentCount		[ ^vm argumentCount ]

SqueakProxy slotSizeOf: obj		[ ^obj isSmallInteger ifTrue: [0] ifFalse: [obj instSize + obj size] ]
SqueakProxy isPointers: obj		[ ^obj isSmallInteger not and: [obj isFixed or: [obj isPointers or: [obj isWeak]]] ]
SqueakProxy isWords: obj		[ ^obj isSmallInteger not and: [obj isWords] ]
SqueakProxy isBytes: obj		[ ^obj isSmallInteger not and: [obj isBytes or: [obj isMethod]] ]
SqueakProxy isWordsOrBytes: obj		[ ^obj isSmallInteger not and: [obj isWords or: [obj isBytes or: [obj isMethod]]] ]

SqueakProxy characterTable		[ ^vm splObj: SqueakCharacterTable ]
SqueakProxy displayObject		[ ^vm splObj: TheDisplay ]
SqueakProxy falseObject			[ ^vm falseObject ]
SqueakProxy nilObject			[ ^vm nilObject   ]
SqueakProxy trueObject			[ ^vm trueObject  ]

SqueakProxy failed			[ ^vm failed ]
SqueakProxy primitiveFail		[ ^vm primitiveFail ]

SqueakProxy showDisplayBits: aForm l: l t: t r: r b: b	[ ^vm showDisplayBits: aForm left: l top: t right: r bottom: b ]

Squeak getProxy
[
    ^self _getProxy: (SqueakProxy withVM: self)
]

Squeak _getProxy: vmProxy
{
    return getProxy(v_vmProxy);
}
