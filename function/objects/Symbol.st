" Symbol.st -- interned strings

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

  Last edited: 2007-12-15 00:44:31 by piumarta on emilia
"

{ import: Objects }

Object isSymbol	[ ^false ]
Symbol isSymbol	[ ^true ]

Symbol intern_: _string size_: _stringSize
{
    char *buf= (char *)alloca((int)v__stringSize + 1);
    memcpy((void *)buf, (void *)v__string, (int)v__stringSize);
    buf[(int)v__stringSize]= '\0';
    _return _libid->intern(buf);
}

Symbol intern_: _string
[
    | _stringSize |
    { v__stringSize= (oop)strlen((char *)v__string); }.
    ^self intern_: _string size_: _stringSize
]

Symbol intern: aString
[
    ^self intern_: aString _stringValue size_: aString size _integerValue
]

Symbol _bytes	[ ^_elements ]
Symbol size	[ ^SmallInteger value_: _size ]

Symbol _stringValue	[ ^_elements ]

Symbol asSymbol	[]
Symbol asString	[ ^String value_: _elements ]

Symbol beginsWith: aString	[ ^self asString beginsWith: aString ]
Symbol endsWith: aString	[ ^self asString endsWith: aString ]

Symbol , aStringOrSymbol	[ ^(self asString , aStringOrSymbol asString) asSymbol ]
Symbol append: aStringOrSymbol	[ ^(self asString , aStringOrSymbol asString) asSymbol ]

Symbol at: offset	[ (offset between: 0 and: self size - 1) ifTrue: [^SmallInteger value_: (self _at_: offset _integerValue)] ]

Symbol _at_: _offset	{ _return (oop)(long)(((char *)self->v__elements)[(long)v__offset]); }

Symbol = other		[ ^self == other ]

Object isKeyword	[ ^nil ]
Symbol isKeyword	[ ^(self at: self size - 1) == $: ]

Symbol printOn: aStream	[ ^aStream nextPut: $#; nextPutAll: self asString ]

Symbol do: unaryBlock	[ 0 to: self size - 1 do: [:i | unaryBlock value: (self at: i)] ]
