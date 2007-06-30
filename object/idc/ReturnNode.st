"							-*- Smalltalk -*-
  Copyright (c) 2005-2007 Ian Piumarta
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

  Last edited: 2007-06-29 13:32:01 by piumarta on emilia.lax04.mtt
"

{ import: ParseNode }

ReturnNode : ParseNode ( value nonLocal variadic )

ParseNode isReturnNode	[ ^false ]
ReturnNode isReturnNode	[ ^true ]

ReturnNode withValue: aNode position: aPosition
[
    self := self withPosition: aPosition.
    value := aNode.
    nonLocal := false.
    variadic := false.
]

ReturnNode encode: encoder
[
    location := value encode: encoder; location.
    "explicit return from deeper than method level -> NLR"
    (nonLocal := encoder level > 1) ifTrue: [encoder noteNLR].
    variadic := encoder scope hasVarargs.
]

ReturnNode generate: gen
[
    value generate: gen.
    variadic ifTrue: [gen endVariadic].
    gen debugReturn: position.
    nonLocal ifTrue: [gen genNonLocalReturn: value] ifFalse: [gen genReturn: value].
]

ReturnNode println: indent
[
    self printIndent: indent.
    'Return' println.
    value println: indent + 1.
]


LocalReturnNode : ReturnNode ()

"I represent an IMPLICT return added at the end of a block to return nil."

LocalReturnNode encode: encoder
[
    value := value encode: encoder.
    variadic := encoder scope hasVarargs.
]

LocalReturnNode println: indent
[
    self printIndent: indent.
    'LocalReturn' println.
    value println: indent + 1.
]
