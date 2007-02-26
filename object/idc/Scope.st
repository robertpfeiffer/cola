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

  Last edited: 2006-01-13 14:40:56 by piumarta on emilia.local
"

"I represent a lexical scope (a block) and any local state defined within it."

{ import: Dictionary }
{ import: SlotVariableNode }
{ import: ArgumentVariableNode }
{ import: TemporaryVariableNode }

Scope : Dictionary (
    argumentCount	"the number of argument variables I define"
    temporaryCount	"the number of temporary variables I define"
    stackSize		"the number of stack locations I would use if bytecoded"
    outer		"my enclosing Scope"
    blocks		"the BlockNodes occuring within me"
    tag			"a number unique to me within Scopes"
    level		"the number of lexial levels I am removed from the global scope"
    lastOffset		"the state vector size needed for my state appearing free in blocks"
    encodings		"a cache of encoded variables from enclosing scopes"
    exportFlag		"true if any of my state appears free in an enclosed scope"
    importFlag		"true if any state from an enclosing scope appears free in me"
    nlrFlag		"true if a nonlocal return traverses my lexical level"
)


Scope initialize
[
    super initialize.
    argumentCount := 0.
    temporaryCount := 0.
    stackSize := 0.
    outer := nil.
    blocks := OrderedCollection new.
    tag := 0.
    level := 0.
    lastOffset := 0.
    encodings := Dictionary new.
    exportFlag := false.
    importFlag := false.
    nlrFlag := false.
]

Scope withOuter: aScope
[
    self := self new.
    outer := aScope.
    level := outer level.	"nesting level DOES NOT increase automatically"
    tag := outer tag + 1.
]

Scope newScope			[ ^self withOuter: self ]

Scope stackSize: size		[  stackSize := size ]
Scope stackSize			[ ^stackSize ]

Scope addBlock: blockNode	[  blocks add: blockNode ]
Scope blocks			[ ^blocks ]

Scope outer			[ ^outer ]
Scope tag			[ ^tag ]

Scope increaseLevel		[  level := level + 1 ]
Scope level			[ ^level ]
Scope nextOffset		[ ^lastOffset := lastOffset + 1 ]

Scope exportState		[  exportFlag := true ]
Scope hasExports		[ ^exportFlag ]

Scope importState		[  importFlag := true ]
Scope hasImports		[ ^importFlag ]

Scope needsOuterScope		[ ^importFlag or: [nlrFlag] ]

Scope hasNLR			[ ^nlrFlag ]

Scope noteNLR
[
    nlrFlag := true.
    "propagate up to outermost method"
    outer notNil ifTrue: [outer noteNLR].
]

Scope stateVectorSize
[
    | size |
    size := 0.
    self do: [:var | var isFree ifTrue: [size := size + 1]].
    ^size
]

Scope encode: nameString
[
    | var |
    "answer cached encoding if present"
    (var := encodings at: nameString ifAbsent: []) notNil ifTrue: [^var].
    "answer nil if unefined"
    (var := self encode: nameString from: self) isNil ifTrue: [^var].
    "note closed-over state from here to defining scope of free variable"
    var isFree ifTrue: [self closeOver: var scope].
    "memoise result"
    ^encodings at: nameString put: var
]

Scope encode: nameString from: innerScope
[
    | var |
    "lookup locally; otherwise in enclosing scope if present"
    var := self at: nameString ifAbsent: [^outer isNil ifFalse: [outer encode: nameString from: innerScope]].
    "global vars or vars from the same lexical level are not free"
    "NOTE: level will be the SAME for enclosing scope of any open-coded block, even though scopes are nested"
    (var isGlobal or: [level == innerScope level]) ifTrue: [^var].
    "otherwise convert to nonlocal ref"
    ^var freeWithin: innerScope
]

Scope closeOver: outerScope
[
    "note that the receiver imports state from the outer scope; propagate up"
    self == outerScope
	ifFalse:
	   [self importState.
	    outer closeOver: outerScope].
]

Scope declare: nameString as: variableType position: aPosition
[
    ^self at: nameString put: (variableType withName: nameString position: aPosition scope: self)
]

Scope declareSlot: name position: position type: type receiver: selfNode
[
    ^(self encode: name) isNil
	ifTrue:
	   [(self declare: name as: SlotVariableNode position: position) type: type receiver: selfNode]
]

Scope declareArgument: name position: position
[
    ^(self encode: name) isNil
	ifTrue:
	   [(self declare: name as: ArgumentVariableNode position: position) index: (argumentCount := argumentCount + 1)]
]

Scope declareTemporary: name position: position
[
    ^(self encode: name) isNil
	ifTrue:
	   [(self declare: name as: TemporaryVariableNode position: position) index: (temporaryCount := temporaryCount + 1)]
]
