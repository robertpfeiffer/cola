{ import: st80 }
{ import: WeakArray }

ObjectTable : Object ( entries size youngStart position lastInstance lastIndex )

Smalltalk garbageCollect
{
    _libid->gc_gcollect();
}

ObjectTable new: numObjects
[
    self := self new.
    entries := WeakArray new: (size := numObjects).
    youngStart := 1.
    position := 0.
    lastInstance := nil.
    lastIndex := 0.
]

ObjectTable record: anObject
[
    ^entries at: self nextEmptyPosition put: anObject.
]

ObjectTable nextEmptyPosition
[
    [(position := position + 1) < size] whileTrue: [(entries at: position) isNil ifTrue:  [^position]].
    'NEXT -> INCR GC' putln.
    self incrementalGC.
    [(position := position + 1) < size] whileTrue: [(entries at: position) isNil ifTrue:  [^position]].
    self error: 'this cannot happen'.
]

ObjectTable incrementalGC
[
    | freeSize youngSize |
    freeSize := self compact.
    youngSize := position - youngStart.
    ('INCR GC ', size printString, ' -> ', youngSize printString, ' + ', freeSize printString,
	 ' = ', (youngSize + freeSize) printString) putln.
    (youngSize > 1024)
	ifTrue:
	   ['INCR GC -> TENURE' putln.
	    youngStart := position].	"tenure"
    (freeSize * 8 < size)		"12.5% free"
	ifTrue:
	   ['INCR GC -> FULL GC' putln.
	    freeSize := self fullGC].
    ^Array elementSize * freeSize
]

ObjectTable fullGC
[
    | freeSize |
    Smalltalk garbageCollect.
    youngStart := 1.
    freeSize := self compact.
    youngStart := position.
    ('FULL GC ', size printString, ' -> ', youngStart printString, ' + ', freeSize printString) putln.
    (freeSize * 2 < size)
	ifTrue:
	   ['FULL GC -> GROW' putln.
	    freeSize := self grow].
    ^Array elementSize * freeSize.
]

ObjectTable compact
[
    | in out anObject |
    in := youngStart.
    out := in.
    [in < position]
	whileTrue:
	   [(anObject := entries at: in) notNil
		ifTrue:
		   [(in ~~ out) ifTrue: [entries at: out put: anObject].
		    out := out + 1].
	    in := in + 1].
    entries from: out to: size put: nil.
    lastIndex := 1.
    position := out.
    ^size - out
]

ObjectTable grow
[
    | oldEntries |
    oldEntries := entries.
    entries := WeakArray new: (size := size * 2).
    entries replaceFrom: 1 to: position - 1 with: oldEntries.
    ^size - position
]

ObjectTable initialInstanceOf: aClass
[
    | anObject |
    lastInstance := nil.
    lastIndex := 0.
    1 to: position do: [:index |
	((anObject := entries at: index) notNil and: [anObject class == aClass])
	    ifTrue:
	       [lastIndex := index.
		^lastInstance := anObject]].
    ^nil
]

ObjectTable instanceAfter: lastObject
[
    | lastClass anObject |
    lastClass := lastObject class.
    (lastInstance == lastObject ifTrue: [lastIndex] ifFalse: [self indexOf: lastObject]) + 1
	to: position
	do: [:index |
	    ((anObject := entries at: index) notNil and: [anObject class == lastClass])
		ifTrue:
		   [lastIndex := index.
		    ^lastInstance := anObject]].
    lastIndex := 0.
    ^lastInstance := nil
]

ObjectTable indexOf: anObject
[
    1 to: position do: [:index | (entries at: index == anObject) ifTrue: [^index]].
    ^position + 1
]

FormatEmpty	:= [ 0 ]
FormatFixed	:= [ 1 ]
FormatPointers	:= [ 2 ]
FormatWeak	:= [ 3 ]
FormatWords	:= [ 4 ]
FormatBytes	:= [ 5 ]
FormatMethod	:= [ 6 ]

SqueakObject : Object ( class hash format instSize fields )

Object isSqueakObject		[ ^false ]
SqueakObject isSqueakObject	[ ^true ]

ObjectMemory := []

SqueakObject initialiseHeap: numObjects
[
    ObjectMemory := ObjectTable new: numObjects.
]

SqueakObject class	[ ^class ]
SqueakObject hashBits	[ ^hash ]
SqueakObject format	[ ^format ]
SqueakObject instSize	[ ^instSize ]
SqueakObject fields	[ ^fields ]
SqueakObject size	[ ^fields size ]

SqueakObject isFixed	[ ^format == FormatFixed ]
SqueakObject isPointers	[ ^format == FormatPointers ]
SqueakObject isWeak	[ ^format == FormatWeak ]
SqueakObject isWords	[ ^format == FormatWords ]
SqueakObject isBytes	[ ^format == FormatBytes ]
SqueakObject isMethod	[ ^format == FormatMethod ]

SqueakObject byteSize	[ ^fields isNil ifTrue: [0] ifFalse: [fields byteSize] ]

SqueakObject isIndexable	[ ^format ~~ FormatEmpty and: [format ~~ FormatFixed] ]

SqueakObject new
[
    ^ObjectMemory record: super new
]

SqueakObject initClass: theClass hash: theHash format: theFormat
[
    class    := theClass.
    hash     := theHash.
    format   := theFormat.
    instSize := 0.
    fields   := nil.
]

SqueakObject initEmpty		[ ]
SqueakObject initFixed: size	[ instSize := size ]
SqueakObject initPointers: size	[ fields := Array new: size ]
SqueakObject initWeak: size	[ fields := WeakArray new: size ]
SqueakObject initWords: size	[ fields := WordArray new: size ]
SqueakObject initBytes: size	[ fields := ByteArray new: size ]

SqueakObject fullGC		[ ^ObjectMemory fullGC ]
SqueakObject incrementalGC	[ ^ObjectMemory incrementalGC ]

SqueakObject initialInstanceOf: aClass	[ ^ObjectMemory initialInstanceOf: aClass ]
SqueakObject instanceAfter: anObject	[ ^ObjectMemory instanceAfter: anObject ]

SqueakObject instVarAt: offset
[
"    self assert: (0 <= offset and: [offset < instSize])."
    ^self fetchPointer: offset
]

SqueakObject instVarAt: offset put: value
[
"    self assert: (0 <= offset and: [offset < instSize])."
    ^self storePointer: offset with: value
]

SqueakObject fetchPointer: offset
[
"    self assert: fields isArray."
    ^fields at: 1 + offset
]

SqueakObject storePointer: offset with: value
[
"    self assert: fields isArray."
    ^fields at: 1 + offset put: value
]

SqueakObject fetchIndexed: offset
[
"    self assert: fields isArray."
    ^fields at: 1 + instSize + offset
]

SqueakObject storeIndexed: offset with: value
[
"    self assert: fields isArray."
    ^fields at: 1 + instSize + offset put: value
]

SqueakObject fetchWord: offset
[
"    self assert: fields isWordArray."
    ^fields at: 1 + offset
]

SqueakObject storeWord: offset with: value
[
"    self assert: fields isWordArray."
    ^fields at: 1 + offset put: value
]

SqueakObject fetchByte: offset
[
"    self assert: fields isByteArray."
    ^fields at: 1 + offset
]

SqueakObject storeByte: offset with: value
[
"    self assert: fields isByteArray."
    ^fields at: 1 + offset put: value
]


SqueakObject new: theClass hash: theHash format: theFormat fixedSize: fixedSize fields: theFields
[
    self := self new.
    class    := theClass.
    hash     := theHash.
    format   := theFormat.
    instSize := fixedSize.
    fields   := theFields
]

"optimised for Points, Contexts and Strings..."

SqueakObject newFixed: theClass hash: theHash size: fixedSize
[
    self     := self new.
    class    := theClass.
    hash     := theHash.
    format   := FormatFixed.
    instSize := fixedSize.
    fields   := (Array new: fixedSize)
]

SqueakObject newPointers: theClass hash: theHash fixedSize: fixedSize indexableSize: indexableSize
[
    indexableSize := indexableSize + fixedSize.
    self     := self new.
    class    := theClass.
    hash     := theHash.
    format   := FormatPointers.
    instSize := fixedSize.
    fields   := indexableSize > 0 ifTrue: [Array new: indexableSize].
]

SqueakObject newWords: theClass hash: theHash indexableSize: indexableSize
[
    self     := self new.
    class    := theClass.
    hash     := theHash.
    format   := FormatWords.
    instSize := 0.
    fields   := WordArray new: indexableSize.
]

SqueakObject newBytes: theClass hash: theHash indexableSize: indexableSize
[
    self     := self new.
    class    := theClass.
    hash     := theHash.
    format   := FormatBytes.
    instSize := 0.
    fields   := ByteArray new: indexableSize.
]

SequenceableCollection copy
[
    | new |
    new := self new: self size.
    new replaceFrom: 1 to: new size with: self.
    ^new
]

SqueakObject cloneWithHash: newHash
[
    ^self new: class hash: newHash format: format fixedSize: instSize fields: fields copy
]

SqueakObject formatOfClass	[ ^self fetchPointer: 2 "Class_format" ]
SqueakObject instSpecOfClass	[ ^self formatOfClass >> 7 bitAnd: 0x0f ]

SqueakObject instSizeOfClass
[
    | fmt |
    fmt := self formatOfClass.
    ^(fmt >> 10 bitAnd: 0xc0) + (fmt >> 1 bitAnd: 0x3f) - 1
]

SqueakObject positiveIntegerValue
[
    ^LargePositiveInteger withBytes: fields
]

SqueakObject setFloatValue: aFloat
[
    | in out |
    in  := aFloat.
    out := self fields _words.
    {
#      if (BYTE_ORDER == LITTLE_ENDIAN)
	((unsigned int *)v_out)[0]= ((unsigned int *)v_in)[1];
	((unsigned int *)v_out)[1]= ((unsigned int *)v_in)[0];
#      else
	((double *)v_out)[0]= ((double *)v_in)[0];
#      endif
    }.
]

SqueakObject floatValue
[
    | aFloat in out |
    aFloat := Float new.
    in  := self fields _words.
    out := aFloat.
    {
#      if (BYTE_ORDER == LITTLE_ENDIAN)
	((unsigned int *)v_out)[0]= ((unsigned int *)v_in)[1];
	((unsigned int *)v_out)[1]= ((unsigned int *)v_in)[0];
#      else
	((double *)v_out)[0]= ((double *)v_in)[0];
#      endif
    }.
    ^aFloat
]

SmallInteger pointsTo: thang
[
    ^false
]

SqueakObject pointsTo: thang
[
    fields notNil and: [fields isArray and: [fields do: [:field | field == thang ifTrue: [^true]]]].
    ^false
]


SqueakObject bulkBecome: from with: to twoWay: twoWay
[
    | map |
    (from isPointers and: [to isPointers and: [from size == to size]]) ifFalse: [^false].
    map := IdentityDictionary new.
    from fields with: to fields do: [:f :t | map at: f put: t].
    twoWay ifTrue: [to fields with: from fields do: [:f :t | map at: f put: t]].
    ObjectMemory exchangePointers: map
]

ObjectTable exchangePointers: map
[
    entries do: [:obj | obj isNil ifFalse: [obj exchangePointers: map]]
]

SqueakObject exchangePointers: map
[
    | key val |
    class := map at: class ifAbsent: [class].
    fields isArray
	ifTrue:
	   [1 to: fields size do: [:i |
	       (val := map at: (fields at: i) ifAbsent: []) notNil
		   ifTrue: [fields at: i put: val]]]
]


SqueakMethod : SqueakObject ( methodHeader literals )

Object isSqueakMethod		[ ^false ]
SqueakMethod isSqueakMethod	[ ^true ]

SqueakMethod literals		[ ^literals ]

SqueakMethod newMethod: theClass hash: theHash indexableSize: indexableSize
[
    self     := self new.
    class    := theClass.
    hash     := theHash.
    format   := FormatMethod.
    instSize := 0.
    fields   := ByteArray new: indexableSize.
]

SqueakMethod initLiterals: size	[  literals := Array new: size ]
SqueakMethod literalsSize	[ ^literals size ]

SqueakMethod fetchLiteral: offset
[
    ^literals at: 1 + offset
]

SqueakMethod storeLiteral: offset with: value
[
    offset == 0 ifTrue: [methodHeader := value].
    ^literals at: 1 + offset put: value.
]

SqueakMethod methodClass
[
    ^literals last instVarAt: 1 "Association_value"
]

SqueakMethod initialPC
[
    ^literals size * 4 + 1
]

SqueakMethod primitiveIndex
[
    ^(methodHeader bitAnd: 0x1ff) + (methodHeader >> 19 bitAnd: 0x200)
]

SqueakMethod numArgs
[
    ^(methodHeader >> 24) bitAnd: 0x0f
]

SqueakMethod numTemps
[
    ^(methodHeader >> 18) bitAnd: 0x3f
]

SqueakMethod needsLargeContext
[
    ^0 ~~ (methodHeader bitAnd: 0x20000)
]

SqueakMethod pointsTo: thang
[
    literals notNil and: [literals isArray and: [literals do: [:field | field == thang ifTrue: [^true]]]].
    ^false
]
