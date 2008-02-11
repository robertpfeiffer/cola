{ import: ParseStream }

"I am one node in a graph of Matches that together recognise sentences read from a ParseStream."

Match : Object ()

Match match: aCollection
[
    | stream result |
    stream := aCollection parseStream.
    stream result: nil.
    (result := self matchOn: stream) ifTrue: [result := stream accept].
    ^result
]

Match matchOn: aStream
[
    "Answer self if I match the next object on aStream, otherwise nil."
    ^self subtypeResponsibility: #matchOn:
]

Match do: unaryBlock
[
    unaryBlock value: self
]

Match inject: aValue into: binaryBlock
[
    self do: [:match | aValue := binaryBlock value: aValue value: match].
    ^aValue
]

"----------------------------------------------------------------"

"I am a wildcard, recognising any available input object."

MatchAny : Match ()

MatchAny matchOn: aStream	[ ^aStream next ]


"I recognise a literal object."

MatchLiteral : Match (
    target	"Object that I recognise."
)

"----------------------------------------------------------------"

MatchLiteral withTarget: anObject
[
    self := self new.
    target := anObject.
]

MatchLiteral matchOn: aStream	[ ^aStream peek == target ifTrue: [aStream skip: 1] ]

"I recognise a single character."

MatchCharacter : MatchLiteral ()

"I recognise a sequence of Integers corresponding to the characters in my string."

MatchString : MatchLiteral ()

MatchString matchOn: aStream
[
    target doWithIndex: [:c :i | (aStream at: i) == c ifFalse: [^nil]].
    aStream skip: target size.
]

MatchClass : MatchCharacter ()

MatchClass matchOn: aStream
[
    | c |
    ^((c := aStream peek) and: [0 ~~ (target bitAt: c)]) ifTrue: [aStream next]
]


MatchGrammar : MatchLiteral ()

MatchGrammar matchOn: aStream	[ ^aStream result: (target match: aStream) ]

"----------------------------------------------------------------"

MatchSingle : Match ( match )

MatchSingle withMatch: aMatch
[
    self := self new.
    match := aMatch.
]

MatchSingle do: unaryBlock
[
    super do: unaryBlock.
    match do: unaryBlock.
]

"I recognise either my match, or nothing (consuming no input), in that order."

MatchZeroOrOne : MatchSingle ()

MatchZeroOrOne matchOn: aStream	[ match matchOn: aStream ]

"I recognise the absence of (failure to recognise) my (inherited) match."

MatchNot : MatchSingle ()

MatchNot matchOn: aStream
[
    | rp ap |
    rp := aStream readPosition.
    ap := aStream actionPosition.
    ^(match matchOn: aStream)
	ifTrue:  [aStream readPosition: rp actionPosition: ap.  nil]
	ifFalse: [self]
]

MatchPeek : MatchSingle ()

MatchPeek matchOn: aStream
[
    | rp ap |
    rp := aStream readPosition.
    ap := aStream actionPosition.
    ^(match matchOn: aStream)
	ifTrue:  [self]
	ifFalse: [aStream readPosition: rp actionPosition: ap.  nil]
]

"I recognise zero or more occurrences of my (inherited) match."

MatchZeroOrMore : MatchSingle ()

MatchZeroOrMore matchOn: aStream	[ [match matchOn: aStream] whileTrue ]

"I recognise one or more occurrences of my (inherited) match."

MatchOneOrMore : MatchSingle ()

MatchOneOrMore matchOn: aStream
[
    ^(match matchOn: aStream)
	ifTrue:
	   [[match matchOn: aStream] whileTrue.
	    self].
]

"----------------------------------------------------------------"

MatchMultiple : Match ( submatches )

MatchMultiple withMatch: aMatch
[
    self := self new.
    submatches := OrderedCollection new.
    submatches addLast: aMatch.
]

MatchMultiple do: unaryBlock
[
    super do: unaryBlock.
    submatches do: [:match | match do: unaryBlock].
]


MatchAll : MatchMultiple ()

MatchAll matchOn: aStream
[
    | rp ap |
    rp := aStream readPosition.
    ap := aStream actionPosition.
    submatches do: [:match |
	(match matchOn: aStream)
	    ifFalse:
		[aStream readPosition: rp actionPosition: ap.
		 ^nil]].
]


MatchFirst : MatchMultiple ()

MatchFirst matchOn: aStream
[
    submatches do: [:match | | result |
	(result := match matchOn: aStream)
	    ifTrue:  [^result]].
    ^nil
]

"----------------------------------------------------------------"

MatchPushImmediate : MatchSingle ( size )

MatchPushImmediate withMatch: aMatch size: anInteger
[
    self := self withMatch: aMatch.
    size := anInteger.
]

MatchPushImmediate matchOn: aStream
[
    | result |
    aStream pushImmediate: size.
    result := match matchOn: aStream.
    aStream popImmediate: size.
    ^result
]


"I recognise my (inherited) match.  My only purpose is to give that Match a name by which it will be known when printing the entire Match graph."

MatchRule : MatchSingle (
    name	"Symbol by which my Match is known."
    immediateSize
    delayedSize
    reached
)

MatchRule named: aString
[
    self := self new.
    name := aString.
]

MatchRule name	[ ^name ]

MatchRule matches: aMatch
[
    match := aMatch.
    immediateSize := match inject: 0 into: [:size :submatch | size max: submatch immediateSize].
    delayedSize   := match inject: 0 into: [:size :submatch | size max: submatch delayedSize].
    "StdOut nextPutAll: name; tab; nextPutAll: 'immediate '; println: immediateSize."
    "StdOut nextPutAll: name; tab; nextPutAll: 'delayed   '; println: delayedSize."
    immediateSize > 0 ifTrue: [match := MatchPushImmediate withMatch: match size: immediateSize].
    delayedSize   > 0 ifTrue: [self error: 'match := (MatchPushDelayed with: delayedSize) , match , (MatchPopDelayed with: delayedSize)'].
]

Match immediateSize	[ ^0 ]
Match delayedSize	[ ^0 ]

"MatchRuleDepth := [ 0 ]"

MatchRule matchOn: aStream
[
    | result |
"   (MatchRuleDepth * 2) timesRepeat: [StdErr space].    StdErr println: name.    MatchRuleDepth := MatchRuleDepth + 1.   "
    result := match matchOn: aStream.
"   MatchRuleDepth := MatchRuleDepth - 1.    (MatchRuleDepth * 2) timesRepeat: [StdErr space].    StdErr print: name; nextPutAll: ' -> '; println: result.   "
    ^result
]

MatchRule do: unaryBlock	[ unaryBlock value: self ]



"I recognise nothing (consuming no input) but cause a block to be evaluated."

MatchImmediateValue : Match (
    _method	"_imp_t (method implementation) that I evaluate."
)

Object isStaticBlockClosure		[ ^false ]
StaticBlockClosure isStaticBlockClosure [ ^true ]
StaticBlockClosure _function		[ ^_function ]

MatchImmediateValue withBlock: aBlock
[
    ^(aBlock isStaticBlockClosure and: [aBlock arity <= 1])
	ifTrue:  [self withMethod_: aBlock _function]
	ifFalse: [aBlock error: 'parse action must be a static block closure of 0 or 1 argument(s)'].
]

MatchImmediateValue withMethod_: _aMethod
[
    self := self new.
    _method := _aMethod.
]

"MatchImmediateValue old_matchOn: aStream	[ aStream result: (valueBlock value: aStream) ]"

MatchImmediateValue matchOn: aStream
[
    | result |
    { v_result = ((oop (*)())(self->v__method))(0, v_aStream, v_aStream); }.
    aStream result: result	"XXX ^s result: r -- will make this a PREDICATE XXX"
]


MatchImmediatePredicate : MatchImmediateValue ()

MatchImmediatePredicate matchOn: aStream
[
    | result |
    { v_result = ((oop (*)())(self->v__method))(0, v_aStream, v_aStream); }.
    ^aStream result: result
]


"I recognise nothing (consuming no input) but cause a block to be evaluated at the end of parsing."

MatchDelayedValue : MatchImmediateValue ()

MatchDelayedValue matchOn: aStream	[ self error: 'aStream noteDelayedValue: valueBlock' ]


MatchStore : Match (
    index	"Integer index of the variable that I store into."
)


MatchStore withIndex: integerIndex
[
    self := self new.
    index := integerIndex.
]

MatchImmediateStore : MatchStore ()

MatchImmediateStore matchOn: aStream	[ aStream store: index ]


MatchImmediateStore immediateSize		[ ^index + 1 ]


MatchDelayedStore : MatchStore ()

MatchDelayedStore matchOn: aStream	[ aStream noteDelayedValue: [:p | p store: index] ]


MatchDelayedStore delayedSize		[ ^index + 1 ]


"I recognise nothing (consuming no input) but cause my ParseStream to remember its current position as the start of the input range for the next action."

MatchBegin : Match ()

MatchBegin matchOn: aStream	[ aStream noteStart ]


"I recognise nothing (consuming no input) but cause my ParseStream to remember its current position as (one past) the end of the input range for the next action."

MatchEnd : Match ()

MatchEnd matchOn: aStream	[ aStream noteEnd   ]


" ---------------- constructors ----------------  "

UndefinedObject match	[ self error: '#match sent to nil -- maybe a circular definition without forward reference?' ]

Match	 match		[ ]
Object	 match		[ ^MatchLiteral withTarget: self ]
String	 match		[ ^self size == 1 ifTrue: [MatchCharacter withTarget: self first] ifFalse: [MatchString withTarget: self] ]
String	 matchClass	[ ^MatchClass withTarget: self asCharacterClass ]
Match	 not		[ ^MatchNot  withMatch: self ]
Match	 peek		[ ^MatchPeek withMatch: self ]

MatchImmediateValue  peek [ ^MatchImmediatePredicate withMethod_: _method ]

Match		zeroOrOne	[ ^MatchZeroOrOne withMatch: self ]
MatchZeroOrOne	zeroOrOne	[ ]

Match		zeroOrMore	[ ^MatchZeroOrMore withMatch: self ]
MatchZeroOrMore	zeroOrMore	[ ]

Match		oneOrMore	[ ^MatchOneOrMore withMatch: self ]
MatchOneOrMore	oneOrMore	[ ]

Match	 , anObject	[ ^(MatchAll withMatch: self) , anObject ]
MatchAll , anObject	[ submatches addLast: anObject match ]

Match	   | anObject	[ ^(MatchFirst withMatch: self) | anObject ]
MatchFirst | anObject	[ submatches addLast: anObject match ]

Match <  anObject	[ ^self , MatchBegin , anObject ]
Match >  anObject	[ ^self , MatchEnd   , anObject ]

Match -> blockOrInteger	[ ^self , (blockOrInteger isInteger
				       ifTrue:  [MatchImmediateStore withIndex: blockOrInteger]
				       ifFalse: [MatchImmediateValue withBlock: blockOrInteger]) ]

Match => blockOrInteger	[ ^self , (blockOrInteger isInteger
				       ifTrue:  [MatchDelayedStore  withIndex: blockOrInteger]
				       ifFalse: [MatchDelayedValue  withBlock: blockOrInteger]) ]

Match named: aString	[ ^(MatchRule named: aString) matches: self ]

StaticBlockClosure	matchDelayed	[ ^MatchDelayedValue   withBlock: self ]
StaticBlockClosure	matchImmediate	[ ^MatchImmediateValue withBlock: self ]

"----------------------------------------------------------------"

{ import: Match-printing }

"
Match		consumesInput	[ ^false ]

MatchAny	consumesInput	[ ^true ]
MatchLiteral	consumesInput	[ ^true ]
MatchString	consumesInput	[ ^target size > 0 ]

MatchOneOrMore	consumesInput	[ ^match consumesInput ]

MatchAll	consumesInput
[
    submatches do: [:m | m consumesInput ifTrue:  [^true ]].
    ^false
]

MatchFirst	consumesInput
[
    | result |
    result := submatches notEmpty.
    submatches do: [:m | m consumesInput ifFalse: [result := false]].
    ^result
]

MatchRule	consumesInput
[
    | result |
    reached
	ifTrue: [StdErr nextPutAll: 'possible infinite left recursion in rule '''; nextPutAll: name; nextPutAll: ''''; cr]
	ifFalse:
	   [reached := true.
	    result := match consumesInput.
	    reached := false].
    ^result
]


Match		loopsForever	[ ^false ]

MatchSingle	loopsForever	[ ^match loopsForever ]

MatchZeroOrOne	loopsForever	[ match consumesInput ifFalse: [StdErr nextPutAll: 'INFINITE LOOP '; println: self].  ^true ]
MatchZeroOrMore	loopsForever	[ match consumesInput ifFalse: [StdErr nextPutAll: 'INFINITE LOOP '; println: self].  ^true ]

MatchMultiple	loopsForever	[ submatches do: [:m | m loopsForever ifTrue: [^true]].  ^false ]

MatchRule	loopsForever
[
    | result |
    reached
	ifFalse:
	   [reached := true.
	    result := match loopsForever.
	    reached := false].
    ^result
]
"
