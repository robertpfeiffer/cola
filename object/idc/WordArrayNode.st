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

  Last edited: 2006-02-24 11:09:02 by piumarta on emilia.local
"

{ import: ArrayLiteralNode }

"I am an ArrayLiteralNode that contains only SmallIntegers. "

WordArrayNode : ArrayLiteralNode ()

WordArrayNode encode: encoder
[
    constructor := encoder requireType: 'wordArray' at: position.
    value := (value collect: [:word | word value]) asWordArray.
    tag := encoder encodeLiteral: self.
    location := encoder push.
]

WordArrayNode genDefinition: gen
[
    super genDefinition: gen.
    gen defineWordArray: tag withElements: value.
]

WordArrayNode genInitialisation: gen
[
    gen initialiseWordArray: tag constructor: constructor with: value
]

WordArrayNode println: indent
[
    self printIndent: indent.
    '#{ ' print.
    value do: [:elt | elt value print.  ' ' print].
    '}' println.
]
