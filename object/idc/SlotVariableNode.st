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

  Last edited: 2008-12-01 15:16:54 by piumarta on ubuntu.piumarta.com
"

"I represent a named field in an object, usually the receiver within a method
 definition.  (In a class-based system that field would be a named instance
 variable.)"

{ import: Object }

SlotVariableNode : Object (
    name	"String - slot name"
    position	"ScannerPosition - first use of name in current context"
    scope	"Scope - in which name is defined"
    receiver	"EncodedVariableNode - the receiver"
    type	"TypeNode - receiver's type"
)

SlotVariableNode initialize
[
    super initialize.
    type := nil.
]

SlotVariableNode withName: nameString position: scannerPosition scope: aScope
[
    self := self new.
    name := nameString.
    position := scannerPosition.
    scope := aScope.
    receiver := nil.
    type := nil.
]

SlotVariableNode type: aType receiver: selfNode
[
    type := aType.
    receiver := selfNode.
]

SlotVariableNode name		[ ^name ]
SlotVariableNode scope		[ ^scope ]

SlotVariableNode isGlobal	[ ^false ]
SlotVariableNode isFree		[ ^receiver isFree ]

SlotVariableNode freeWithin: innerScope
[
    receiver freeWithin: innerScope.
]

SlotVariableNode generate: gen location: location
[
    ^gen loadSlot: self type: type location: location
]

SlotVariableNode generateStore: gen location: location
[
    ^gen storeSlot: self type: type location: location
]

SlotVariableNode generate: gen freeIn: innerLevel location: location
[
    ^gen loadFreeSlot: name type: type name scope: scope tag outer: innerLevel - scope level offset: receiver tied offset location: location
]

SlotVariableNode generateStore: gen freeIn: innerLevel location: location
[
    ^gen storeFreeSlot: name type: type name scope: scope tag outer: innerLevel - scope level offset: receiver tied offset location: location
]
