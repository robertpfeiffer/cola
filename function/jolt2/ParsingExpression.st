{ import: Object }
{ import: Expression }

ParsingExpression : Object ()
  PeAny : ParsingExpression ()						" . "
  PeRest : ParsingExpression ()						" .* "
  ParsingExpressionValue : ParsingExpression ( value )
    PeIdentity : ParsingExpressionValue ()				" == "
    PeEquality : ParsingExpressionValue ()				" = "
    PeClass : ParsingExpressionValue ()					" [charClass] "
    PeSequence : ParsingExpressionValue ()				" enumerated == "
  ParsingExpressionSingle : ParsingExpressionValue ()
    PeNot : ParsingExpressionSingle ()					" ! e "
    PeStructure : ParsingExpressionSingle ()				" descend into Collection "
    ParsingExpressionRepeat : ParsingExpressionSingle ()
      PeZeroOne : ParsingExpressionRepeat ()				" e ? "
      PeZeroMore : ParsingExpressionRepeat ()				" e * "
      PeOneMore : ParsingExpressionRepeat ()				" e + "
    PeName : ParsingExpressionSingle ( name grammar )			" rule "
    PeRule : ParsingExpressionSingle ( name preAction postAction save )	" name = <pexprs...> "
  ParsingExpressionMultiple : ParsingExpressionValue ()
    PeAnd : ParsingExpressionMultiple ()				" e1   e2   ... "
    PeOr : ParsingExpressionMultiple ()					" e1 | e2 | ... "

"---------------- constructing"

ParsingExpressionValue withValue: aValue
[
    self := super new.
    value := aValue.
]

ParsingExpressionSingle withValue: aValue
[
    self := super new.
    value := aValue.
]

ParsingExpressionMultiple new
[
    self := super withValue: OrderedCollection new.
]

ParsingExpressionMultiple add: pe
[
    value addLast: pe
]

PeUnresolved : ParsingExpressionValue ()

PeUnresolved parse: aParser
[
    self error: 'grammar not finalised at rule ''', value , ''''
]

PeName withName: aSymbol
[
    self := super new.
    value := PeUnresolved withValue: aSymbol.
    name := aSymbol.
]

PeName withName: aSymbol grammar: aGrammar
[
    self := self withName: aSymbol.
    grammar := aGrammar.
]

PeRule withValue: pe name: aSymbol
[
    self := super withValue: pe.
    name := aSymbol.
]

"---------------- parsing"

PeAny parse: aParser	[ ^aParser matchAny ]
PeRest parse: aParser	[ ^aParser matchRest ]

PeIdentity parse: aParser	[ ^aParser match: value ]
PeEquality parse: aParser	[ ^aParser matchEqual: value ]
PeClass parse: aParser		[ ^aParser matchClass: value ]

PeSequence parse: aParser
[
    | rp ap |
    rp := aParser readPosition.
    ap := aParser actionPosition.
    value do: [:anObject | (aParser match: anObject) ifFalse: [^aParser readPosition: rp actionPosition: ap]].
]

PeStructure parse: aParser
[
    | input ok |
    (input := aParser input) peek isSequenceableCollection ifFalse: [^nil].
    input := aParser newInput: input next readStream.
    ok := (value parse: aParser) and: [aParser atEnd].
    aParser oldInput: input.
    ^ok
]

PeNot parse: aParser
[
    | rp ap |
    rp := aParser readPosition.
    ap := aParser actionPosition.
    ^(value parse: aParser)
	ifTrue:  [aParser readPosition: rp actionPosition: ap]
	ifFalse: [self]
]

PeZeroOne  parse: aParser	[   value parse: aParser ]
PeZeroMore parse: aParser	[  [value parse: aParser] whileTrue ]
PeOneMore  parse: aParser	[ ^(value parse: aParser) ifTrue: [[value parse: aParser] whileTrue.  self ] ]

PeName parse: aParser		[ ^value parse: aParser ]

PeRule parse: aParser
[
    | ok |
    aParser enter: name.
    ok := value parse: aParser.
    aParser leave: name.
    ^ok
]

PeAnd parse: aParser
[
    | rp ap i j |
    rp := aParser readPosition.
    ap := aParser actionPosition.
    i := 0.
    j := value size.
    [i < j]
	whileTrue:
	   [((value at: i) parse: aParser) ifFalse: [^aParser readPosition: rp actionPosition: ap].
	    i := i + 1].
]

PeOr parse: aParser
[
    | i j |
    i := 0.
    j := value size.
    [i < j]
	whileTrue:
	   [((value at: i) parse: aParser) ifTrue: [^self].
	    i := i + 1].
    ^nil
]

"----------------"

PeTextResult : ParsingExpressionSingle ()	" e $ "

PeTextResult parse: aParser
[
    | start |
    start := aParser readPosition.
    (value parse: aParser) ifFalse: [^nil].
    aParser result: (aParser contentsFrom: start) asString.
]


PeTextValue : ParsingExpressionValue ( limit )

PeTextValue withValue: start value: stop
[
    self := super withValue: start.
    limit := stop.
]

PeTextValue parse: aParser
[
    aParser result: (aParser contentsFrom: value to: limit)
]


PeTextValueAction : ParsingExpressionSingle ()	" e $ action "

PeTextValueAction parse: aParser
[
    | start |
    start := aParser readPosition.
    (value parse: aParser) ifFalse: [^nil].
    aParser noteAction: (PeTextValue withValue: start value: aParser readPosition - 1).
]


PeItemResult : ParsingExpressionSingle ()	" e -> "

PeItemResult parse: aParser
[
    ^(value parse: aParser) ifTrue: [aParser result: aParser last.  self]
]


PeAction : ParsingExpressionValue ()		" e action "

PeAction parse: aParser	[ aParser noteAction: value ]


PeSave : ParsingExpressionSingle ( size )	"recognition phase stack"

PeSave withValue: pe size: anInteger
[
    self := super withValue: pe.
    size := anInteger.
]

PeSave parse: aParser
[
    | ok |
    aParser push: size.
    ok := value parse: aParser.
    aParser pop: size.
    ^ok
]


PePush : ParsingExpressionValue ()		"commit phase stack"
PePop : ParsingExpressionValue ()

PePush parse: aParser	[ aParser push: value ]
PePop parse: aParser	[ aParser pop: value ]


PeStoreResult : ParsingExpressionValue ()	" -> "

PeStoreResult parse: aParser	[ aParser storeResult: value ]


PeSetResult : ParsingExpressionValue ( expression )		" <- "

PeSetResult withExpression: anExpression
[
    self := self new.
    expression := anExpression.
]

PeSetResult parse: aParser
[
    aParser setResultFromFunction_: value
]


PeCollectResult : PeStoreResult ()		" [?*+] -> "

PeCollectResult parse: aParser	[ 
    (aParser @ value == aParser result) ifTrue: [self error: 'OOPS!'].
    aParser @ value add: aParser result
]


PeCollectResults : ParsingExpressionSingle ( index )		" [?*+] -> "

PeCollectResults withValue: pe index: i
[
    self := super withValue: pe.
    index := i.
]

PeCollectResults parse: aParser
[
    aParser result: OrderedCollection new; storeResult: index.
    ^value parse: aParser
]
