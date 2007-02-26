" Character.st -- 8-bit ASCII characters

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

  Last edited: 2007-02-21 15:30:30 by piumarta on emilia.lax02.mtt
"

{ import: Magnitude }
{ import: Array }

Character : Magnitude ( value )

Character isCharacter	[ ^true ]
Object isCharacter	[ ^false ]

Character _value: anInteger
[
    self := super new.
    value := anInteger.
]

CharacterTable : Array ()
[
    CharacterTable := Array new: 256.
    0 to: 255 do: [:i | CharacterTable at: i + 1 put: (Character _value: i)]
]

Character value: anInteger	[ ^CharacterTable at: anInteger + 1 ]
Character value_: _int		[ ^self value: (SmallInteger value_: _int) ]

Character asciiValue		[ ^value ]
Character value			[ ^value ]
Character asInteger		[ ^value ]

Character hash			[ ^value * 6653 ]
Character = aCharacter		[ ^aCharacter isCharacter and: [value == aCharacter asciiValue] ]
Character < aCharacter		[ ^aCharacter isCharacter and: [value  < aCharacter asciiValue] ]
Character > aCharacter		[ ^aCharacter isCharacter and: [value  > aCharacter asciiValue] ]

Character asUppercase		[ ^(0x60 < value and: [value < 0x7b]) ifTrue: [Character value: value - 0x20] ifFalse: [self] ]
Character asLowercase		[ ^(0x40 < value and: [value < 0x5b]) ifTrue: [Character value: value + 0x20] ifFalse: [self] ]
Character asString		[ ^String with: self ]

Character digitValue: anInteger
[
    ^self value: (anInteger < 10 ifTrue: [48] ifFalse: [87]) + anInteger
]

Character digitValue
[
    " Answer 0-9 if the receiver is $0-$9, 10-35 if it is $A-$Z, and <
      0 otherwise.  This is used to parse literal numbers of radix
      2-36. "
    ^#(	"    0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F"
       	"0" -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
       	"1" -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
       	"2" -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
       	"3"  0  1  2  3  4  5  6  7  8  9 -1 -1 -1 -1 -1 -1
       	"4" -1 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
       	"5" 25 26 27 28 29 30 31 32 33 34 35 -1 -1 -1 -1 -1
       	"6" -1 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
       	"7" 25 26 27 28 29 30 31 32 33 34 35 -1 -1 -1 -1 -1
       	"8" -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
       	"9" -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
       	"A" -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
       	"B" -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
       	"C" -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
       	"D" -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
       	"E" -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
       	"F" -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 )
	at: 1 + self asciiValue
]

Character isLetter	[ ^(self between: $a and: $z) or: [self between: $A and: $Z] ]
Character isDigit	[ ^self between: $0 and: $9 ]

Character printOctalOn: aStream
[
    aStream
        nextPut: (Character digitValue: self asciiValue // 64 \\ 8);
        nextPut: (Character digitValue: self asciiValue //  8 \\ 8);
        nextPut: (Character digitValue: self asciiValue //  1 \\ 8).
]

" ---------------------------------------------------------------- "

Integer readFrom: aStream base: base
[
    | negative value |
    negative := false.
    value := 0.
    aStream peek = $+
	ifTrue: [aStream skip: 1]
	ifFalse:
	    [aStream peek = $-
                 ifTrue: [negative := negative not.
                          aStream skip: 1]].
    [aStream atEnd]
	whileFalse:
	    [| digit |
	     digit := aStream next.
	     digit = $r
		 ifTrue:
		     [value < 2 ifTrue: [self error: 'illegal radix in integer constant'].
		      base := value.
		      value := 0]
		 ifFalse:
		     [digit := digit digitValue.
		      (digit < 0 or: [digit >= base]) ifTrue: [self error: 'illegal digit in integer constant: ', aStream contents].
		      value := value * base + digit]].
    ^negative ifTrue: [value negated] ifFalse: [value]
]
