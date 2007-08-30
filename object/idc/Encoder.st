"							-*- Smalltalk -*-
  Copyright (c) 2005-2007 Ian Piumarta
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

  Last edited: 2007-08-24 17:09:15 by piumarta on emilia
"

{ import: Object }
{ import: Scope }
{ import: SendNode }
{ import: GlobalVariableNode }

"I am responsible for mapping abstract symbolic names for things onto
 corresponding concrete runtime entities."

Encoder : Object (
    globalContext	"an object responsible for encoding type names and globals"
    globals		"a cache of the globals in the globalContext"
    scope		"the current lexical scope (declarations, etc.)"
    tempCount		"the current number of live, unnamed temporaray variables"
    tempMax		"the largest value attained by tempCount"
    outerCount		"OrderedCollection of tempCounts in outer scopes"
    selectors		"Dictionary mapping plain selector names onto mangled names"
    literals		"OrderedCollection of all literals used in this scope"
    literalMap		"Dictionary mapping LiteralNodes values onto their unique tags"
    literalTag		"the next unique tag to assign to a literal"
    methodType		"PrototypeNode of the method (inside a method defn) or nil (outside)"
    specialEncoders	"Dictionary mapping macro/arithmetic/special selectors to specific encoding methods"
    implementations	"Dictionary mapping type names onto Dictionary of selectors onto implementation counts"
    knownSelectors	"IdentitySet of known selectors"
)

Encoder withGlobalContext: aGlobalContext knownSelectors: knownSelectorSet
[
    self := self new.
    globalContext := aGlobalContext.
    globals := scope := Scope new.
    tempCount := tempMax := 0.
    outerCount := OrderedCollection new.
    selectors := Dictionary new.
    literals := OrderedCollection new.
    literalMap := Dictionary new.
    literalTag := 0.
    methodType := nil.
    specialEncoders := Dictionary new.
    implementations := Dictionary new.
    globalContext inlineMacroSelectors   ifTrue: [specialEncoders addAll: SendNode macroEncoders].
    globalContext inlineSpecialSelectors ifTrue: [specialEncoders addAll: SendNode specialEncoders].
    globalContext inlineTaggedArithmetic ifTrue: [specialEncoders addAll: SendNode taggedEncoders].
    knownSelectors := knownSelectorSet.
]

Encoder withGlobalContext: aGlobalContext
[
    self := self new.
    globalContext := aGlobalContext.
    globals := scope := Scope new.
    tempCount := tempMax := 0.
    outerCount := OrderedCollection new.
    selectors := Dictionary new.
    literals := OrderedCollection new.
    literalMap := Dictionary new.
    literalTag := 0.
    methodType := nil.
    specialEncoders := Dictionary new.
    implementations := Dictionary new.
    globalContext inlineMacroSelectors   ifTrue: [specialEncoders addAll: SendNode macroEncoders].
    globalContext inlineSpecialSelectors ifTrue: [specialEncoders addAll: SendNode specialEncoders].
    globalContext inlineTaggedArithmetic ifTrue: [specialEncoders addAll: SendNode taggedEncoders].
]

Encoder scope		[ ^scope ]
Encoder selectors	[ ^selectors ]
Encoder level		[ ^scope level ]
Encoder noteNLR		[  scope noteNLR ]

Encoder methodType	[ ^methodType ]

Encoder superTypeAt: position
[
    "sent from within SendNode with 'super' receiver"
    methodType base isNil ifTrue: [globalContext errorNoSuper: methodType name at: position].
    ^methodType base.
]

Encoder thisTypeAt: position
[
    "sent from within SendNode with 'this' receiver"
    ^methodType name.
]

NameManglingTable : Array ()
[
    "For (relative) readability:
         a-zA-Z0-9 -> a-zA-Z0-9
	 :         -> _
	 .         -> _<2-digit-hex-value>
     Since characters > $\x7E are illegal, ':' cannot start an
     identifier and no identifier can start with [0-7], unmangling a
     '_' is unambiguous. "
    NameManglingTable := Array new: 256.
    NameManglingTable atAllPut: #'mangleOther:to:'.
    NameManglingTable at: $: asciiValue put: #'mangleColon:to:'.
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
	do: [:char | NameManglingTable at: char asciiValue put: #'mangleLetter:to:'].
]

Encoder mangleSelector: aString
[
    | mangled |
    mangled := (String new: aString size * 2) writeStream.
    aString do: [:char | self perform: (NameManglingTable at: char asciiValue) with: char with: mangled].
    ^mangled contents
]

Encoder mangleLetter: aCharacter to: aStream	[ aStream nextPut: aCharacter ]
Encoder mangleColon: aCharacter to: aStream	[ aStream nextPut: $_ ]

Encoder mangleOther: aCharacter to: aStream
[
    | ascii |
    ascii := aCharacter asciiValue.
    aStream nextPut: $_.
    ascii < 127
	ifTrue:
	   [aStream
		nextPut: (Character digitValue: ascii // 16);
		nextPut: (Character digitValue: ascii \\ 16)].
]

Encoder addSelector: aSelector
[
    selectors at: aSelector ifAbsent: [selectors at: aSelector put: (self mangleSelector: aSelector)]
]

Encoder addSelector: aSelector at: aPosition
[
    | symbol |
    selectors at: aSelector ifAbsent: [selectors at: aSelector put: (self mangleSelector: aSelector)].
    knownSelectors
	ifTrue:
	    [(knownSelectors includes: (symbol := aSelector asSymbol))
		ifFalse:
		    [self warn: aSelector, ' may not be implemented' at: aPosition.
		     knownSelectors add: symbol]]
]

Encoder noteImplementation: selectorName in: typeName at: aPosition
[
    | dict count |
    dict := implementations at: typeName ifAbsent: [implementations at: typeName put: Dictionary new].
    count := dict at: selectorName ifAbsent: [dict at: selectorName put: -1].
    count < 0 ifFalse: [self warn: typeName, '.', selectorName, ' redefined' at: aPosition].
    ^dict at: selectorName put: count + 1
]

Encoder requireType: typeName at: aPosition
[
    | constructor |
    "typeName is 'built-in' to the global context; the constructor is concreteName -> cloningSelector."
    constructor := globalContext constructorFor: typeName.
    "make sure we have a prototype to clone"
    self encode: constructor key position: aPosition.
    "if the value isn't nil, make sure we have a selector to send"
    constructor value notNil ifTrue: [self addSelector: constructor value].
    ^constructor
]

Encoder requireBooleanAt: aPosition
[
    self
	encode: (globalContext constructorFor: 'true')  key position: aPosition;
	encode: (globalContext constructorFor: 'false') key position: aPosition.
]

Encoder beginScope	[ ^scope := scope newScope ]	"scope only: no level change"
Encoder endScope	[ ^scope := scope outer ]

Encoder beginSequence	[ ^self beginScope ]		"ditto"
Encoder endSequence	[ ^self endScope ]

Encoder beginBlock
[
    "ASSUME: tempCount == 0"
    scope stackSize: tempMax.		"save tempMax for later"
    outerCount addLast: tempCount.	"save tempCount for later"
    self beginSequence.			"push scope"
    tempCount := tempMax := 0.		"new unnamed temp space"
    scope increaseLevel.		"new lexical nesting level"
    ^scope.
]

Encoder endBlock
[
    scope stackSize: tempMax.		"save final tempMax in outgoing scope"
    self endSequence.			"pop to enclosing scope"
    tempMax := scope stackSize.
    tempCount := outerCount removeLast.
    ^scope
]

Encoder beginMethod: aMethodNode in: typeNode
[
    self beginBlock.
    self addSelector: aMethodNode selector.	"make sure we have a selector to install"
    methodType := typeNode.
    scope hasVarargs: aMethodNode isVariadic.
    ^scope.
]

Encoder endMethod
[
    methodType := nil.
    ^self endBlock.
]

Encoder declareSlot:  name position: position type: type receiver: selfNode
[
    | var |
    (var := scope declareSlot: name position: position type: type receiver: selfNode) isNil
	ifTrue: [globalContext errorRedefined: name at: position].
    ^var
]

Encoder declareArgument:  name position: position
[
    | var |
    (var := scope declareArgument: name position: position) isNil
	ifTrue: [globalContext errorRedefined: name at: position].
    ^var
]

Encoder declareTemporary: name position: position
[
    | var |
    (var := scope declareTemporary: name position: position) isNil
	ifTrue: [globalContext errorRedefined: name at: position].
    ^var
]

Encoder push
[
    tempCount := tempCount + 1.
    tempCount > tempMax ifTrue: [tempMax := tempCount].
    ^tempCount
]

Encoder pop: count
[
    tempCount < count ifTrue: [self error: 'internal compiler error #1'].	"temp underflow"
    ^tempCount := tempCount - count.
]

Encoder pop
[
    ^self pop: 1
]

Encoder encode: nameString position: aPosition
[
    | node |
    "look in the lexically nested local namespaces"
    (node := scope encode: nameString) notNil 
	ifTrue: [^node].
    "look for a global or type name"
    (node := globalContext encode: nameString) isNil
	ifTrue: [globalContext errorUndefined: nameString at: aPosition].
    node noteUsed.
    "memoise the result for later"
    ^globals at: nameString put: (GlobalVariableNode withName: nameString position: node position scope: globalContext).
]

Encoder nextLiteralTag
[
    ^literalTag := literalTag + 1
]

Encoder encodeLiteral: literalNode
[
    | lit |
    "try to reuse an existing literal of equivalent value"
    lit := literalMap at: literalNode ifAbsent: [literalMap at: (literals add: literalNode) put: self nextLiteralTag].
    ^lit
]

Encoder literals
[

    "Answer the ordered collection of literals (preserving order is
     VITAL for literal arrays with subarrays) and clear the local
     literal caches."
    | lits |
    lits := literals.
    literals := OrderedCollection new.
    literalMap := Dictionary new.
    ^lits
]

Encoder encodeBlock: blockNode
[
    ^self nextLiteralTag	"blocks are literals"
]

Encoder addBlock: blockNode
[
    scope addBlock: blockNode	"record block for out-of-line processing"
]

Encoder encodeType: typeName position: aPosition
[
    "typeName is the left hand side of a method defn; we need BOTH a
     type defn (to determine the object's layout) and an available
     variable (in which to install the method)."
    | type |
    (type := globalContext encode: typeName) isNil
	ifTrue: [globalContext errorUndefined: typeName at: aPosition].
    "assume the globalContext only stores type defns"
    ^type
]

Encoder specialEncoders [ ^specialEncoders ]

"Forward errors and warnings to the globalContext (usually an offline
or interactive Compiler)."

Encoder error: message at: aPosition	[ ^globalContext error: message at: aPosition ]
Encoder warn:  message at: aPosition	[ ^globalContext warn:  message at: aPosition ]
