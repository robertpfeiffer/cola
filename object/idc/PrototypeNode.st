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

  Last edited: 2006-09-30 12:42:10 by piumarta on emilia.local
"


"I represent a type and (global) variable declaration (and
 corresponding definition if used in the current translation unit)."

{ import: ParseNode }

PrototypeNode : ParseNode (
    name	"the name of the type I declare"
    base	"declaration of my base type or nil if no base type"
    slots	"OrderedCollection of my slot names, including all base slots"
    used	"true if the corresponding global value is referenced"
    external	"true if the value is defined in an imported library"
)

Object isPrototypeNode [ ^false ]
PrototypeNode isPrototypeNode [ ^true ]

PrototypeNode withName: nameString base: baseString slots: slotStrings position: aPosition
[
    self := self withPosition: aPosition.
    name := nameString.
    base := baseString.
    slots := slotStrings.
    used := false.
    external := false.
]

PrototypeNode name		[ ^name ]
PrototypeNode base		[ ^base ]
PrototypeNode slots		[ ^slots ]

PrototypeNode noteUsed		[  used := true ]
PrototypeNode beExternal	[  external := true ]
PrototypeNode isExternal	[ ^external ]

PrototypeNode slots: slotCollection	[ ^slots := slotCollection ]

PrototypeNode = aPrototypeNode		[ ^aPrototypeNode isPrototypeNode and: [slots = aPrototypeNode slots] ]

PrototypeNode addTo: client		[ client addType: self ]

PrototypeNode encode: encoder
[
    "make sure the base type has been declared"
    base notNil ifTrue: [encoder encode: base position: position].
    "make sure we can install the implicit methods if defining the type"
    external
	ifFalse:
	   [used := true.
	    encoder
		addSelector: '_sizeof';    noteImplementation: '_sizeof'    in: name at: position;
		addSelector: '_debugName'; noteImplementation: '_debugName' in: name at: position].
]

"Do not generate anything (runtime import of external prorotype, local
 definition of internal prototype) unless at least one message is sent
 to my prototype."

PrototypeNode genDeclaration: gen	[ gen declareType: self ]
PrototypeNode genDefinition: gen	[ used ifTrue: [gen defineType: self] ]
PrototypeNode genImplementation: gen	[ (used and: [external not]) ifTrue: [gen implementType: self] ]

PrototypeNode genInitialisation: gen
[
    used
	ifTrue:
	   [external
	        ifTrue:  [gen initialiseExternal: name ]
		ifFalse: [gen initialiseType: self name in: base]]
]

PrototypeNode println: indent
[
    self printIndent: indent.
    ('Type ', name printString, ' = ', base printString, ' + ', slots printString) println.
]
