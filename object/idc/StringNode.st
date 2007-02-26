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

  Last edited: 2006-02-24 11:08:44 by piumarta on emilia.local
"

{ import: LiteralNode }

"I represent a literal string appearing within the program."

StringNode : LiteralNode ()

StringNode fromString: aString position: aPosition
[
    ^self withValue: aString position: aPosition
]

StringNode encode: encoder
[
    constructor := encoder requireType: 'string' at: position.
    tag := encoder encodeLiteral: self.
    location := encoder push.
]

StringNode genInitialisation: gen
[
    gen initialiseString: tag constructor: constructor with: value
]

StringNode generate: gen
[
    gen loadLiteral: tag to: location
]

StringNode println: indent
[
    self printIndent: indent.
    $' put.  value print.  $' put.  $\n put.
]
