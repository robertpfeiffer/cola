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

  Last edited: 2005-12-21 20:43:45 by piumarta on emilia.local
"

{ import: ArrayLiteralNode }

ByteArrayNode : ArrayLiteralNode ()

ByteArrayNode encode: encoder
[
    constructor := encoder requireType: 'byteArray' at: position.
    value := (value collect: [:byte | byte value]) asByteArray.
    tag := encoder encodeLiteral: self.
    location := encoder push.
]

ByteArrayNode genInitialisation: gen
[
    gen initialiseByteArray: tag constructor: constructor with: value
]

ByteArrayNode println: indent
[
    self printIndent: indent.
    '#[ ' print.
    value do: [:elt | elt value print.  ' ' print].
    ']' println.
]
