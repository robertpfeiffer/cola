{ import: Object }
{ import: Smalltalk }

File : Object ( _fd )

File withDescriptor_: _descriptor
[
    self := self new.
    _fd := _descriptor
]

File withDescriptor: descriptor
[
    ^self withDescriptor_: descriptor _integerValue
]

File initialize
[
    super initialize.
    _fd := -1.
]

File isOpen	[ ^_fd ~~ -1 ]
File descriptor	[ ^SmallInteger value_: _fd ]

File openForReading: path	[ ^self open: path flags: self readOnlyFlag mode: 0 ]
File openForWriting: path	[ ^self open: path flags: (self readWriteFlag) mode: 8r666 ]
File createForWriting: path	[ ^self open: path flags: (self writeOnlyFlag bitOr: self createFlag) mode: 8r666 ]

File readOnlyFlag	{ return (oop)(O_RDONLY   << 1 | 1); }
File writeOnlyFlag	{ return (oop)(O_WRONLY   << 1 | 1); }
File readWriteFlag	{ return (oop)(O_RDWR     << 1 | 1); }
File nonBlockFlag	{ return (oop)(O_NONBLOCK << 1 | 1); }
File appendFlag		{ return (oop)(O_APPEND   << 1 | 1); }
File createFlag		{ return (oop)(O_CREAT    << 1 | 1); }
File truncateFlag	{ return (oop)(O_TRUNC    << 1 | 1); }

File asyncFlag
{
#  if !defined(__CYGWIN__)
    return (oop)(O_ASYNC    << 1 | 1);
#  else
    return (oop)0;
#  endif
}

File open: path flags: flags mode: mode
[
    ('open: ', path printString, ' flags: ', flags printString, ' mode: ', mode printString) putln.
    self := self new open_: path _stringValue flags_: flags _integerValue mode_: mode _integerValue.
    self isOpen ifFalse: [^nil].
]

File open_: _path flags_: _flags mode_: _mode	{ self->v__fd= (oop)(long)open((char *)v__path, (int)v__flags, (int)v__mode); }

File close					{ close((int)self->v__fd); }

File read: anArray			[ ^self read: anArray startingAt: 1     size: anArray size ]
File read: anArray size: size		[ ^self read: anArray startingAt: 1     size:         size ]
File read: anArray startingAt: index	[ ^self read: anArray startingAt: index size: anArray size ]

File read: array startingAt: index size: size
[
    ^(0 < index and: [index + size - 1 <= array size])
	ifTrue:  [(SmallInteger value_: (self _read_: array _elements
					         at_: (index - 1 * array elementSize) _integerValue
					       size_: (size * array elementSize) _integerValue))
		      // array elementSize]
	ifFalse: [self errorNoSuchElement]
]

File _read_:  _bytes at_: _offset size_: _size	{ return (oop) read((int)self->v__fd, (void *)((char *)v__bytes + (int)v__offset), (size_t)v__size); }

File write: anArray			[ ^self write: anArray startingAt: 1     size: anArray size ]
File write: anArray size: size		[ ^self write: anArray startingAt: 1     size:         size ]
File write: anArray startingAt: index	[ ^self write: anArray startingAt: index size: anArray size ]

File write: array startingAt: index size: size
[
    ^(0 < index and: [index + size - 1 <= array size])
	ifTrue:  [(SmallInteger value_: (self _write_: array _elements
					          at_: (index - 1 * array elementSize) _integerValue
					        size_: (size * array elementSize) _integerValue))
		      // array elementSize]
	ifFalse: [self errorNoSuchElement]
]

File _write_: _bytes at_: _offset size_: _size	{ return (oop)write((int)self->v__fd, (void *)((char *)v__bytes + (int)v__offset), (size_t)v__size); }

File next
[
    | buffer |
    ^(self read: (buffer := ByteArray new: 1)) == 1 ifTrue: [Character value: buffer first]
]

File nextPut: aCharacter
[
    ^(self write: (ByteArray with: aCharacter value)) == 1
]

File seek: position	[ self seek_: position _integerValue ]
File seek_: _offset	{ lseek((int)self->v__fd, (int)v__offset, SEEK_SET); }

File tell		[ ^SmallInteger value_: self _tell ]
File _tell		{ return (oop)(long)lseek((int)self->v__fd, 0, SEEK_CUR); }

File _flags		{ return (oop)fcntl((int)(self->v__fd), F_GETFL); }
File flags_: _flags	{ fcntl((int)(self->v__fd), F_SETFL, (int)v__flags); }

File flags		[ ^SmallInteger value_: self _flags ]
File flags: flags	[  self flags_: flags _integerValue ]

File setFlag:   flag	[ self flags: (self flags bitOr: flag) ]
File clearFlag: flag	[ self flags: (self flags bitAnd: flag negated - 1) ]
File testFlag:  flag	[ ^(self flags bitAnd: flag) ~= 0 ]

File unlink: pathName	[ self _unlink_: pathName _stringValue ]
File _unlink_: _path	{ return (oop)unlink((char *)v__path); }

File copyDataFrom: aFile
[
    ^self copyFrom: aFile withBuffer: (ByteArray new: self blockSize)
]

File copyDataFrom: aFile withBuffer: buffer
[
    | n |
    [(n := aFile read: buffer) > 0]
	whileTrue:
	    [(self write: buffer size: n) ~~ n
		 ifTrue: [Smalltalk osWarning: 'write']].
    n < 0 ifTrue: [Smalltalk osWarning: 'read'].
]

File size
[
    ^self isOpen ifTrue: [SmallInteger value_: self _size]
]

File _size
{
  struct stat st;
  if (fstat((int)(self->v__fd), &st)) return 0;
  return (oop)(long)st.st_size;
}


StandardInput  : File ()	[ StandardInput  := StandardInput  withDescriptor: 0 ]
StandardOutput : File ()	[ StandardOutput := StandardOutput withDescriptor: 1 ]
StandardError  : File ()	[ StandardError  := StandardError  withDescriptor: 2 ]
