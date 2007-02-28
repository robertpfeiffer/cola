{ import: Squeak }

Squeak interpret	[ self fastInterpret ]

Squeak slowInterpret
[
    [true]
	whileTrue:
	   [currentBytecode := method fields at: instructionPointer.
	    instructionPointer := instructionPointer + 1.
	    self _perform: (bytecodeTable at: 1 + currentBytecode)]
]

Squeak fastInterpret
[
    | imps _imps cb |
    imps := bytecodeTable collect: [:sel | self _vtable methodAt: sel].
    _imps := imps _elements.
    [true]
	whileTrue:
	   [cb := currentBytecode := method fields at: instructionPointer.
	    instructionPointer := instructionPointer + 1.
	    { (((_imp_t *)v__imps)[(long)v_cb >> 1])(0, v_stateful_self, v_self); }]
]

_vtable methodAt: aSelector
[
    | assoc |
    ^(assoc := self findKeyOrNil: aSelector) isNil ifFalse: [assoc value _method]
]

_object   isNil		[ ^false ]
_assoc    value		[ ^value ]
_closure _method	[ ^_method ]

Squeak fetchByte
[
    | byte |
    byte := method fetchByte: instructionPointer - 1.
    instructionPointer := instructionPointer + 1.
    ^byte
]

Squeak stackTop
[
    ^activeContext fetchPointer: Context_stackFrameStart + stackPointer
]

Squeak stackValue: offset
[
    ^activeContext fetchPointer: Context_stackFrameStart + stackPointer - offset
]

Squeak push: value
[
"    self assert: (value isSmallInteger or: [value isSqueakObject]).
    value isNil ifTrue: [self error: 'push NIL' ]."
    ^activeContext storePointer: Context_stackFrameStart + (stackPointer := stackPointer + 1) with: value
]

Squeak popThenPush: value
[
"    self assert: (value isSmallInteger or: [value isSqueakObject]).
    value isNil ifTrue: [self error: 'push NIL' ]."
    ^activeContext storePointer: Context_stackFrameStart + stackPointer with: value
]

Squeak pop: n thenPush: value
[
"    self assert: (value isSmallInteger or: [value isSqueakObject]).
    value isNil ifTrue: [self error: 'push NIL' ]."
    ^activeContext storePointer: Context_stackFrameStart + (stackPointer := stackPointer - n + 1) with: value
]

Squeak pop2thenPush: value
[
"    self assert: (value isSmallInteger or: [value isSqueakObject]).
    value isNil ifTrue: [self error: 'push NIL' ]."
    ^activeContext storePointer: Context_stackFrameStart + (stackPointer := stackPointer - 1) with: value
]

Squeak pop3thenPush: value
[
"    self assert: (value isSmallInteger or: [value isSqueakObject]).
    value isNil ifTrue: [self error: 'push NIL' ]."
    ^activeContext storePointer: Context_stackFrameStart + (stackPointer := stackPointer - 2) with: value
]

Squeak drop
[
    stackPointer := stackPointer - 1
]

Squeak drop: n
[
    stackPointer := stackPointer - n
]

Squeak pop
[
    ^activeContext fetchPointer: Context_tempFrameStart + (stackPointer := stackPointer - 1)
]

Squeak fetchReceiver: offset
[
    ^receiver instVarAt: offset
]

Squeak storeReceiver: offset with: value
[
    receiver instVarAt: offset put: value
]

Squeak fetchTemporary: offset
[
    ^homeContext fetchPointer: Context_tempFrameStart + offset
]

Squeak storeTemporary: offset with: value
[
    homeContext storePointer: Context_tempFrameStart + offset with: value
]

Squeak fetchLiteral: offset
[
    ^method fetchLiteral: 1 + offset
]

Squeak fetchLiteralVariable: offset
[
    ^(method fetchLiteral: 1 + offset) instVarAt: Association_value
]

Squeak illegalStore: offset with: value
[
    self error: 'UNIMPLEMENTED illegalStore:'
]

Squeak storeLiteralVariable: offset with: value
[
    ^(method fetchLiteral: 1 + offset) instVarAt: Association_value put: value
]

Squeak jump: offset
[
    instructionPointer := instructionPointer + offset
]

Squeak jumpFalse: offset
[
    | boolean |
    boolean := self stackTop.
    boolean == falseObj ifTrue: [^self drop; jump: offset].
    boolean == trueObj  ifTrue: [^self drop].
    messageSelector := self splObj: SelectorMustBeBoolean.
    argumentCount := 0.
    self normalSend
]

Squeak jumpTrue: offset
[
    | boolean |
    boolean := self stackTop.
    boolean == trueObj  ifTrue: [^self drop; jump: offset].
    boolean == falseObj ifTrue: [^self drop].
    messageSelector := self splObj: SelectorMustBeBoolean.
    argumentCount := 0.
    self normalSend
]


Squeak specialSelector: n	[ ^(self splObj: SpecialSelectors) fetchPointer: 2 * n     ]
Squeak specialArgumentCount: n	[ ^(self splObj: SpecialSelectors) fetchPointer: 2 * n + 1 ]

Squeak specialSend: selectorOffset numArgs: nArgs
[
    messageSelector := (self splObj: SpecialSelectors) fetchPointer: 2 * selectorOffset.
    argumentCount := nArgs.
"    self assert: nArgs == (self specialArgumentCount: selectorOffset)."
    self normalSend.
]

Squeak superSend: selectorOffset numArgs: nArgs
[
    messageSelector := (self fetchLiteral: selectorOffset).
    argumentCount := nArgs.
    self superclassSend.
]

Squeak normalSend
[
    receiverClass := lkupClass := (self stackValue: argumentCount) class.
    self findNewMethod; executeNewMethod.
]

Squeak superclassSend
[
    lkupClass := method methodClass instVarAt: Class_superclass.
    receiverClass := (self stackValue: argumentCount) class.
    self findNewMethod; executeNewMethod
]

Squeak findNewMethod
[
    (self lookupMethodInCacheSel: messageSelector class: lkupClass)
	ifFalse: [self
		      lookupMethodInClass: lkupClass;
		      addNewMethodToCacheSel: messageSelector class: lkupClass]
]

Squeak findNewMethodInClass: aClass
[
    (self lookupMethodInCacheSel: messageSelector class: aClass)
	ifFalse:
	   [self lookupMethodInClass: aClass.
	    lkupClass := aClass.
	    self addNewMethodToCacheSel: messageSelector class: aClass]
]

Squeak hashSelector: selector withClass: class
{
    return (oop)((((unsigned long)v_selector << 3) ^ ((unsigned long)v_class) >> 2) | 1);
}

Squeak lookupMethodInCacheSel: selector class: class
[
    | hash probe |
"
    cacheHits := cacheHits + 1.
"
    hash := self hashSelector: selector withClass: class.
    probe := 1 + (hash bitAnd: MethodCacheMask).
    (selector == (methodCacheSelector at: probe) and: [class == (methodCacheClass at: probe)])
	ifTrue:
	   [newMethod := methodCacheMethod at: probe.
	    primitiveIndex := methodCachePrimitive at: probe.
	    ^true].
    probe := 1 + ((hash >> 1) bitAnd: MethodCacheMask).
    (selector == (methodCacheSelector at: probe) and: [class == (methodCacheClass at: probe)])
	ifTrue:
	   [newMethod := methodCacheMethod at: probe.
	    primitiveIndex := methodCachePrimitive at: probe.
	    ^true].
    probe := 1 + ((hash >> 2) bitAnd: MethodCacheMask).
    (selector == (methodCacheSelector at: probe) and: [class == (methodCacheClass at: probe)])
	ifTrue:
	   [newMethod := methodCacheMethod at: probe.
	    primitiveIndex := methodCachePrimitive at: probe.
	    ^true].
"
    cacheHits := cacheHits - 1.
    cacheMisses := cacheMisses + 1.
"
    ^false
]

Squeak addNewMethodToCacheSel: selector class: class
[
    | hash probe |
    hash := self hashSelector: selector withClass: class.
    0 to: 2 do: [:p |
	probe := 1 + ((hash >> p) bitAnd: MethodCacheMask).
	(methodCacheSelector at: probe) isNil
	    ifTrue:
	       [methodCacheSelector  at: probe put: selector.
		methodCacheClass     at: probe put: class.
		methodCacheMethod    at: probe put: newMethod.
		methodCachePrimitive at: probe put: primitiveIndex.
		^self]].
    probe := 1 + (hash bitAnd: MethodCacheMask).
    methodCacheSelector  at: probe put: selector.
    methodCacheClass     at: probe put: class.
    methodCacheMethod    at: probe put: newMethod.
    methodCachePrimitive at: probe put: primitiveIndex.
    methodCacheSelector  at: 1 + ((hash >> 1) bitAnd: MethodCacheMask) put: nil.
    methodCacheSelector  at: 1 + ((hash >> 2) bitAnd: MethodCacheMask) put: nil.
]

Squeak flushMethodCache
[
    methodCacheSelector atAllPut: nil.
    methodCacheClass    atAllPut: nil.
    methodCacheMethod   atAllPut: nil.
]

Squeak lookupMethodInClass: class
[
    | currentClass dictionary |
    currentClass := class.
    [currentClass ~~ nilObj]
	whileTrue:
	   [(dictionary := currentClass instVarAt: Class_mdict) == nilObj
		ifTrue:
		   [self createActualMessageTo: class.
		    messageSelector := self splObj: SelectorCannotInterpret.
		    ^self lookupMethodInClass: (currentClass instVarAt: Class_superclass)].
	    (self lookupMethodInDictionary: dictionary)
		ifTrue: [^methodClass := currentClass].
	    currentClass := currentClass instVarAt: Class_superclass].
    (messageSelector == (self splObj: SelectorDoesNotUnderstand))
	ifTrue: [self error: 'Recursive not understood error encountered'].
    self createActualMessageTo: class.
    messageSelector := self splObj: SelectorDoesNotUnderstand.
    self lookupMethodInClass: class.
]

Squeak lookupMethodInDictionary: dictionary
[
    | length index wrap nextSelector methodArray |
    length := dictionary size.
    index  := MethodDictionary_selectorStart + (messageSelector hashBits bitAnd: (length - MethodDictionary_selectorStart - 1)).
    wrap   := false.
    [
	(nextSelector := dictionary fetchPointer: index) == nilObj ifTrue: [^false].
	nextSelector == messageSelector
	    ifTrue:
	       [methodArray := dictionary instVarAt: MethodDictionary_array.
		newMethod := methodArray fetchPointer: index - MethodDictionary_selectorStart.
		newMethod isSqueakMethod
		    ifTrue:
		       [primitiveIndex := newMethod primitiveIndex.
			primitiveIndex > MaxPrimitiveIndex ifTrue: [primitiveIndex := 0]]
		    ifFalse:
		       [primitiveIndex := 248].
		^true].
	index := index + 1.
	(index == length)
	    ifTrue:
	       [wrap ifTrue: [^false].
		wrap := true.
		index := MethodDictionary_selectorStart]
    ] repeat.
]

Squeak createActualMessageTo: lookupClass
[
    | argumentArray message |
    argumentArray := SqueakObject newPointers: (self splObj: ClassArray) hash: self newObjectHash fixedSize: 0 indexableSize: argumentCount.
    message := SqueakObject newPointers: (self splObj: ClassMessage) hash: self newObjectHash fixedSize: 3 indexableSize: 0.
    argumentCount - 1 downTo: 0 do: [:i | argumentArray storePointer: i with: self pop].
    self push: message.
    argumentCount := 1.
    message storePointer: Message_selector    with: messageSelector.
    message storePointer: Message_arguments   with: argumentArray.
    message storePointer: Message_lookupClass with: lookupClass.
]

Squeak executeNewMethod
[
    (primitiveIndex > 0 and: [self primitiveResponse])
	ifFalse:
	   [self activateNewMethod; quickCheckForInterrupts]
]

Squeak activateNewMethod
[
    | theMethod newContext tempCount nilOop |
    tempCount :=  (theMethod := newMethod) numTemps.
    (newContext := self allocateContext: theMethod needsLargeContext)
	instVarAt: Context_sender		put: activeContext;
	instVarAt: Context_instructionPointer	put: theMethod initialPC;
	instVarAt: Context_stackPointer		put: tempCount;
	instVarAt: MethodContext_method		put: theMethod.
    self transfer: 1 + argumentCount
	 from: activeContext pointer: Context_stackFrameStart + stackPointer - argumentCount
	 to:   newContext    pointer: MethodContext_receiver.
    nilOop := nilObj.
    1 + argumentCount to: tempCount do: [:i | newContext storePointer: MethodContext_receiver + i with: nilOop].
    self drop: 1 + argumentCount.
    self newActiveContext: newContext
]

Squeak newObjectHash
[
    ^lastHash := 13849 + (16381 * lastHash) bitAnd: 65535
]

Squeak allocateContext: largeFlag
[
    | context |
    context := SqueakObject
	newPointers:   (self splObj: ClassMethodContext)
	hash:          self newObjectHash
	fixedSize:     6
	indexableSize: (largeFlag ifTrue: [Context_largeFrameSize] ifFalse: [Context_smallFrameSize]).
    context instVarAt: MethodContext_receiverMap put: nilObj.	"the rest are initialised in activateNewMethod"
    ^context
]

Squeak transfer: count from: source pointer: sourceOffset to: dest pointer: destOffset
[
    [(count := count - 1) >= 0]
	whileTrue:
	   [dest storePointer: destOffset with: (source fetchPointer: sourceOffset).
	    sourceOffset := sourceOffset + 1.
	    destOffset := destOffset + 1]
]

Squeak refsnart: count from: source pointer: sourceOffset to: dest pointer: destOffset
[
    [(count := count - 1) >= 0]
	whileTrue:
	   [dest storePointer: destOffset + count with: (source fetchPointer: sourceOffset + count)]
]

Squeak newActiveContext: aContext
[
    self
	storeContextRegisters: activeContext;
	fetchContextRegisters: (activeContext := aContext)
]

Squeak return: returnValue to: returnContext
[
    | nilOop thisCntx contextOfCaller |
    nilOop := nilObj.
    thisCntx := activeContext.
    (returnContext == nilOop or: [(returnContext instVarAt: Context_instructionPointer) == nilOop])
	ifTrue: [^self cannotReturn: returnValue].
    thisCntx := activeContext instVarAt: Context_sender.
    [thisCntx ~~ returnContext]
	whileTrue:
	   [thisCntx == nilOop ifTrue: [^self cannotReturn: returnValue].
	    (self isUnwindMarked: thisCntx) ifTrue: [^self aboutToReturnThrough: thisCntx].
	    thisCntx := thisCntx instVarAt: Context_sender].
    thisCntx := activeContext.
    [thisCntx ~~ returnContext]
	whileTrue:
	   [contextOfCaller := thisCntx instVarAt: Context_sender.
	    thisCntx instVarAt: Context_sender put: nilOop.
	    thisCntx instVarAt: Context_instructionPointer put: nilOop.
	    thisCntx := contextOfCaller].
    self fetchContextRegisters: (activeContext := thisCntx).
    self push: returnValue.
]

Squeak isUnwindMarked: aContext
[
    ^aContext class == (self splObj: ClassMethodContext)
	and: [(aContext instVarAt: MethodContext_method) primitiveIndex == 198]
]

Squeak quickCheckForInterrupts
[
    (interruptCheckCounter := interruptCheckCounter - 1) <= 0
	ifTrue: [self checkForInterrupts]
]

Squeak checkForInterrupts
[
    | now sema |
    now := io mSecs bitAnd: MillisecondClockMask.
    (now < lastTick)
	ifTrue:
	   [nextPollTick := now + (nextPollTick - lastTick).
	    nextWakeupTick ~= 0 ifTrue: [nextWakeupTick := now + (nextWakeupTick - lastTick)]].
    interruptCheckCounterFeedbackReset := ((now - lastTick) < interruptChecksEveryNms)
	ifTrue:  [interruptCheckCounterFeedbackReset + 10]
	ifFalse: [interruptCheckCounterFeedbackReset <= 1000
		      ifTrue:  [1000]
		      ifFalse: [interruptCheckCounterFeedbackReset - 12]].
  interruptCheckCounter := interruptCheckCounterFeedbackReset.
  lastTick := now.
  (now >= nextPollTick)
      ifTrue:
	 [io processEvents.
	  nextPollTick := now + 500].
  interruptPending
      ifTrue:
	 [interruptPending := false.
	  sema := self splObj: TheInterruptSemaphore.
	  (sema ~~ nilObj) ifTrue: [self synchronousSignal: sema]].
  (nextWakeupTick > 0 and: [now >= nextWakeupTick])
      ifTrue:
	 [nextWakeupTick := 0.
	  sema := self splObj: TheTimerSemaphore.
	  (sema ~~ nilObj) ifTrue: [self synchronousSignal: sema]].
"
  if (pendingFinalizationSignals > 0)
    {
      oop sema= splObj(TheFinalizationSemaphore);
      if (fetchClassOf(sema) == splObj(ClassSemaphore))
	synchronousSignal(sema);
      pendingFinalizationSignals= 0;
    }
  if (semaphoresToSignalCountA || semaphoresToSignalCountB)
    signalExternalSemaphores();
"
    interruptCheckCounter := 1000.
]

Squeak synchronousSignal: aSemaphore
[
    | excessSignals |
    (self isEmptyList: aSemaphore)
	ifTrue:
	   [excessSignals := aSemaphore instVarAt: Semaphore_excessSignals.
	    aSemaphore instVarAt: Semaphore_excessSignals put: excessSignals + 1]
	ifFalse:
	   [self resume: (self removeFirstLinkOfList: aSemaphore)]
]

Squeak resume: aProcess
[
    | activeProc activePriority newPriority |
    activeProc := self processScheduler instVarAt: ProcSched_activeProcess.
    activePriority := activeProc instVarAt: Process_priority.
    newPriority := aProcess instVarAt: Process_priority.
    (newPriority > activePriority)
	ifTrue:  [self putToSleep: activeProc; transferTo: aProcess]
	ifFalse: [self putToSleep: aProcess]
]

Squeak putToSleep: aProcess
[
    | priority processLists processList |
    priority := aProcess instVarAt: Process_priority.
    processLists := self processScheduler instVarAt: ProcSched_processLists.
    processList := processLists fetchPointer: priority - 1.
    self addLastLink: aProcess toList: processList.
]

Squeak transferTo: newProc
[
    | sched oldProc |
    sched := self processScheduler.
    oldProc := sched instVarAt: ProcSched_activeProcess.
    sched instVarAt: ProcSched_activeProcess put: newProc.
    oldProc instVarAt: Process_suspendedContext put: activeContext.
    self newActiveContext: (newProc instVarAt: Process_suspendedContext).
    newProc instVarAt: Process_suspendedContext put: nilObj.
]

Squeak wakeHighestPriority
[
    | schedLists index processList |
    schedLists := self processScheduler instVarAt: ProcSched_processLists.
    index := schedLists size.
    [(index := index - 1) >= 0]
	whileTrue:
	   [processList := schedLists fetchPointer: index.
	    (self isEmptyList: processList)
		ifFalse: [^self removeFirstLinkOfList: processList]].
    self error: 'scheduler could not find a runnable process'
]

Squeak isEmptyList: list
[
    ^(list instVarAt: LinkedList_firstLink) == nilObj
]

Squeak addLastLink: link toList: list
[
"    self assert: list instSize >= 2.
    self assert: link instSize >= 4."
    (self isEmptyList: list)
	ifTrue:  [ list instVarAt: LinkedList_firstLink put: link]
	ifFalse: [(list instVarAt: LinkedList_lastLink) instVarAt: Link_nextLink put: link].
    list instVarAt: LinkedList_lastLink put: link.
    link instVarAt: Process_myList put: list.
]

Squeak removeFirstLinkOfList: aList
[
    | first last next |
    first := aList instVarAt: LinkedList_firstLink.
    last  := aList instVarAt: LinkedList_lastLink.
    first == last
	ifTrue:
	   [aList instVarAt: LinkedList_firstLink put: nilObj.
	    aList instVarAt: LinkedList_lastLink  put: nilObj]
	ifFalse:
	   [next := first instVarAt: Link_nextLink.
	    aList instVarAt: LinkedList_firstLink put: next].
    first instVarAt: Link_nextLink put: nilObj.
    ^first
]
