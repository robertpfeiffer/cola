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

  Last edited: 2007-03-11 17:49:33 by piumarta on emilia.local
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

ReductionGrammar : Object ( startSets insnSets )

ReductionGrammar new
[
    self := super new.
    startSets := IdentityDictionary new.
    insnSets := IdentityDictionary new.
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
    | production |
    production := GrammarProduction withSymbol: startSymbol pattern: pattern predicate: predicateBlock action: actionBlock.
    (self at: startSymbol) addFirst: production.
    (pattern isArray and: [pattern first isSymbol]) ifTrue: [(self at: startSymbol at: pattern first) addFirst: production].
]

ReductionGrammar startSetAt: startSymbol at: insnName
[
    | set |
    set := insnSets at: startSymbol ifAbsent: [self error: 'no start set for ', startSymbol printString].
    set := set at: insnName ifAbsent: [self error: 'no rule for ', insnName printString, ' in start set for ', startSymbol printString].
    ^set
]

ReductionGrammar at: startSymbol at: insnName
[
    | set |
    set := insnSets at: startSymbol ifAbsent: [insnSets at: startSymbol put: IdentityDictionary new].
    ^set at: insnName ifAbsent: [set at: insnName put: OrderedCollection new].
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

