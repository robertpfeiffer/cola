{ import: Match }

MatchAny		printOn: aStream	[ aStream nextPut: $. ]

MatchLiteral		printOn: aStream	[ aStream print: target ]

MatchCharacter printOn: aStream
[
    aStream nextPut: $'.
    target == $' ifTrue: [aStream nextPut: $\\].
    self next: aStream putEscaped: target.
    aStream nextPut: $'.
]

MatchCharacter next: aStream putEscaped: aCharacter
[
    (aCharacter between: 32 and: 126)
	ifTrue:  [aStream nextPut: aCharacter]
	ifFalse: [aStream nextPut: $\\; print: aCharacter base: 8 width: 3].
]

MatchString		printOn: aStream	[ target printEscapedOn: aStream delimited: $" ]

MatchClass printOn: aStream
[
    | prev |
    aStream nextPut: $[.
    0 to: 255 do: [:c |
	(target bitAt: c) == 1
	    ifTrue:  [prev ifFalse: [prev := c]]
	    ifFalse:
	       [prev
		    ifTrue:
		       [self printFrom: prev to: c - 1 escapedOn: aStream.
			prev := nil]]].
    prev ifTrue: [self printFrom: prev to: 255 escapedOn: aStream].
    aStream nextPut: $].
]

MatchClass printFrom: start to: stop escapedOn: aStream
[
    start == stop
	ifTrue: [self next: aStream putEscaped: start]
	ifFalse:
	   [start + 1 == stop
		ifTrue: [self next: aStream putEscaped: start; next: aStream putEscaped: stop]
		ifFalse:
		   [self next: aStream putEscaped: start.
		    aStream nextPut: $-.
		    self next: aStream putEscaped: stop]]
]

MatchNot		printOn: aStream	[ self printOn: aStream prefixed: $! ]
MatchZeroOrOne		printOn: aStream	[ self printOn: aStream suffixed: $? ]
MatchZeroOrMore		printOn: aStream	[ self printOn: aStream suffixed: $* ]
MatchOneOrMore		printOn: aStream	[ self printOn: aStream suffixed: $+ ]

MatchSingle		printOn: aStream prefixed: prefix	[ aStream nextPut: prefix; "nextPut: $(; "print: match"; nextPut: $)" ]
MatchSingle		printOn: aStream suffixed: suffix	[ aStream "nextPut: $(; "print: match; "nextPut: $); "nextPut: suffix ]

MatchRule		printOn: aStream	[  aStream nextPutAll: name ]

MatchRule printMatchOn: aStream
[
    aStream
	nextPutAll: name;
	nextPutAll: ' '; print: immediateSize; nextPut: $/; print: delayedSize; nextPutAll: ' = ';
	print: match
]

MatchAll		printOn: aStream	[ self printOn: aStream delimited: $, ]
MatchFirst		printOn: aStream	[ self printOn: aStream delimited: $| ]

MatchMultiple printOn: aStream delimited: delimiter
[
    aStream nextPut: $(; space.
    submatches do: [:match | aStream print: match] separatedBy: [aStream space; nextPut: delimiter; space].
    aStream space; nextPut: $).
]

MatchPushImmediate	printOn: aStream	[ super printOn: aStream.  aStream nextPut: $(; print: size; nextPut: $); space; print: match ]

MatchImmediateStore	printOn: aStream	[ aStream nextPutAll: '->'; print: index ]
MatchDelayedStore	printOn: aStream	[ aStream nextPutAll: '=>'; print: index ]

"----------------------------------------------------------------"

Match printGrammarOn: aStream
[
    | names |
    names := IdentityDictionary new.
    self addNamesTo: names.
    names valuesDo: [:match |
	match printMatchOn: aStream.
	aStream cr].
]

MatchRule addNamesTo: aDictionary
[
    (aDictionary includesKey: name)
	ifFalse:
	   [aDictionary at: name put: self.
	    match addNamesTo: aDictionary]
]

Match		addNamesTo: aDictionary	[ ]
MatchSingle	addNamesTo: aDictionary	[ match addNamesTo: aDictionary ]
MatchMultiple	addNamesTo: aDictionary	[ submatches do: [:match | match addNamesTo: aDictionary] ]
