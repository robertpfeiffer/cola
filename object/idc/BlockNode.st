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

  Last edited: 2007-02-21 16:21:44 by piumarta on emilia.lax02.mtt
"

{ import: SequenceNode }
{ import: VariableNode }
{ import: ReturnNode }
{ import: OrderedCollection }

"I represent a block, either literal or open-coded."

BlockNode : SequenceNode (
    arguments		"OrderedCollection of argument name Strings"
    tag			"an integer unique to me within all blocks and literals"
    constructor		"the type and selector for creating a closure state"
    stateConstructor	"the type and selector for creating a vector for my local state"
)

BlockNode isBlockNode [ ^true ]
ParseNode isBlockNode [ ^false ]

BlockNode initialize
[
    super initialize.
    arguments := OrderedCollection new.
    tag := nil.
    constructor := nil.
    stateConstructor := nil.
]

BlockNode addArgument: aVariableNode
[
    arguments add: aVariableNode.
]

BlockNode arguments	[ ^arguments ]
BlockNode tag		[ ^tag ]

ParseNode isOpenCodable	[ ^false ]
BlockNode isOpenCodable	[ ^arguments isEmpty and: [temporaries isEmpty] ]	"BUG: we should open-code 'to:do:' and '[:x | ...] value:'"

BlockNode scope [ ^scope ]

BlockNode encodeOpen: encoder
[
    "encode the contents of the block for inlining; send from SendNode"
    | last |
    scope := encoder beginSequence.	"DO NOT INCREASE LEXICAL LEVEL"
    temporaries := temporaries collect: [:tmp | encoder declareTemporary: tmp position: position].
    statements isEmpty
	ifTrue:
	   [statements addLast: (VariableNode withName: 'nil' position: position)].
    last := statements last.
    statements do: [:stmt |
	stmt encode: encoder.
	stmt == last ifFalse: [encoder pop]].
    "result is result of last statement"
    location := last location.
    "propagate blocks up to enclosing scope (exec or method), already encoded"
    scope blocks do: [:block | scope outer addBlock: block].
    encoder endSequence.
    scope hasExports ifTrue: [stateConstructor := encoder requireType: 'vector' at: position].
]

BlockNode generateOpen: gen
[
    "generate the contents of the block for inlining; sent from SendNode"
    gen beginSequence: self.
    scope hasExports ifTrue: [gen createStateVector: scope stateVectorSize inScope: scope tag constructor: stateConstructor].
    temporaries do: [:var | var isFree ifFalse: [gen declareTemporary: var]].
    temporaries do: [:temp | temp isFree ifFalse: [gen defineTemporary: temp]].
    statements do: [:stmt | stmt generate: gen].
    gen endSequence: self.
]

BlockNode encode: encoder
[
    "encode the receiver as a literal block"
    tag := encoder encodeBlock: self.
    location := encoder push.
    encoder addBlock: self.	"save contents for processing after the enclosing scope has closed"
]

BlockNode encodeBody: encoder
[
    "encode the body of a literal block"
    scope notNil ifTrue: [^self].	"already encoded in enclosed open-coded block then propagated back out (see encodeOpen:)"
    scope := encoder beginBlock.	"increase lexical level"
    arguments   := arguments   collect: [:arg | encoder declareArgument:  arg position: position].
    temporaries := temporaries collect: [:tmp | encoder declareTemporary: tmp position: position].
    statements isEmpty
	ifTrue:
	   [statements addLast: (VariableNode withName: 'nil' position: position)].
    statements last isReturnNode
	ifFalse:
	   [| last |
	    last := statements removeLast.
	    statements addLast: (LocalReturnNode withValue: last position: last position)].
    statements do: [:stmt |
	stmt encode: encoder.
	encoder pop].
    "encode bodies of all literal blocks within this block"
    scope blocks do: [:block | block encodeBody: encoder].
    scope hasExports ifTrue: [stateConstructor := encoder requireType: 'vector' at: position].
    constructor := encoder
	requireType: (scope needsOuterScope ifTrue: ['fullClosure'] ifFalse: ['staticClosure'])
	at: position.
    encoder endBlock.	"pop lexical level"
]

BlockNode generateFullClosure: gen
[

    "free references and/or a nonlocal return crossed the receiver's
     scope: make a new closure every time the receiver is loaded"
    gen
	comment: scope printString;
	comment: scope outer printString;
	comment: scope outer hasImports printString;
	comment: scope level printString;
	comment: scope outer level printString.
    gen makeBlock: tag constructor: constructor outerFlag: scope outer hasImports
	function:  tag arity: arguments size state: (scope outer hasExports ifTrue: [scope outer tag]) nlrFlag: scope hasNLR
	location:  location
]

BlockNode generateStaticClosure: gen
[
    "no free refs or NLR: the receiver's closure is created once and is immutable"
    gen loadBlock: tag location: location
]

BlockNode generate: gen
[
    scope needsOuterScope	"scope imports free vars or has NLR"
	ifTrue:  [self generateFullClosure: gen]
	ifFalse: [self generateStaticClosure: gen].
]

BlockNode genDeclaration: gen
[
    scope needsOuterScope ifFalse: [gen declareLiteral: tag].	"static block: is really a literal"
    scope blocks do: [:block | block genDeclaration: gen].	"propagate to enclosed blocks"
]

BlockNode genDefinition: gen
[
    scope blocks do: [:block | block genDefinition: gen].	"propagate to enclosed blocks"
]

BlockNode genImplementation: gen
[
    "generate the function part of a closure"
    "NOTE: since the body refers to enclosed block implementations
     when generating full closures, those implementations MUST be
     generated first."
    scope blocks do: [:block | block genImplementation: gen].
    gen beginBlock: self arguments: arguments variadic: false.
    gen beginSequence: self.
    scope hasExports ifTrue: [gen createStateVector: scope stateVectorSize inScope: scope tag constructor: stateConstructor].
    temporaries do: [:var | var isFree ifFalse: [gen declareTemporary: var]].
    gen declareStack: scope stackSize.
    temporaries do: [:temp | temp isFree ifFalse: [gen defineTemporary: temp]].
    gen defineStack: scope stackSize.
    arguments   do: [:var | var isFree ifTrue: [gen saveArgument: var]].
    statements  do: [:stmt | stmt generate: gen].
    gen endSequence: self.
]

BlockNode genInitialisation: gen
[
    "init static blocks only: create closure once, save as literal"
    scope needsOuterScope ifFalse: [gen initialiseBlock: tag function: tag arity: arguments size constructor: constructor].
    scope blocks do: [:block | block genInitialisation: gen].
]

BlockNode println: indent
[
    self printIndent: indent.
    (': ', arguments printString) println.
    super println: indent.
]
