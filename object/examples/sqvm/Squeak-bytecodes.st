{ import: Squeak }

Squeak bytecodeTable
[
    ^#(
	(  0  15 pushReceiverVariableBytecode)
	( 16  31 pushTemporaryVariableBytecode)
	( 32  63 pushLiteralConstantBytecode)
	( 64  95 pushLiteralVariableBytecode)
	( 96 103 storeAndPopReceiverVariableBytecode)
	(104 111 storeAndPopTemporaryVariableBytecode)
	(112	 pushReceiverBytecode)
	(113	 pushConstantTrueBytecode)
	(114	 pushConstantFalseBytecode)
	(115	 pushConstantNilBytecode)
	(116	 pushConstantMinusOneBytecode)
	(117	 pushConstantZeroBytecode)
	(118	 pushConstantOneBytecode)
	(119	 pushConstantTwoBytecode)
	(120	 returnReceiver)
	(121	 returnTrue)
	(122	 returnFalse)
	(123	 returnNil)
	(124	 returnTopFromMethod)
	(125	 returnTopFromBlock)
	(126	 unknownBytecode)
	(127	 unknownBytecode)
	(128	 extendedPushBytecode)
	(129	 extendedStoreBytecode)
	(130	 extendedStoreAndPopBytecode)
	(131	 singleExtendedSendBytecode)
	(132	 doubleExtendedDoAnythingBytecode)
	(133	 singleExtendedSuperBytecode)
	(134	 secondExtendedSendBytecode)
	(135	 popStackBytecode)
	(136	 duplicateTopBytecode)
	(137	 pushActiveContextBytecode)
	(138 143 experimentalBytecode)
	(144 151 shortUnconditionalJump)
	(152 159 shortConditionalJump)
	(160 167 longUnconditionalJump)
	(168 171 longJumpIfTrue)
	(172 175 longJumpIfFalse)
	"176-191 sendArithmeticSelectorBytecode"
	(176	 bytecodePrimAdd)
	(177	 bytecodePrimSubtract)
	(178	 bytecodePrimLessThan)
	(179	 bytecodePrimGreaterThan)
	(180	 bytecodePrimLessOrEqual)
	(181	 bytecodePrimGreaterOrEqual)
	(182	 bytecodePrimEqual)
	(183	 bytecodePrimNotEqual)
	(184	 bytecodePrimMultiply)
	(185	 bytecodePrimDivide)
	(186	 bytecodePrimMod)
	(187	 bytecodePrimMakePoint)
	(188	 bytecodePrimBitShift)
	(189	 bytecodePrimDiv)
	(190	 bytecodePrimBitAnd)
	(191	 bytecodePrimBitOr)	
	"192-207 sendCommonSelectorBytecode"
	(192	 bytecodePrimAt)
	(193	 bytecodePrimAtPut)
	(194	 bytecodePrimSize)
	(195	 bytecodePrimNext)
	(196	 bytecodePrimNextPut)
	(197	 bytecodePrimAtEnd)
	(198	 bytecodePrimEquivalent)
	(199	 bytecodePrimClass)
	(200	 bytecodePrimBlockCopy)
	(201	 bytecodePrimValue)
	(202	 bytecodePrimValueWithArg)
	(203	 bytecodePrimDo)
	(204	 bytecodePrimNew)
	(205	 bytecodePrimNewWithArg)
	(206	 bytecodePrimPointX)
	(207	 bytecodePrimPointY)
	(208 223 sendLiteralSelectorBytecode0)
	(224 239 sendLiteralSelectorBytecode1)
	(240 255 sendLiteralSelectorBytecode2)
    )
]

"
	BYTECODES
"

Squeak pushReceiverVariableBytecode
[
    self push: (self fetchReceiver: currentBytecode)
]

Squeak pushTemporaryVariableBytecode
[
    self push: (self fetchTemporary: (currentBytecode bitAnd: 15))
]

Squeak pushLiteralConstantBytecode
[
    self push: (self fetchLiteral: (currentBytecode bitAnd: 0x1f))
]

Squeak pushLiteralVariableBytecode
[
    self push: (self fetchLiteralVariable: (currentBytecode bitAnd: 0x1f))
]

Squeak storeAndPopReceiverVariableBytecode
[
    self storeReceiver: (currentBytecode bitAnd: 7) with: self pop
]

Squeak storeAndPopTemporaryVariableBytecode
[
    self storeTemporary: (currentBytecode bitAnd: 7) with: self pop
]

Squeak pushReceiverBytecode
[
    self push: receiver
]

Squeak pushConstantTrueBytecode		[ self push: trueObj  ]
Squeak pushConstantFalseBytecode	[ self push: falseObj ]
Squeak pushConstantNilBytecode		[ self push: nilObj   ]
Squeak pushConstantMinusOneBytecode	[ self push: -1	      ]
Squeak pushConstantZeroBytecode		[ self push:  0       ]
Squeak pushConstantOneBytecode		[ self push:  1       ]
Squeak pushConstantTwoBytecode		[ self push:  2       ]

Squeak returnReceiver			[ self return: receiver      to: (homeContext  	instVarAt: Context_sender) ]
Squeak returnTrue			[ self return: trueObj       to: (homeContext  	instVarAt: Context_sender) ]
Squeak returnFalse			[ self return: falseObj      to: (homeContext  	instVarAt: Context_sender) ]
Squeak returnNil			[ self return: nilObj        to: (homeContext  	instVarAt: Context_sender) ]
Squeak returnTopFromMethod		[ self return: self stackTop to: (homeContext  	instVarAt: Context_sender) ]
Squeak returnTopFromBlock		[ self return: self stackTop to: (activeContext instVarAt: Context_sender) ]

Squeak unknownBytecode
[
    self error: 'UNIMPLEMENTED BYTECODE unknownBytecode'.
]

ExtendedFetches := [
    #(	fetchReceiver:
	fetchTemporary:
	fetchLiteral:
	fetchLiteralVariable:  ) collect: [:s | s asSelector]
]

Squeak extendedPushBytecode
[
    | descriptor index |
    descriptor := self fetchByte.
    index := descriptor bitAnd: 0x3F.
    self push: (self _perform: (ExtendedFetches at:  1 + (descriptor >> 6 bitAnd: 3)) w: index)
]

ExtendedStores := [
    #(	storeReceiver:with:
	storeTemporary:with:
	illegalStore:with:
	storeLiteralVariable:with:  ) collect: [:s | s asSelector]
]

Squeak extendedStoreBytecode
[
    | descriptor index |
    descriptor := self fetchByte.
    index := descriptor bitAnd: 0x3F.
    self _perform: (ExtendedStores at:  1 + (descriptor >> 6 bitAnd: 3)) w: index w: self stackTop
]

Squeak extendedStoreAndPopBytecode
[
    self extendedStoreBytecode; drop
]

Squeak singleExtendedSendBytecode
[
    | descriptor |
    descriptor := self fetchByte.
    messageSelector := self fetchLiteral: (descriptor bitAnd: 0x1f).
    argumentCount := descriptor >> 5.
    self normalSend
]

ExtendedAnythings := [
    #(	doubleExtendedSend:with:
	doubleExtendedSuper:with:
	doubleExtendedPushReceiver:with:
	doubleExtendedPushLiteralConstant:with:
	doubleExtendedPushLiteralVariable:with:
	doubleExtendedStoreReceiver:with:
	doubleExtendedStoreAndPopPopReceiver:with:
	doubleExtendedStoreLiteralVariable:with:  ) collect: [:s | s asSelector]
]

Squeak doubleExtendedDoAnythingBytecode
[
    | byte2 byte3 |
    byte2 := self fetchByte.
    byte3 := self fetchByte.
    self _perform: (ExtendedAnythings at: 1 + (byte2 >> 5)) w: byte2 w: byte3.
]

Squeak doubleExtendedSend: byte2 with: byte3
[ 
    messageSelector := self fetchLiteral: byte3.
    argumentCount := byte2 bitAnd: 0x1f.
    self normalSend.
]

Squeak doubleExtendedSuper: byte2 with: byte3
[ 
    messageSelector := self fetchLiteral: byte3.
    argumentCount := byte2 bitAnd: 0x1f.
    self superclassSend.
]

Squeak doubleExtendedPushReceiver: byte2 with: byte3		[ self push: (self fetchReceiver: byte3) ]
Squeak doubleExtendedPushLiteralConstant: byte2 with: byte3	[ self push: (self fetchLiteral: byte3) ]
Squeak doubleExtendedPushLiteralVariable: byte2 with: byte3	[ self push: (self fetchLiteralVariable: byte3) ]
Squeak doubleExtendedStoreReceiver: byte2 with: byte3		[ self storeReceiver: byte3 with: self stackTop ]
Squeak doubleExtendedStoreAndPopPopReceiver: byte2 with: byte3	[ self storeReceiver: byte3 with: self pop ]
Squeak doubleExtendedStoreLiteralVariable: byte2 with: byte3	[ self storeLiteralVariable: byte3 with: self stackTop ]

Squeak singleExtendedSuperBytecode
[
    | descriptor |
    descriptor := self fetchByte.
    self superSend: (descriptor bitAnd: 0x1f) numArgs: descriptor >> 5.
]

Squeak secondExtendedSendBytecode
[
    | descriptor |
    descriptor := self fetchByte.
    messageSelector := self fetchLiteral: (descriptor bitAnd: 0x3f).
    argumentCount := descriptor >> 6.
    self normalSend.
]

Squeak popStackBytecode
[
    self drop
]

Squeak duplicateTopBytecode
[
    self push: self stackTop
]

Squeak pushActiveContextBytecode
[
    self push: activeContext.
]

Squeak experimentalBytecode
[
    self error: 'UNIMPLEMENTED BYTECODE experimentalBytecode'.
]

Squeak shortUnconditionalJump
[
    self jump: 1 + (currentBytecode bitAnd: 7)
]

Squeak shortConditionalJump
[
    self jumpFalse: 1 + (currentBytecode bitAnd: 7)
]

Squeak longUnconditionalJump
[
    | nPages |
    nPages := (currentBytecode bitAnd: 7) - 4.
    self jump: 256 * nPages + self fetchByte.
    nPages < 0 ifTrue: [self quickCheckForInterrupts].
]

Squeak longJumpIfTrue
[
    self jumpTrue: 256 * (currentBytecode bitAnd: 3) + self fetchByte
]

Squeak longJumpIfFalse
[
    self jumpFalse: 256 * (currentBytecode bitAnd: 3) + self fetchByte
]

Squeak bytecodePrimAdd
[
    successFlag := true.
    self primitiveAdd.
    successFlag ifFalse: [self specialSend: 0 numArgs: 1]
]

Squeak bytecodePrimSubtract
[
    successFlag := true.
    self primitiveSubtract.
    successFlag ifFalse: [self specialSend: 1 numArgs: 1]
]

Squeak bytecodePrimLessThan
[
    successFlag := true.
    self primitiveLessThan.
    successFlag ifFalse: [self specialSend: 2 numArgs: 1]
]

Squeak bytecodePrimGreaterThan
[
    successFlag := true.
    self primitiveGreaterThan.
    successFlag ifFalse: [self specialSend: 3 numArgs: 1]
]

Squeak bytecodePrimLessOrEqual
[
    successFlag := true.
    self primitiveLessOrEqual.
    successFlag ifFalse: [self specialSend: 4 numArgs: 1]
]

Squeak bytecodePrimGreaterOrEqual
[
    successFlag := true.
    self primitiveGreaterOrEqual.
    successFlag ifFalse: [self specialSend: 5 numArgs: 1]
]

Squeak bytecodePrimEqual
[
    successFlag := true.
    self primitiveEqual.
    successFlag ifFalse: [self specialSend: 6 numArgs: 1]
]

Squeak bytecodePrimNotEqual
[
    successFlag := true.
    self primitiveNotEqual.
    successFlag ifFalse: [self specialSend: 7 numArgs: 1]
]

Squeak bytecodePrimMultiply
[
    successFlag := true.
    self primitiveMultiply.
    successFlag ifFalse: [self specialSend: 8 numArgs: 1]
]

Squeak bytecodePrimDivide
[
    successFlag := true.
    self primitiveDivide.
    successFlag ifFalse: [self specialSend: 9 numArgs: 1]
]

Squeak bytecodePrimMod
[
    successFlag := true.
    self primitiveMod.
    successFlag ifFalse: [self specialSend: 10 numArgs: 1]
]

Squeak bytecodePrimMakePoint
[
    successFlag := true.
    self primitiveMakePoint.
    successFlag ifFalse: [self specialSend: 11 numArgs: 1]
]

Squeak bytecodePrimBitShift
[
    successFlag := true.
    self primitiveBitShift.
    successFlag ifFalse: [self specialSend: 12 numArgs: 1]
]

Squeak bytecodePrimDiv
[
    successFlag := true.
    self primitiveDiv.
    successFlag ifFalse: [self specialSend: 13 numArgs: 1]
]

Squeak bytecodePrimBitAnd
[
    successFlag := true.
    self primitiveBitAnd.
    successFlag ifFalse: [self specialSend: 14 numArgs: 1]
]

Squeak bytecodePrimBitOr	
[
    successFlag := true.
    self primitiveBitOr.
    successFlag ifFalse: [self specialSend: 15 numArgs: 1]
]

Squeak bytecodePrimAt
[
    self specialSend: 16 numArgs: 1.
]

Squeak bytecodePrimAtPut
[
    self specialSend: 17 numArgs: 2.
]

Squeak bytecodePrimSize
[
    successFlag := true.
    self primitiveSize.
    successFlag ifFalse: [self specialSend: 18 numArgs: 0]
]

Squeak bytecodePrimNext
[
    successFlag := true.
    self primitiveNext.
    successFlag ifFalse: [self specialSend: 19 numArgs: 0]
]

Squeak bytecodePrimNextPut
[
    successFlag := true.
    self primitiveNextPut.
    successFlag ifFalse: [self specialSend: 20 numArgs: 1]
]

Squeak bytecodePrimAtEnd
[
    successFlag := true.
    self primitiveAtEnd.
    successFlag ifFalse: [self specialSend: 21 numArgs: 0]
]

Squeak bytecodePrimEquivalent
[
    | top |
    top := self pop.
    self popThenPush: (top == self stackTop ifTrue: [trueObj] ifFalse: [falseObj]).
    "successFlag ifFalse: [self specialSend: 22 numArgs: 1]"
]

Squeak bytecodePrimClass
[
    self popThenPush: self stackTop class.
    "successFlag ifFalse: [self specialSend: 23 numArgs: 0]"
]

Squeak bytecodePrimBlockCopy
[
    | type |
    type := self stackTop class.
    (type == (self splObj: ClassMethodContext) or: [type == (self splObj: ClassBlockContext)])
	ifTrue:
	   [successFlag := true.
	    self primitiveBlockCopy.
	    successFlag ifTrue: [^self]].
    self specialSend: 24 numArgs: 1
]

Squeak bytecodePrimValue
[
    self stackTop class == (self splObj: ClassBlockContext)
	ifTrue:
	   [successFlag := true.
	    self primitiveValue.
	    successFlag ifTrue: [^self]].
    self specialSend: 25 numArgs: 0
]

Squeak bytecodePrimValueWithArg
[
    (self stackValue: 1) == (self splObj: ClassBlockContext)
	ifTrue:
	   [successFlag := true.
	    self primitiveValueWithArg.
	    successFlag ifTrue: [^self]].
    self specialSend: 26 numArgs: 1
]

Squeak bytecodePrimDo
[
    self specialSend: 27 numArgs: 1
]

Squeak bytecodePrimNew
[
    self specialSend: 28 numArgs: 0
]

Squeak bytecodePrimNewWithArg
[
    self specialSend: 29 numArgs: 1
]

Squeak bytecodePrimPointX
[
    | rcvr |
    (rcvr := self stackTop) class == (self splObj: ClassPoint)
	ifTrue:
	   [^self popThenPush: (rcvr fetchPointer: Point_x)].
    self specialSend: 30 numArgs: 0
]

Squeak bytecodePrimPointY
[
    | rcvr |
    (rcvr := self stackTop) class == (self splObj: ClassPoint)
	ifTrue:
	   [^self popThenPush: (rcvr fetchPointer: Point_y)].
    self specialSend: 31 numArgs: 0
]

Squeak sendLiteralSelectorBytecode0
[
    messageSelector := self fetchLiteral: (currentBytecode bitAnd: 0x0f).
    argumentCount := 0.
    self normalSend
]

Squeak sendLiteralSelectorBytecode1
[
    messageSelector := self fetchLiteral: (currentBytecode bitAnd: 0x0f).
    argumentCount := 1.
    self normalSend
]

Squeak sendLiteralSelectorBytecode2
[
    messageSelector := self fetchLiteral: (currentBytecode bitAnd: 0x0f).
    argumentCount := 2.
    self normalSend
]
