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

  Last edited: 2005-12-21 20:56:19 by piumarta on emilia.local
"

{ import: ParseNode }

"I represent something primitive and unparsed at the top level: plain text to pass along."

ExternNode : ParseNode ( code )

ExternNode withCode: codeString position: aPosition
[
    self := self withPosition: aPosition.
    code := codeString.
]

ExternNode addTo: client	[ client addExtern: self ]

ExternNode encode: encoder	[]

ExternNode genDeclaration: gen		[]
ExternNode genDefinition: gen		[]
ExternNode genImplementation: gen	[]
ExternNode genInitialisation: gen	[ gen genExtern: code ]

ExternNode println: indent
[
    'Extern { ' print.
    code print.
    ' }' println.
]
