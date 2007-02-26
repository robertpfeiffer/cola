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

  Last edited: 2006-03-25 09:56:34 by piumarta on emilia.local
"

{ import: SequenceNode }

"I represent a sequence of imperatives at the top-level to be executed immediately."

ExecNode : SequenceNode (
    stateConstructor	"type and selector names to create my closed-over state vector"
    "declaration"	"PrototypeNode immediately preceding this immediate block"
)

"
ExecNode inDeclaration: d	[ declaration := d ]
"

ExecNode addTo: client
[
    client addExec: self
]

ExecNode encode: encoder
[
    scope := encoder beginBlock.	"NOTE: increases lexical level by 1"
"
    declaration notNil ifTrue: [temporaries addLast: 'self'].
"
    temporaries := temporaries collect: [:tmp | encoder declareTemporary: tmp position: position].
    statements do: [:stmt |
	stmt encode: encoder.
	encoder pop].
    "encode literal blocks"
    scope blocks do: [:block | block encodeBody: encoder].
    encoder endBlock.
    literals := encoder literals.
    scope hasExports ifTrue: [stateConstructor := encoder requireType: 'vector' at: position].
]

ExecNode genDeclaration: gen
[
    literals do: [:literal | literal genDeclaration: gen].
    scope blocks do: [:block | block genDeclaration: gen].
]

ExecNode genDefinition: gen
[
    literals do: [:literal | literal genDefinition: gen].
    scope blocks do: [:block | block genDefinition: gen].
]

ExecNode genImplementation: gen
[
    scope blocks do: [:block | block genImplementation: gen].
]

ExecNode genInitialisation: gen
[
    self genInitialisation: gen into: nil
]

ExecNode genInitialisation: gen into: definitionNode
[
    literals do: [:literal | literal genInitialisation: gen].
    scope blocks do: [:block | block genInitialisation: gen].
    gen beginSequence: self.
    scope hasExports ifTrue: [gen createStateVector: scope stateVectorSize inScope: scope tag constructor: stateConstructor].
    temporaries do: [:temp | temp isFree ifFalse: [gen declareTemporary: temp]].
    gen declareStack: scope stackSize.
    temporaries do: [:temp | temp isFree ifFalse: [gen defineTemporary: temp]].
    gen defineStack: scope stackSize.
"   declaration notNil ifTrue: [gen storeTemporary: temporaries last withPrototype: declaration]."
    statements do: [:stmt | stmt generate: gen].
"   declaration notNil ifTrue: [gen storePrototype: declaration withTemporary: temporaries last]."
    definitionNode notNil
	ifTrue:
	   [statements isEmpty
		ifTrue:  [gen initialiseVariable: definitionNode name]
		ifFalse: [gen initialiseVariable: definitionNode name location: statements last location]].
    gen endSequence: self.
]

ExecNode println: indent
[
    self printIndent: indent.
    'Exec [' println.
    super println: indent + 1.
    ']' println.
]
