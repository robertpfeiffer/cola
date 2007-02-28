" File.st -- stream-like accessors for files

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

  Last edited: 2007-02-28 14:34:11 by piumarta on emilia
"

{ import: Objects }

{ include "tag.h" }

File : Object ( _fd name )

File isFile	[ ^true ]
Object isFile	[ ^false ]

File withFd: fd
[
    self := self new.
    _fd := fd _integerValue.
    name := '<unknown>'.
]

File withFd: fd name: nameString
[
    self := self new.
    _fd := fd _integerValue.
    name := nameString.
]

File name			[ ^name ]

File print: anObject		[ anObject printOn: self ]
File print: aNumber base: base	[ aNumber printOn: self base: base ]
File cr				[ self nextPut: $\n ]
File cr: n			[ n timesRepeat: [self cr] ]
File space			[ self nextPut: $   ]
File space: n			[ n timesRepeat: [self space] ]
File tab			[ self nextPut: $\t ]
File tab: n			[ n timesRepeat: [self tab] ]

File nextPut: aByte
[
    { if ((long)v_aByte & 1) { char c= _I(v_aByte);  return _O(write((int)self->v__fd, (void *)&c, 1)); } }.
    ^self primitiveFailed
]

File nextPutAll: aString
[
    | _bytes _size |
    _bytes := aString _bytes.
    _size  := aString size _integerValue.
    { return _O(write((int)self->v__fd, (void *)v__bytes, (size_t)v__size)); }.
]

File print_x: _pointer
{
    char buf[1024];
    int size= sprintf(buf, "%x", (int)v__pointer);
    return _O(write((int)self->v__fd, (void *)buf, (size_t)size));
}

File  read: aCollection			[ ^self read: aCollection size: aCollection size ]
File  read: aCollection size: size	[ ^SmallInteger value_: (self _read_: aCollection _elements size_: size _integerValue) ]
File _read_: _bytes size_: _size	{ return (oop)read((int)self->v__fd, (void *)v__bytes, (size_t)v__size); }

File isInteractive			{ return (oop)isatty((int)self->v__fd); }

File open: pathString
[
    ^self open: pathString ifAbsent: [self error: pathString, ': No such file or directory'].
]

File openIfPresent: pathString
[
    ^self open: pathString ifAbsent: [].
]

File open: pathString ifAbsent: errorBlock
[
    | descriptor |
    descriptor := self open_: pathString _stringValue.
    ^descriptor >= 0
	ifTrue:  [File withFd: descriptor name: pathString]
	ifFalse: [errorBlock value]
]

File open_: _path
{
    return (oop)(((long)open((char *)v__path, O_RDONLY, 0)) << 1 | 1);
}

File create: pathString
[
    ^self create: pathString ifAbsent: [self error: pathString, ': Cannot open for writing'].
]

File create: pathString ifAbsent: errorBlock
[
    | descriptor |
    descriptor := self create_: pathString _stringValue.
    ^descriptor >= 0
	ifTrue:  [File withFd: descriptor name: pathString]
	ifFalse: [errorBlock value]
]

File create_: _path
{
    return (oop)(((long)open((char *)v__path, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)) << 1 | 1);
}

File close
{
    close((long)self->v__fd);
}

File contents
[
    | buf out n |
    buf := ByteArray new: 8192.
    out := WriteStream on: (ByteArray new: 8192).
    [(n := self read: buf) > 0]
	whileTrue:
	   [out next: n putAll: buf].
    ^out contents
]

"----------------------------------------------------------------"

SharedFile : File ( readStream )

SharedFile readStream
[
    readStream isNil ifTrue: [readStream := super readStream].
    ^readStream
]

File readStream
[
    ^(self isInteractive ifTrue: [ConsoleFileStream] ifFalse: [FileStream]) on: self
]
