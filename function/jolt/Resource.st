{ import: Objects }

Resource : Object ( refCount used )

Resource new
[
    self := super new.
    refCount := 0.
    used := false.
]

Resource allocate	[  refCount := refCount + 1.  used := true ]
Resource release	[  (refCount := refCount - 1) < 0 ifTrue: [self error: 'ref count underflow'] ]
Resource live		[ ^refCount > 0 ]
Resource refCount	[ ^refCount ]

Resource used		[ ^used ]

Register : Resource ( class name _encoding )

Register withClass: aClass name: aString encoding: anInteger
[
    self := self new.
    class := aClass.
    name := aString.
    _encoding := anInteger _integerValue.
]

Register class		[ ^class ]

Register _reg		[ ^_encoding ]

Resource releaseRegister	[]
Register releaseRegister	[ self release ]

Register printOn: aStream
[
    aStream nextPutAll: name
]

RegisterSet : OrderedCollection ()


RegisterSet add: aRegister	[ (self includes: aRegister) ifFalse: [super add: aRegister] ]

RegisterSet allocate: insn
[
    self do: [:reg | (reg live or: [insn clobbers: reg] "or: [reg class ~~ class]") ifFalse: [^reg]].
    ^nil
]

RegisterSet allocateAll	[ StdOut nextPutAll: 'ALLOCATE '; print: self; cr.  self do: [:reg | reg allocate] ]
RegisterSet releaseAll	[ StdOut nextPutAll: 'RELEASE '; print: self; cr.  self do: [:reg | reg release] ]

"----------------------------------------------------------------"

Temporary : Resource ( base offset )

Temporary withBase: baseRegister offset: offsetInteger
[
    self := self new.
    base := baseRegister.
    offset := offsetInteger.
]

Temporary base: aRegister	[ ^base := aRegister]
Temporary base			[ ^base ]
Temporary offset: anInteger	[ ^offset := anInteger]
Temporary offset		[ ^offset ]

Temporary printOn: aStream
[
    aStream print: offset; nextPut: $@; print: base
]
