{ import: Squeak }

Form_bits	:= [ 0 ]
Form_width	:= [ 1 ]
Form_height	:= [ 2 ]
Form_depth	:= [ 3 ]
Form_offset	:= [ 4 ]

Squeak primitiveTable
[
    ^#(
	"Integer Primitives (0-19)"
	(  0 	 primitiveFail)
        (  1 	 primitiveAdd)
	(  2 	 primitiveSubtract)
	(  3 	 primitiveLessThan)
	(  4 	 primitiveGreaterThan)
	(  5 	 primitiveLessOrEqual)
	(  6 	 primitiveGreaterOrEqual)
	(  7 	 primitiveEqual)
	(  8 	 primitiveNotEqual)
	(  9 	 primitiveMultiply)
	( 10 	 primitiveDivide)
	( 11 	 primitiveMod)
	( 12 	 primitiveDiv)
	( 13 	 primitiveQuo)
	( 14 	 primitiveBitAnd)
	( 15 	 primitiveBitOr)
	( 16 	 primitiveBitXor)
	( 17 	 primitiveBitShift)
	( 18 	 primitiveMakePoint)
	( 19 	 primitiveFail)					"Guard primitive for simulation -- *must* fail"
	"LargeInteger Primitives (20-39)"
	"32-bit logic is aliased to Integer prims above"
	( 20  39 primitiveFail)
	"Float Primitives (40-59)"
	( 40 	 primitiveAsFloat)
	( 41 	 primitiveFloatAdd)
	( 42 	 primitiveFloatSubtract)
	( 43 	 primitiveFloatLessThan)
	( 44 	 primitiveFloatGreaterThan)
	( 45 	 primitiveFloatLessOrEqual)
	( 46 	 primitiveFloatGreaterOrEqual)
	( 47 	 primitiveFloatEqual)
	( 48 	 primitiveFloatNotEqual)
	( 49 	 primitiveFloatMultiply)
	( 50 	 primitiveFloatDivide)
	( 51 	 primitiveTruncated)
	( 52 	 primitiveFractionalPart)
	( 53 	 primitiveExponent)
	( 54 	 primitiveTimesTwoPower)
	( 55 	 primitiveSquareRoot)
	( 56 	 primitiveSine)
	( 57 	 primitiveArctan)
	( 58 	 primitiveLogN)
	( 59 	 primitiveExp)
	"Subscript and Stream Primitives (60-67)"
	( 60 	 primitiveAt)
	( 61 	 primitiveAtPut)
	( 62 	 primitiveSize)
	( 63 	 primitiveStringAt)
	( 64 	 primitiveStringAtPut)
	( 65 	 primitiveNext)
	( 66 	 primitiveNextPut)
	( 67 	 primitiveAtEnd)
	"StorageManagement Primitives (68-79)"
	( 68 	 primitiveObjectAt)
	( 69 	 primitiveObjectAtPut)
	( 70 	 primitiveNew)
	( 71 	 primitiveNewWithArg)
	( 72 	 primitiveArrayBecomeOneWay)	"Blue Book: primitiveBecome"
	( 73 	 primitiveInstVarAt)
	( 74 	 primitiveInstVarAtPut)
	( 75 	 primitiveHash)
	( 76 	 primitiveStoreStackp)					"Blue Book: primitiveAsObject"
	( 77 	 primitiveSomeInstance)
	( 78 	 primitiveNextInstance)
	( 79 	 primitiveNewMethod)

	"Control Primitives (80-89)"
	( 80 	 primitiveBlockCopy)
	( 81 	 primitiveValue)
	( 82 	 primitiveValueWithArgs)
	( 83 	 primitivePerform)
	( 84 	 primitivePerformWithArgs)
	( 85 	 primitiveSignal)
	( 86 	 primitiveWait)
	( 87 	 primitiveResume)
	( 88 	 primitiveSuspend)
	( 89 	 primitiveFlushCache)
	"Input/Output Primitives (90-109)"
	( 90 	 primitiveMousePoint)
	( 91 	 primitiveTestDisplayDepth)			"Blue Book: primitiveCursorLocPut"
	( 92 	 primitiveSetDisplayMode)				"Blue Book: primitiveCursorLink"
	( 93 	 primitiveInputSemaphore)
	( 94 	 primitiveGetNextEvent)				"Blue Book: primitiveSampleInterval"
	( 95 	 primitiveInputWord)
	( 96 	 primitiveCopyBits)				"primitiveCopyBits"
	( 97 	 primitiveSnapshot)
	( 98 	 primitiveStoreImageSegment)
	( 99 	 primitiveLoadImageSegment)
	(100 	 primitivePerformInSuperclass)		"Blue Book: primitiveSignalAtTick"
	(101 	 primitiveBeCursor)
	(102 	 primitiveBeDisplay)
	(103 	 primitiveScanCharacters)
	(104 	 primitiveFail)	"primitiveDrawLoop"
	(105 	 primitiveStringReplace)
	(106 	 primitiveScreenSize)
	(107 	 primitiveMouseButtons)
	(108 	 primitiveKbdNext)
	(109 	 primitiveKbdPeek)
	"System Primitives (110-119)"
	(110 	 primitiveEquivalent)
	(111 	 primitiveClass)
	(112 	 primitiveBytesLeft)
	(113 	 primitiveQuit)
	(114 	 primitiveExitToDebugger)
	(115 	 primitiveChangeClass)					"Blue Book: primitiveOopsLeft"
	(116 	 primitiveFlushCacheByMethod)
	(117 	 primitiveExternalCall)
	(118 	 primitiveDoPrimitiveWithArgs)
	(119 	 primitiveFlushCacheSelective)
	    "Squeak 2.2 and earlier use 119.  Squeak 2.3 and later use 116.  Both are supported for backward compatibility."
	"Miscellaneous Primitives (120-127)"
	(120 	 primitiveCalloutToFFI)
	(121 	 primitiveImageName)
	(122 	 primitiveNoop)					"Blue Book: primitiveImageVolume"
	(123 	 primitiveValueUninterruptably)	"@@@: Remove this when all VMs have support"
	(124 	 primitiveLowSpaceSemaphore)
	(125 	 primitiveSignalAtBytesLeft)
	"Squeak Primitives Start Here"
	"Squeak Miscellaneous Primitives (128-149)"
	(126 	 primitiveDeferDisplayUpdates)
	(127 	 primitiveShowDisplayRect)
	(128 	 primitiveArrayBecome)
	(129 	 primitiveSpecialObjectsOop)
	(130 	 primitiveFullGC)
	(131 	 primitiveIncrementalGC)
	(132 	 primitiveObjectPointsTo)
	(133 	 primitiveSetInterruptKey)
	(134 	 primitiveInterruptSemaphore)
	(135 	 primitiveMillisecondClock)
	(136 	 primitiveSignalAtMilliseconds)
	(137 	 primitiveSecondsClock)
	(138 	 primitiveSomeObject)
	(139 	 primitiveNextObject)
	(140 	 primitiveBeep)
	(141 	 primitiveClipboardText)
	(142 	 primitiveVMPath)
	(143 	 primitiveShortAt)
	(144 	 primitiveShortAtPut)
	(145 	 primitiveConstantFill)
	"NOTE: When removing the obsolete indexed primitives, the following two should go become #primitiveIntegerAt / atPut"
	(146 	 primitiveObsoleteIndexedPrimitive)	"primitiveReadJoystick"
	(147 	 primitiveObsoleteIndexedPrimitive)	"primitiveWarpBits"
	(148 	 primitiveClone)
	(149 	 primitiveGetAttribute)
	"File Primitives (150-169) - NO LONGER INDEXED"
	(150     primitiveObsoleteIndexedPrimitive)
	(151     primitiveFileClose)
	(152     primitiveFileGetPosition)
	(153	 primitiveFileOpen)
	(154	 primitiveObsoleteIndexedPrimitive)
	(155	 primitiveFileSetPosition)
	(156	 primitiveObsoleteIndexedPrimitive)
	(157	 primitiveFileSize)
	(158	 primitiveFileWrite)
	(159 160 primitiveObsoleteIndexedPrimitive)
	(161	 primitivePathNameDelimiter)
	(162 164 primitiveObsoleteIndexedPrimitive)
	(165     primitiveIntegerAt)		"hacked in here for now"
	(166     primitiveIntegerAtPut)
	(167 168 primitiveMissing)
	(169     primitiveObsoleteIndexedPrimitive)
	"Sound Primitives (170-199) - NO LONGER INDEXED"
	(170 185 primitiveObsoleteIndexedPrimitive)
	"Closure primitives"
	(186 	 primitiveClosureValue)
	(187 	 primitiveClosureValueWithArgs)
	(188 	 primitiveExecuteMethod)
	"Sound Primitives (continued) - NO LONGER INDEXED"
	(189 194 primitiveObsoleteIndexedPrimitive)
	"Unwind primitives"
	(195 	 primitiveFindNextUnwindContext)
	(196 	 primitiveTerminateTo)
	(197 	 primitiveFindHandlerContext)
	(198 	 primitiveMarkUnwindMethod)
	(199 	 primitiveMarkHandlerMethod)
	"Networking Primitives (200-229) - NO LONGER INDEXED"
	(200 225 primitiveObsoleteIndexedPrimitive)
	(226 229 primitiveMissing)
	"Other Primitives (230-249)"
	(230 	 primitiveRelinquishProcessor)
	(231 	 primitiveForceDisplayUpdate)
	(232 	 primitiveFormPrint)
	(233 	 primitiveSetFullScreen)
	(234 	 primitiveBitmapDecompress) "primBitmapdecompressfromByteArrayat"
	(235 	 primitiveFail)			    "primStringcomparewithcollated"
	(236 	 primitiveObsoleteIndexedPrimitive) "primSampledSoundconvert8bitSignedFromto16Bit"
	(237 	 primitiveFail)				"primBitmapcompresstoByteArray"
	(238 241 primitiveObsoleteIndexedPrimitive) "serial port primitives"
	(242 	 primitiveMissing)
	(243 	 primitiveObsoleteIndexedPrimitive) "primStringtranslatefromtotable"
	(244 	 primitiveObsoleteIndexedPrimitive) "primStringfindFirstInStringinSetstartingAt"
	(245 	 primitiveFail) "primStringindexOfAsciiinStringstartingAt"
	(246 	 primitiveObsoleteIndexedPrimitive) "primStringfindSubstringinstartingAtmatchTable"
	(247 	 primitiveSnapshotEmbedded)
	(248 	 primitiveInvokeObjectAsMethod)
	(249 	 primitiveMissing)
	"VM Implementor Primitives (250-255)"
	(250 	 clearProfile)
	(251 	 dumpProfile)
	(252 	 startProfiling)
	(253 	 stopProfiling)
	(254 	 primitiveVMParameter)
	(255 	 primitiveInstVarsPutFromStack) "Never used except in Disney tests.  Remove after 2.3 release."
	"Quick Push Const Methods"
	(256 	 primitivePushSelf)
	(257 	 primitivePushTrue)
	(258 	 primitivePushFalse)
	(259 	 primitivePushNil)
	(260 	 primitivePushMinusOne)
	(261 	 primitivePushZero)
	(262 	 primitivePushOne)
	(263 	 primitivePushTwo)
	"Quick Push Const Methods"
	(264 519 primitiveLoadInstVar)
	"MIDI Primitives (520-539) - NO LONGER INDEXED"
	(520 529 primitiveObsoleteIndexedPrimitive)
	(530 539 primitiveMissing)  "reserved for extended MIDI primitives"
	"Experimental Asynchrous File Primitives - NO LONGER INDEXED"
	(540 545 primitiveObsoleteIndexedPrimitive)
	(546 547 primitiveMissing)
	"Pen Tablet Primitives - NO LONGER INDEXED"
	(548 	 primitiveObsoleteIndexedPrimitive)
	(549 	 primitiveObsoleteIndexedPrimitive)
	"Sound Codec Primitives - NO LONGER INDEXED"
	(550 553 primitiveObsoleteIndexedPrimitive)
	(554 569 primitiveMissing)
	"External primitive support primitives"
	(570 	 primitiveFlushExternalPrimitives)
	(571 	 primitiveUnloadModule)
	(572 	 primitiveListBuiltinModule)
	(573 	 primitiveListExternalModule)
	(574 	 primitiveMissing) "reserved for addl. external support prims"
	"Unassigned Primitives"
	(575 700 primitiveMissing)
    )
]

MillisecondClockMask := [ 0x1fffffff ]

Squeak pop2thenPushIfIntegerValue: result
[
    result isSmallInteger
	ifTrue:  [self pop2thenPush: result]
	ifFalse: [successFlag := false]
]

Squeak loadFloatFrom: obj
[
    (obj class == (self splObj: ClassFloat)) ifTrue: [^obj floatValue].
    successFlag := false.
    ^1
]

Squeak loadFloatOrIntFrom: obj
[
    (obj isSmallInteger) ifTrue: [^obj asFloat].
    (obj class == (self splObj: ClassFloat)) ifTrue: [^obj floatValue].
    successFlag := false.
    ^1
]

Squeak primitiveResponse
[
    | startTime timerPending sp |
    (timerPending := nextWakeupTick > 0)
	ifTrue: [startTime := io lowResMSecs].
    successFlag := true.
    sp := stackPointer.
    self _perform: (primitiveTable at: 1 + primitiveIndex).
"
    successFlag ifFalse: [primitiveIndex == 19 ifFalse: [self put: 'FAILED primitive '; print: primitiveIndex; put: ' after '; print: bytecodeCount; put: ' bytecodes\n']].
"
    (timerPending and: [io lowResMSecs ~~ startTime and: [(io mSecs bitAnd: MillisecondClockMask) >= nextWakeupTick]])
	ifTrue:
	   [successFlag
		ifTrue:  [self checkForInterrupts]
		ifFalse: [interruptCheckCounter := 0]].
    ^successFlag
]

Squeak primitiveFail
[
    successFlag := false
]

Squeak primitiveAdd
[
    | rcvr arg |
    rcvr := self stackValue: 1.
    arg  := self stackTop.
    (rcvr isSmallInteger and: [arg isSmallInteger]) ifTrue: [^self pop2thenPushIfIntegerValue: rcvr + arg].
    successFlag := false
]

Squeak primitiveSubtract
[
    | rcvr arg |
    rcvr := self stackValue: 1.
    arg  := self stackTop.
    (rcvr isSmallInteger and: [arg isSmallInteger]) ifTrue: [^self pop2thenPushIfIntegerValue: rcvr - arg].
    successFlag := false
]

Squeak primitiveLessThan
[
    | rcvr arg |
    rcvr := self stackValue: 1.
    arg  := self stackTop.
    (rcvr isSmallInteger and: [arg isSmallInteger]) ifTrue: [^self pop2thenPush: (rcvr < arg ifTrue: [trueObj] ifFalse: [falseObj])].
    successFlag := false
]

Squeak primitiveGreaterThan
[
    | rcvr arg |
    rcvr := self stackValue: 1.
    arg  := self stackTop.
    (rcvr isSmallInteger and: [arg isSmallInteger]) ifTrue: [^self pop2thenPush: (rcvr > arg ifTrue: [trueObj] ifFalse: [falseObj])].
    successFlag := false
]

Squeak primitiveLessOrEqual
[
    | rcvr arg |
    rcvr := self stackValue: 1.
    arg  := self stackTop.
    (rcvr isSmallInteger and: [arg isSmallInteger]) ifTrue: [^self pop2thenPush: (rcvr <= arg ifTrue: [trueObj] ifFalse: [falseObj])].
    successFlag := false
]

Squeak primitiveGreaterOrEqual
[
    | rcvr arg |
    rcvr := self stackValue: 1.
    arg  := self stackTop.
    (rcvr isSmallInteger and: [arg isSmallInteger]) ifTrue: [^self pop2thenPush: (rcvr >= arg ifTrue: [trueObj] ifFalse: [falseObj])].
    successFlag := false
]

Squeak primitiveEqual
[
    | rcvr arg |
    rcvr := self stackValue: 1.
    arg  := self stackTop.
    (rcvr isSmallInteger and: [arg isSmallInteger]) ifTrue: [^self pop2thenPush: (rcvr == arg ifTrue: [trueObj] ifFalse: [falseObj])].
    successFlag := false
]

Squeak primitiveNotEqual
[
    | rcvr arg |
    rcvr := self stackValue: 1.
    arg  := self stackTop.
    (rcvr isSmallInteger and: [arg isSmallInteger]) ifTrue: [^self pop2thenPush: (rcvr ~~ arg ifTrue: [trueObj] ifFalse: [falseObj])].
    successFlag := false
]

Squeak primitiveMultiply
[
    | rcvr arg |
    rcvr := self stackValue: 1.
    arg  := self stackTop.
    (rcvr isSmallInteger and: [arg isSmallInteger]) ifTrue: [^self pop2thenPushIfIntegerValue: rcvr * arg].
    successFlag := false
]

Squeak primitiveDivide
[
    | rcv arg ans |
    rcv := self stackValue: 1.
    arg := self stackTop.
    (rcv isSmallInteger and: [arg isSmallInteger and: [arg ~= 0]])
	ifTrue:
	   [ans := rcv / arg.
	    rcv == ans * arg ifTrue: [^self pop2thenPush: ans]].
    successFlag := false.
]

Squeak primitiveMod
[
    | rcvr arg |
    rcvr := self stackValue: 1.
    arg  := self stackTop.
    (rcvr isSmallInteger and: [arg isSmallInteger]) ifTrue: [^self pop2thenPushIfIntegerValue: rcvr \\ arg].
    successFlag := false
]

Squeak primitiveDiv
[
    | rcvr arg |
    rcvr := self stackValue: 1.
    arg  := self stackTop.
    (rcvr isSmallInteger and: [arg isSmallInteger]) ifTrue: [^self pop2thenPushIfIntegerValue: rcvr // arg].
    successFlag := false
]

Squeak primitiveQuo
[
    | rcv arg ans |
    rcv := self stackValue: 1.
    arg := self stackTop.
    (rcv isSmallInteger and: [arg isSmallInteger and: [arg ~= 0 and: [(ans := rcv quo: arg) isSmallInteger]]])
	ifTrue:  [self pop2thenPush: ans]
	ifFalse: [successFlag := false]
]

Squeak primitiveBitAnd
[
    | rcv arg |
    rcv := self stackValue: 1.
    arg := self stackTop.
    (rcv isSmallInteger and: [rcv >= 0 and: [arg isSmallInteger and: [arg >= 0]]])
	ifTrue:  [self pop2thenPush: (rcv bitAnd: arg)]
	ifFalse: [successFlag := false]
]

Squeak primitiveBitOr
[
    | rcv arg |
    rcv := self stackValue: 1.
    arg := self stackTop.
    (rcv isSmallInteger and: [rcv >= 0 and: [arg isSmallInteger and: [arg >= 0]]])
	ifTrue:  [self pop2thenPush: (rcv bitOr: arg)]
	ifFalse: [successFlag := false]
]

Squeak primitiveBitXor
[
    | rcv arg |
    rcv := self stackValue: 1.
    arg := self stackTop.
    (rcv isSmallInteger and: [rcv >= 0 and: [arg isSmallInteger and: [arg >= 0]]])
	ifTrue:  [self pop2thenPush: (rcv bitXor: arg)]
	ifFalse: [successFlag := false]
]

Squeak primitiveBitShift
[
    | rcv arg ans |
    rcv := self stackValue: 1.
    arg := self stackTop.
    (rcv isSmallInteger and: [arg isSmallInteger])
	ifTrue:
	   [(arg < 0)
		ifTrue: [^self pop2thenPush: rcv >> (0 - arg)].
	    ans := rcv << arg.
	    (ans isSmallInteger and: [ans >> arg == rcv])
		ifTrue: [^self pop2thenPush: ans]].
    successFlag := false
]

Squeak primitiveMakePoint
[
    | rcvr arg pt |
    rcvr := self stackValue: 1.
    arg  := self stackTop.
    (rcvr isSmallInteger and: [arg isSmallInteger])
	ifTrue:  [self pop2thenPush: (self makePointX: rcvr Y: arg)]
	ifFalse: [successFlag := false]
]

	"Float Primitives"

Squeak primitiveAsFloat
[
    | arg |
    arg := self stackTop.
    (arg isSmallInteger)
	ifTrue:  [self popThenPush: (self makeFloat: arg asFloat)]
	ifFalse: [successFlag := false]
]

Squeak primitiveFloatAdd
[
    | rcv arg |
    rcv := self loadFloatOrIntFrom: (self stackValue: 1).
    arg := self loadFloatOrIntFrom: (self stackTop).
    successFlag ifTrue: [self pop2thenPush: (self makeFloat: rcv + arg)].
]

Squeak primitiveFloatSubtract
[
    | rcv arg |
    rcv := self loadFloatOrIntFrom: (self stackValue: 1).
    arg := self loadFloatOrIntFrom: (self stackTop).
    successFlag ifTrue: [self pop2thenPush: (self makeFloat: rcv - arg)].
]

Squeak primitiveFloatLessThan
[
    | rcv arg |
    rcv := self loadFloatOrIntFrom: (self stackValue: 1).
    arg := self loadFloatOrIntFrom: (self stackTop).
    successFlag ifTrue: [self pop2thenPush: (rcv < arg ifTrue: [trueObj] ifFalse: [falseObj])]
]

Squeak primitiveFloatGreaterThan
[
    | rcv arg |
    rcv := self loadFloatOrIntFrom: (self stackValue: 1).
    arg := self loadFloatOrIntFrom: (self stackTop).
    successFlag ifTrue: [self pop2thenPush: (rcv > arg ifTrue: [trueObj] ifFalse: [falseObj])]
]

Squeak primitiveFloatLessOrEqual
[
    | rcv arg |
    rcv := self loadFloatOrIntFrom: (self stackValue: 1).
    arg := self loadFloatOrIntFrom: (self stackTop).
    successFlag ifTrue: [self pop2thenPush: (rcv <= arg ifTrue: [trueObj] ifFalse: [falseObj])]
]

Squeak primitiveFloatGreaterOrEqual
[
    | rcv arg |
    rcv := self loadFloatOrIntFrom: (self stackValue: 1).
    arg := self loadFloatOrIntFrom: (self stackTop).
    successFlag ifTrue: [self pop2thenPush: (rcv >= arg ifTrue: [trueObj] ifFalse: [falseObj])]
]

Squeak primitiveFloatEqual
[
    | rcv arg |
    rcv := self loadFloatOrIntFrom: (self stackValue: 1).
    arg := self loadFloatOrIntFrom: (self stackTop).
    successFlag ifTrue: [self pop2thenPush: (rcv = arg ifTrue: [trueObj] ifFalse: [falseObj])]
]

Squeak primitiveFloatNotEqual
[
    | rcv arg |
    rcv := self loadFloatOrIntFrom: (self stackValue: 1).
    arg := self loadFloatOrIntFrom: (self stackTop).
    successFlag ifTrue: [self pop2thenPush: (rcv ~= arg ifTrue: [trueObj] ifFalse: [falseObj])]
]

Squeak primitiveFloatMultiply
[
    | rcv arg |
    rcv := self loadFloatOrIntFrom: (self stackValue: 1).
    arg := self loadFloatOrIntFrom: (self stackTop).
    successFlag ifTrue: [self pop2thenPush: (self makeFloat: rcv * arg)].
]

Squeak primitiveFloatDivide
[
    | rcv arg |
    rcv := self loadFloatOrIntFrom: (self stackValue: 1).
    arg := self loadFloatOrIntFrom: (self stackTop).
    successFlag ifTrue: [self pop2thenPush: (self makeFloat: rcv / arg)].
]

Squeak primitiveTruncated
[
    | rcv t |
    rcv := self loadFloatFrom: self stackTop.
    (successFlag and: [(t := rcv truncated) isSmallInteger])
	ifTrue:  [self popThenPush: t]
	ifFalse: [successFlag := false]
]

Squeak primitiveFractionalPart
[
    | rcv |
    rcv := self loadFloatFrom: self stackTop.
    successFlag
	ifTrue:  [self popThenPush: (self makeFloat: rcv fractionPart)]
	ifFalse: [successFlag := false]
]

Squeak primitiveExponent
[
    | rcv |
    rcv := self loadFloatFrom: self stackTop.
    successFlag
	ifTrue:  [self popThenPush: rcv exponent]
	ifFalse: [successFlag := false]
]

Squeak primitiveTimesTwoPower		[ ^self error: 'UNIMPLEMENTED primitiveTimesTwoPower' ]
Squeak primitiveSquareRoot		[ ^self error: 'UNIMPLEMENTED primitiveSquareRoot' ]

Squeak primitiveSine
[
    | rcv |
    rcv := self loadFloatFrom: self stackTop.
    successFlag
	ifTrue:  [self popThenPush: (self makeFloat: rcv sin)]
	ifFalse: [successFlag := false]
]

Squeak primitiveArctan			[ ^self error: 'UNIMPLEMENTED primitiveArctan' ]
Squeak primitiveLogN			[ ^self error: 'UNIMPLEMENTED primitiveLogN' ]
Squeak primitiveExp			[ ^self error: 'UNIMPLEMENTED primitiveExp' ]

	"Subscript and Stream Primitives (60-67)"

PrimitivesAt := [
    #(	primitiveEmpty:at:
	primitiveFixed:at:
	primitivePointers:at:
	primitiveWeakPointers:at:
	primitiveWords:at:
	primitiveBytes:at:
	primitiveMethod:at:  ) collect: [:s | s asSelector]
]

Squeak primitiveAt
[
    | rcvr arg ans |
    rcvr := self stackValue: 1.
    arg  := self stackTop.
    (rcvr isSmallInteger not
		and: [arg isSmallInteger and: [arg > 0 and: [arg <= (rcvr size - rcvr instSize)
		and: [(ans := self _perform: (PrimitivesAt at: 1 + rcvr format) w: rcvr w: arg) notNil]]]])
	ifTrue:  [self pop2thenPush: ans]
	ifFalse: [successFlag := false]
]

Squeak primitiveEmpty: object at: index		[ ^nil ]
Squeak primitiveFixed: object at: index		[ ^nil ]
Squeak primitivePointers: object at: index	[ ^object fetchIndexed: index - 1 ]
Squeak primitiveWeakPointers: object at: index	[ ^object fetchIndexed: index - 1 ]
Squeak primitiveBytes: object at: index		[ ^object fetchByte: index - 1 ]
Squeak primitiveMethod: object at: index	[ ^object fetchByte: index - 1 ]

Squeak primitiveWords: object at: index
[
    | val |
    ^(val := object fetchWord: index - 1) isLargePositiveInteger
	ifTrue:  [self makeLargeInteger: val]
	ifFalse: [val]
]

PrimitivesAtPut := [
    #(	primitiveEmpty:at:put:
	primitiveFixed:at:put:
	primitivePointers:at:put:
	primitiveWeakPointers:at:put:
	primitiveWords:at:put:
	primitiveBytes:at:put:
	primitiveMethod:at:put:  ) collect: [:s | s asSelector]
]

Squeak primitiveAtPut
[
    | rcvr arg value ret |
    rcvr  := self stackValue: 2.
    arg   := self stackValue: 1.
    value := self stackTop.
    (rcvr isSmallInteger not
		and: [arg isSmallInteger and: [arg > 0 and: [arg <= rcvr size
		and: [(ret := self _perform: (PrimitivesAtPut at: 1 + rcvr format) w: rcvr w: arg w: value) notNil]]]])
	ifTrue:  [self pop3thenPush: value]
	ifFalse: [successFlag := false].
"
    successFlag ifFalse: [self printObject: rcvr; put: ' primitiveAt: '; printObject: arg; put: ' put: '; printObject: value; cr]
"
]

Squeak primitiveEmpty: object at: index put: val	[ ^nil ]
Squeak primitiveFixed: object at: index put: val	[ ^nil ]
Squeak primitivePointers: object at: index put: val	[ ^object storeIndexed: index - 1 with: val ]
Squeak primitiveWeakPointers: object at: index put: val	[ ^object storeIndexed: index - 1 with: val ]

Squeak primitiveWords: object at: index put: val
[
    (val isSmallInteger and: [0 <= val])
	ifTrue: [^object storeWord: index - 1 with: val].
    (val class == (self splObj: ClassLargePositiveInteger) and: [val size == 4])
	ifTrue: [^object storeWord: index - 1 with: val positiveIntegerValue].
    ^nil
]

Squeak primitiveBytes: object at: index put: val
[
    ^(val isSmallInteger and: [0 <= val and: [val <= 255]])
	ifTrue:  [object storeByte: index - 1 with: val]
	ifFalse: [nil]
]

Squeak primitiveMethod: object at: index put: val
[
    ^(val isSmallInteger and: [0 <= val and: [val <= 255]])
	ifTrue:  [object storeByte: index - 1 with: val]
	ifFalse: [nil]
]

Squeak primitiveSize
[
    | rcvr |
    rcvr := self stackTop.
    (rcvr isSmallInteger not and: [rcvr isIndexable])
	ifTrue:  [self popThenPush: rcvr size - rcvr instSize]
	ifFalse: [successFlag := false]
]

Squeak primitiveStringAt
[
    | rcv idx |
    rcv := self stackValue: 1.
    idx := self stackTop.
    (idx isSmallInteger and: [0 < idx and: [idx <= rcv size]])
	ifTrue:  [self pop2thenPush: ((self splObj: SqueakCharacterTable) fetchPointer: (rcv fetchByte: idx - 1))]
	ifFalse: [successFlag := false]
]

Squeak primitiveStringAtPut
[
    | rcv idx val |
    rcv := self stackValue: 2.
    idx := self stackValue: 1.
    val := self stackTop.
"    self assert: rcv isSmallInteger not.
    self assert: rcv isBytes."
    (val class == (self splObj: ClassCharacter) and: [idx isSmallInteger and: [0 < idx and: [idx <= rcv size]]])
	ifFalse: [^successFlag := false].
    rcv storeByte: idx - 1 with: (val instVarAt: Character_value).
    self pop3thenPush: val
]

Squeak primitiveNext			[ ^self primitiveFail ]
Squeak primitiveNextPut			[ ^self primitiveFail ]
Squeak primitiveAtEnd			[ ^self primitiveFail ]

	"StorageManagement Primitives (68-79)"

Squeak primitiveObjectAt
[
    | aMethod index |
    aMethod := self stackValue: 1.
    index := self stackTop.
    (index isSmallInteger and: [index > 0 and: [index <= aMethod literalsSize]])
	ifTrue:  [self pop2thenPush: (aMethod fetchLiteral: index - 1)]
	ifFalse: [successFlag := false]
]

Squeak primitiveObjectAtPut
[
    | theMethod index val |
    theMethod := self stackValue: 2.
    index := self stackValue: 1.
    val := self stackTop.
    (index isSmallInteger and: [index > 0 and: [index <= theMethod literalsSize]])
	ifTrue:  [self pop3thenPush: (theMethod storeLiteral: index - 1 with: val)]
	ifFalse: [successFlag := false]
]

Squeak primitiveNew
[
    self popThenPush: (self instantiateClass: self stackTop indexableSize: 0)
]

Squeak primitiveNewWithArg
[
    | type size |
    type := self stackValue: 1.
    size := self stackTop.
    (size isSmallInteger and: [size >= 0])
	ifTrue: [^self pop2thenPush: (self instantiateClass: type indexableSize: size)].
    successFlag := false.
]

Squeak primitiveArrayBecomeOneWay
[
    | rcv  arg |
    rcv := self stackValue: 1.
    arg := self stackTop.
    (rcv isSmallInteger not and: [arg isSmallInteger not
			    and: [SqueakObject bulkBecome: rcv with: arg twoWay: false]])
	ifTrue:  [self drop]
	ifFalse: [successFlag := false]
]

Squeak primitiveInstVarAt
[
    | rcv idx |
    rcv := self stackValue: 1.
    idx := self stackTop.
    (rcv isSmallInteger not and: [idx isSmallInteger and: [idx > 0 and: [idx <= rcv instSize]]])
	ifTrue:  [self pop2thenPush: (rcv instVarAt: idx - 1)]
	ifFalse: [successFlag := false]
]

Squeak primitiveInstVarAtPut
[
    | rcv idx obj |
    rcv := self stackValue: 2.
    idx := self stackValue: 1.
    obj := self stackTop.
    (rcv isSmallInteger not and: [idx isSmallInteger and: [idx > 0 and: [idx <= rcv instSize]]])
	ifTrue:  [self pop3thenPush: (rcv instVarAt: idx - 1 put: obj)]
	ifFalse: [successFlag := false]
]

Squeak primitiveHash
[
    | rcvr |
    (rcvr := self stackTop) isSmallInteger
	ifFalse: [self popThenPush: rcvr hashBits]
]

Squeak primitiveStoreStackp		[ ^self error: 'UNIMPLEMENTED primitiveStoreStackp' ]

Squeak primitiveSomeInstance
[
    | instance |
    (instance := SqueakObject initialInstanceOf: self stackTop) notNil
	ifTrue:  [self pop: 1 + argumentCount thenPush: instance]
	ifFalse: [successFlag := false]
]

Squeak primitiveNextInstance
[
    | instance |
    (instance := SqueakObject instanceAfter: self stackTop) notNil
	ifTrue:  [self pop: 1 + argumentCount thenPush: instance]
	ifFalse: [successFlag := false]
]

Squeak primitiveNewMethod
[
    | bytecodeSize methodHeader literalCount theMethod |
    bytecodeSize := self stackValue: 1.
    methodHeader := self stackTop.
    (bytecodeSize isSmallInteger and: [methodHeader isSmallInteger])
	ifTrue:
	   [literalCount := methodHeader >> 9 bitAnd: 0xff.
	    theMethod := SqueakMethod newMethod:     (self stackValue: 2)
				      hash:	     self newObjectHash
				      indexableSize: (1 + literalCount) * Array elementSize + bytecodeSize.
	    theMethod initLiterals: 1 + literalCount.
	    theMethod literals atAllPut: nilObj.
	    theMethod storeLiteral: 0 with: methodHeader.
	    self pop3thenPush: theMethod]
	ifFalse:
	   [successFlag := false]
]

	"Control Primitives (80-89)"

Squeak primitiveBlockCopy
[
    | rcv arg homeCtxt blockSize newBlock initialPC |
    rcv := self stackValue: 1.
    arg := self stackTop.
    (rcv isSmallInteger not and: [arg isSmallInteger])
	ifTrue:
	   [homeCtxt := rcv.
	    (homeCtxt instVarAt: MethodContext_method) isSmallInteger
		ifTrue: [homeCtxt := homeCtxt instVarAt: BlockContext_home].
	    blockSize := homeCtxt size - 6.
	    newBlock  := SqueakObject newPointers:   (self splObj: ClassBlockContext)
				      hash:	     self newObjectHash
				      fixedSize:     6
				      indexableSize: blockSize.
	    initialPC :=  instructionPointer + 2.
	    newBlock
		instVarAt: Context_sender		put: nilObj;
		instVarAt: Context_instructionPointer	put: initialPC;
		instVarAt: Context_stackPointer		put: 0;
		instVarAt: BlockContext_argumentCount	put: arg;
		instVarAt: BlockContext_initialPC	put: initialPC;
		instVarAt: BlockContext_home		put: homeCtxt.
	    ^self pop2thenPush: newBlock].
    successFlag := false
]

Squeak primitiveValue
[
    | argCount block |
    argCount := argumentCount.
    block := self stackValue: argCount.
    (block class == (self splObj: ClassBlockContext)
		and: [(block instVarAt: BlockContext_argumentCount) == argCount
		and: [(block instVarAt: Context_sender) == nilObj]])
	ifFalse: [^successFlag := false].
    self transfer: argCount
	 from:     activeContext pointer: Context_tempFrameStart + stackPointer - argCount
	 to:       block         pointer: Context_tempFrameStart.
    block
	instVarAt: Context_sender		put: activeContext;
	instVarAt: Context_instructionPointer	put: (block instVarAt: BlockContext_initialPC);
	instVarAt: Context_stackPointer		put: argCount.
    self drop: 1 + argCount.
    self newActiveContext: block
]

Squeak primitiveValueWithArgs		[ ^self error: 'UNIMPLEMENTED primitiveValueWithArgs' ]

Squeak primitivePerform
[
    | argCount performSelector performMethod newReceiver selectorIndex |
    argCount	    := argumentCount.
    performSelector := messageSelector.
    performMethod   := newMethod.
    newReceiver	    := self stackValue: argCount.
    messageSelector := self stackValue: argCount - 1.
    argumentCount   := argCount := argCount - 1.
    selectorIndex   := stackPointer - argumentCount.
    self transfer: argCount
	 from:	   activeContext pointer: Context_stackFrameStart + selectorIndex + 1
	 to:	   activeContext pointer: Context_stackFrameStart + selectorIndex.
    self drop: 1.
    self findNewMethodInClass: newReceiver class.
    (newMethod numArgs == argCount)
	ifTrue:
	   [self executeNewMethod.
	    ^successFlag := true].
    self refsnart: argCount
	 from:	   activeContext pointer: Context_stackFrameStart + selectorIndex
	 to:	   activeContext pointer: Context_stackFrameStart + selectorIndex + 1.
    self drop: -1.
    activeContext storePointer: Context_stackFrameStart + selectorIndex with: messageSelector.
    argumentCount := argumentCount + 1.
    newMethod := performMethod.
    messageSelector := performSelector.
    successFlag := false.
]

Squeak primitivePerformWithArgs		[ ^self error: 'UNIMPLEMENTED primitivePerformWithArgs' ]

Squeak primitiveSignal
[
    | sema |
    sema := self stackTop.
    sema class == (self splObj: ClassSemaphore)	ifFalse: [^successFlag := false].
    self synchronousSignal: sema.
]

Squeak primitiveWait
[
    | sema excessSignals activeProc |
    sema := self stackTop.
    sema class == (self splObj: ClassSemaphore) ifFalse: [^successFlag := false].
    excessSignals := sema instVarAt: Semaphore_excessSignals.
    excessSignals > 0
	ifTrue: [sema instVarAt: Semaphore_excessSignals put: excessSignals - 1]
	ifFalse:
	    [activeProc := self processScheduler instVarAt: ProcSched_activeProcess.
	     self addLastLink: activeProc toList: sema.
	     self transferTo: self wakeHighestPriority]
]

Squeak primitiveResume			[ self resume: self stackTop ]

Squeak primitiveSuspend
[
    (self stackTop == (self processScheduler instVarAt: ProcSched_activeProcess))
	ifTrue:  [self popThenPush: nilObj; transferTo: self wakeHighestPriority]
	ifFalse: [successFlag := false]
]

Squeak primitiveFlushCache		[ self flushMethodCache ]

	"Input/Output Primitives (90-109)"

Squeak primitiveMousePoint
[
    | p |
    p := io mousePoint.
    self popThenPush: (self makePointX: (p >> 16) Y: (p bitAnd: 0xffff)).
]

Squeak primitiveTestDisplayDepth
[
    | bpp ok |
    (bpp := self stackTop) isSmallInteger
	ifTrue:
	   [ok := io hasDisplayDepth: bpp.
	    successFlag ifTrue: [self pop2thenPush: (ok ifTrue: [trueObj] ifFalse: [falseObj])]]
	ifFalse:
	   [successFlag := false]
]

Squeak primitiveSetDisplayMode		[ ^self error: 'UNIMPLEMENTED primitiveSetDisplayMode' ]
Squeak primitiveInputSemaphore		[ ^self error: 'UNIMPLEMENTED primitiveInputSemaphore' ]
Squeak primitiveGetNextEvent		[ ^self error: 'UNIMPLEMENTED primitiveGetNextEvent' ]
Squeak primitiveInputWord		[ ^self error: 'UNIMPLEMENTED primitiveInputWord' ]

Squeak showDisplayBits: aForm left: l top: t right: r bottom: b
[
    aForm == (self splObj: TheDisplay)
	ifTrue:
	    [io showDisplayBits_: (aForm instVarAt: Form_bits  ) fields _words
		width_:		  (aForm instVarAt: Form_width ) _integerValue
		height_:	  (aForm instVarAt: Form_height) _integerValue
		depth_:		  (aForm instVarAt: Form_depth ) _integerValue
		left_:		  l _integerValue
		top_:		  t _integerValue
		right_:		  r _integerValue
		bottom_: 	  b _integerValue]
]

Squeak primitiveCopyBits
[
    bitBlt copyBits.
    (successFlag and: [bitBlt combinationRule == 22 or: [bitBlt combinationRule == 32]])
	ifTrue: [self pop2thenPush: bitBlt bitCount].
]

Squeak primitiveSnapshot		[ ^self error: 'UNIMPLEMENTED primitiveSnapshot' ]
Squeak primitiveStoreImageSegment	[ ^self error: 'UNIMPLEMENTED primitiveStoreImageSegment' ]
Squeak primitiveLoadImageSegment	[ ^self error: 'UNIMPLEMENTED primitiveLoadImageSegment' ]
Squeak primitivePerformInSuperclass	[ ^self error: 'UNIMPLEMENTED primitivePerformInSuperclass' ]

Squeak primitiveBeCursor
[
    | cursor mask bits extentX extentY depth offset offsetX offsetY cursorBits maskBits |
    cursor := self stackValue: argumentCount.
    mask   := self stackValue: 0.
    (cursor isFixed and: [cursor size >= 5]) ifFalse: [^successFlag := false].
    bits    := cursor fetchPointer: Form_bits.
    extentX := cursor fetchPointer: Form_width.
    extentY := cursor fetchPointer: Form_height.
    depth   := cursor fetchPointer: Form_depth.
    offset  := cursor fetchPointer: Form_offset.
    (bits isWords and: [bits size == 16]) ifFalse: [^successFlag := false].
    (depth isSmallInteger and: [extentX isSmallInteger and: [extentY isSmallInteger]]) ifFalse: [^successFlag := false].
    (offset isSmallInteger not and: [offset isFixed and: [offset instSize >= 2]]) ifFalse: [^successFlag := false].
    offsetX := offset fetchPointer: Point_x.
    offsetY := offset fetchPointer: Point_y.
    (offsetX isSmallInteger and: [offsetY isSmallInteger]) ifFalse: [^successFlag := false].
    (depth == 1 and: [extentX == 16 and: [extentY == 16
		and: [(offsetX between: -16 and: 0)
		and: [(offsetY between: -16 and: 0)]]]]) ifFalse: [^successFlag := false].
    cursorBits := bits fields.
    maskBits   := cursorBits.
    (mask ~~ cursor)
	ifTrue:
	   [(mask isFixed and: [mask size >= 5]) ifFalse: [^successFlag := false].
	    bits    := mask fetchPointer: Form_bits.
	    extentX := mask fetchPointer: Form_width.
	    extentY := mask fetchPointer: Form_height.
	    depth   := mask fetchPointer: Form_depth.
	    (bits isWords and: [bits size == 16]) ifFalse: [^successFlag := false].
	    (depth isSmallInteger and: [extentX isSmallInteger and: [extentY isSmallInteger]]) ifFalse: [^successFlag := false].
	    (depth == 1 and: [extentX == 16 and: [extentY == 16]]) ifFalse: [^successFlag := false].
	    maskBits := bits fields].
    io setCursor: cursorBits withMask: maskBits offsetX: offsetX offsetY: offsetY.
    self drop: argumentCount.
]

Squeak primitiveBeDisplay
[
    | rcvr |
    rcvr := self stackTop.
    (rcvr isFixed and: [rcvr instSize >= 4])
	ifTrue:  [specialObjectsArray storePointer: TheDisplay with: rcvr]
	ifFalse: [successFlag := false]
]

Squeak primitiveScanCharacters		[ self primitiveFail ]

Squeak primitiveStringReplace
[
    | dst dstPos dstEnd src srcPos fmt |
"    self assert: argumentCount == 4."
    dst    := self stackValue: 4.
    dstPos := self stackValue: 3.
    dstEnd := self stackValue: 2.
    src    := self stackValue: 1.
    srcPos := self stackTop.

"
self printObject: dst;
    put: ' copyReplaceFrom: '; printObject: dstPos;
    put: ' to: '; printObject: dstEnd;
    put: ' with: '; printObject: src;
    put: ' startingAt: '; printObject: srcPos;
    cr.
"

    "beware source/destination SmallIntegers during LargeInteger arithmetic"
    (dstEnd isSmallInteger
		and: [dst isSmallInteger not and: [dstPos isSmallInteger
		and: [src isSmallInteger not and: [srcPos isSmallInteger]]]])
	ifTrue:
	   [fmt := src format.
	    (fmt == dst format and: [dstPos > 0 and: [dstEnd <= dst size
			       and: [srcPos > 0 and: [srcPos + dstEnd - dstPos - 1 <= src size]]]])
		ifTrue:
		   [dst fields replaceFrom: dstPos to: dstEnd with: src fields startingAt: srcPos.
		    ^self drop: 4]].
    successFlag := false
]

Squeak primitiveScreenSize
[
    self popThenPush: (self makePointX: 640 Y: 480)
]

Squeak primitiveMouseButtons
[
    | state |
    state := io getButtonState.
"    state == 0 ifFalse: [tracing := true]."
    self popThenPush: state
]

Squeak primitiveKbdNext
[
    | keystroke |
    self popThenPush: ((keystroke := io getKeystroke: true) >= 0 ifTrue:  [keystroke] ifFalse: [nilObj])
]


Squeak primitiveKbdPeek
[
    | keystroke |
    self popThenPush: ((keystroke := io getKeystroke: false) >= 0 ifTrue:  [keystroke] ifFalse: [nilObj])
]

	"System Primitives (110-119)"

Squeak primitiveEquivalent
[
    | top |
    top := self pop.
    self popThenPush: (self stackTop == top ifTrue: [trueObj] ifFalse: [falseObj]).
]

Squeak primitiveClass			[ ^self error: 'UNIMPLEMENTED primitiveClass' ]
Squeak primitiveBytesLeft		[ ^self error: 'UNIMPLEMENTED primitiveBytesLeft' ]

Squeak primitiveQuit
[
    'goodbye' putln.
    Smalltalk quit.
]

Squeak primitiveExitToDebugger		[ ^self error: 'UNIMPLEMENTED primitiveExitToDebugger' ]
Squeak primitiveChangeClass		[ ^self error: 'UNIMPLEMENTED primitiveChangeClass' ]

Squeak primitiveFlushCacheByMethod	[ self flushMethodCache ]

Squeak primitiveExternalCall		[ ^self error: 'UNIMPLEMENTED primitiveExternalCall' ]
Squeak primitiveDoPrimitiveWithArgs	[ ^self error: 'UNIMPLEMENTED primitiveDoPrimitiveWithArgs' ]

Squeak primitiveFlushCacheSelective	[ self flushMethodCache ]

	"Miscellaneous Primitives (120-127)"

Squeak primitiveCalloutToFFI		[ ^self error: 'UNIMPLEMENTED primitiveCalloutToFFI' ]

Squeak primitiveImageName		[ self popThenPush: (self makeString: viPath) ]

Squeak primitiveNoop			[ ]
Squeak primitiveValueUninterruptably	[ ^self error: 'UNIMPLEMENTED primitiveValueUninterruptably' ]

Squeak primitiveLowSpaceSemaphore	[ self drop ]
Squeak primitiveSignalAtBytesLeft	[ self drop ]

	"Squeak Miscellaneous Primitives (128-149)"

Squeak primitiveDeferDisplayUpdates	[ ^self error: 'UNIMPLEMENTED primitiveDeferDisplayUpdates' ]
Squeak primitiveShowDisplayRect		[ ^self error: 'UNIMPLEMENTED primitiveShowDisplayRect' ]

Squeak primitiveArrayBecome
[
    | rcv  arg |
    rcv := self stackValue: 1.
    arg := self stackTop.
    (rcv isSmallInteger not and: [arg isSmallInteger not
			    and: [SqueakObject bulkBecome: rcv with: arg twoWay: true]])
	ifTrue:  [self drop]
	ifFalse: [successFlag := false]
]

Squeak primitiveSpecialObjectsOop	[ self popThenPush: specialObjectsArray ]

Squeak primitiveFullGC			[ self popThenPush: SqueakObject fullGC ]
Squeak primitiveIncrementalGC		[ self popThenPush: SqueakObject incrementalGC ]

Squeak primitiveObjectPointsTo
[
    | rcvr thang |
    rcvr := self stackValue: 1.
    thang := self stackTop.
    self pop2thenPush: ((rcvr pointsTo: thang) ifTrue: [trueObj] ifFalse: [falseObj]).
]

Squeak primitiveSetInterruptKey		[ ^self error: 'UNIMPLEMENTED primitiveSetInterruptKey' ]

Squeak primitiveInterruptSemaphore
[
    | arg |
    arg := self pop.
    specialObjectsArray
	storePointer: TheInterruptSemaphore
	with: (arg class == (self splObj: ClassSemaphore) ifTrue: [arg] ifFalse: [nilObj])
]

Squeak primitiveMillisecondClock	[ self popThenPush: (io mSecs bitAnd: MillisecondClockMask) ]

Squeak primitiveSignalAtMilliseconds
[
    | sema tick |
    sema := self stackValue: 1.
    tick := self stackTop.
    (tick isSmallInteger and: [sema isSmallInteger not])
	ifTrue:
	   [sema class == (self splObj: ClassSemaphore)
		ifTrue:
		   [specialObjectsArray storePointer: TheTimerSemaphore with: sema.
		    nextWakeupTick := tick]
		ifFalse:
		   [specialObjectsArray storePointer: TheTimerSemaphore with: nilObj.
		    nextWakeupTick := 0].
	    ^self drop: 2].
    successFlag := false.
]

Squeak primitiveSecondsClock		[ ^self error: 'UNIMPLEMENTED primitiveSecondsClock' ]
Squeak primitiveSomeObject		[ ^self error: 'UNIMPLEMENTED primitiveSomeObject' ]
Squeak primitiveNextObject		[ ^self error: 'UNIMPLEMENTED primitiveNextObject' ]
Squeak primitiveBeep			[ ^self error: 'UNIMPLEMENTED primitiveBeep' ]
Squeak primitiveClipboardText		[ ^self error: 'UNIMPLEMENTED primitiveClipboardText' ]

Squeak primitiveVMPath			[ self popThenPush: (self makeString: vmPath) ]

Squeak primitiveShortAt			[ ^self error: 'UNIMPLEMENTED primitiveShortAt' ]
Squeak primitiveShortAtPut		[ ^self error: 'UNIMPLEMENTED primitiveShortAtPut' ]
Squeak primitiveConstantFill		[ ^self error: 'UNIMPLEMENTED primitiveConstantFill' ]

Squeak primitiveClone
[
    self popThenPush: (self stackTop cloneWithHash: self newObjectHash)
]

Squeak primitiveGetAttribute		[ ^self error: 'UNIMPLEMENTED primitiveGetAttribute' ]

	"File Primitives (150-169) - NO LONGER INDEXED"

FileRecord_sessionID	:= [ 0 ]
FileRecord_file		:= [ 1 ]

Squeak newFileRecord: aFile
[
    | record |
    record := SqueakObject newPointers: (self splObj: ClassArray) hash: self newObjectHash fixedSize: 0 indexableSize: 2.
    record storePointer: FileRecord_sessionID with: thisSessionID.
    record storePointer: FileRecord_file with: aFile.
    ^record
]

Squeak getFileRecord: record
[
    ^(record isSmallInteger not
	    and: [record isPointers
	    and: [record size == 2
	    and: [(record fetchPointer: FileRecord_sessionID) == thisSessionID]]])
	ifTrue: [record fetchPointer: FileRecord_file]
]

Squeak primitiveFileClose
[
    | record file |
    record := self stackTop.
    (file := self getFileRecord: record) isNil ifTrue: [^successFlag := false].
    file close.
    record storePointer: 0 with: nilObj.
    self drop.
]

Squeak primitiveFileGetPosition
[
    | file |
    (file := self getFileRecord: self stackTop) isNil ifTrue: [^successFlag := false].
    self pop2thenPush: file tell.
]

Squeak primitiveFileOpen
[
    | writeFlag string path file |
    writeFlag := self stackTop.
    (writeFlag == trueObj or: [writeFlag == falseObj]) ifFalse: [^successFlag := false].
    string := self stackValue: 1.
    path := String size: string size value_: string fields _bytes.
    'PRIMITIVE FILE OPEN <', path, '>'.
    file := writeFlag
	ifTrue:  [File openForWriting: path]
	ifFalse: [File openForReading: path].
    (file isNil and: [writeFlag])
	ifTrue: [file := File createForWriting: path].
    file isNil
	ifTrue: [^successFlag := false].
    self pop3thenPush: (self newFileRecord: file)
]

Squeak primitiveFileSetPosition
[
    | record file newPosition |
    record := self stackValue: 1.
    (file := self getFileRecord: record) isNil ifTrue: [^successFlag := false].
    (newPosition := self stackTop) isSmallInteger ifFalse: [^successFlag := false].
    file seek: newPosition.
    self drop: 2.
]

Squeak primitiveFileSize
[
    | record file size |
    record := self stackTop.
    (file := self getFileRecord: record) isNil ifTrue: [^successFlag := false].
    (size := file size) notNil
	ifTrue:  [self pop2thenPush: size]
	ifFalse: [successFlag := false]
]

Squeak primitiveFileWrite
[
    | record file count startIndex array bytesWritten |
    record := self stackValue: 3.
    (file := self getFileRecord: record) isNil ifTrue: [^successFlag := false].
    array := self stackValue: 2.
    (array isBytes or: [array isWords]) ifFalse: [^successFlag := false].
    array := array fields.
    startIndex := self stackValue: 1.
    startIndex isSmallInteger ifFalse: [^successFlag := false].
    count := self stackTop.
    count isSmallInteger ifFalse: [^successFlag := false].
    "buffer can be any indexable words or bytes object except CompiledMethod"
    (startIndex > 0 and: [startIndex + count - 1 <= array size]) ifFalse: [^successFlag := false].
    startIndex == 1 ifFalse: [array := array copyFrom: startIndex to: startIndex + count - 1].
    bytesWritten := array isByteArray
	ifTrue:  [file write: array size: count]
	ifFalse: [file writeWords: array size: count].
    count * array elementSize == bytesWritten ifFalse: [^successFlag := false].
    self pop: 5 thenPush: bytesWritten.
]

Squeak primitivePathNameDelimiter
[
    self popThenPush: ((self splObj: SqueakCharacterTable) fetchPointer: $/ asciiValue)
]

Squeak primitiveIntegerAt		[ ^self error: 'UNIMPLEMENTED primitiveIntegerAt' ]
Squeak primitiveIntegerAtPut		[ ^self error: 'UNIMPLEMENTED primitiveIntegerAtPut' ]
	"Sound Primitives (170-199) - NO LONGER INDEXED"
	"Closure primitives"
Squeak primitiveClosureValue		[ ^self error: 'UNIMPLEMENTED primitiveClosureValue' ]
Squeak primitiveClosureValueWithArgs	[ ^self error: 'UNIMPLEMENTED primitiveClosureValueWithArgs' ]
Squeak primitiveExecuteMethod		[ ^self error: 'UNIMPLEMENTED primitiveExecuteMethod' ]
	"Sound Primitives (continued) - NO LONGER INDEXED"
	"Unwind primitives"
Squeak primitiveFindNextUnwindContext	[ ^self error: 'UNIMPLEMENTED primitiveFindNextUnwindContext' ]
Squeak primitiveTerminateTo		[ ^self error: 'UNIMPLEMENTED primitiveTerminateTo' ]
Squeak primitiveFindHandlerContext	[ ^self error: 'UNIMPLEMENTED primitiveFindHandlerContext' ]
Squeak primitiveMarkUnwindMethod	[ ^self error: 'UNIMPLEMENTED primitiveMarkUnwindMethod' ]
Squeak primitiveMarkHandlerMethod	[ ^self error: 'UNIMPLEMENTED primitiveMarkHandlerMethod' ]

	"Networking Primitives (200-229) - NO LONGER INDEXED"

	"Other Primitives (230-249)"

Squeak primitiveRelinquishProcessor
[
    | microSecs |
    microSecs := self stackTop.
    (microSecs isSmallInteger)
	ifTrue:
	   [self drop.
	    io relinquishProcessor: microSecs]
	ifFalse:
	   [successFlag := false]
]

Squeak primitiveForceDisplayUpdate	[ io forceDisplayUpdate ]

Squeak primitiveFormPrint		[ ^self error: 'UNIMPLEMENTED primitiveFormPrint' ]
Squeak primitiveSetFullScreen		[ ^self error: 'UNIMPLEMENTED primitiveSetFullScreen' ]

Squeak primitiveBitmapDecompress	[ successFlag := false ]

Squeak primitiveSnapshotEmbedded	[ ^self error: 'UNIMPLEMENTED primitiveSnapshotEmbedded' ]
Squeak primitiveInvokeObjectAsMethod	[ ^self error: 'UNIMPLEMENTED primitiveInvokeObjectAsMethod' ]
	"VM Implementor Primitives (250-255)"
Squeak clearProfile			[ ^self error: 'UNIMPLEMENTED clearProfile' ]
Squeak dumpProfile			[ ^self error: 'UNIMPLEMENTED dumpProfile' ]
Squeak startProfiling			[ ^self error: 'UNIMPLEMENTED startProfiling' ]
Squeak stopProfiling			[ ^self error: 'UNIMPLEMENTED stopProfiling' ]
Squeak primitiveVMParameter		[ ^self error: 'UNIMPLEMENTED primitiveVMParameter' ]
Squeak primitiveInstVarsPutFromStack	[ ^self error: 'UNIMPLEMENTED primitiveInstVarsPutFromStack' ]

	"Quick Push Const Methods"

Squeak primitivePushSelf		["self popThenPush: receiver"]
Squeak primitivePushTrue		[ self popThenPush: trueObj  ]
Squeak primitivePushFalse		[ self popThenPush: falseObj ]
Squeak primitivePushNil			[ self popThenPush: nilObj   ]
Squeak primitivePushMinusOne		[ self popThenPush: -1 ]
Squeak primitivePushZero		[ self popThenPush:  0 ]
Squeak primitivePushOne			[ self popThenPush:  1 ]
Squeak primitivePushTwo			[ self popThenPush:  2 ]

Squeak primitiveLoadInstVar		[ self popThenPush: (self stackTop instVarAt: primitiveIndex - 264) ]

	"External primitive support primitives"

Squeak primitiveFlushExternalPrimitives	[ ^self error: 'UNIMPLEMENTED primitiveFlushExternalPrimitives' ]
Squeak primitiveUnloadModule		[ ^self error: 'UNIMPLEMENTED primitiveUnloadModule' ]
Squeak primitiveListBuiltinModule	[ ^self error: 'UNIMPLEMENTED primitiveListBuiltinModule' ]
Squeak primitiveListExternalModule	[ ^self error: 'UNIMPLEMENTED primitiveListExternalModule' ]

Squeak primitiveObsoleteIndexedPrimitive
[
    self primitiveMissing
]

Squeak primitiveMissing
[
    ^self error: 'MISSING primitive ', primitiveIndex printString
]
