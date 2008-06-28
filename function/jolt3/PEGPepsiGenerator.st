{ import: PEGParser }	"for PEGIterator"

CollectPositions : PEGIterator ( depth max )

CollectPositions max	[ ^max ]

CollectPositions for: aGrammar
[
    self := self new.
    max := depth := 0.
    self preOrderApply: aGrammar.
]

CollectPositions sequence :expr		[ self reservePosition: expr ]
CollectPositions and :expr		[ self reservePosition: expr ]
CollectPositions not :expr		[ self reservePosition: expr ]
CollectPositions text :expr		[ self reservePosition: expr ]
CollectPositions zeroMany :expr		[ self reservePosition: expr ]
CollectPositions oneMany :expr		[ self reservePosition: expr ]

CollectPositions reservePosition: expr
[
    max := max max: (depth := depth + 1).
    super preOrderRest: expr.
    depth := depth - 1
]

CollectPositions reserve		[ ^'pos', (depth := depth + 1) printString ]
CollectPositions release		[  depth := depth - 1 ]

"----------------------------------------------------------------"

ParserGenerator : Object ( grammar output indent bol positions )

ParserGenerator on: aGrammar
[
    self := self new.
    grammar := aGrammar.
    output := StdOut.
    indent := 0.
    bol := true.
]

ParserGenerator print: anObject		[ bol ifTrue: [output tab: indent].  output print:      anObject.  bol := false. ]
ParserGenerator emit: aString		[ bol ifTrue: [output tab: indent].  output nextPutAll: aString.   bol := false. ]
ParserGenerator cr			[ output cr.  bol := true. ]
ParserGenerator space			[ output space ]

ParserGenerator generate
[
    self generate: grammar.
]

ParserGenerator generate: aGrammar
[
    ^self perform: aGrammar first with: aGrammar
]

ParserGenerator grammar :expr		"(grammar defns...)"
[
    self emit: '"THIS FILE WAS GENERATED AUTOMATICALLY -- DO NOT EDIT!"'; cr; cr.
    self emit: '{ import: Object }'; cr; cr.
    self emit: '{ import: Parser }'; cr; cr.
    self emit: 'MyParser : Parser ()'; cr.
    expr from: 1 do: [:defn | self generate: defn].
    self emit: 'MyParser test'; cr;
	emit: '['; cr;
	emit: '    self := self on: StdIn.'; cr;
	emit: '    self start ifTrue: [result println] ifFalse: [''FAIL'' putln].'; cr;
	emit: ']'; cr;
	cr;
	emit: '[ MyParser test ]'; cr
]

ParserGenerator definition :expr	"(definition name expr)"
[
    | body locals params |
    locals := OrderedCollection new.
    body := expr third.
    body first == #parameters
	ifTrue:
	   [params := body second.
	    locals addAll: body third].
    positions := CollectPositions for: expr.
    1 to: positions max do: [:i | locals add: ('pos', i printString) asSymbol].
    self beginDefinition: expr second.
    indent := indent + 1.
    self declareLocals: locals.
    params ifTrue: [params do: [:p | self emit: p; emit: ' := input next.'; cr]].
    self beginBody: expr third.
    self generate: expr third.
    indent := indent - 1.
    self endDefinition: expr second.
]

ParserGenerator parameters :expr	"(parameters (params) (locals) expr)"
[
    self generate: expr fourth.
]

PPG : ParserGenerator ()

PPG beginDefinition: name
[
    self emit: 'MyParser '; emit: name; cr.
    self emit: '['; cr.
]

PPG declareLocals: names
[
    names isEmpty ifTrue: [^self].
    self emit: '|'.
    names do: [:name | self space; emit: name].
    self emit: ' |'; cr.
]

PPG beginBody: expr
[
    self emit: '^'.
]

PPG storeInput: name
[
    self emit: name; emit: ' := input next.'; cr
]

PPG sequence :expr	"(sequence exprs...)"
[
    | last pos |
    pos := positions reserve.
    self emit: '((('; emit: pos; emit: ' := input position)'.
    indent := indent + 1.
    expr from: 1 to: expr size - 1 do: [:e | self cr; emit: 'and: ['; generate: e].
    expr from: 1 to: expr size - 1 do: [:e | self emit: ']'].
    indent := indent - 1.
    self emit: ') or: [input position: '; emit: pos; emit: '])'; cr.
    positions release.
]

PPG alternatives :expr	"(sequence exprs...)"
[
    self emit: '('; generate: expr second.
    indent := indent + 1.
    expr from: 2 to: expr size - 1 do: [:e | self cr; emit: 'or: ['; generate: e].
    expr from: 2 to: expr size - 1 do: [:e | self emit: ']'].
    indent := indent - 1.
    self emit: ')'; cr.
]

PPG and :expr		"(and expr)"
[
    self error: 'not implemented: and'.
]

PPG not :expr		"(not expr)"
[
    | pos |
    pos := positions reserve.
    self
	emit: '((('; emit: pos; emit: ' := input position) and: ['; generate: expr second;
	emit: ']) ifTrue: [input position: '; emit: pos;
	emit: '] ifFalse: [1])'.
    pos := positions release.
]

PPG text :expr		"(text expr)"
[
    | pos |
    pos := positions reserve.
    indent := indent + 1.
    self emit: '((('; emit: pos; emit: ' := input position)'; cr.
    self emit: 'and: ['; generate: expr second; emit: '])'.
    indent := indent + 1.
    self emit: 'ifTrue: [result := '; emit: pos; emit: ' text: input position])'; cr.
    indent := indent - 2.
    positions release.
]

PPG store :expr		"(store name expr)"
[
    self emit: '('; generate: expr third; emit: ' and: ['; emit: expr second; emit: ' := result. 1])'.
]

PPG zeroOne :expr	"(zeroOne expr)"
[
    self emit: '(('; generate: expr second.
    indent := indent + 1.
    self emit: ') ifTrue: [result := Array with: result] ifFalse: [result := #()])'.
    indent := indent - 1.
]

PPG zeroMany :expr	"(zeroMany expr)"
[
    | pos |
    pos := positions reserve.
    self emit: '(('; emit: pos; emit: ' := OrderedCollection new)'; cr.
    indent := indent + 1.
    self emit: 'and: [['; generate: expr second; emit: '] whileTrue: ['; emit: pos; emit: ' add: result].'; cr.
    indent := indent + 1.
    self emit: 'result := '; emit: pos; emit: '])'.
    indent := indent - 2.
    pos := positions release.
]

PPG oneMany :expr	"(oneMany expr)"
[
    | pos |
    pos := positions reserve.
    self emit: '(('; emit: pos; emit: ' := OrderedCollection new)'; cr.
    indent := indent + 1.
    self emit: 'and: [(('; generate: expr second; emit: ') ifTrue: ['; emit: pos; emit: ' add: result. 1])'; cr.
    self emit: 'and: [['; generate: expr second; emit: '] whileTrue: ['; emit: pos; emit: ' add: result].'; cr.
    self emit: '      result := '; emit: pos; emit: '. 1]])'.
    indent := indent - 1.
    pos := positions release.
]

PPG invoke :expr	"(invoke name args...)"
[
    self emit: '(self '; emit: expr second; emit: ')'
]

PPG class :expr		"(class charClass)"
[
    self emit: '(self class: '; emit: expr second printString; emit: ')'
]

PPG string :expr	"(string string)"
[
    self emit: '(self string: '; print: expr second; emit: ')'; cr.
]

PPG literal :expr	"(literal object)"
[
    self emit: '((input peek == '; print: expr second; emit: ') ifTrue: [result := input next])'; cr.
]

PPG answer :expr	"(answer name)"
[
    self emit: '(result := '; emit: expr second; emit: ')'.
]

PPG dot :expr		"(dot)"
[
    self emit: '(input atEnd not and: [result := input next. 1])'; cr.
]

PPG endDefinition: name
[
    self emit: ']'; cr.
]
