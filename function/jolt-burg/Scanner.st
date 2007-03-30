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

  Last edited: 2007-03-29 21:25:28 by piumarta on emilia
"

{ import: Objects }
{ import: Expression }

Scanner : Object ( characterTable stream nextChar )

Scanner on: aStream
[
    self := self new initialize.
    stream := aStream.
    self nextChar.
]

Scanner initialize	[ characterTable := Array new: 256 withAll: #xIllegal ]

Scanner atEnd		[ ^nextChar isNil ]
Scanner nextChar	[ ^nextChar := stream next ]
Scanner peekChar	[ ^stream peek ]

Scanner nextToken
[
    | token |
    [nextChar notNil and: [(token := self perform: (characterTable at: nextChar)) isNil]] whileTrue.
    ^token
]

Scanner xIllegal
[
    StdErr cr; nextPutAll: 'illegal character: '; print: nextChar; cr; halt.
]

"----------------------------------------------------------------"

CokeScanner : Scanner ( characterEscapes tokenType tokenValue quasiquoting )

CokeScanner on: aStream
[
    self := super on: aStream.
]

CokeScanner initialize
[
    super initialize.
    characterTable
	atAll: '('			put: #xOpen;
	atAll: ')'			put: #xClose;
	atAll: '['			put: #xOpenBracket;
	atAll: ']'			put: #xCloseBracket;
	atAll: '!#$%&*./:<=>?@\\^_|~'	put: #xLetter;
	atAll: ','			put: #xComma;
	atAll: '+-'			put: #xSign;
	from:  $a to: $z		put: #xLetter;
	from:  $A to: $Z		put: #xLetter;
	from:  $0 to: $9		put: #xDigit;
	from:   0 to: 32		put: #xSpace;
	at:    $"			put: #xString;
	at:    $'			put: #xQuote;
	at:    $`			put: #xBackQuote;
	at:    $;			put: #xComment.
    (characterEscapes := IdentityDictionary new)
	at: $a  put: $\a; "bel"
	at: $b  put: $\b; "bs"
	at: $e  put: $\e; "esc"
	at: $f  put: $\f; "ff"
	at: $n  put: $\n; "nl"
	at: $r  put: $\r; "cr"
	at: $t  put: $\t; "ht"
	at: $v  put: $\v. "vt"
    quasiquoting := false.
]

CokeScanner nextCharWithEscape
[
    nextChar == $\\ ifFalse: [^nextChar].
    self nextChar isNil ifTrue: [^self error: 'incomplete character escape'].
    ^characterEscapes at: nextChar ifAbsent: [nextChar]
]


CokeScanner xSpace
[
    [self nextChar notNil and: [(characterTable at: nextChar) == #xSpace]] whileTrue.
    ^nil
]

CokeScanner xComment
[
    [self nextChar notNil and: [nextChar ~~ $\n and: [nextChar ~~ $\r]]] whileTrue.
    ^nil
]

CokeScanner xQuote
[
    tokenValue := String with: nextChar.
    self nextChar.
    ^#quote
]

CokeScanner xBackQuote
[
    tokenValue := String with: nextChar.
    self nextChar.
    ^#backQuote
]

CokeScanner xComma
[
    quasiquoting ifFalse: [^self xLetter].
    tokenValue := String with: nextChar.
    ^self nextChar == $@
	ifTrue:
	   [tokenValue := tokenValue , '@'.
	    self nextChar.
	    #commaAt]
	ifFalse:
	   [#comma]
]

CokeScanner xString
[
    tokenValue := WriteStream on: (String new: 8).
    [self nextChar notNil and: [nextChar ~~ $"]]
	whileTrue: [tokenValue nextPut: self nextCharWithEscape].
    nextChar isNil ifTrue: [self error: 'EOF in string literal'].
    self nextChar.
    tokenValue := tokenValue contents.
    ^#string
]

CokeScanner xDigit
[
    | radix dv multiplier |
    radix := 10.
    tokenValue := nextChar digitValue.
    self nextChar.
    tokenValue == 0
	ifTrue:
	   [nextChar == $x
		ifTrue:  [radix := 16.  self nextChar]
		ifFalse: [nextChar == $b
			      ifTrue: [radix := 2.
				       self nextChar]
			      ifFalse: [nextChar == $. ifFalse: [radix := 8]]]].
    [(dv := nextChar digitValue) notNil and: [dv < radix]]
	whileTrue:
	   [tokenValue := tokenValue * radix + dv.
	    self nextChar].
    nextChar == $.
	ifTrue:
	   [self nextChar.
	    multiplier := 1.0.
	    [(dv := nextChar digitValue) notNil and: [dv < radix]]
		whileTrue:
		   [multiplier := multiplier / radix.
		    tokenValue := tokenValue + (multiplier * dv).
		    self nextChar]].
    ^#number
]

CokeScanner xLetter
[
    tokenValue := WriteStream on: (String new: 8).
    tokenValue nextPut: nextChar.
    [(characterTable at: self nextChar) == #xLetter
		or: [(characterTable at: nextChar) == #xDigit
		or: [(characterTable at: nextChar) == #xSign
		or: [(characterTable at: nextChar) == #xComma]]]]
	whileTrue:
	   [tokenValue nextPut: nextChar].
    tokenValue := tokenValue contents.
    ^#name
]

CokeScanner xSign
[
    | sign |
    sign := nextChar.
    (characterTable at: self peekChar) == #xDigit ifFalse: [^self xLetter].
    self nextChar; xDigit.
    sign == $- ifTrue: [tokenValue := tokenValue negated].
    ^#number
]

CokeScanner xOpen
[
    self nextChar.
    ^#open
]

CokeScanner xClose
[
    self nextChar.
    ^#close
]

CokeScanner xOpenBracket
[
    self nextChar.
    ^#openBracket
]

CokeScanner xCloseBracket
[
    self nextChar.
    ^#closeBracket
]

CokeScanner next
[
    ^(tokenType := super nextToken) notNil ifTrue: [self parse]
]

CokeScanner parse
[
    ^self perform: tokenType
]

CokeScanner number
[
    ^tokenValue.
]

CokeScanner string
[
    ^tokenValue.
]

CokeScanner name
[
    ^tokenValue asSymbol.
]

CokeScanner quote
[
    ^Expression with: #quote with: self next
]

CokeScanner backQuote
[
    | outerQuote node |
    outerQuote := quasiquoting.
    quasiquoting := true.
    node := self next.
    quasiquoting := outerQuote.
    ^Expression with: #quasiquote with: node.
]

CokeScanner comma
[
    ^Expression with: #unquote with: self next
]

CokeScanner commaAt
[
    ^Expression with: #'unquote-splicing' with: self next
]

CokeScanner open
[
    | list |
    list := WriteStream on: (Expression new: 8).
    [(tokenType := self nextToken) notNil and: [tokenType ~~ #close]]
	whileTrue: [list nextPut: self parse].
    ^list contents
]

CokeScanner close
[
    self error: 'unbalanced '')'''
]

"Syntactic sugar:
	[receiver unary]			=> (send 'unary receiver)
	[receiver binary arg]			=> (send 'binary receiver arg)
	[receiver key1: arg1 key2: arg2 ...]	=> (send 'key1:key2:... receiver arg1 arg2...)
"

Object isKeyword
[
    ^false
]

Symbol isKeyword
[
    ^self asString isKeyword
]

String isKeyword
[
    ^self last == $:
]

CokeScanner openBracket
[
    | list receiver selector arguments |
    list := OrderedCollection new.
    [(tokenType := self nextToken) notNil and: [tokenType ~~ #closeBracket]]
	whileTrue: [list addLast: self parse].
    list size >= 2 ifFalse: [self error: 'missing elements in message send syntax: ', list printString].
    receiver  := list removeFirst.
    selector  := list removeFirst.
    arguments := OrderedCollection new.
    selector isSymbol
	ifFalse:
	   [self error: 'selector is not a symbol in send syntax: [',
		receiver printString, ' ', selector printString, ' ...]'].
    list notEmpty ifTrue: [arguments addLast: list removeFirst].
    [list size >= 2 and: [selector isKeyword and: [list first isKeyword]]]
	whileTrue:
	   [selector := selector asString, list removeFirst asString.
	    arguments addLast:  list removeFirst].
    arguments addAllLast: list.
    ^(WriteStream on: (Expression new: 8))
	nextPut: #send;
	nextPut: (Expression with: #quote with: selector asSymbol);
	nextPut: receiver;
	nextPutAll: arguments;
	contents
]

CokeScanner closeBracket
[
    self error: 'unbalanced '']'''
]

