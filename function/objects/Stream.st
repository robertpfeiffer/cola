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

  Last edited: 2007-04-22 20:29:47 by piumarta on emilia
"

{ import: Objects }

SinkStream : Object ()

SinkStream cr			[]
SinkStream tab			[]
SinkStream space		[]
SinkStream print: o		[]
SinkStream print: o base: b	[]
SinkStream print_x: o		[]
SinkStream nextPut: o		[]
SinkStream nextPutAll: o	[]

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

ReadStream peek		[ ^self atEnd ifFalse: [collection at: position] ]
ReadStream peek: offset	[ ^position + offset < readLimit ifTrue: [collection at: position + offset] ]
ReadStream next		[ ^self atEnd ifFalse: [collection at: (position := position + 1) - 1] ]
ReadStream atEnd	[ ^position >= readLimit and: [self refill not] ]
ReadStream position	[ ^position ]
ReadStream position: i	[ ^position := i ]
ReadStream refill	[ ^false ]

ReadStream skip: count	[ count timesRepeat: [self next] ]

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

WriteStream cr			[ self nextPut: $\n ]
WriteStream tab			[ self nextPut: $\t ]
WriteStream space		[ self nextPut: $   ]
WriteStream print: o		[ o printOn: self ]
WriteStream print: o base: b	[ o printOn: self base: b ]
WriteStream print_x: o		[ self print: (Integer value_: o) base: 16 ]

WriteStream grow		[ self grow: collection size ]

WriteStream grow: count
[
    | newCollection |
    newCollection := collection new: (writeLimit := collection size + count).
    newCollection replaceFrom: 0 to: collection size - 1 with: collection startingAt: 0.
    collection := newCollection.
]

WriteStream contents
[
    ^collection copyFrom: 0 to: position - 1
]

WriteStream fullContents
[
    ^collection copyFrom: 0 to: readLimit - 1
]



WriteStream dump
[
    StdOut nextPutAll: self debugName;
	nextPutAll: '(collection='; nextPutAll: collection debugName; nextPut: $[; print: collection size; nextPut: $];
	nextPutAll: ' position=';   print: position;
	nextPutAll: ' readLimit=';  print: readLimit;
	nextPutAll: ' writeLimit='; print: writeLimit;
	nextPut: $); cr.
]


"----------------------------------------------------------------"

FileStream : ReadStream ( file )

FileStream refill
[
    | n |
    (n := file read: collection) > 0 ifFalse: [^false].
    position := 0.
    readLimit := n.
]

FileStream on: aFile
[
    self := super on: (ByteArray new: 8192).
    file := aFile.
    position := collection size.
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

{ include <readline/readline.h }
{ include <readline/history.h }

ConsoleFileStream _atexit
{
    write_history(".jolt-history");
}

ConsoleFileStream refill
[
    | length _buffer _bytes |
    {
	static char *buffer= 0;
        static int   live= 1;
        if (!live)
	    return 0;
	if (buffer)
	{
	    free(buffer);
	    buffer= 0;
	}
	else
	{
	    using_history();
	    stifle_history(1000);
	    read_history(".jolt-history");
	    atexit((void (*)(void))ConsoleFileStream___5fatexit);
	}
	buffer= readline((char *)self->v__prompt);
	if (!buffer) return (oop)(live= 0);
	if (*buffer) add_history(buffer);
	v_length= (oop)((strlen(buffer) + 1) << 1 | 1);
	v__buffer= (oop)buffer;
    }.
    collection size < length ifTrue: [collection := collection new: length].
    _bytes := collection _bytes.
    {
	strcpy((char *)v__bytes, (char *)v__buffer);
    }.
    collection at: length - 1 put: $\n.
    position := 0.
    readLimit := length.
]
