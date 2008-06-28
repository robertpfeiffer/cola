{ import: Object }
{ import: Parser }

PEGIterator : Object ()

PEGIterator literal		:expr []
PEGIterator class		:expr []
PEGIterator string		:expr []
PEGIterator invoke		:expr []
PEGIterator dot			:expr []
PEGIterator zeroOne		:expr [ ^self preOrderApply: expr second ]
PEGIterator zeroMany		:expr [ ^self preOrderApply: expr second ]
PEGIterator oneMany		:expr [ ^self preOrderApply: expr second ]
PEGIterator text		:expr [ ^self preOrderApply: expr second ]
PEGIterator answer		:expr []
PEGIterator store		:expr [ ^self preOrderApply: expr third  ]
PEGIterator and			:expr [ ^self preOrderApply: expr second ]
PEGIterator not			:expr [ ^self preOrderApply: expr second ]
PEGIterator sequence		:expr [ ^self preOrderRest:  expr        ]
PEGIterator alternatives	:expr [ ^self preOrderRest:  expr        ]
PEGIterator parameters		:expr [ ^self preOrderApply: expr fourth ]
PEGIterator definition		:expr [ ^self preOrderApply: expr third  ]
PEGIterator grammar		:expr [ ^self preOrderRest:  expr        ]

PEGIterator preOrderApply: tree
[
    tree isEmpty ifTrue: [^self].
    self perform: tree first with: tree.
]

PEGIterator preOrderRest: tree
[
    tree from: 1 do: [:e | e isArray ifTrue: [self preOrderApply: e]].
]

"----------------"

CollectLocals : PEGIterator ( locals )

CollectLocals for: aGrammar
[
    self := self new.
    locals := IdentityDictionary new.
    self preOrderApply: aGrammar.
    ^locals.
]

CollectLocals store :expr :arg
[
    locals at: expr second put: true.
    super store :expr :arg
]

"----------------------------------------------------------------"

PEGParser : Parser ()

PEGParser endOfLine
[
    $\r == input peek
	ifTrue:
	   [input next.
	    [$\n == input peek] whileTrue: [input next].
	    ^self].
    $\n == input peek
	ifTrue:
	   [input next.
	    [$\r == input peek] whileTrue: [input next].
	    ^self].
    ^nil
]

PEGParser space
[
    $    == input peek ifTrue: [^input next].
    $\t  == input peek ifTrue: [^input next].
    ^self endOfLine
]

PEGParser comment
[
    | pos |
    $# == input peek ifFalse: [^nil].
    pos := input position.
    [self endOfLine not and: [input next]] whileTrue: [pos := input position].
    input position: pos.
    self endOfLine ifFalse: [^input position: pos].
]

PEGParser spacing	[ [self space or: [self comment]] whileTrue ]

PEGParser equal		[ ($= == input peek) ifFalse: [^nil].  input next.  self spacing ]
PEGParser semicolon	[ ($; == input peek) ifFalse: [^nil].  input next.  self spacing ]
PEGParser bar		[ ($| == input peek) ifFalse: [^nil].  input next.  self spacing ]
PEGParser and		[ ($& == input peek) ifFalse: [^nil].  input next.  self spacing ]
PEGParser not		[ ($! == input peek) ifFalse: [^nil].  input next.  self spacing ]
PEGParser question	[ ($? == input peek) ifFalse: [^nil].  input next.  self spacing ]
PEGParser star		[ ($* == input peek) ifFalse: [^nil].  input next.  self spacing ]
PEGParser plus		[ ($+ == input peek) ifFalse: [^nil].  input next.  self spacing ]
PEGParser open		[ ($( == input peek) ifFalse: [^nil].  input next.  self spacing ]
PEGParser close		[ ($) == input peek) ifFalse: [^nil].  input next.  self spacing ]
PEGParser dot		[ ($. == input peek) ifFalse: [^nil].  input next.  self spacing ]
PEGParser leftAngle	[ ($< == input peek) ifFalse: [^nil].  input next.  self spacing ]
PEGParser rightAngle	[ ($> == input peek) ifFalse: [^nil].  input next.  self spacing ]

PEGParser rightArrow
[
    | pos |
    ($- == input peek) ifFalse: [^nil].
    pos := input position.
    input next.
    ($> == input peek) ifFalse: [^input position: pos].
    input next.
    self spacing.
]

EscapedCharacters := [ IdentityDictionary new
			   at: $t	put:  9;
			   at: $n	put: 10;
			   at: $r	put: 13;
			   yourself ]

DigitRange02 := [ '0-2' asCharacterClass ]
DigitRange07 := [ '0-7' asCharacterClass ]

PEGParser char2
[
    | pos0 pos1 c |
    "eof"
    pos0 := input position.
    (result := input next) ifFalse: [^nil].
    "non-escaped character"
    $\\ == result ifFalse: [^self].
    "octal character"
    pos1 := input position.
    input push: DigitRange02.
    ((self includes and: [input push: DigitRange07.  self includes and: [input push: DigitRange07.  self includes]])
	or: [input position: pos1; push: DigitRange07.
	     (self includes and: [input push: DigitRange07.  self includes or: [true]])])
	ifTrue: [^result := pos1 to: input position inject: 0 into: [:num :tok | num * 8 + (tok - $0)]].
    input position: pos1.
    "eof after backslash"
    (result := input next) ifFalse: [^nil].
    "ansi escape or anonymous escape"
    result := EscapedCharacters at: result ifAbsent: [result].
]

PEGParser char
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

PEGParser string
[
    | open close pos s |
    open := input next.
    close := input next.
    pos := input position.
    open == input peek ifFalse: [^nil].
    s := WriteStream on: (String new: 16).
    input next.
    [close ~~ input peek and: [self char]] whileTrue: [s nextPut: result].
    close == input next ifFalse: [^input position: pos].
    result := s contents.
]

PEGParser range
[
    | pos c1 c2 |
    pos := input position.
    self char ifFalse: [^nil].
    $- == input peek ifFalse: [^result := String with: result].
    input next.
    self char ifFalse: [^input position: pos].
    result := pos text: input position
]

PEGParser class
[
    | pos s |
    $[ == input peek ifFalse: [^nil].
    pos := input position.
    s := WriteStream on: (String new: 16).
    input next.
    [$] ~~ input peek and: [self range]] whileTrue: [s nextPutAll: result].
    $] == input next ifFalse: [^input position: pos].
    self spacing.
    s := s contents.
    result := s size == 1
	ifTrue:  [Array with: #literal with: s first]
	ifFalse: [Array with: #class with: s asCharacterClass]
]

PEGParser literal
[
    | l |
    input push: $'; push: $'.
    self string
	ifFalse:
	   [input push: $"; push: $".
	    self string ifFalse: [^nil]].
    l := result size == 1
	ifTrue:  [Array with: #literal with: result first]
	ifFalse: [Array with: #string  with: result].
    self spacing.
    result := l.
]

Alpha	 := [ 'A-Za-z_' asCharacterClass ]
AlphaNum := [ '0-9A-Za-z_' asCharacterClass ]

PEGParser identifier
[
    | first last |
    first := input position.
    input push: Alpha.
    self includes ifFalse: [^nil].
    [ input push: AlphaNum.
      self includes ]
	whileTrue.
    last := input position.
    self spacing.
    result := (first merge: last as: String) asSymbol.
]

PEGParser argument
[
    ^self identifier
]

PEGParser invocation
[
    | pos p |
    pos := input position.
    self identifier
	ifTrue:
	   [self equal ifTrue: [^input position: pos].
	    ^result := Array with: #invoke with: result].
    self leftAngle	ifFalse:   [^nil].
    self identifier	ifFalse:   [^input position: pos].
    p := OrderedCollection
	with: #invoke
	with: result.
    [self argument]	whileTrue: [p add: result].
    self rightAngle	ifFalse:   [^input position: pos].
    ^result := p asArray
]

PEGParser answer
[
    | pos |
    pos := input position.
    (self rightArrow and: [self identifier]) ifFalse: [^input position: pos].
    result := Array with: #answer with: result.
]

PEGParser primary
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
    self dot		ifTrue:  [^result := Array with: #dot].
    self answer		ifTrue:  [^self].
    ^nil
]

PEGParser suffix
[
    | pos s |
    pos := input position.
    self primary	ifFalse: [^nil].
    s := result.
    self question	ifTrue: [^result := Array with: #zeroOne  with: s].
    self star		ifTrue: [^result := Array with: #zeroMany with: s].
    self plus		ifTrue: [^result := Array with: #oneMany  with: s].
    result := s.
]

PEGParser storable
[
    | pos s |
    self suffix		ifFalse: [^nil].
    $$ == input peek	ifFalse: [^self].
    input next.
    self spacing.
    result := Array with: #text with: result.
]

PEGParser assignment
[
    | pos storable |
    self storable ifFalse: [^nil].
    $: == input peek ifFalse: [^self].
    pos := input position.
    storable := result.
    input next.
    self identifier
	ifFalse:
	   [input position: pos.
	    ^result := storable].
    result := Array with: #store with: result with: storable
]

PEGParser prefix
[
    | pos |
    pos := input position.
    self and
	ifTrue:
	   [self assignment ifFalse: [^input position: pos].
	    ^result := Array with: #and with: result].
    self not
	ifTrue:
	   [self assignment ifFalse: [^input position: pos].
	    ^result := Array with: #not with: result].
    $: == input peek
	ifTrue:
	   [input next.
	    self identifier ifFalse: [^input position: pos].
	    ^result := Array with: #store with: result with: (Array with: #dot)].
    ^self assignment
]

PEGParser sequence
[
    | seq |
    self prefix			ifFalse: [^nil].
    seq := OrderedCollection with: #sequence with: result.
    [self prefix] whileTrue: [seq add: result].
    result := seq size == 2 ifTrue: [seq last] ifFalse: [seq asArray].
]

PEGParser expression
[
    | pos expr |
    pos := input position.
    self sequence		ifFalse: [^nil].
    expr := OrderedCollection with: #alternatives with: result.
    [self bar]
	whileTrue:
	   [self sequence	ifFalse: [^input position: pos].
	    expr add: result].
    result := expr size == 2 ifTrue: [expr last] ifFalse: [expr asArray].
]

PEGParser parameter
[
    | pos |
    $: == input peek ifFalse: [^nil].
    pos := input next; position.
    self identifier ifFalse: [^input position: pos].
]

PEGParser definition
[
    | pos name params locals expr |
    pos := input position.
    self identifier		ifFalse: [^input position: pos].
    name := result.
    params := IdentityDictionary new.
    [self parameter] whileTrue: [params at: result put: true].
    self equal			ifFalse: [^input position: pos].
    self expression		ifFalse: [^input position: pos].
    expr := result.
    self semicolon.
    locals := CollectLocals for: expr.
    params keysDo: [:key | locals at: key put: true].
    locals notEmpty ifTrue: [expr := Array with: #parameters with: params keys asArray with: locals keys asArray with: expr].
    result := Array with: #definition with: name with: expr
]

PEGParser grammar
[
    | pos grammar |
    pos := input position.
    grammar := OrderedCollection with: #grammar.
    self spacing.
    self definition		ifFalse: [^input position: pos].
    grammar add: result.
    [self definition] whileTrue: [grammar add: result].
    result := grammar asArray.
]
