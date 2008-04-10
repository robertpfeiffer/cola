{ import: Parser }
{ import: ParsingExpression }

Grammars := [ IdentityDictionary new ]

Grammar : IdentityDictionary ( parent lastSymbol startRule dirty name )

Grammar startRule	[ ^startRule ]

Grammar at: nameSymbol
[
    ^super at: nameSymbol
	   ifAbsent: [parent
			  ifTrue:  [parent at: nameSymbol]
			  ifFalse: [self errorKeyNotFound: nameSymbol]]
]

Grammar at: nameSymbol put: pe
[
    (self includesKey: nameSymbol) ifTrue: [StdErr nextPutAll: 'grammar rule ''', nameSymbol, ''' redefined'].
    lastSymbol := nameSymbol.
    dirty := true.
    ^super at: nameSymbol put: (PeRule withValue: pe name: nameSymbol)
]

Grammar - aSymbol	[ ^PeName withName: aSymbol grammar: self ]

Grammar name: aSymbol	[  Grammars at: (name := aSymbol) put: self ]
Grammar named: aSymbol	[ ^Grammars at: aSymbol ifAbsent: [self error: 'No such Grammar: ', aSymbol] ]

Grammar startSymbol: aSymbol
[
    self finalise.
    startRule := self at: aSymbol.
]

Grammar startRule: pe
[
    startRule := PeRule withValue: pe name: #'<start>'.
    dirty := true.
    self finalise.
]

Grammar finalise
[
    dirty
	ifTrue:
	   [self do: [:assoc | assoc value finaliseIn: self].
	    startRule
		ifTrue:  [startRule finaliseIn: self]
		ifFalse: [startRule := self at: lastSymbol].
	    dirty := false].
]

PeRule finaliseIn: aGrammar
[
    | n |
    self resolveIn: aGrammar.
    (n := self actionSize) > 0 ifTrue: [self actionSize: n].
    (n := self storeSize)  > 0 ifTrue: [self storeSize: n].
]

PeRule actionSize: n
[
    preAction
	ifTrue:
	   [preAction value value: n.
	    postAction value value: n]
	ifFalse:
	   [preAction  := (PePush withValue: n) action.
	    postAction := (PePop withValue: n) action.
	    value := preAction , value , postAction].
]

PeRule storeSize: n
[
    save
	ifTrue:  [save size: n]
	ifFalse: [value := PeSave withValue: value size: n].
]

ParsingExpression resolveIn: aGrammar		[]
ParsingExpressionSingle resolveIn: aGrammar	[ value resolveIn: aGrammar ]
ParsingExpressionMultiple resolveIn: aGrammar	[ value do: [:pe | pe resolveIn: aGrammar] ]

PeName resolveIn: aGrammar			[ value := (grammar ifNil: [aGrammar]) at: name ]

ParsingExpression storeSize			[ ^0 ]
ParsingExpressionSingle storeSize		[ ^value storeSize ]
ParsingExpressionMultiple storeSize		[ ^value inject: 0 into: [:n :pe | n max: pe storeSize] ]
PeName storeSize				[ ^0 ]

ParsingExpression actionSize			[ ^0 ]
ParsingExpressionSingle actionSize		[ ^value actionSize ]
ParsingExpressionMultiple actionSize		[ ^value inject: 0 into: [:n :pe | n max: pe actionSize] ]
PeName actionSize				[ ^0 ]

PeStoreResult storeSize				[ ^1 + value ]
PeAction actionSize				[ ^value storeSize ]

PeSetResult resolveIn: aGrammar
[
    expression
	ifTrue:
	   [value := (Expression
			  with: #lambda
			  with: (Expression with: #_send with: #_state with: #self with: #result)
			  with: expression) "println" _eval]
]

Grammar parserOn: aStream	[ ^Parser on: aStream rule: startRule ]

Grammar printOn: aStream
[
    aStream nextPutAll: 'Grammar('; cr.
    self do: [:assoc | aStream space; space; print: assoc; cr].
    aStream println: startRule.
    aStream nextPutAll: ')'; cr.
]
