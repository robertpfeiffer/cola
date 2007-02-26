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

  Last edited: 2007-02-21 20:21:32 by piumarta on emilia.lax02.mtt
"

{ import: ParseNode }

"I represent a variable name and a runtime location for storing a value."

VariableNode : ParseNode (
    name	"String - my identifier"
    variable	"EncodedVariableNode - my physical location at runtime"
    level	"SmallInteger - lexical (nesting) depth at my point of definition"
)

VariableNode isVariableNode	[ ^true ]
ParseNode isVariableNode	[ ^false ]

VariableNode withName: nameString position: aPosition
[
    self := self withPosition: aPosition.
    name := nameString.
]

VariableNode name	[ ^name ]

VariableNode isSuper	[ ^name = 'super' ]
ParseNode isSuper	[ ^false ]

VariableNode isThis	[ ^name = 'this' ]
ParseNode isThis	[ ^false ]

VariableNode encode: encoder
[
    "Encode the receiver as an r-value."
    variable := encoder encode: name position: position.
    level := encoder level.	"the encoder asks the current scope"
    location := encoder push.
]

VariableNode encodeLvalue: encoder location: aLocation
[
    "Encode the receiver as an l-value."
    variable := encoder encode: name position: position.
    level := encoder level.
    location := aLocation.	"output location is input location"
]

VariableNode generate: gen
[
    variable isFree
	ifTrue:  [variable generate: gen freeIn: level location: location]
	ifFalse: [variable generate: gen location: location].
]

VariableNode generateStore: gen
[
    variable isFree
	ifTrue:  [variable generateStore: gen freeIn: level location: location]
	ifFalse: [variable generateStore: gen location: location].
]

VariableNode println: indent
[
    self printIndent: indent.
    name println.
]
