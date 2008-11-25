" Stream.st -- serialised access to collections

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

  Last edited: 2008-11-25 14:32:12 by piumarta on emilia.vpri.org
"

{ import: Objects }

SinkStream : Object ()

SinkStream cr				[]
SinkStream tab				[]
SinkStream space			[]
SinkStream print: o			[]
SinkStream println: o			[]
SinkStream print: o base: b		[]
SinkStream print: o base: b width: w	[]
SinkStream print_x: o			[]
SinkStream nextPut: o			[]
SinkStream nextPutAll: o		[]

"----------------------------------------------------------------"

ReadStream : Object ( collection position readLimit )

ReadStream collection	[ ^collection ]

ReadStream on: aCollection
[
    self := self new.
    collection := aCollection.
    position := 0.
    readLimit := collection size.
]

ReadStream readStream	[ ^self ]

ReadStream peek: offset
[
    | index |
    index := position + offset.
    [index >= readLimit and: [self refill]] whileTrue.
    ^index < readLimit ifTrue: [collection at: position + offset]
]

ReadStream peek		[ [position >= readLimit and: [self refill]] whileTrue.  ^position < readLimit ifTrue: [collection at: position] ]
ReadStream next		[ [position >= readLimit and: [self refill]] whileTrue.  ^position < readLimit ifTrue: [collection at: (position := position + 1) - 1] ]
ReadStream atEnd	[ ^position >= readLimit and: [self refill not] ]
ReadStream position	[ ^position ]
ReadStream position: i	[ ^position := i ]
ReadStream skip: count	[ position := position + count ]
ReadStream refill	[ ^false ]

ReadStream flush
[
    position > (collection size // 2)
	ifTrue:
	   [| newLimit |
	    newLimit := readLimit - position.
	    collection replaceFrom: 0 to: newLimit - 1 with: collection startingAt: position.
	    readLimit := newLimit.
	    position  := 0]
]

ReadStream grow		[ self grow: (collection size max: 2)]

ReadStream grow: count
[
    | collectionSize newCollection |
    collectionSize := collection size.
    newCollection := collection new: collectionSize + count.
    newCollection replaceFrom: 0 to: collectionSize - 1 with: collection startingAt: 0.
    collection := newCollection.
]

ReadStream matchAny
[
    ^self next
]

ReadStream matchRest
[
    [self next] whileTrue.
]

ReadStream match: anObject
[
    ^anObject == self peek
	ifTrue:
	   [position := position + 1.
	    anObject]
]

ReadStream matchEqual: anObject
[
    ^anObject = self peek
	ifTrue:
	   [self next]
]

ReadStream matchClass: characterClass
[
    | c |
    ^((c := self peek) and: [0 ~~ (characterClass bitAt: c)])
	ifTrue:
	   [position := position + 1.
	    c]
]

ReadStream matchType: prototype
[
    | anObject |
    ^((anObject := self peek) and: [anObject isKindOf: prototype])
	ifTrue:
	   [position := position + 1.
	    anObject]
]

ReadStream matchSequence: aCollection
[
    aCollection doWithIndex: [:c :i | (self peek: i) == c ifFalse: [^nil]].
    position := position + aCollection size.
    ^aCollection
]

ReadStream last					[ ^collection at: position - 1 ]
ReadStream contentsFrom: start			[ ^collection copyFrom: start to: position - 1 ]
ReadStream contentsFrom: start to: limit	[ ^collection copyFrom: start to: (limit min: collection size - 1)]

"----------------------------------------------------------------"

WriteStream : ReadStream ( writeLimit )

WriteStream isWriteStream	[ ^true ]
Object isWriteStream		[ ^false ]

WriteStream on: aCollection
[
    self := super on: aCollection.
    writeLimit := collection size.
    readLimit := 0.
]

WriteStream with: aCollection
[
    self := super on: aCollection.
    position := readLimit := writeLimit := collection size.
]

WriteStream reset
[
    readLimit := position.
    position := 0.
]

WriteStream nextPut: anObject
[
    position >= writeLimit ifTrue: [self grow].
    collection at: position put: anObject.
    readLimit := (position := position + 1) max: readLimit.
    ^anObject
]

WriteStream nextPutAll: aCollection
[
    aCollection do: [:anObject | self nextPut: anObject].
    ^aCollection
]

WriteStream next: count putAll: seqCollection
[
    position + count >= writeLimit ifTrue: [self grow: (count max: collection size)].
    collection replaceFrom: position to: position + count - 1 with: seqCollection startingAt: 0.
    readLimit := (position := position + count) max: readLimit.
    ^seqCollection
]

WriteStream cr				[ self nextPut: $\n ]
WriteStream tab				[ self nextPut: $\t ]
WriteStream space			[ self nextPut: $   ]
WriteStream print: o			[ o printOn: self ]
WriteStream println: o			[ self print: o; cr ]
WriteStream print: o base: b		[ o printOn: self base: b ]
WriteStream print: o base: b width: w	[ o printOn: self base: b width: w ]
WriteStream print_x: o			[ self print: (Integer value_: o) base: 16 ]

WriteStream grow: count
[
    writeLimit := collection size + count.
    super grow: count.
]

WriteStream contents		[ ^collection copyFrom: 0 to: position - 1 ]
WriteStream fullContents	[ ^collection copyFrom: 0 to: readLimit - 1 ]

"----------------------------------------------------------------"

FileStream : ReadStream ( file )

FileStream refill
[
    | n |
    position == collection size ifTrue: [self grow].
    (n := file read: collection at: position size: collection size - position) > 0 ifFalse: [^false].
    readLimit := position + n.
]

FileStream on: aFile
[
    self := super on: (ByteArray new: 8192).
    file := aFile.
    readLimit := 0.
]

FileStream contents
[
    | ws |
    ws := WriteStream on: (String new: 8192).
    [self atEnd] whileFalse: [ws nextPut: self next].
    ^ws contents
]

FileStream close
[
    file close
]

"----------------------------------------------------------------"

ConsoleFileStream : FileStream ( _prompt )

Object isConsoleFileStream		[ ^false ]
ConsoleFileStream isConsoleFileStream	[ ^true ]

ConsoleFileStream on: aFile
[
    ^self on: aFile prompt: (aFile isInteractive ifTrue: ['.'] ifFalse: ['']).
]

ConsoleFileStream on: aFile prompt: aString
[
    self := super on: aFile.
    _prompt := aString _stringValue.
]

ConsoleFileStream prompt: aString
[
    _prompt := aString _stringValue.
]

ConsoleFileStream refill
[
    | length _buffer _bytes _position |
    {
	static char *buffer= 0;
        static int   live= 1;
        if (!live)
	    { _return 0; }
	if (!buffer)
	    buffer= malloc(1024);
	printf("%s", (char *)self->v__prompt);
	fflush(stdout);
	if (fgets(buffer, 1024, stdin))
	    {
		long len= strlen(buffer);
		if (len && buffer[len - 1] == '\n')
		    buffer[--len]= '\0';
		v_length= (oop)(long)(len << 1 | 1);
		v__buffer= (oop)buffer;
	    }
	else
	    { _return (oop)(long)(live= 0); }
    }.
    [collection size <= (position + length)] whileTrue: [self grow].
    _bytes := collection _bytes.
    _position := position _integerValue.
    {
	strcpy((char *)v__bytes + (long)v__position, (char *)v__buffer);
    }.
    collection at: position + length put: $\n.
    readLimit := position + length + 1.
]
