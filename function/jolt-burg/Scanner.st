" Scanner.st -- lexical analysis

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

  Last edited: 2007-04-27 15:53:48 by piumarta on emilia
"

{ import: Objects }
{ import: Expression }

Scanner : Object ( saves )

Scanner xIllegal: stream	[ self error: 'illegal character: ', stream peek printString ]

Scanner new
[
    self := super new.
    saves := OrderedCollection new.
    0 to: 255 do: [:c | self _vtable methodAt: c put: (self _methodAt: #xIllegal:) with: 0].
]

Scanner readerAt: aCharacter						[ ^(self _vtable lookup: aCharacter) value _method ]
Scanner readerAt: aCharacter put: aMethod				[ ^(self _vtable methodAt: aCharacter put: aMethod with: 0) ]

Scanner attributeAt: aCharacter						[ ^(self _vtable lookup: aCharacter) value data ]
Scanner attribtueAt: aCharacter put: anObject				[ ^(self _vtable lookup: aCharacter) value data: anObject ]

Scanner readerAt: aCharacter put: aMethod withAttribute: anObject	[ ^(self _vtable methodAt: aCharacter put: aMethod with: anObject) ]

Scanner readerAt: firstCharacter through: lastCharacter put: aMethod withAttribute: anObject
[
    firstCharacter to: lastCharacter do: [:c | self _vtable methodAt: c put: aMethod with: anObject]
]

Scanner save
[
    | readers attributes |
    readers := Array new: 256.
    attributes := Array new: 256.
    0 to: 255 do: [:c |
	readers at: c put: (self readerAt: c).
	attributes at: c put: (self attributeAt: c)].
    saves addLast: readers; addLast: attributes.
]

Scanner restore
[
    | readers attributes |
    attributes := saves removeLast.
    readers := saves removeLast.
    0 to: 255 do: [:c | self readerAt: c put: (readers at: c) withAttribute: (attributes at: c)].
]

Scanner read: aStringOrStream
[
    | input char reader object |
    input := aStringOrStream readStream.
    [object or: [input atEnd]] whileFalse: [object := self internalRead: input].
    ^object
]

Scanner internalRead: stream
[
    | char |
    (char := stream peek) ifFalse: [^nil].
    ^self perform: char with: stream
]

Scanner read: stream list: type delimited: delimiter
[
    | list element |
    list := WriteStream on: (type new: 8).
    [self ignoreSpaces: stream]
	whileTrue:
	   [stream peek == delimiter ifTrue: [stream next.  ^list contents].
	    (element := self internalRead: stream) ifTrue: [list nextPut: element]].
    ^self error: 'unterminated list'
]

Scanner ignoreSpaces: stream
[
    [stream atEnd not]
	whileTrue:
	   [(self attributeAt: stream peek) == #space ifFalse: [^self].
	    stream next].
    ^nil
]

Scanner read: stream string: type delimited: delimiter withEscapes: escapeTable
[
    | tokenValue nextChar |
    tokenValue := WriteStream on: (type new: 8).
    [stream atEnd or: [stream peek == delimiter]]
	whileFalse: [tokenValue nextPut: (self nextChar: stream withEscape: escapeTable)].
    stream atEnd ifTrue: [self error: 'EOF in string literal'].
    stream next.
    ^tokenValue contents
]

Scanner nextChar: stream withEscape: escapeTable
[
    | c |
    (c := stream next) == $\\	ifFalse: [^c].
    (c := stream next) isNil	ifTrue:  [^nil].
    ^(escapeTable at: c) ifNil: [c]
]

"----------------------------------------------------------------"

CokeEscapeTable := [
    (Array new: 256)
	at: $a  put: $\a; "bel"
	at: $b  put: $\b; "bs"
	at: $e  put: $\e; "esc"
	at: $f  put: $\f; "ff"
	at: $n  put: $\n; "nl"
	at: $r  put: $\r; "cr"
	at: $t  put: $\t; "ht"
	at: $v  put: $\v;  "vt"
	yourself
]

CokeScanner : Scanner ()

CokeScanner xSpace: stream
[
    [stream atEnd not and: [(self attributeAt: stream peek) == #space]] whileTrue: [stream next].
    ^nil
]

CokeScanner xComment: stream
[
    | c |
    [stream atEnd not]
	whileTrue:
	    [((c := stream next) == $\n or: [c == $\r]) ifTrue: [^nil]].
    ^nil
]

CokeScanner xString: stream
[
    ^self read: stream string: String delimited: stream next withEscapes: CokeEscapeTable
]

CokeScanner xQuote: stream
[
    | node |
    stream next.
    (node := self read: stream) ifFalse: [self error: 'EOF in quoted literal'].
    ^Expression with: #quote with: node
]

CokeScanner xDigit: stream
[
    | tokenValue dv |
    tokenValue := 0.
    [(dv := stream peek digitValue) and: [dv < 10]]
	whileTrue:
	   [tokenValue := tokenValue * 10 + dv.
	    stream next].
    ^tokenValue
]

CokeScanner xLetter: stream
[
    | tokenValue nextChar active |
    tokenValue := WriteStream on: (String new: 8).
    tokenValue nextPut: stream next.
    [(nextChar := stream peek) and: [(self attributeAt: nextChar) == #id]]
	whileTrue:
	   [tokenValue nextPut: stream next].
    ^tokenValue contents asSymbol
]

CokeScanner xOpen: stream
[
    stream next.
    ^self read: stream list: Expression delimited: $)
]

CokeScanner xClose: stream
[
    ^self error: stream unexpected: $)
]

CokeScanner pendingInput: stream
[
    | tokens |
    tokens := WriteStream on: (String new: 20).
    20 timesRepeat: [stream peek ifTrue: [tokens nextPut: stream next]].
    ^tokens contents
]

CokeScanner errorSyntax: stream
[
    ^self error: 'syntax error near: ', (self pendingInput: stream)
]

CokeScanner error: stream unexpected: character
[
    ^self error: 'unexpected ', (String with: character), ' near: ', (self pendingInput: stream)
]


CokeScanner initialise
[
    self
	readerAt:   0 through:  32	put: (CokeScanner _methodAt: #xSpace:  ) withAttribute: #space;
	readerAt:  33 through: 126	put: (CokeScanner _methodAt: #xLetter: ) withAttribute: #id;
	readerAt:  $0 through:  $9	put: (CokeScanner _methodAt: #xDigit:  ) withAttribute: #id;
	readerAt:  $(			put: (CokeScanner _methodAt: #xOpen:   );
	readerAt:  $)			put: (CokeScanner _methodAt: #xClose:  );
	readerAt:  $"			put: (CokeScanner _methodAt: #xString: );
	readerAt:  $'			put: (CokeScanner _methodAt: #xQuote:  );
	readerAt:  $;			put: (CokeScanner _methodAt: #xComment:)
]

[ CokeScanner := CokeScanner new initialise ]
