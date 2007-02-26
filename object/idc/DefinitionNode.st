"							-*- Smalltalk -*-
  Copyright (c) 2006 Ian Piumarta
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

  Last edited: 2006-03-25 11:41:47 by piumarta on emilia.local
"


"I represent global variable declaration and definition."

{ import: ParseNode }

DefinitionNode : ParseNode (
    name	"the name of the variable I declare"
    exec	"ExecNode with defining value, or nil if external"
    used	"true if the variable is referenced"
    external	"true if the value is defined in an imported library"
)

Object isDefinitionNode		[ ^false ]
DefinitionNode isDefinitionNode	[ ^true ]

DefinitionNode withName: nameString exec: execNode position: aPosition
[
    self := self withPosition: aPosition.
    name := nameString.
    exec := execNode.
    used := false.
    external := false.
]

DefinitionNode name		[ ^name ]

DefinitionNode noteUsed		[  used := true ]
DefinitionNode beExternal	[  external := true ]
DefinitionNode isExternal	[ ^external ]

DefinitionNode addTo: client		[ client addDefinition: self ]

DefinitionNode encode: encoder
[
    "make sure we init if definining, even if not used"
    external
	ifFalse:
	   [used := true.
	    exec encode: encoder]
]

DefinitionNode genDeclaration: gen	[ external ifFalse: [exec genDeclaration: gen] ]

DefinitionNode genDefinition: gen
[
    used ifTrue: [gen defineVariable: self].
    external ifFalse: [exec genDefinition: gen].
]

DefinitionNode genImplementation: gen	[ external ifFalse: [exec genImplementation: gen] ]

DefinitionNode genInitialisation: gen
[
    used
	ifTrue:
	   [external
	        ifTrue:  [gen initialiseExternal: name ]
		ifFalse:
		   [exec genInitialisation: gen into: self]]
]

DefinitionNode println: indent
[
    self printIndent: indent.
    ('Definition ', name printString, ' = ') println.
    exec println: indent + 1
]
