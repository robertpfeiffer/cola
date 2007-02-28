{ import: Objects }

Object isSymbol	[ ^false ]
Symbol isSymbol	[ ^true ]

Symbol intern_: _string size_: _stringSize
{
    char *buf= (char *)alloca((int)v__stringSize + 1);
    memcpy((void *)buf, (void *)v__string, (int)v__stringSize);
    buf[(int)v__stringSize]= '\0';
    return _selector(buf);
}

Symbol intern: aString
[
    ^self intern_: aString _stringValue size_: aString size _integerValue
]

Symbol _bytes	[ ^_elements ]
Symbol size	[ ^SmallInteger value_: _size ]

Symbol _stringValue	[ ^_elements ]

Symbol asString	[ ^String value_: _elements ]

Symbol beginsWith: aString	[ ^self asString beginsWith: aString ]
Symbol endsWith: aString	[ ^self asString endsWith: aString ]

Symbol , aStringOrSymbol	[ ^(self asString , aStringOrSymbol asString) asSymbol ]
Symbol append: aStringOrSymbol	[ ^(self asString , aStringOrSymbol asString) asSymbol ]

Symbol at: offset	[ (offset between: 0 and: self size - 1) ifTrue: [^SmallInteger value_: (self _at_: offset _integerValue)] ]

Symbol _at_: _offset	{ return (oop)(long)(((char *)self->v__elements)[(long)v__offset]); }

Symbol = other		[ ^self == other ]

Symbol printOn: aStream	[ ^aStream nextPut: $#; nextPutAll: self asString ]

