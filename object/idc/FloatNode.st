"							-*- Smalltalk -*-
  Copyright (c) 2005, 2006 Ian Piumarta
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

  Last edited: 2006-02-05 01:13:26 by piumarta on emilia.local
"

{ import: LiteralNode }

FloatNode : LiteralNode ()

FloatNode fromString: aString position: aPosition
[
    "xxx TODO: convert to Float here, when Floats are implemented"
    ^self withValue: aString position: aPosition.
]

FloatNode encode: encoder
[
    constructor := encoder requireType: 'float' at: position.
    tag := encoder encodeLiteral: self.
    location := encoder push.
]

FloatNode genDefinition: gen
[
    super genDefinition: gen.
    gen defineFloat: tag withValue: value.
]

FloatNode genInitialisation: gen	[ gen initialiseFloat: tag constructor: constructor with: value ]

FloatNode generate: gen			[ gen loadLiteral: tag to: location ]

FloatNode println: indent
[
    self printIndent: indent.
    'Float(' print.  value print.  ')' println.
]
