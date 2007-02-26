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

  Last edited: 2006-03-29 15:13:28 by piumarta on emilia.local
"

{ import: ParseNode }

"I represent an included C header file."

IncludeNode : ParseNode ( name )

IncludeNode withName: nameString position: aPosition
[
    self := self withPosition: aPosition.
    name := nameString.
]

IncludeNode addTo: client		[ client addInclude: self ]
IncludeNode encode: encoder		[]

IncludeNode genDeclaration: gen		[]
IncludeNode genDefinition: gen		[]
IncludeNode genImplementation: gen	[ gen genInclude: name ]
IncludeNode genInitialisation: gen	[]

IncludeNode println: indent
[
    self printIndent: indent.
    ('Include <', name, '>') println.
]
