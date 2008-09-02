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

  Last edited: 2008-06-26 17:12:19 by piumarta on emilia
"

{ import: ParseNode }
{ import: OrderedCollection }
{ import: Dictionary }
{ import: VariableNode }
{ import: IntegerNode }

SendNode : ParseNode (
    receiver		"ParseNode, or nil if I am a cascaded send"
    selector		"the selector of the message that I send"
    arguments		"the arguments that I pass"
    cascades		"cascaded sends (empty if I am a cascaded send)"
    superedType		"the type in which to start lookup, or nil for normal send"
    specialGenerator	"#generate: message for macro/special/arithmetic selector"
)

ParseNode isSendNode	[ ^false ]
SendNode isSendNode	[ ^true ]

SendNode initialize
[
    super initialize.
    arguments := OrderedCollection new.
    cascades := OrderedCollection new.
    superedType := nil.
]

SendNode withReceiver: receiverNode selector: selectorString position: aPosition
[
    self := self withPosition: aPosition.
    receiver := receiverNode.
    selector := selectorString.
]

SendNode addArgument: aNode	[ arguments add: aNode ]
SendNode addKeyword: aString	[ selector := selector , aString ]
SendNode addCascade: aSendNode	[ cascades add: aSendNode ]

SendNode beSuperSend: methodType
[
    "My receiver will be VariableNode('super') which needs correction."
    superedType := methodType.
    receiver notNil
	ifTrue:
	   [receiver := VariableNode withName: 'self' position: receiver position.
	    cascades do: [:send | send beSuperSend: methodType]].
]

SendNode beThisSend: methodType
[
    "My receiver will be VariableNode('super') which needs correction."
    superedType := methodType.
    receiver notNil
	ifTrue:
	   [receiver := VariableNode withName: 'self' position: receiver position.
	    cascades do: [:send | send beThisSend: methodType]].
]

SendNode encode: encoder
[
    "ensure the literals contain my selector"
    encoder addSelector: selector at: position.
    "ensure an supertype is available for super sends"
    (receiver notNil and: [receiver isSuper])
	ifTrue: [self beSuperSend: (encoder superTypeAt: position)].
    (receiver notNil and: [receiver isThis])
	ifTrue: [self beThisSend: (encoder thisTypeAt: position)].
    "try to macro expand or generate a special/arithmetic response"
    (receiver notNil				"not a cascaded send"
		and: [superedType isNil		"not a send to 'super'"
		and: [cascades isEmpty		"not followed by a cascaded send"
		and: [(specialGenerator := self encodeSpecial: encoder) notNil]]])
	ifTrue: [^self].
    receiver notNil
	ifTrue: [location := receiver encode: encoder; location].
    arguments := arguments collect: [:arg | arg encode: encoder].
    "deallocate arguments; reuse receiver location for result"
    encoder pop: arguments size.
    cascades do: [:send | send encode: encoder].
]

SendNode generate: gen
[
    specialGenerator notNil ifTrue: [^self perform: specialGenerator with: gen].
    receiver generate: gen.
    arguments do: [:arg | arg generate: gen].
    gen debugLine: position.
    gen send: selector to: receiver withArguments: arguments forValue: cascades isEmpty supered: superedType.
    cascades notEmpty
	ifTrue:
	   [| last |
	    last := cascades last.
	    cascades do: [:send | send generate: gen withReceiver: receiver forValue: send == last]].
]

SendNode generate: gen withReceiver: rcvr forValue: valueFlag
[
    arguments do: [:arg | arg generate: gen].
    gen send: selector to: rcvr withArguments: arguments forValue: valueFlag supered: superedType.
]


SendNode println: indent
[
    receiver isNil ifFalse: [receiver println: indent + 1].
    self printIndent: indent.
    selector println.
    arguments do: [:arg | arg println: indent + 1].
    cascades do: [:cascade |
	self printIndent: indent.
	';' println.
	cascade println: indent + 1].
]

"{ input SendNode-specials }"

									" -*- Smalltalk -*- "

SendNode encodeSpecial: encoder
[
    | encodingMessage |
    encodingMessage := encoder specialEncoders at: selector ifAbsent: [^false].
    ^self perform: encodingMessage with: encoder.
]

"macro selectors: literal blocks are open-coded inline"

SendNode macroEncoders
[
    ^Dictionary new
	at: 'ifTrue:'		put: #encodeIfTrue_:		;
	at: 'and:'		put: #encodeAnd_:		;
	at: 'ifFalse:'		put: #encodeIfFalse_:		;
	at: 'or:'		put: #encodeOr_:		;
	at: 'ifTrue:ifFalse:'	put: #encodeIfTrue_ifFalse_:	;
	at: 'ifFalse:ifTrue:'	put: #encodeIfFalse_ifTrue_:	;
	at: 'value'		put: #encodeValue:		;
	at: 'whileTrue'		put: #encodeWhileTrue:		;
	at: 'whileFalse'	put: #encodeWhileFalse:		;
	at: 'whileTrue:'	put: #encodeWhileTrue_:		;
	at: 'whileFalse:'	put: #encodeWhileFalse_:	;
	yourself.
]

SendNode encodeIfTrue_: encoder
[
    self warnIfBlockReceiver: encoder.
    "arguments size can be > 2 if anonymous arguments present"
    (arguments size == 1 and: [arguments first isOpenCodable]) ifFalse: [^nil].
    location := encoder push.
    receiver encode: encoder.
    encoder pop: 2.
    arguments first encodeOpen: encoder.
    arguments first location == location ifFalse: [self error: 'internal compiler error #4'].
    ^#genIfTrue_:.
]

SendNode genIfTrue_: gen
[
    | label |
    label := gen pushLabel.
    gen comment: 'ifTrue:'.
    "load nil then overwrite if necessary; removes one jump"
    gen loadNil: self location.
    receiver generate: gen.
    gen jumpFalse: receiver location to: label.
    arguments first generateOpen: gen.
    gen defineLabel: label.
    gen popLabel.
]

SendNode encodeAnd_: encoder
[
    self warnIfBlockReceiver: encoder.
    "arguments size can be > 2 if anonymous arguments present"
    (arguments size == 1 and: [arguments first isOpenCodable]) ifFalse: [^nil].
    location := receiver encode: encoder; location.
    encoder pop.
    arguments first encodeOpen: encoder.
    arguments first location == location ifFalse: [self error: 'internal compiler error #12'].
    ^#genAnd_:.
]

SendNode genAnd_: gen
[
    | label |
    label := gen pushLabel.
    gen comment: 'and:'.
    receiver generate: gen.
    gen jumpFalse: receiver location to: label.
    arguments first generateOpen: gen.
    gen defineLabel: label.
    gen popLabel.
]

SendNode encodeIfFalse_: encoder
[
    self warnIfBlockReceiver: encoder.
    (arguments size == 1 and: [arguments first isOpenCodable]) ifFalse: [^nil].
    location := encoder push.
    receiver encode: encoder.
    encoder pop: 2.
    arguments first encodeOpen: encoder.
    arguments first location == location ifFalse: [self error: 'internal compiler error #5'].
    ^#genIfFalse_:.
]

SendNode genIfFalse_: gen
[
    | label |
    label := gen pushLabel.
    gen comment: 'ifFalse:'.
    gen loadNil: self location.
    receiver generate: gen.
    gen jumpTrue: receiver location to: label.
    arguments first generateOpen: gen.
    gen defineLabel: label.
    gen popLabel.
]

SendNode encodeOr_: encoder
[
    self warnIfBlockReceiver: encoder.
    (arguments size == 1 and: [arguments first isOpenCodable]) ifFalse: [^nil].
    location := receiver encode: encoder; location.
    encoder pop.
    arguments first encodeOpen: encoder.
    arguments first location == location ifFalse: [self error: 'internal compiler error #13'].
    ^#genOr_:.
]

SendNode genOr_: gen
[
    | label |
    label := gen pushLabel.
    gen comment: 'or:'.
    receiver generate: gen.
    gen jumpTrue: receiver location to: label.
    arguments first generateOpen: gen.
    gen defineLabel: label.
    gen popLabel.
]

SendNode encodeIfTrue_ifFalse_: encoder
[
    self warnIfBlockReceiver: encoder.
    (arguments size == 2 and: [arguments first  isOpenCodable and: [arguments second isOpenCodable]])
	ifFalse: [^nil].
    location := receiver encode: encoder; location.
    encoder pop.
    arguments first encodeOpen: encoder.
    arguments first location == location ifFalse: [self error: 'internal compiler error #6'].
    encoder pop.
    arguments second encodeOpen: encoder.
    arguments second location == location ifFalse: [self error: 'internal compiler error #7'].
    ^#genIfTrue_ifFalse_:.
]

SendNode genIfTrue_ifFalse_: gen
[
    | alternate continue |
    alternate := gen pushLabel.
    continue := gen pushLabel.
    gen comment: 'ifTrue:ifFalse:'.
    receiver generate: gen.
    gen jumpFalse: receiver location to: alternate.
    arguments first generateOpen: gen.
    gen jumpTo: continue.
    gen defineLabel: alternate.
    arguments second generateOpen: gen.
    gen defineLabel: continue.
    gen popLabels: 2.
]

SendNode encodeIfFalse_ifTrue_: encoder
[
    self warnIfBlockReceiver: encoder.
    (arguments size == 2 and: [arguments first isOpenCodable and: [arguments second isOpenCodable]])
	ifFalse: [^nil].
    location := receiver encode: encoder; location.
    encoder pop.
    arguments first encodeOpen: encoder.
    arguments first location == location ifFalse: [self error: 'internal compiler error #8'].
    encoder pop.
    arguments second encodeOpen: encoder.
    arguments second location == location ifFalse: [self error: 'internal compiler error #9'].
    ^#genIfFalse_ifTrue_:.
]

SendNode genIfFalse_ifTrue_: gen
[
    | alternate continue |
    alternate := gen pushLabel.
    continue := gen pushLabel.
    gen comment: 'ifFalse:ifTrue:'.
    receiver generate: gen.
    gen jumpTrue: receiver location to: alternate.
    arguments first generateOpen: gen.
    gen jumpTo: continue.
    gen defineLabel: alternate.
    arguments second generateOpen: gen.
    gen defineLabel: continue.
    gen popLabels: 2.
]

SendNode encodeValue: encoder
[
    (receiver isOpenCodable and: [arguments isEmpty]) ifFalse: [^nil].
    location := receiver encodeOpen: encoder; location.
    ^#genValue:.
]

SendNode genValue: gen
[
    | loop |
    gen comment: 'value'.
    receiver generateOpen: gen.
]

SendNode encodeWhileTrue: encoder
[
    (receiver isOpenCodable and: [arguments isEmpty]) ifFalse: [^nil].
    location := receiver encodeOpen: encoder; location.
    ^#genWhileTrue:.
]

SendNode genWhileTrue: gen
[
    | loop |
    loop := gen pushLabel.
    gen comment: 'whileTrue'.
    gen defineLabel: loop.
    receiver generateOpen: gen.
    gen jumpTrue: receiver location to: loop.
    gen loadNil: location.
    gen popLabel.
]

SendNode encodeWhileFalse: encoder
[
    (receiver isOpenCodable and: [arguments isEmpty]) ifFalse: [^nil].
    location := receiver encodeOpen: encoder; location.
    ^#genWhileFalse:.
]

SendNode genWhileFalse: gen
[
    | loop |
    loop := gen pushLabel.
    gen comment: 'whileFalse'.
    gen defineLabel: loop.
    receiver generateOpen: gen.
    gen jumpFalse: receiver location to: loop.
    gen loadNil: location.
    gen popLabel.
]

SendNode encodeWhileTrue_: encoder
[
    (receiver isOpenCodable and: [arguments size == 1 and: [arguments first isOpenCodable]])
	ifFalse: [^nil].
    receiver encodeOpen: encoder.
    encoder pop.
    location := arguments first encodeOpen: encoder; location.
    ^#genWhileTrue_:.
]

SendNode genWhileTrue_: gen
[
    | loop test |
    loop := gen pushLabel.
    test := gen pushLabel.
    gen comment: 'whileTrue:'.
    "compile body first and fall into test; removes one jump per
     iteration at the cost of an initial jump to the test"
    gen jumpTo: test.
    gen defineLabel: loop.
    arguments first generateOpen: gen.
    gen defineLabel: test.
    receiver generateOpen: gen.
    gen jumpTrue: receiver location to: loop.
    gen loadNil: location.
    gen popLabels: 2.
]

SendNode encodeWhileFalse_: encoder
[
    (receiver isOpenCodable and: [arguments size == 1 and: [arguments first isOpenCodable]])
	ifFalse: [^nil].
    receiver encodeOpen: encoder.
    encoder pop.
    location := arguments first encodeOpen: encoder; location.
    ^#genWhileFalse_:.
]

SendNode genWhileFalse_: gen
[
    | loop test |
    loop := gen pushLabel.
    test := gen pushLabel.
    gen comment: 'whileFalse:'.
    gen jumpTo: test.
    gen defineLabel: loop.
    arguments first generateOpen: gen.
    gen defineLabel: test.
    receiver generateOpen: gen.
    gen jumpFalse: receiver location to: loop.
    gen loadNil: location.
    gen popLabels: 2.
]

SendNode warnIfBlockReceiver: encoder
[
    receiver isBlockNode
	ifTrue: [encoder warn: 'sending ', selector printString, ' to a literal block' at: position]
]

"special selectors: send is eliminated entirely for all or some types"

SendNode specialEncoders
[
    ^Dictionary new
	at: '=='	put: #encodeIdentical:		;
	at: '~~'	put: #encodeNotIdentical:	;
	yourself.
]

SendNode encodeIdentical: encoder
[
    arguments size == 1 ifFalse: [^nil].
    encoder requireBooleanAt: position.
    location := receiver encode: encoder; location.
    arguments first encode: encoder.
    encoder pop.
    ^#genIdentical:.
]

SendNode genIdentical: gen
[
    receiver generate: gen.
    arguments first generate: gen.
    gen compare: receiver location identical: arguments first location location: location.
]

SendNode encodeNotIdentical: encoder
[
    arguments size == 1 ifFalse: [^nil].
    encoder requireBooleanAt: position.
    location := receiver encode: encoder; location.
    arguments first encode: encoder.
    encoder pop.
    ^#genNotIdentical:.
]

SendNode genNotIdentical: gen
[
    receiver generate: gen.
    arguments first generate: gen.
    gen compare: receiver location notIdentical: arguments first location location: location.
]

"arithmetic selectors: send is eliminated for tagged integer types"

SendNode taggedEncoders
[
    ^Dictionary new
	at: '+'		put: #encodeTaggedAdd:	 ;
	at: '-'		put: #encodeTaggedSub:	 ;
	at: '*'		put: #encodeTaggedMul:	 ;
	at: '//'	put: #encodeTaggedDiv:	 ;
	at: '\\\\'	put: #encodeTaggedMod:	 ;
	at: 'bitAnd:'	put: #encodeTaggedAnd:	 ;
	at: 'bitOr:'	put: #encodeTaggedOr:	 ;
	at: 'bitXor:'	put: #encodeTaggedXor:	 ;
	at: 'bitShift:'	put: #encodeTaggedShift: ;
	at: '<<'	put: #encodeTaggedLeft:	 ;
	at: '>>'	put: #encodeTaggedRight: ;
	at: '<'		put: #encodeTaggedLT:	 ;
	at: '<='	put: #encodeTaggedLE:	 ;
	at: '='		put: #encodeTaggedEQ:	 ;
	at: '~='	put: #encodeTaggedNE:	 ;
	at: '>='	put: #encodeTaggedGE:	 ;
	at: '>'		put: #encodeTaggedGT:	 ;
	yourself.
]

SendNode encodeTaggedAdd: encoder	[ ^self encodeTaggedBinary: encoder generator: #genTaggedAdd: ]
SendNode encodeTaggedSub: encoder	[ ^self encodeTaggedBinary: encoder generator: #genTaggedSub: ]
SendNode encodeTaggedMul: encoder	[ ^self encodeTaggedBinary: encoder generator: #genTaggedMul: ]
SendNode encodeTaggedDiv: encoder	[ ^self encodeTaggedBinary: encoder generator: #genTaggedDiv: ]
SendNode encodeTaggedMod: encoder	[ ^self encodeTaggedBinary: encoder generator: #genTaggedMod: ]
SendNode encodeTaggedAnd: encoder	[ ^self encodeTaggedBinary: encoder generator: #genTaggedAnd: ]
SendNode encodeTaggedOr: encoder	[ ^self encodeTaggedBinary: encoder generator: #genTaggedOr: ]
SendNode encodeTaggedXor: encoder	[ ^self encodeTaggedBinary: encoder generator: #genTaggedXor: ]
SendNode encodeTaggedShift: encoder	[ ^self encodeTaggedBinary: encoder generator: #genTaggedShift: ]
SendNode encodeTaggedLeft: encoder	[ ^self encodeTaggedBinary: encoder generator: #genTaggedLeft: ]
SendNode encodeTaggedRight: encoder	[ ^self encodeTaggedBinary: encoder generator: #genTaggedRight: ]

SendNode genTaggedAdd: gen		[ ^self genTaggedBinary: gen emitter: #tagged:add:location:checking: ]
SendNode genTaggedSub: gen		[ ^self genTaggedBinary: gen emitter: #tagged:sub:location:checking: ]
SendNode genTaggedMul: gen		[ ^self genTaggedBinary: gen emitter: #tagged:mul:location:checking: ]
SendNode genTaggedDiv: gen		[ ^self genTaggedBinary: gen emitter: #tagged:div:location:checking: ]
SendNode genTaggedMod: gen		[ ^self genTaggedBinary: gen emitter: #tagged:mod:location:checking: ]
SendNode genTaggedAnd: gen		[ ^self genTaggedBinary: gen emitter: #tagged:and:location:checking: ]
SendNode genTaggedOr: gen		[ ^self genTaggedBinary: gen emitter: #tagged:or:location:checking: ]
SendNode genTaggedXor: gen		[ ^self genTaggedBinary: gen emitter: #tagged:xor:location:checking: ]
SendNode genTaggedShift: gen		[ ^self genTaggedBinary: gen emitter: #tagged:shift:location:checking: ]
SendNode genTaggedLeft: gen		[ ^self genTaggedBinary: gen emitter: #tagged:left:location:checking: ]
SendNode genTaggedRight: gen		[ ^self genTaggedBinary: gen emitter: #tagged:right:location:checking: ]

SendNode encodeTaggedBinary: encoder generator: generatorSelector
[
    arguments size == 1 ifFalse: [^nil].
    location := receiver encode: encoder; location.
    arguments first encode: encoder.
    encoder pop.
    ^generatorSelector.
]

SendNode genTaggedBinary: gen emitter: emitterSelector
[
    receiver generate: gen.
    arguments first generate: gen.
    gen perform: emitterSelector
	with: receiver location
	with: arguments first location
	with: location
	with: (receiver tagCheckFor: arguments first).
]

SendNode encodeTaggedLT: encoder	[ ^self encodeTaggedRelation: encoder generator: #genTaggedLT: ]
SendNode encodeTaggedLE: encoder	[ ^self encodeTaggedRelation: encoder generator: #genTaggedLE: ]
SendNode encodeTaggedEQ: encoder	[ ^self encodeTaggedRelation: encoder generator: #genTaggedEQ: ]
SendNode encodeTaggedNE: encoder	[ ^self encodeTaggedRelation: encoder generator: #genTaggedNE: ]
SendNode encodeTaggedGE: encoder	[ ^self encodeTaggedRelation: encoder generator: #genTaggedGE: ]
SendNode encodeTaggedGT: encoder	[ ^self encodeTaggedRelation: encoder generator: #genTaggedGT: ]

SendNode genTaggedLT: gen		[ ^self genTaggedRelation: gen emitter: #tagged:lt:location:checking: ]
SendNode genTaggedLE: gen		[ ^self genTaggedRelation: gen emitter: #tagged:le:location:checking: ]
SendNode genTaggedEQ: gen		[ ^self genTaggedRelation: gen emitter: #tagged:eq:location:checking: ]
SendNode genTaggedNE: gen		[ ^self genTaggedRelation: gen emitter: #tagged:ne:location:checking: ]
SendNode genTaggedGE: gen		[ ^self genTaggedRelation: gen emitter: #tagged:ge:location:checking: ]
SendNode genTaggedGT: gen		[ ^self genTaggedRelation: gen emitter: #tagged:gt:location:checking: ]

SendNode encodeTaggedRelation: encoder generator: generatorSelector
[
    arguments size == 1 ifFalse: [^nil].
    encoder requireBooleanAt: position.
    location := receiver encode: encoder; location.
    arguments first encode: encoder.
    encoder pop.
    ^generatorSelector.
]

SendNode genTaggedRelation: gen emitter: emitterSelector
[
    receiver generate: gen.
    arguments first generate: gen.
    gen perform: emitterSelector
	with: receiver location
	with: arguments first location
	with: location
	with: (receiver tagCheckFor: arguments first).
]

"given receiver and arguments: determine whether left, right, both or none of them require a tag check"

ParseNode tagCheckFor: aNode	[ ^aNode tagCheckFromObject ]
ParseNode tagCheckFromObject	[ ^#both ]
ParseNode tagCheckFromInteger	[ ^#right ]

IntegerNode tagCheckFor: aNode	[ ^value isSmallInteger ifTrue: [aNode tagCheckFromInteger] ifFalse: [super tagCheckFor: aNode] ]
IntegerNode tagCheckFromObject	[ ^value isSmallInteger ifTrue: [#left] ifFalse: [#both] ]
IntegerNode tagCheckFromInteger	[ ^value isSmallInteger ifTrue: [#none] ifFalse: [#right] ]
