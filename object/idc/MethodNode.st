"							-*- Smalltalk -*-
  Copyright (c) 2005, 2008 Ian Piumarta
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

  Last edited: 2008-06-18 12:08:17 by piumarta on emilia.local
"

{ import: BlockNode }

MethodNode : BlockNode (
    type		"String - name of type in which this method is installed"
    selector		"String - method selector"
    sequenceNumber	"Integer - method sequence number"
    variadic		"Boolean - true if method accepts arguments beyond last named"
    sourceEnd		"Integer - line number of first token following method source"
)

MethodNode withType: typeString selector: selectorString arguments: argumentStrings position: aPosition
[
    self := self withPosition: aPosition.
    type := typeString.
    selector := selectorString.
    sequenceNumber := 0.
    arguments := argumentStrings.
    variadic := false.
    sourceEnd := aPosition line.
]

MethodNode type			[ ^type ]
MethodNode selector		[ ^selector ]
MethodNode sequenceNumber	[ ^sequenceNumber ]
MethodNode isVariadic		[ ^variadic ]
MethodNode sourceEnd		[ ^sourceEnd ]

MethodNode beVariadic		[ variadic := true ]
MethodNode sourceEnd: lineNum	[ sourceEnd := lineNum ]

MethodNode external: externalNode	[ ^self addStatement: externalNode ]
MethodNode addTo: client		[ client addMethod: self ]

MethodNode encode: encoder
[
    "ensure type is declared"
    type := encoder encodeType: type position: position.
    type noteUsed.
    sequenceNumber := encoder noteImplementation: selector in: type name at: position.
    tag := encoder nextLiteralTag.
    ('_sizeof' = selector)
	ifTrue:
	   [type noteResized.
	    (position printString, ': WARNING: redefining _sizeof can break object allocation; check _sizeof carefully in all subtypes') putln].
    "push a new scope and increase level"
    scope := encoder beginMethod: self in: type.
    arguments addFirst: 'self'.		"<--------"
    arguments addFirst: 'stateful_self'.
    arguments   := arguments   collect: [:arg | encoder declareArgument:  arg position: position].
    temporaries := temporaries collect: [:tmp | encoder declareTemporary: tmp position: position].
    "variadic ifTrue: [temporaries addLast: (encoder declareVararg: 'nextArgument' position: position)]."
    arguments second tied: arguments first.	"<--------"
    type slots do: [:slot | encoder declareSlot: slot position: position type: type receiver: arguments first].	"<--------"
    "implicit ^self"
    (statements isEmpty or: [statements last isReturnNode not])
	ifTrue: [statements add: (ReturnNode withValue: (VariableNode withName: 'self' position: position) position: position)].
    statements do: [:stmt |
	stmt encode: encoder.
	encoder pop].
    "encode bodies of blocks within my method scope (BEFORE popping from encoder)"
    scope blocks do: [:block | block encodeBody: encoder].
    "pop my scope from encoder"
    encoder endMethod.
    literals := encoder literals.
    scope hasExports ifTrue: [stateConstructor := encoder requireType: 'vector' at: position].
]

MethodNode genDeclaration: gen
[
    literals do: [:literal | literal genDeclaration: gen].
    scope blocks do: [:block | block genDeclaration: gen].
]

MethodNode genDefinition: gen
[
    literals do: [:literal | literal genDefinition: gen].
    scope blocks do: [:block | block genDefinition: gen].
]

MethodNode genImplementation: gen
[
    scope blocks do: [:block | block genImplementation: gen in: self].
    gen beginMethod: self in: type arguments: arguments variadic: variadic sequence: sequenceNumber.
    gen beginSequence: self.
    gen debugMethod: self.
    scope hasExports ifTrue: [gen createStateVector: scope stateVectorSize inScope: scope tag constructor: stateConstructor].
    "declarations"
    temporaries do: [:var | var isFree ifFalse: [gen declareTemporary: var]].
    gen declareStack: scope stackSize.
    scope hasNLR ifTrue: [gen declareNonLocalReturn].
    variadic ifTrue: [gen declareVariadic: arguments last].
    "definitions"
    temporaries do: [:var | var isFree ifFalse: [gen defineTemporary: var]].
    gen defineStack: scope stackSize.
    arguments   do: [:var | var isFree ifTrue: [gen saveArgument:  var]].
    "
    variadic
	ifTrue:
	   [| var |
	    var := temporaries last.
	    gen defineVariadic: arguments last.
	    var isFree ifTrue: [gen saveTemporary: var]].
    "
    scope hasNLR ifTrue: [gen defineNonLocalReturn].
    "body"
    gen debugLine: position.
    statements do: [:stmt | stmt generate: gen].
    gen debugReturn: position.
    gen endSequence: self.
]


MethodNode genInitialisation: gen
[
    literals do: [:literal | literal genInitialisation: gen].
    scope blocks do: [:block | block genInitialisation: gen].
    gen initialiseMethod: selector in: type sequence: sequenceNumber.
]

MethodNode println: indent
[
    self printIndent: indent.
    ('Method ', type, ' ', selector) print.
    variadic ifTrue: [' ...' print].
    ' [' println.
    super println: indent + 1.
    self printIndent: indent.
    ']' println.
]
