"							-*- Smalltalk -*-
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

  Last edited: 2006-02-05 00:41:39 by piumarta on emilia.local
"

"I represent a scanner converting a stream of text into a stream of tokens."

{ import: Object }
{ import: IdentityDictionary }
{ import: WriteStream }
{ import: ScannerPosition }
{ import: Symbol }

Scanner : Object (
    charTable		"maps initial token character to token scanning message"
    charEscapes		"maps character escapes (letters) onto (nonprintable) ascii values"
    context		"the ScannerContext of the currently active input stream"
    c			"the NEXT character to scan (one CHARACTER LOOKAHEAD beyond...)"
    token		"...the text of the LAST token scanned (one TOKEN LOOKAHEAD)"
    type		"a Symbol giving the semantic type of the LAST token scanned"
    prevHash		"true if the previous character was a hash (#, number, pound, whatever) sign"
    line		"the input line number as of the BEGINNING of the LAST token scanned"
)

Scanner on: aScannerContext
[
    self := self new.
    context := aScannerContext.
    self next.
    token := String new writeStream.
    line := 0.
]

Scanner initialize
[
    super initialize.
    (charTable := Array new: 256)
        atAllPut: #xIllegal;
	atAll: '0123456789'			asByteArray put: #xDigit;
	atAll: 'abcdefghijklmnopqrstuvwxyz'	asByteArray put: #xLetter;
	atAll: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'	asByteArray put: #xLetter;
	atAll: '_'				asByteArray put: #xLetter;
	atAll: '~!@%&*=\\?/><,|^'		asByteArray put: #xBinary;
	atAll: '+-'				asByteArray put: #xSign;
	atAll: '#[];()}'			asByteArray put: #xPunctuator;
	atAll: ' \t\n\r\v\f'			asByteArray put: #xSpace;
	at:    $.				asciiValue  put: #xDot;
	at:    $:				asciiValue  put: #xColon;
	at:    ${				asciiValue  put: #xBrace;
	at:    $$				asciiValue  put: #xCharacter;
	at:    $'				asciiValue  put: #xString;
	at:    $"				asciiValue  put: #xComment.
    (charEscapes := IdentityDictionary new)
	at: $a  put: $\a; "bel"
	at: $b  put: $\b; "bs"
	at: $e  put: $\e; "esc"
	at: $f  put: $\f; "ff"
	at: $n  put: $\n; "nl"
	at: $r  put: $\r; "cr"
	at: $t  put: $\t; "ht"
	at: $v  put: $\v. "vt"
    prevHash := false.
]

Scanner position
[
    ^ScannerPosition withFile: context file line: line
]

Scanner context	[ ^context ]
Scanner atEnd	[ ^context atEnd ]
Scanner next	[ ^c := context next ]

Scanner scan
[
    "first char already in c; scan next token, leaving first nontoken char in c"
    type := nil.
    [c notNil and: [type isNil]]
	whileTrue:
	    [token resetToStart.
	     [c notNil and: [(charTable at: c value) == #xSpace]] whileTrue: [self next].
	     line := context line.
	     c notNil ifTrue: [self perform: (charTable at: c value)]].
    prevHash := #'#' == type.
    ^type
]

Scanner xSign
[
    ^context peek isDigit
	ifTrue: [self xDigit]
	ifFalse: [self xBinary]
]

Scanner xDot
[
    token nextPut: c.
    self next.
    (c = $. and: [context peek = $.])
	ifTrue:
	    [self next; next.
	     type := #ellipsis]
	ifFalse:
	    [type := #'.'].
    ^type
]

Scanner xColon
[
    token nextPut: c.
    self next.
    c == $= ifFalse: [^type := token contents asSymbol].
    token nextPut: c.
    self next.
    ^type := #assign
]

Scanner xPunctuator
[
    token nextPut: c.
    type := c asString asSymbol.
    self next.
    ^type
]

Scanner xBinary
[
    token nextPut: c.	"eat + or -, if present (see xSign)"
    self next.
    [c notNil and: [(charTable at: c value) == #xBinary]]
	whileTrue:
	    [token nextPut: c.
	     self next].
    ^type := #binary
]

Scanner xLetter
[
    type := #identifier.
    [c notNil and: [(charTable at: c value) == #xLetter or: [(charTable at: c value) == #xDigit]]]
	whileTrue:
	    [token nextPut: c.
	     self next].
    c == $:
	ifTrue:
	    [token nextPut: c.
	     self next.
	     type := #keyword].
    ^type
]

Scanner scanKeywords
[
    | keywords |
    keywords := token contents.
    [c notNil and: [(charTable at: c value) == #xLetter]]
	whileTrue:
	   [self scan.
	    type == #keyword ifFalse: [self error: 'composite keyword does not end in '':'''].
	    keywords := keywords , token contents].
    token resetToStart; nextPutAll: keywords
]

Scanner xDigit
[
    | d |
    token nextPut: c.	"eat sign, if present (see xSign)"
    self next.
    "integer"
    [c notNil and: [(charTable at: c value) == #xLetter or: [(charTable at: c value) == #xDigit]]]
	whileTrue:
	    [token nextPut: c.
	     self next].
    (c ~~ $.)			ifTrue:  [^type := #integer].
    (d := context peek) isNil	ifTrue:  [^type := #integer].
    (d isDigit or: [d == $e])	ifFalse: [^type := #integer].
    token nextPut: c.	"."
    self next.
    "fractional part of mantissa"
    [c notNil and: [(charTable at: c value) == #xDigit]]
	whileTrue:
	    [token nextPut: c.
	     self next].
    (c == $e or: [c == $E])	ifFalse: [^type := #float].
    token nextPut: c.
    self next.
    "exponent"
    [c notNil and: [(charTable at: c value) == #xSign]]
	whileTrue:
	    [token nextPut: c.
	     self next].
    (c notNil and: [(charTable at: c value) == #xDigit])
	ifFalse: [self error: 'missing exponent in floating constant'].
    [c notNil and: [(charTable at: c value) == #xDigit]]
	whileTrue:
	    [token nextPut: c.
	     self next].
    ^type := #float
]

Scanner xCharacter
[
    self next.
    c isNil ifTrue: [self error: 'EOF in character literal'].
    self scanCharacter.
    ^type := #character
]

Scanner xString
[
    [c == $']
	whileTrue:
	    [self next.
	     [c notNil and: [c ~~ $']] whileTrue: [self scanCharacter].
	     c isNil ifTrue: [self error: 'EOF in string literal'].
	     (self next) == $' ifTrue: [token nextPut: c]].
    ^type := #string
]

Scanner scanCharacter
[
    | d |
    d := c.
    self next.
    d == $\\ ifTrue: [self scanEscape] ifFalse: [token nextPut: d]
]

Scanner scanEscape
[
    | char | 
    c isNil ifTrue: [self error: 'EOF while scanning escaped character'].
    c == $\n ifTrue: [^self next].	"ignore escaped EOL"
    char := charEscapes at: c ifAbsent: [(c between: $0 and: $7) ifTrue: [self scanOctal] ifFalse: [c]].
    self next.
    token nextPut: char
]

Scanner scanOctal
[
    | char |
    char := c digitValue.
    2 timesRepeat:
	[self next.
	 c isNil ifTrue: [self error: 'EOF while scanning octal character escape'].
	 (c between: $0 and: $7) ifFalse: [self error: 'illegal digit in octal character escape'].
	 char := char * 8 + c digitValue].
    ^Character value: char
]

Scanner xIllegal
[
    self error: 'illegal character: ', c printString
]

Scanner xComment
[
    self next.
    [c notNil and: [c ~~ $"]] whileTrue: [self next].
    self next.
    ^type := nil
]

Scanner xBrace
[
    | nest |
    prevHash
	ifTrue:
	    [self next.
	     ^type := #'{'].
    "gobble everything up to the balancing '}'"
    nest := 1.
    [nest > 0]
	whileTrue:
	    [self next.
	     [c notNil and: [c ~~ $}]]
		 whileTrue:
		     [token nextPut: c.
		      c == ${ ifTrue: [nest := nest + 1].
		      self next].
	     c isNil ifTrue: [self error: 'EOF in external code'].
	     (nest := nest - 1) > 0 ifTrue: [token nextPut: c]].
    self next.
    ^type := #extern
]
