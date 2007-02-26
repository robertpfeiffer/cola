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

  Last edited: 2006-02-24 11:08:50 by piumarta on emilia.local
"

{ import: LiteralNode }

"I represent a symbol appearing as a literal within the program."

SymbolNode : LiteralNode ()

SymbolNode fromString: aString position: aPosition
[
    ^self withValue: aString position: aPosition
]

SymbolNode encode: encoder
[
    constructor := encoder requireType: 'symbol' at: position.
    tag := encoder encodeLiteral: self.
    location := encoder push.
]

SymbolNode genInitialisation: gen
[
    "Pretend to be a String, but with a different constructor."
    gen initialiseString: tag constructor: constructor with: value
]

SymbolNode generate: gen
[
    gen loadLiteral: tag to: location
]

SymbolNode println: indent
[
    self printIndent: indent.
    $# put.  $' put.  value  print.  $' put.  $\n put.
]
