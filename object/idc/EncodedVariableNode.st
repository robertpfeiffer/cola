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

  Last edited: 2005-12-21 20:39:12 by piumarta on emilia.local
"

{ import: Object }

"I represent the concrete runtime location of a named variable."

EncodedVariableNode : Object (
    name	"String containing the original name"
    position	"ScannerPosition for the first use of this name in the current context"
    scope	"Scope in which name is defined"
    offset	"integer offset into state vector for a free variable, or nil if local"
)

EncodedVariableNode withName: nameString position: aPosition scope: aScope
[
    self := self new.
    name := nameString.
    position := aPosition.
    scope := aScope.
    offset := nil.
]

EncodedVariableNode name	[ ^name ]
EncodedVariableNode scope	[ ^scope ]
EncodedVariableNode offset	[ ^offset ]
EncodedVariableNode isFree	[ ^offset notNil ]

EncodedVariableNode freeWithin: innerScope
[
    "non-nil means the receiver is already in the state vector"
    offset isNil ifTrue: [offset := scope nextOffset].
    scope exportState.		"ensure creation of state vector at runtime"
]

EncodedVariableNode generate: gen freeIn: innerLevel location: location
[
    "If (INNERLEVEL - SCOPE LEVEL) > 0 then the reference is non local: use that
     difference to climb up through the closures to the containing state vector
     where the var is stored at OFFSET.
       If (INNERLEVEL - SCOPE LEVEL) = 0 then SCOPE TAG is the tag of a
     locally-visible state vector and OFFSET identifies the variable within it."
    ^gen loadFree: name scope: scope tag outer: innerLevel - scope level offset: offset location: location
]

EncodedVariableNode generateStore: gen freeIn: innerLevel location: location
[
    "See comment above."
    ^gen storeFree: name scope: scope tag outer: innerLevel - scope level offset: offset location: location
]
