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

  Last edited: 2005-12-21 20:52:43 by piumarta on emilia.local
"

{ import: LiteralNode }

CharacterNode : LiteralNode ()

CharacterNode encode: encoder
[
    constructor := encoder requireType: 'character' at: position.
    tag := encoder encodeLiteral: self.
    location := encoder push.
]

CharacterNode genInitialisation: gen
[
    gen initialiseCharacter: tag constructor: constructor with: value
]

CharacterNode generate: gen
[
    gen loadLiteral: tag to: location
]

CharacterNode println: indent
[
    self printIndent: indent.
    value println.
]
