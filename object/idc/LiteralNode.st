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

  Last edited: 2005-12-21 20:41:39 by piumarta on emilia.local
"

{ import: ParseNode }

LiteralNode : ParseNode (
    value	"value -- either the literal verbatim, or a collection of nodes (for array types)"
    tag		"a number unique to me"
    constructor	"the type and selector names for building the represented literal"
)

LiteralNode isLiteralNode [ ^true ]
Object isLiteralNode [ ^false ]

LiteralNode withValue: anObject position: aPosition
[
    self := self withPosition: aPosition.
    value := anObject.
    tag := nil.
    constructor := nil.
]

LiteralNode value [ ^value ]
LiteralNode tag [ ^tag ]

"LiterlNodes compare on the value they represent.  Assuming they are
 read-only, literals with equal values can be shared by all uses
 within the program."

LiteralNode hash		[ ^value hash ]
LiteralNode = aLiteralNode	[ ^self family == aLiteralNode family and: [value = aLiteralNode value] ]

LiteralNode genDeclaration: gen	[ gen declareLiteral: tag ]
LiteralNode genDefinition: gen	[ gen defineLiteral: tag ]
