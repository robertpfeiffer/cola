"							-*- Smalltalk -*-
  Copyright (c) 2007 Ian Piumarta
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

  Last edited: 2007-06-29 13:08:17 by piumarta on emilia.lax04.mtt
"

{ import: ParseNode }

"I represent a variable name and a runtime location for storing a value."

VarargNode : ParseNode (
)

VarargNode encode: encoder
[
    location := encoder push.
]

VarargNode generate: gen
[
    gen loadVararg: self location: location.
]

VarargNode println: indent
[
    self printIndent: indent.
    '...' println.
]
