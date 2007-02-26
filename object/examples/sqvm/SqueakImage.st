{ import: st80 }
{ import: File }

ImageClassInteger	:= [  5 ]
ImageCompactClasses	:= [ 28 ]

ImageClass_format	:= [ 2 ]

WordArray withBytes: bytes
[
    self := self _clone.
    size := bytes size // 4.
    _words := bytes _bytes.
]

HeaderTypeSizeAndClass	:= [ 0 ]
HeaderTypeClass		:= [ 1 ]
HeaderTypeFree		:= [ 2 ]
HeaderTypeShort		:= [ 3 ]
TypeMask		:= [ 3 ]

SizeMask		:= [ 0xfc ]

SqueakImage : Object ( _version headerSize dataSize oldBaseAddr specialObjectsOop lastHash savedWindowSize fullScreenFlag extraVMMemory bytes words )

SqueakImage open: imageName
[
    | file version swap header |
    self := self new.
    (file := File openForReading: imageName) notNil ifFalse: [self error: 'cannot open image'].
    swap := false.
    file _read_: self at_: 0 _integerValue size_: self _sizeof.
    version := SmallInteger value_: _version.
    (version = 6502)
	ifFalse:
	   [swap := true.
	    self byteSwap_: self size: self sizeof.
	    version := SmallInteger value_: _version].
    (version = 6502)
	ifFalse:
	   [self error: 'cannot read image version ', version printString].

    headerSize          := SmallInteger value_: headerSize.             'headerSize        ' put.  headerSize        println.
    dataSize            := SmallInteger value_: dataSize.               'dataSize          ' put.  dataSize          println.
    oldBaseAddr         := SmallInteger value_: oldBaseAddr.            'oldBaseAddr       ' put.  oldBaseAddr	     println.
    specialObjectsOop   := SmallInteger value_: specialObjectsOop.      'specialObjectsOop ' put.  specialObjectsOop println.
    lastHash            := SmallInteger value_: lastHash.               'lastHash          ' put.  lastHash          println.
    savedWindowSize     := SmallInteger value_: savedWindowSize.        'savedWindowSize   ' put.  savedWindowSize   println.
    fullScreenFlag      := SmallInteger value_: fullScreenFlag.         'fullScreenFlag    ' put.  fullScreenFlag    println.
    extraVMMemory       := SmallInteger value_: extraVMMemory.          'extraVMMemory     ' put.  extraVMMemory     println.
    .                                                                   'swapped           ' put.  swap              println.

    bytes := ByteArray new: dataSize + 4.	"room for empty FreeBlock"
    words := WordArray withBytes: bytes.	"parallel word accessor"

    file read: bytes size: headerSize - self sizeof.	"seek to image data"
    file read: bytes size: dataSize.
    file close.

    words at: 1 + (dataSize // 4) put: HeaderTypeFree.

    swap
	ifTrue:
	   ['swap words...' putln.
	    self byteSwap_: bytes _bytes size: dataSize.
	    'swap bytes...' putln.
	    self unswapByteObjects].

  'relocating pointers...' putln.
  self relocatePointersBy: oldBaseAddr.
]

SqueakImage sizeof
[
    ^SmallInteger value_: self _sizeof
]

SqueakImage byteSwap_: _addr size: size
[
    ^self byteSwap_: _addr size_: size _integerValue
]

SqueakImage byteSwap_: _addr size_: _size
{
    unsigned int *addr= (unsigned int *)v__addr;
    unsigned int *last= (unsigned int *)((char *)v__addr + (int)v__size);
    for (; addr < last;  ++addr)
      {
        unsigned int u= *addr;
	*addr= ((u >> 24) & 0xff) | ((u >> 8) & 0xff00) | ((u & 0xff00) << 8) | ((u & 0xff) << 24);
      }
}

ByteArray byteSwapFrom: firstOffset to: lastOffset
[
    self byteSwapFrom_: firstOffset _integerValue to_: lastOffset _integerValue
]

ByteArray byteSwapFrom_: _first to_: _last
{
    unsigned int *addr= (unsigned int *)((char *)self->v__bytes + (int)v__first);
    unsigned int *last= (unsigned int *)((char *)self->v__bytes + (int)v__last);
    for (; addr < last;  ++addr)
      {
        unsigned int u= *addr;
	*addr= ((u >> 24) & 0xff) | ((u >> 8) & 0xff00) | ((u & 0xff00) << 8) | ((u & 0xff) << 24);
      }
}

UnswapObjects := [
    #( unswapNone:	"    0 no fields"
       unswapNone:	"    1 fixed fields only (all containing pointers)"
       unswapNone:	"    2 indexable fields only (all containing pointers)"
       unswapNone:	"    3 both fixed and indexable fields (all containing pointers)"
       unswapNone:	"    4 both fixed and indexable weak fields (all containing pointers)"
       illegalFormat:	"    5 unused"
       unswapNone:	"    6 indexable word fields only (no pointers)"
       illegalFormat:	"    7 unused"
       unswapBytes:	" 8-11 indexable byte fields only (no pointers)"
       unswapBytes:
       unswapBytes:
       unswapBytes:
       unswapMethod:	"12-15 compiled methods"
       unswapMethod:
       unswapMethod:
       unswapMethod:
    ) collect: [:s | s asSelector]
]

SqueakImage unswapByteObjects
[
    self oopsDo: [:obj | self _perform: (UnswapObjects at: 1 + (self formatOf: obj)) w: obj].
]

SqueakImage unswapNone: obj []

SqueakImage unswapBytes: obj
[
    | size |
    size := self sizeBitsOf: obj.
    size := size - ((self formatOf: obj) bitAnd: 3).
    bytes byteSwapFrom: obj + 4 to: obj + size.
]

SqueakImage unswapMethod: obj
[
    | header literalCount size |
    size := self sizeBitsOf: obj.
    size := size - ((self formatOf: obj) bitAnd: 3).
    bytes byteSwapFrom: obj + 8 + (4 * (self literalCountOf: obj)) to: obj + size.
]

SqueakImage oopsDo: unaryBlock
[
    | obj |
    obj := self firstObject.
    [	unaryBlock value: obj.
	(obj := self objectAfter: obj) notNil
    ] whileTrue.
]

ExtraHeaderBytes := [ #( 8 4 0 0 ) ]

SqueakImage byteAt: ptr			[ ^bytes at: 1 + (ptr) ]
SqueakImage longAt: ptr			[ ^words at: 1 + (ptr // 4) ]
SqueakImage longAt: ptr put: value	[ ^words at: 1 + (ptr // 4) put: value ]
SqueakImage typeOf: oopOrChunk		[ ^(self longAt: oopOrChunk) bitAnd: TypeMask ]
SqueakImage isFreeBlock: oopOrChunk	[ ^(self typeOf: oopOrChunk) == HeaderTypeFree ]
SqueakImage sizeHeader: obj		[ ^(self longAt: obj - 8) ]
SqueakImage classHeader: obj		[ ^(self longAt: obj - 4) ]
SqueakImage baseHeader: obj		[ ^(self longAt: obj) ]
SqueakImage methodHeader: obj		[ ^(self longAt: obj + 4) ]
SqueakImage formatOf: obj		[ ^(self baseHeader: obj) >> 8 bitAnd: 0x0f ]
SqueakImage extraHeaderBytes: chunk	[ ^ExtraHeaderBytes at: 1 + (self typeOf: chunk) ]
SqueakImage oopFromChunk: chunk		[ ^chunk + (self extraHeaderBytes: chunk) ]
SqueakImage firstObject			[ ^self oopFromChunk: 0 ]
SqueakImage objectAfter: obj		[ ^(self isFreeBlock: (obj := self oopFromChunk: obj + (self sizeBitsOf: obj))) ifFalse: [obj] ]
SqueakImage isIntegerObject: obj	[ ^(obj bitAnd: 1) ~~ 0 ]
SqueakImage literalCountOfHeader: hdr	[ ^hdr >> 10 bitAnd: 0xff ]
SqueakImage literalCountOf: method	[ ^self literalCountOfHeader: (self methodHeader: method) ]

SqueakImage intAt: ptr			[ ^words _at: 1 + (ptr // 4) ]

SqueakImage sizeBitsOf: obj
[
    ^(self typeOf: obj) == HeaderTypeSizeAndClass
	ifTrue:  [self sizeHeader: obj]
	ifFalse: [(self baseHeader: obj) bitAnd: SizeMask]
]

RelocateHeaders := [
    #( relocateHeader:by:
       relocateHeader:by:
       yourself:with:
       yourself:with: ) collect: [:s | s asSelector]
]

RelocateObjects := [
    #( yourself:with:		"    0 no fields"
       relocatePointers:by:	"    1 fixed fields only (all containing pointers)"
       relocatePointers:by:	"    2 indexable fields only (all containing pointers)"
       relocatePointers:by:	"    3 both fixed and indexable fields (all containing pointers)"
       relocatePointers:by:	"    4 both fixed and indexable weak fields (all containing pointers)"
       illegalFormat:with:	"    5 unused"
       yourself:with:		"    6 indexable word fields only (no pointers)"
       illegalFormat:with:	"    7 unused"
       yourself:with:		" 8-11 indexable byte fields only (no pointers)"
       yourself:with:
       yourself:with:
       yourself:with:
       relocateMethod:by:	"12-15 compiled methods"
       relocateMethod:by:
       relocateMethod:by:
       relocateMethod:by:
    ) collect: [:s | s asSelector]
]   

SqueakImage yourself: a with: b []

SqueakImage relocatePointersBy: delta
[
    | numObjects |
    numObjects := 0.
    self oopsDo: [:obj |
	numObjects := numObjects + 1.
	self _perform: (RelocateHeaders at: 1 + (self typeOf:   obj)) w: obj w: delta.
	self _perform: (RelocateObjects at: 1 + (self formatOf: obj)) w: obj w: delta].
    numObjects print.
    ' objects in image' putln.
    specialObjectsOop := specialObjectsOop - delta.
]

SqueakImage relocateHeader: obj by: delta
[
    self longAt: obj - 4
	 put:    (self longAt: obj - 4) - delta
]

SqueakImage relocatePointers: obj by: delta
[
    self relocatePointersFrom: obj + 4 to: obj + (self sizeBitsOf: obj) - 4 by: delta
]

SqueakImage relocateMethod: obj by: delta
[
    self relocatePointersFrom: obj + 4 to: obj + 4 + (4 * (self literalCountOf: obj)) by: delta
]

SqueakImage relocatePointersFrom: field to: last by: delta
[
    [field <= last]
	whileTrue:
	   [| ptr |
	    ptr := self longAt: field.
	    (self isIntegerObject: ptr)
		ifFalse: [self longAt: field put: ptr - delta].
	    field := field + 4]
]

SqueakImage maxObjectIndex
[
    ^dataSize // 4
]

SqueakImage indexOf: anOop
[
    ^anOop // 4
]

SqueakImage specialObjectsOop
[
    ^specialObjectsOop
]

SqueakImage lastHash
[
    ^lastHash
]

SqueakImage fetchClassOf: obj
[
    | ccIndex |
    (self isIntegerObject: obj) ifTrue: [^self splObj: ImageClassInteger].
    ccIndex := (self baseHeader: obj) >> 12 bitAnd: 0x1f.
    ^ccIndex > 0
	ifTrue:  [self longAt: (self splObj: ImageCompactClasses) + (4 * ccIndex)]
	ifFalse: [self classHeader: obj]
]

SqueakImage hashBitsOf: obj
[
    ^(self baseHeader: obj) >> 17 bitAnd: 0x0fff
]

SqueakImage splObj: index
[
    ^self longAt: specialObjectsOop + 4 + (4 * index)
]

SqueakImage fixedFieldsOf: obj
[
    | format |
    format := self formatOf: obj.
    (format > 4 or: [format == 2]) ifTrue: [^0].		"indexable fields only"
    (format < 2) ifTrue: [^(self sizeBitsOf: obj) // 4 - 1].	"fixed fields only (zero or more)"
    obj := self fetchClassOf: obj.
    format := self longAt: obj + 4 + (4 * ImageClass_format).
    ^((format >> 11) bitAnd: 0x0c0) + ((format >>  2) bitAnd: 0x03f) - 1
]
