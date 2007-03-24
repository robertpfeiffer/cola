" Resource.st -- machine resources: registers and automatic variables

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

  Last edited: 2007-03-23 18:53:54 by piumarta on ubuntu
"

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
Register encoding	[ ^SmallInteger value_: _encoding ]

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
