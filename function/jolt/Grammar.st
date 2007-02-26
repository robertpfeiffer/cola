{ import: Objects }

GrammarProduction : Object ( symbol pattern predicate action )

GrammarProduction withSymbol: aSymbol pattern: patternList predicate: predicateBlock action: actionBlock
[
    self := self new.
    symbol    := aSymbol.
    pattern   := patternList.
    predicate := predicateBlock.
    action    := actionBlock.
]

GrammarProduction symbol	[ ^symbol ]
GrammarProduction pattern	[ ^pattern ]
GrammarProduction predicate	[ ^predicate ]
GrammarProduction action	[ ^action ]

GrammarProduction printOn: aStream
[
    super printOn: aStream.
    aStream nextPut: $(; print: symbol; nextPutAll: ' -> '; print: pattern; nextPut: $)
]

"----------------------------------------------------------------"

ReductionGrammar : Object ( startSets listing )

ReductionGrammar new
[
    self := super new.
    startSets := IdentityDictionary new.
    listing := StdOut.
]

ReductionGrammar listing: l	[ listing := l ]

ReductionGrammar at: startSymbol
[
    ^startSets at: startSymbol ifAbsent: [startSets at: startSymbol put: OrderedCollection new]
]

ReductionGrammar at: startSymbol add: pattern
[
    self at: startSymbol add: pattern do: [:x|]
]

ReductionGrammar at: startSymbol add: pattern do: actionBlock
[
    self at: startSymbol add: pattern if: [:x | true] do: actionBlock
]

ReductionGrammar at: startSymbol add: pattern if: predicateBlock do: actionBlock
[
    (self at: startSymbol)
	addFirst: (GrammarProduction withSymbol: startSymbol
				     pattern: pattern
				     predicate: predicateBlock
				     action: actionBlock).
]

ReductionGrammar reduce: aTree to: startSymbol
[
    | startSet |
    ""listing nextPutAll: '  reduce: '; print: aTree; nextPutAll: ' to: '; print: startSymbol; cr.""
    aTree isArray ifFalse: [self error: 'ReductionGrammar cannot reduce a non-tree'].
    aTree first == #par ifTrue: [^self reducePar: aTree to: startSymbol].
    (aTree first beginsWith: 'call') ifTrue: [self reduceArguments: aTree].
    startSet := startSets at: startSymbol ifAbsent: [self error: 'start symbol #', startSymbol asString, ' not in rule set'].
    startSet do: [:rule |
	(self match: aTree with: rule pattern)
	    ifTrue:
	       [listing print: aTree; nextPutAll: ' --> '; print: rule pattern; nextPutAll: ' -> '; print: rule symbol; cr.
		rule action value: aTree.
		^startSymbol]].
    ^self cannotReduce: aTree to: startSymbol
]

ReductionGrammar match: aList with: pattern
[
    ""listing nextPutAll: '    ? '; print: aList; nextPutAll: ' = '; print: pattern; cr.""
    pattern isSymbol ifTrue: [^(self reduce: aList to: pattern) notNil].
    aList put: #gen value: nil.
    aList first == pattern first ifFalse: [^false].
    1 to: pattern size - 1 do: [:index |
	(self match: (aList at: index) with: (pattern at: index))
	    ifFalse: [listing nextPutAll: 'fail\n'.  ^false]].
    ^true
]

ReductionGrammar cannotReduce: aTree to: startSymbol
[
    StdErr nextPutAll: '\ncannot reduce: '; print: aTree; nextPutAll: ' to: '; print: startSymbol; cr; abort.
]

ReductionGrammar printOn: aStream
[
    super printOn: aStream.
    aStream nextPut: $(.
    startSets do: [:startSet |
	aStream cr; nextPutAll: '  '; print: startSet key.
	startSet value do: [:rule | aStream nextPutAll: '\n    ->\t'; print: rule pattern]].
    aStream cr; nextPut: $)
]

"----------------------------------------------------------------"

Intel32Grammar := [ ReductionGrammar new
	at: #stmt add: #reg			"discard";
	at: #reg  add: #(cnsti4)		do: [:gen :op | gen MOVir :op value      :op  output		];
	at: #stmt add: #(reti4	reg)		do: [:gen :op | gen MOVrr :op lhs output :gen eax		];
	at: #reg  add: #(addi4	reg reg)	do: [:gen :op | gen ADDrr :op rhs output :op  lhs output	];
	yourself ]

[ StdOut print: Intel32Grammar; cr ]
