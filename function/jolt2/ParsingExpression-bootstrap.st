{ import: ParsingExpression }

Object parse	[ self error: 'cannot make ParsingExpression from ', self debugName ]

SmallInteger parse			[ ^PeIdentity withValue: self ]
String parse				[ ^size == 1 ifTrue: [PeIdentity withValue: self first] ifFalse: [PeSequence withValue: self] ]
SequenceableCollection parseClass	[ ^PeClass withValue: self asCharacterClass ]
Symbol parse				[ ^PeName withName: self ]
Object parseLiteral			[ ^PeIdentity withValue: self ]

ParsingExpression parseStructure	[ ^PeStructure  withValue: self ]

ParsingExpression zeroOne	[ ^PeZeroOne  withValue: self ]		ParsingExpressionRepeat	zeroOne	 [ self error: 'cannot repeat repetition' ]
ParsingExpression zeroMore	[ ^PeZeroMore withValue: self ]		ParsingExpressionRepeat	zeroMore [ self error: 'cannot repeat repetition' ]
ParsingExpression oneMore	[ ^PeOneMore  withValue: self ]		ParsingExpressionRepeat	oneMore	 [ self error: 'cannot repeat repetition' ]

PeAny zeroMore			[ ^PeRest ]

ParsingExpression not	[ ^PeNot withValue: self ]

ParsingExpression , pe	[ ^PeAnd new add: self; add: pe ]
PeAnd		  , pe	[ value addLast: pe ]

ParsingExpression | pe	[ ^PeOr new add: self; add: pe ]
PeOr		  | pe	[ value addLast: pe ]

ParsingExpression textResult	[ ^PeTextResult withValue: self ]
PeTextResult textResult		[]

ParsingExpression action	[ ^PeAction withValue: self ]
PeTextResult action		[ ^PeTextValueAction withValue: value ]
SmallInteger storeResult	[ ^PeStoreResult withValue: self ]

BlockClosure setResult		[  self error: 'action block must not contain free references or non-local returns' ]
StaticBlockClosure setResult	[ ^PeSetResult withValue: _function ]

"----"

ParsingExpression -> anInteger	[ ^self itemResult , anInteger storeResult ]
ParsingExpression => anInteger	[ ^self , anInteger storeResult action ]
ParsingExpression <- aBlock	[ ^self , aBlock setResult ]
ParsingExpression <= aBlock	[ ^self , aBlock setResult action ]

ParsingExpression itemResult		[]
PeAny itemResult			[ ^PeItemResult withValue: self ]

ParsingExpressionRepeat -> anInteger
[
    value := value , (PeCollectResult withValue: anInteger).
    ^PeCollectResults withValue: self index: anInteger
]
