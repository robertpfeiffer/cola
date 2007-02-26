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

  Last edited: 2005-12-21 20:59:43 by piumarta on emilia.local
"


"I represent something primitive and unparsed within a method: plain text to pass along."

{ import: ParseNode }

PrimitiveNode : ParseNode ( code mtype )

PrimitiveNode withCode: codeString position: aPosition
[
    self := self withPosition: aPosition.
    code := codeString.
    mtype := nil.
]

PrimitiveNode println: indent
[
    self printIndent: indent.
    'Primitive { ' print.
    code print.
    self printIndent: indent.
    '}' println.
]

PrimitiveNode encode: encoder
[
    mtype := encoder methodType.
    "we're a statement so we need to generate a final value"
    location := encoder push.
]

PrimitiveNode generate: gen
[
    gen genPrimitive: code in: mtype.
    gen loadNil: location.
]
