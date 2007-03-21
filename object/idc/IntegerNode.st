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

  Last edited: 2007-03-21 16:04:46 by piumarta on emilia.local
"

{ import: LiteralNode }

IntegerNode : LiteralNode ()

IntegerNode fromString: aString position: aPosition
[
    | base aStream |
    aStream := aString readStream.
    "support 0x... for hex (but do NOT support 0... for octal)"
    (aString beginsWith: '0x')
	ifTrue:  [base := 16.
		  aStream skip: 2]
	ifFalse: [base := 10].
    ^self withValue: (Integer readFrom: aStream base: base) position: aPosition.
]

IntegerNode encode: encoder
[
    constructor := encoder
	requireType: (value isSmallInteger
			ifTrue:  ['integer']
			ifFalse: [value negative ifTrue: ['largeNegativeInteger'] ifFalse: ['largePositiveInteger']])
	at: position.
    tag := encoder encodeLiteral: self.
    location := encoder push.
]

IntegerNode generate: gen		[ gen loadLiteral: tag to: location ]

IntegerNode genInitialisation: gen
[
    value isSmallInteger
	ifTrue:  [gen initialiseInteger:      tag constructor: constructor with: value]
	ifFalse: [gen initialiseLargeInteger: tag constructor: constructor with: value]
]

IntegerNode println: indent
[
    self printIndent: indent.
    'Integer(' print.  value print.  ')' println.
]
