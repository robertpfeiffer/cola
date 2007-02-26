{ import: Squeak }

Squeak printCallStack
[
    self printCallStack: activeContext
]

Squeak printCallStack: aContext
[
"   ('bytecodeCount = ', bytecodeCount printString) putln."
    [aContext ~~ nilObj]
	whileTrue:
	   [self printContext: aContext.
	    $\n put.
	    aContext := aContext instVarAt: Context_sender]
]

Squeak printContext: aContext
[
    | home classAndSelector |
    home := aContext class == (self splObj: ClassBlockContext) ifTrue: [aContext instVarAt: BlockContext_home] ifFalse: [aContext].
    classAndSelector := self findMethodClassAndSelector: (home instVarAt: MethodContext_method)
			     forReceiver: (home instVarAt: MethodContext_receiver).
"
    (aContext fetchPointer: Context_instructionPointer) print.
    $: put.
    (aContext fetchPointer: Context_stackPointer) print.
    $. put.
"
    home == aContext ifFalse: ['[]' put].
    classAndSelector first printNameOfClass.
    '>>' put.
    classAndSelector second notNil
	ifTrue:  [classAndSelector second putString]
	ifFalse: ['?' put].
"
    $. put.
    (aContext hashBits printStringRadix: 16) put.
"
]

Squeak findMethodClassAndSelector: aMethod forReceiver: aReceiver
[
    | currClass |
    currClass := aReceiver class.
    [currClass ~~ nilObj]
	whileTrue:
	   [| mDict mArray size |
	    mDict  := currClass instVarAt: Class_mdict.
	    mArray := mDict instVarAt: MethodDictionary_array.
	    size   := mArray size.
	    0 to: size - 1 do: [:i |
		aMethod == (mArray fetchPointer: i)
		    ifTrue: [^Array with: currClass with: (mDict fetchPointer: MethodDictionary_selectorStart + i)]].
	    currClass := currClass instVarAt: Class_superclass].
    ^Array with: aReceiver class with: nil
]

SqueakObject printNameOfClass
[
    ^self printNameOfClass: 5
]

SqueakObject printNameOfClass: depth
[
    depth <= 0 ifTrue: [^'class recursion too deep' putln].
    self isFixed ifFalse: ['class has wrong format' putln].
    (instSize == 6 or: [instSize == 7])		"Metaclass"
	ifTrue:
	   [(self instVarAt: instSize - 1) printNameOfClass: depth - 1.
	    ^' class' put].
    (instSize == 9 or: [instSize == 11])	"Class"
	ifTrue:
	   [^(self fetchPointer: 6) putString].
    ('class has wrong size: ', instSize printString) putln.
]

SqueakObject putString
[
    self isBytes ifFalse: [('string has wrong format: ') putln.   format print.  ^0].
    fields do: [:c | (Character value: c) put].
    ^fields size
]

Squeak cr		[ $\n put ]
Squeak tab		[ $\t put ]
Squeak put: anObject	[ anObject put ]
Squeak print: anObject	[ anObject print ]
Squeak hex2: anInteger	[ (((anInteger // 16) printStringRadix: 16), ((anInteger \\ 16) printStringRadix: 16)) put ]

SmallInteger printHex2
[
    self < 16 ifTrue: [$0 put].
    (self printStringRadix: 16) put.
]

Squeak printObject: obj
[
    obj    isNil    ifTrue: [^'NIL'   put].
    obj == nilObj   ifTrue: [^'nil'   put].
    obj == trueObj  ifTrue: [^'true'  put].
    obj == falseObj ifTrue: [^'false' put].
    obj isSmallInteger ifTrue: [obj print.  $# put.  ^(obj printStringRadix: 16) put].
    (obj class == (self splObj: ClassLargePositiveInteger))
	 ifTrue:
	    [$# put.
	     obj size downTo: 1 do: [:i | (obj fields at: i) printHex2].
	     ^$  put].
    (obj class == (self splObj: ClassFloat))
	 ifTrue:
	    [$$ put.
	     ^obj floatValue print].
    (obj class == (self splObj: ClassMethodContext) or: [obj class == (self splObj: ClassBlockContext)])
	ifTrue:  [self printContext: obj]
	ifFalse:
	   [obj class printNameOfClass.
	    (obj fields notNil and: [obj size > obj instSize]) ifTrue: [$[ put.  obj size print.  $] put]]
]

Squeak decodeTable
[
    ^#(
	(  0  15 decodePushReceiverVariable:)
	( 16  31 decodePushTemporaryVariable:)
	( 32  63 decodePushLiteralConstant:)
	( 64  95 decodePushLiteralVariable:)
	( 96 103 decodeStoreAndPopReceiverVariable:)
	(104 111 decodeStoreAndPopTemporaryVariable:)
	(112	 decodePushReceiver:)
	(113	 decodePushConstantTrue:)
	(114	 decodePushConstantFalse:)
	(115	 decodePushConstantNil:)
	(116	 decodePushConstantMinusOne:)
	(117	 decodePushConstantZero:)
	(118	 decodePushConstantOne:)
	(119	 decodePushConstantTwo:)
	(120	 decodeReturnReceiver:)
	(121	 decodeReturnTrue:)
	(122	 decodeReturnFalse:)
	(123	 decodeReturnNil:)
	(124	 decodeReturnTopFromMethod:)
	(125	 decodeReturnTopFromBlock:)
	(126	 decodeUnknown:)
	(127	 decodeUnknown:)
	(128	 decodeExtendedPush:)
	(129	 decodeExtendedStore:)
	(130	 decodeExtendedStoreAndPop:)
	(131	 decodeSingleExtendedSend:)
	(132	 decodeDoubleExtendedDoAnything:)
	(133	 decodeSingleExtendedSuper:)
	(134	 decodeSecondExtendedSend:)
	(135	 decodePopStack:)
	(136	 decodeDuplicateTop:)
	(137	 decodePushActiveContext:)
	(138 143 decodeExperimental:)
	(144 151 decodeShortUnconditionalJump:)
	(152 159 decodeShortConditionalJump:)
	(160 167 decodeLongUnconditionalJump:)
	(168 171 decodeLongJumpIfTrue:)
	(172 175 decodeLongJumpIfFalse:)
	"176-191 sendArithmeticSelectorBytecode"
	(176 207 decodeSendSpecialSelector:)
	(208 223 decodeSendLiteralSelector0:)
	(224 239 decodeSendLiteralSelector1:)
	(240 255 decodeSendLiteralSelector2:)
    )
]

DecodeTable := []

Squeak initialiseDebugging
[
    DecodeTable := Array new: 256.
    self table: DecodeTable from: self decodeTable
]

PrevContext := []

Squeak peekByte: offset
[
    ^method fetchByte: instructionPointer + offset - 1
]

Squeak trace
[
    | bc n |
""
    PrevContext ~~ activeContext
	ifTrue:
	   [self printContext: activeContext; cr.
"	    '\t\t' put.  receiver class printNameOfClass.  $\n put."
	    PrevContext := activeContext].
""
    bc := self peekByte: 0.
    self put: $\t; print: instructionPointer; put: $\t; hex2: bc; put: $ .
    n := self _perform: (DecodeTable at: 1 + bc) w: bc.
    32 - n timesRepeat: [$  put].
    self put: ' ['; print: stackPointer; put: $].
    1 to: stackPointer do: [:i | self put: $ ; printObject: (activeContext fetchPointer: Context_stackFrameStart + i)].
    $\n put.
]

Squeak Ill: b		[ ^self error: ('ILLEGAL BYTECODE', b printStringRadix: 16) ]
Squeak Drop		[ ^('pop') put ]
Squeak Dup		[ ^('dup') put ]
Squeak LdSelf        	[ ^('ld self') put ]
Squeak LdNil         	[ ^('ld nil') put ]
Squeak LdTrue        	[ ^('ld true') put ]
Squeak LdFalse       	[ ^('ld false') put ]
Squeak LdThisContext 	[ ^('ld thisContext') put ]
Squeak Ld: n           	[ ^('ld ', n printString) put ]
Squeak LdRcv: n        	[ ^('ld rcv ', n printString) put ]
Squeak LdTmp: n        	[ ^('ld tmp ', n printString) put ]
Squeak LdLit: n        	[ ^('ld lit ', n printString) put ]
Squeak LdVar: n        	[ ^('ld var ', n printString) put ]
Squeak StRcv: n        	[ ^('st rcv ', n printString) put ]
Squeak StTmp: n        	[ ^('st tmp ', n printString) put ]
Squeak StIll: n        	[ ^self error: 'ILLEGAL STORE ' ]
Squeak StVar: n        	[ ^('st var ', n printString) put ]
Squeak PopRcv: n       	[ ^('pop rcv ', n printString) put ]
Squeak PopTmp: n       	[ ^('pop tmp ', n printString) put ]
Squeak PopVar: n       	[ ^('pop var ', n printString) put ]
Squeak RetSelf       	[ ^('ret self') put ]
Squeak RetTrue       	[ ^('ret true') put ]
Squeak RetFalse      	[ ^('ret false') put ]
Squeak RetNil        	[ ^('ret nil') put ]
Squeak RetTop        	[ ^('ret top') put ]
Squeak RetTopBlk     	[ ^('blk ret top') put ]
Squeak Send: s n: n    	[ ^('send ' ) put + n print + $  put + (self fetchLiteral: s) putString ]
Squeak Super: s n: n   	[ ^('super ') put + n print + $  put + (self fetchLiteral: s) putString ]
Squeak Special: s 	[ ^('special ') put + (self specialArgumentCount: s) print + $  put + (self specialSelector: s) putString ]
Squeak Br: n           	[ ^('br ', n printString) put ]
Squeak Bt: n           	[ ^('bt ', n printString) put ]
Squeak Bf: n           	[ ^('bf ', n printString) put ]
Squeak CkIntr		[ ^('ck intr') put ]

Squeak decodePushReceiverVariable: bc		[ ^self LdRcv: bc ]
Squeak decodePushTemporaryVariable: bc		[ ^self LdTmp: (bc bitAnd: 0x0f) ]
Squeak decodePushLiteralConstant: bc		[ ^self LdLit: (bc bitAnd: 0x1f) ]
Squeak decodePushLiteralVariable: bc		[ ^self LdVar: (bc bitAnd: 0x1f) ]
Squeak decodeStoreAndPopReceiverVariable: bc	[ ^self PopRcv: (bc bitAnd: 7) ]
Squeak decodeStoreAndPopTemporaryVariable: bc	[ ^self PopTmp: (bc bitAnd: 7) ]
Squeak decodePushReceiver: bc			[ ^self LdSelf ]
Squeak decodePushConstantTrue: bc		[ ^self LdTrue ]
Squeak decodePushConstantFalse: bc		[ ^self LdFalse ]
Squeak decodePushConstantNil: bc		[ ^self LdNil ]
Squeak decodePushConstantMinusOne: bc		[ ^self Ld: -1 ]
Squeak decodePushConstantZero: bc		[ ^self Ld:  0 ]
Squeak decodePushConstantOne: bc		[ ^self Ld:  1 ]
Squeak decodePushConstantTwo: bc		[ ^self Ld:  2 ]
Squeak decodeReturnReceiver: bc			[ ^self RetSelf ]
Squeak decodeReturnTrue: bc			[ ^self RetTrue ]
Squeak decodeReturnFalse: bc			[ ^self RetFalse ]
Squeak decodeReturnNil: bc			[ ^self RetNil ]
Squeak decodeReturnTopFromMethod: bc		[ ^self RetTop ]
Squeak decodeReturnTopFromBlock: bc		[ ^self RetTopBlk ]
Squeak decodeUnknown: bc			[ ^self Ill: bc ]

Squeak decodeExtendedPush: bc
[
    | b1 t o |
    b1 := self peekByte: 1.
    t := b1 >> 6 bitAnd: 3.
    o := b1 bitAnd: 0x3f.
    t == 0 ifTrue: [^self LdRcv: o ].
    t == 1 ifTrue: [^self LdTmp: o ].
    t == 2 ifTrue: [^self LdLit: o ].
    t == 3 ifTrue: [^self LdVar: o ].
]

Squeak decodeExtendedStore: bc
[
    | b1 t o |
    b1 := self peekByte: 1.
    t := b1 >> 6 bitAnd: 3.
    o := b1 bitAnd: 0x3f.
    t == 0 ifTrue: [^self StRcv: o ].
    t == 1 ifTrue: [^self StTmp: o ].
    t == 2 ifTrue: [^self StIll: o ].
    t == 3 ifTrue: [^self StVar: o ].
]

Squeak decodeExtendedStoreAndPop: bc
[
    | b1 t o |
    b1 := self peekByte: 1.
    t := b1 >> 6 bitAnd: 3.
    o := b1 bitAnd: 0x3f.
    t == 0 ifTrue: [^self PopRcv: o ].
    t == 1 ifTrue: [^self PopTmp: o ].
    t == 2 ifTrue: [^self StIll:  o ].
    t == 3 ifTrue: [^self PopVar: o ].
]

Squeak decodeSingleExtendedSend: bc
[
    | b1 |
    b1 := self peekByte: 1.
    ^self Send: (b1 bitAnd: 0x1f) n: b1 >> 5
]

Squeak decodeDoubleExtendedDoAnything: bc
[
    | b1 b2 t |
    b1 := self peekByte: 1.
    b2 := self peekByte: 2.
    t := b1 >> 5.
    t == 0 ifTrue: [^self Send:   b2 n: (b1 bitAnd: 0x1F) ].
    t == 1 ifTrue: [^self Super:  b2 n: (b1 bitAnd: 0x1F) ].
    t == 2 ifTrue: [^self LdRcv:  b2 ].
    t == 3 ifTrue: [^self LdLit:  b2 ].
    t == 4 ifTrue: [^self LdVar:  b2 ].
    t == 5 ifTrue: [^self StRcv:  b2 ].
    t == 6 ifTrue: [^self PopRcv: b2 ].
    t == 7 ifTrue: [^self StVar:  b2 ].
]

Squeak decodeSingleExtendedSuper: bc
[
    | b1 |
    b1 := self peekByte: 1.
    ^self Super: (b1 bitAnd: 0x1f) n: b1 >> 5
]

Squeak decodeSecondExtendedSend: bc
[
    | b1 |
    b1 := self peekByte: 1.
    ^self Send: (b1 bitAnd: 0x3f) n: b1 >> 6
]

Squeak decodePopStack: bc		[ ^self Drop ]
Squeak decodeDuplicateTop: bc		[ ^self Dup ]
Squeak decodePushActiveContext: bc	[ ^self LdThisContext ]
Squeak decodeExperimental: bc		[ ^self Ill: bc ]
Squeak decodeShortUnconditionalJump: bc	[ ^self Br: (bc bitAnd: 7) + 1 ]
Squeak decodeShortConditionalJump: bc	[ ^self Bf: (bc bitAnd: 7) + 1 ]

Squeak decodeLongUnconditionalJump: bc
[
    | b1 |
    b1 := self peekByte: 1.
    ^self Br: 256 * ((bc bitAnd: 7) - 4) + b1
]

Squeak decodeLongJumpIfTrue: bc
[
    | b1 |
    b1 := self peekByte: 1.
    ^self Bt: 256 * (bc bitAnd: 3) + b1
]

Squeak decodeLongJumpIfFalse: bc
[
    | b1 |
    b1 := self peekByte: 1.
    ^self Bf: 256 * (bc bitAnd: 3) + b1
]

Squeak decodeSendSpecialSelector: bc	[ ^self Special: bc - 176 ]

Squeak decodeSendLiteralSelector0: bc	[ ^self Send: (bc bitAnd: 0xf) n: 0 ]
Squeak decodeSendLiteralSelector1: bc	[ ^self Send: (bc bitAnd: 0xf) n: 1 ]
Squeak decodeSendLiteralSelector2: bc	[ ^self Send: (bc bitAnd: 0xf) n: 2 ]
