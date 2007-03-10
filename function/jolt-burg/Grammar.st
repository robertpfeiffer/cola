" Grammar.st -- bottom-up rewrite grammar

  Copyright (c) 2006, 2007 Ian Piumarta
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

  Last edited: 2007-03-01 16:18:33 by piumarta on emilia
"

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

ReductionGrammar : Object ( startSets )

ReductionGrammar new
[
    self := super new.
    startSets := IdentityDictionary new.
]

ReductionGrammar startSetAt: startSymbol
[
    ^startSets at: startSymbol ifAbsent: [self error: 'no start set for ', startSymbol printString]
]

ReductionGrammar at: startSymbol
[
    ^startSets at: startSymbol ifAbsent: [startSets at: startSymbol put: OrderedCollection new]
]

ReductionGrammar at: startSymbol add: pattern
[
    self at: startSymbol add: pattern do: [:x :y | nil]
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

ReductionGrammar printOn: aStream
[
    super printOn: aStream.
    aStream nextPut: $(.
    startSets do: [:startSet |
	aStream cr; nextPutAll: '  '; print: startSet key.
	startSet value do: [:rule | aStream nextPutAll: '\n    ->\t'; print: rule pattern]].
    aStream cr; nextPut: $)
]

