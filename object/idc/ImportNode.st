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

  Last edited: 2007-09-03 13:14:33 by piumarta on ubuntu
"

{ import: ParseNode }

"I represent an imported runtime library."

ImportNode : ParseNode (
    name	"String -- the name of the imported file"
    included	"non-nil if I was imported indirectly through another import"
)

ImportNode withName: nameString position: aPosition
[
    self := self withPosition: aPosition.
    name := nameString.
]

ImportNode withName: nameString included: includedFlag position: aPosition
[
    self := self withPosition: aPosition.
    name := nameString.
    included := includedFlag.
]

ImportNode encode: encoder
[
    "_object _import: 'name'"
    encoder
	requireType: 'object' at: position;
	addSelector: '_import:'.
]

ImportNode genDeclaration: gen		[]
ImportNode genDefinition: gen		[]
ImportNode genImplementation: gen	[]
ImportNode genInitialisation: gen	[ included ifFalse: [gen import: name] ]

ImportNode println: indent
[
    self printIndent: indent.
    ('Import <', name, '>') println.
]
