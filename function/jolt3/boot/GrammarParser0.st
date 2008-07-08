{ import: Parser }
{ import: PEGIterator }

GrammarParser : Parser ( input )

GrammarParser class: aClass	[ ^super class: aClass :input ]
GrammarParser string: aString	[ ^super string: aString :input ]

GrammarParser endOfLine
[
    $\r == input peek
	ifTrue:
	   [input nextToken.
	    [$\n == input peek] whileTrue: [input nextToken].
	    ^self].
    $\n == input peek
	ifTrue:
	   [input nextToken.
	    [$\r == input peek] whileTrue: [input nextToken].
	    ^self].
    ^nil
]

GrammarParser space
[
    $    == input peek ifTrue: [^input nextToken].
    $\t  == input peek ifTrue: [^input nextToken].
    ^self endOfLine
]

GrammarParser comment
[
    | pos |
    $% == input peek ifFalse: [^nil].
    pos := input position.
    [self endOfLine not and: [input nextToken]] whileTrue: [pos := input position].
    input position: pos.
    self endOfLine ifFalse: [^input position: pos].
]

GrammarParser spacing		[ [self space or: [self comment]] whileTrue ]

GrammarParser equal		[ ($= == input peek) ifFalse: [^nil].  input nextToken.  self spacing ]
GrammarParser colon		[ ($: == input peek) ifFalse: [^nil].  input nextToken.  self spacing ]
GrammarParser semicolon		[ ($; == input peek) ifFalse: [^nil].  input nextToken.  self spacing ]
GrammarParser bar		[ ($| == input peek) ifFalse: [^nil].  input nextToken.  self spacing ]
GrammarParser and		[ ($& == input peek) ifFalse: [^nil].  input nextToken.  self spacing ]
GrammarParser not		[ ($! == input peek) ifFalse: [^nil].  input nextToken.  self spacing ]
GrammarParser question		[ ($? == input peek) ifFalse: [^nil].  input nextToken.  self spacing ]
GrammarParser star		[ ($* == input peek) ifFalse: [^nil].  input nextToken.  self spacing ]
GrammarParser plus		[ ($+ == input peek) ifFalse: [^nil].  input nextToken.  self spacing ]
GrammarParser open		[ ($( == input peek) ifFalse: [^nil].  input nextToken.  self spacing ]
GrammarParser close		[ ($) == input peek) ifFalse: [^nil].  input nextToken.  self spacing ]
GrammarParser dot		[ ($. == input peek) ifFalse: [^nil].  input nextToken.  self spacing ]
GrammarParser leftAngle		[ ($< == input peek) ifFalse: [^nil].  input nextToken.  self spacing ]
GrammarParser rightAngle	[ ($> == input peek) ifFalse: [^nil].  input nextToken.  self spacing ]

GrammarParser rightArrow
[
    | pos |
    ($- == input peek) ifFalse: [^nil].
    pos := input position.
    input nextToken.
    ($> == input peek) ifFalse: [^input position: pos].
    input nextToken.
    self spacing.
]

GrammarParser structure
[
    | pos e |
    $# == input peek ifFalse: [^nil].
    pos := input position.
    input nextToken.
    self open ifFalse: [^input position: pos].
    self expression ifFalse: [^input position: pos].
    e := result.
    self close ifFalse: [^input position: pos].
    ^result := (TokenGroup with: #structure) add: e
]

EscapedCharacters := [ IdentityDictionary new
			   at: $t	put:  9;
			   at: $n	put: 10;
			   at: $r	put: 13;
			   yourself ]

DigitRange02 := [ '0-2' asCharacterClass ]
DigitRange07 := [ '0-7' asCharacterClass ]

GrammarParser char
[
    | pos0 pos1 c |
    "eof"
    pos0 := input position.
    (result := input next) ifFalse: [^nil].
    "non-escaped character"
    $\\ == result ifFalse: [^self].
    "octal character"
    pos1 := input position.
    (((self class: DigitRange02) and: [(self class: DigitRange07) and: [self class: DigitRange07]])
	 or: [input position: pos1.
	      (self class: DigitRange07) and: [(self class: DigitRange07) or: [1]]])
	ifTrue: [^result := pos1 to: input position inject: 0 into: [:num :tok | num * 8 + (tok - $0)]].
    input position: pos1.
    "eof after backslash"
    (result := input next) ifFalse: [^nil].
    "ansi escape or anonymous escape"
    result := EscapedCharacters at: result ifAbsent: [result].
]

GrammarParser string
[
    | open close pos s |
    open := input next.
    close := input next.
    pos := input position.
    open == input peek ifFalse: [^nil].
    s := WriteStream on: (String new: 16).
    input nextToken.
    [close ~~ input peek and: [self char]] whileTrue: [s nextPut: result].
    close == input next ifFalse: [^input position: pos].
    result := s contents.
]

GrammarParser range
[
    | pos c1 c2 |
    pos := input position.
    self char ifFalse: [^nil].
    $- == input peek ifFalse: [^result := String with: result].
    input nextToken.
    self char ifFalse: [^input position: pos].
    result := pos text: input position
]

GrammarParser class
[
    | pos s |
    $[ == input peek ifFalse: [^nil].
    pos := input position.
    s := WriteStream on: (String new: 16).
    input nextToken.
    [$] ~~ input peek and: [self range]] whileTrue: [s nextPutAll: result].
    $] == input next ifFalse: [^input position: pos].
    self spacing.
    s := s contents.
    result := s size == 1
	ifTrue:  [(TokenGroup with: #literal) add: s first]
	ifFalse: [(TokenGroup with: #class)   add: s asCharacterClass]
]

GrammarParser literal
[
    | l |
    input push: $'; push: $'.
    self string
	ifFalse:
	   [input push: $"; push: $".
	    self string ifFalse: [^nil]].
    l := result size == 1
	ifTrue:  [(TokenGroup with: #literal) add: result first]
	ifFalse: [(TokenGroup with: #string)  add: result].
    self spacing.
    result := l.
]

Alpha	 := [ 'A-Za-z_' asCharacterClass ]
AlphaNum := [ '0-9A-Za-z_' asCharacterClass ]

GrammarParser identifier
[
    | first last |
    first := input position.
    (self class: Alpha) ifFalse: [^nil].
    [self class: AlphaNum] whileTrue.
    last := input position.
    self spacing.
    result := (first text: last) asSymbol.
]

GrammarParser invocation
[
    | pos |
    pos := input position.
    self identifier
	ifTrue:
	   [self equal ifTrue: [^input position: pos].
	    ^result := (TokenGroup with: #invoke) add: result].
    ^self application
]

GrammarParser application
[
    | pos p |
    pos := input position.
    self leftAngle	ifFalse:   [^nil].
    self identifier	ifFalse:   [^input position: pos].
    p := (TokenGroup with: #invoke) add: result.
    [self argument]	whileTrue: [p add: result].
    self rightAngle	ifFalse:   [^input position: pos].
    ^result := p
]

GrammarParser argument
[
    self identifier ifTrue: [^result := (TokenGroup with: #argvar) add: result].
    self symbol	    ifTrue: [^result := (TokenGroup with: #arglit) add: result].
    ^self application
]

GrammarParser symbol
[
    | pos |
    $# == input peek ifFalse: [^nil].
    pos := input nextToken; position.
    self identifier ifFalse: [^input position: pos].
    ^result := (TokenGroup with: #literal) add: result.
]

GrammarParser answer
[
    | pos |
    pos := input position.
    self rightArrow	ifFalse: [^nil].
    self identifier	ifTrue: [^result := (TokenGroup with: #answer) add: result].
    self action		ifTrue: [^result := (TokenGroup with: #answer) add: result].
    ^input position: pos
]

GrammarParser action
[
    | pos text |
    ${ == input peek ifFalse: [^nil].
    pos := input position.
    input nextToken.
    [$} == input peek] whileFalse: [input nextToken ifFalse: [^input position: pos]].
    text := pos next text: input position.
    input nextToken.
    self spacing.
    result := (TokenGroup with: #action) add: text.
]

GrammarParser primary
[
    | pos p |
    self invocation	ifTrue:  [^self].
    pos := input position.
    self open
	ifTrue:
	   [(self expression and: [p := result.  self close]) ifFalse: [^input position: pos].
	    result := p.
	    ^self].
    self literal	ifTrue:  [^self].
    self class		ifTrue:  [^self].
    self structure	ifTrue:  [^self].
    self symbol		ifTrue:  [^self].
    self dot		ifTrue:  [^result := (TokenGroup with: #dot)].
    self answer		ifTrue:  [^self].
    self action		ifTrue:  [^self].
    ^nil
]

GrammarParser suffix
[
    | pos s |
    pos := input position.
    self primary	ifFalse: [^nil].
    s := result.
    self question	ifTrue: [^result := (TokenGroup with: #zeroOne)  add: s].
    self star		ifTrue: [^result := (TokenGroup with: #zeroMany) add: s].
    self plus		ifTrue: [^result := (TokenGroup with: #oneMany ) add: s].
    result := s.
]

GrammarParser storable
[
    | pos s |
    self suffix		ifFalse: [^nil].
    $$ == input peek	ifFalse: [^self].
    input nextToken.
    self spacing.
    result := (TokenGroup with: #text) add: result.
]

GrammarParser assignment
[
    | pos storable |
    self storable ifFalse: [^nil].
    $: == input peek ifFalse: [^self].
    pos := input position.
    storable := result.
    input nextToken.
    self identifier
	ifFalse:
	   [input position: pos.
	    ^result := storable].
    result := (TokenGroup with: #store) add: result; add: storable
]

GrammarParser prefix
[
    | pos |
    pos := input position.
    self and
	ifTrue:
	   [self assignment ifFalse: [^input position: pos].
	    ^result := (TokenGroup with: #and) add: result].
    self not
	ifTrue:
	   [self assignment ifFalse: [^input position: pos].
	    ^result := (TokenGroup with: #not) add: result].
    $: == input peek
	ifTrue:
	   [input nextToken.
	    self identifier ifFalse: [^input position: pos].
	    ^result := (TokenGroup with: #store) add: result; add: (TokenGroup with: #dot)].
    ^self assignment
]

GrammarParser sequence
[
    | seq |
    self prefix			ifFalse: [^nil].
    seq := TokenGroup with: result.
    [self prefix] whileTrue: [seq addLast: result].
    result := (seq hasSize: 1) ifTrue: [seq first] ifFalse: [seq addFirst: #sequence.  seq].
]

GrammarParser expression
[
    | pos expr |
    pos := input position.
    self sequence		ifFalse: [^nil].
    expr := TokenGroup with: result.
    [self bar]
	whileTrue:
	   [self sequence	ifFalse: [^input position: pos].
	    expr add: result].
    result := (expr hasSize: 1) ifTrue: [expr first] ifFalse: [expr addFirst: #alternatives.  expr].
]

GrammarParser parameter
[
    | pos |
    $: == input peek ifFalse: [^nil].
    pos := input nextToken; position.
    self identifier ifFalse: [^input position: pos].
]

GrammarParser definition
[
    | pos name params locals expr |
    pos := input position.
    self identifier		ifFalse: [^input position: pos].
    name := result.
    params := TokenGroup new.
    [self parameter] whileTrue: [params addLast: result].
    self equal			ifFalse: [^input position: pos].
    self expression		ifFalse: [^input position: pos].
    expr := result.
    self semicolon.
    locals := CollectLocals for: expr.
    params do: [:tok | locals at: tok put: true].
    result := (TokenGroup with: #definition) add: name;	add: params; add: (TokenGroup withAll: locals keys); add: expr
]

GrammarParser declaration
[
    | pos n b v |
    pos := input position.
    self identifier				ifFalse: [^nil].
    n := result.
    self colon					ifFalse: [^input position: pos].
    self identifier				ifFalse: [^input position: pos].
    b := result.
    v := TokenGroup new.
    self open					ifFalse: [^input position: pos].
    [self identifier] whileTrue: [v addLast: result].
    self close					ifFalse: [^input position: pos].
    result := (TokenGroup with: #declaration) add: n; add: b; add: v.
]

GrammarParser grammar
[
    | pos grammar |
    grammar := (TokenGroup with: #grammar).
    self spacing.
    self declaration
	ifTrue:  [grammar addLast: result]
	ifFalse: [grammar addLast: TokenGroup new].
    [self definition] whileTrue: [grammar addLast: result].
    result := grammar.
]

GrammarParser start :tokenStream
[
    input := tokenStream.
    ^self grammar
]
