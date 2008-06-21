" String.st -- support for strings of bytes

  Copyright (c) 2005 Ian Piumarta
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

  Last edited: 2008-06-20 14:37:19 by piumarta on emilia.local
"

{ import: ByteArray }

String  : ByteArray ()

String species	[ ^String ]

String at: anInteger		[ ^Character value: (super at: anInteger) ]
String at: anInteger put: aChar	[ super at: anInteger put: aChar asciiValue.  ^aChar ]

String asUppercase		[ ^self collect: [:char | char asUppercase] ]
String asLowercase		[ ^self collect: [:char | char asLowercase] ]

String _stringValue
[
    | _string |
    {
      int len= (long)(self->v_size) >> 1;
      v__string= _libid->balloc(len + 1);
      memcpy(v__string, self->v__bytes, len);
      ((char *)v__string)[len]= '\0';
    }.
    ^_string
]

String value_: _cString
[
    self := self _clone.
    {
      int len= strlen((char *)v__cString);
      self->v_size= (oop)(long)((len << 1) | 1);
      self->v__bytes= _libid->balloc(len);
      memcpy(self->v__bytes, v__cString, len);
    }.
]

Object isString	[ ^false ]
String isString	[ ^true ]

String < aString
[
    | cmp |
    aString isString ifFalse: [^false].
    cmp := self strncmp_: _bytes _: aString _bytes _: (self size min: aString size) _integerValue.
    ^cmp < 0 or: [cmp == 0 and: [self size < aString size]]
]

String = aString
[
    (aString isString and: [self size == aString size]) ifFalse: [^false].
    ^0 == (self strncmp_: _bytes _: aString _bytes _: self size _integerValue).
]

String > aString
[
    | cmp |
    aString isString ifFalse: [^false].
    cmp := self strncmp_: _bytes _: aString _bytes _: (self size min: aString size) _integerValue.
    ^cmp > 0 or: [cmp == 0 and: [self size > aString size]]
]

String <= aString	[ ^self = aString or: [self < aString] ]
String >= aString	[ ^self = aString or: [self > aString] ]

String strncmp_: _s1 _: _s2 _: _length	{ return (oop)(long)(strncmp((char *)v__s1, (char *)v__s2, (long)v__length) << 1 | 1); }


String asByteArray
[
    | byteArray |
    byteArray := ByteArray new: self size.
    1 to: self size do: [:index | byteArray at: index put: (self byteAt: index)].
    ^byteArray
]


ImmutableString  : String ()			{ pragma: type string ImmutableString }

ImmutableString at: anInteger put: aChar	[ ^self errorImmutable ]

ImmutableString value_: _cString
[
    self := self _clone.
    {
      self->v_size= (oop)(long)((strlen((char *)v__cString) << 1) | 1);
      self->v__bytes= v__cString;
    }.
]

ImmutableString writeStream
[
    ^((String new: size) copyFrom: 1 to: size) writeStream
]
