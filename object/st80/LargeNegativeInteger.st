" LargeNegativeInteger.st -- support for arbitrary-precision integers

  Copyright (c) 2006 Ian Piumarta
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

  Last edited: 2007-03-21 16:06:28 by piumarta on emilia.local
"

{ import: LargePositiveInteger }

LargeNegativeInteger : LargePositiveInteger ()

LargeNegativeInteger size_: _size value_: _bytes
[
    ^self withBytes: (ByteArray size_: _size value_: _bytes)
]

LargeNegativeInteger normalize
[
    "Check for leading zeroes and return shortened copy if so"
    | sLen val len oldLen minVal |
    len := oldLen := self digitLength.
    [len = 0 ifTrue: [^0].
     (self digitAt: len) = 0]
	whileTrue: [len := len - 1].
    "Now check if in SmallInteger range"
    sLen := 4  "SmallInteger minVal digitLength".
    len <= sLen
	ifTrue:
	   [minVal := SmallInteger minVal.
	    (len < sLen or: [(self digitAt: sLen) < minVal lastDigit])
		ifTrue:
		   [val := 0.
		    len to: 1 by: -1 do: [:i | val := (val * 256) - (self digitAt: i)].
		    ^ val].
	    1 to: sLen do: [:i | (self digitAt: i) = (minVal digitAt: i)
				     ifFalse: [^len < oldLen
						   ifTrue:  [self growTo: len]
						   ifFalse: [self]]].
	    ^minVal].
    "Return self, or a shortened copy"
    ^len < oldLen
	ifTrue:  [self growTo: len]
	ifFalse: [self]
]

LargeNegativeInteger abs	[ ^self negated ]

LargeNegativeInteger negative	[ ^true ]

