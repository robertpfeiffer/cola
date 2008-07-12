{ import: PEGIterator }

CollectPositions : PEGIterator ( depth max )

CollectPositions max	[ ^max ]

CollectPositions for: aGrammar
[
    self := self new.
    max := depth := 0.
    self preOrderApply: aGrammar.
]

CollectPositions sequence :node		[ self reservePosition: node ]
CollectPositions and :node		[ self reservePosition: node ]
CollectPositions not :node		[ self reservePosition: node ]
CollectPositions text :node		[ self reservePosition: node ]
CollectPositions zeroMany :node		[ self reservePosition: node ]
CollectPositions oneMany :node		[ self reservePosition: node ]
CollectPositions structure :node	[ self reservePosition: node ]

CollectPositions reservePosition: node
[
    max := max max: (depth := depth + 1).
    super preOrderRest: node.
    depth := depth - 1
]

CollectPositions reserve		[ ^'pos', (depth := depth + 1) printString ]
CollectPositions release		[  depth := depth - 1 ]

"----------------------------------------------------------------"

ParserGenerator : Object ( grammar grammarName output positions )

ParserGenerator on: aGrammar
[
    self := self new.
    grammar := aGrammar.
    output := StdOut.
]

ParserGenerator print: anObject		[ output print: anObject. ]
ParserGenerator printEscaped: aString	[ aString printEscapedOn: output ]
ParserGenerator emit: aString		[ output nextPutAll: aString. ]
ParserGenerator cr			[ output cr. ]
ParserGenerator space			[ output space. ]

ParserGenerator generate		[  self generate: grammar ]

ParserGenerator generate: expr
[
    expr ifFalse: [^self error: 'empty expr'].
    expr isGroup ifFalse: [^self error: 'expr is not group'].
    self perform: expr first with: expr.
]

PPG : ParserGenerator ()

PPG grammar :node		"(grammar (declaration name base (vars...)) defns...)"
[
    | decl base vars |
    self emit: '"THIS FILE WAS GENERATED AUTOMATICALLY -- DO NOT EDIT!"'; cr; cr.
    decl := node second.
    grammarName := decl second.
    base := decl third.
    vars := decl fourth.
    self emit: '{ import: '; emit: base; emit: ' }'; cr.
    self emit: grammarName; emit: ' : '; emit: base; emit: ' ('.
    vars do: [:v | self emit: v] separatedBy: [self space].
    self emit: ')'; cr.
    node from: 2 do: [:subNode | self generate: subNode].
]

PPG definition :node	"(definition name {params} expr)"
[
    | name params locals body |
    name   := node second.
    params := node third.
    body   := node fourth.
    locals := CollectLocals for: body.
    params do: [:n | locals at: n put: true].
    locals := locals keys.
    self emit: grammarName; space; emit: name; emit: ' :inputStream\n['; cr.
    positions := CollectPositions for: body.
    (locals notEmpty or: [positions max > 0])
	ifTrue:
	   [self emit: '|'.
	    locals do: [:n | self space; emit: n].
	    1 to: positions max do: [:i | self emit: ' pos'; print: i].
	    self emit: ' |'; cr].
    params
	ifTrue:
	   [params do: [:n | self emit: n; emit: ' := inputStream next.'; cr]].
    self emit: '^'.
    self generate: body.
    self cr; emit: ']'; cr.
]

PPG sequence :node	"(sequence exprs...)"
[
    | last pos |
    (node hasSize: 2) ifTrue: [^self generate: node second].
    pos := positions reserve.
    self emit: '((('; emit: pos; emit: ' := inputStream position)'.
    node from: 1 do: [:expr | self cr; emit: ' and: ['; generate: expr].
    node from: 1 do: [:expr | self emit: ']'].
    self emit: ')'; cr; emit: ' or: [(inputStream position: '; emit: pos; emit: ')])'.
    positions release.
]

PPG alternatives :node	"(sequence exprs...)"
[
    (node hasSize: 2) ifTrue: [^self generate: node second].
    self emit: '('; generate: node second.
    node from: 2 do: [:e | self cr; emit: ' or: ['; generate: e].
    node from: 2 do: [:e | self emit: ']'].
    self emit: ')'.
]

PPG and :node		"(and expr)"
[
    | pos |
    pos := positions reserve.
    self
	emit: '((('; emit: pos; emit: ' := inputStream position)'; cr; emit: ' and: ['; generate: node second;
	emit: ']) ifTrue: [(inputStream position: '; emit: pos; emit: '). 1])'.
    positions release.
]

PPG not :node		"(not expr)"
[
    | pos |
    pos := positions reserve.
    self
	emit: '((('; emit: pos; emit: ' := inputStream position)'; cr; emit: ' and: ['; generate: node second;
	emit: ']) ifTrue: [(inputStream position: '; emit: pos;
	emit: ')] ifFalse: [1])'.
    positions release.
]

PPG text :node		"(text expr)"
[
    | pos |
    pos := positions reserve.
    self emit: '((('; emit: pos; emit: ' := inputStream position)'.
    self cr; emit: ' and: ['; generate: node second; emit: '])'.
    self emit: ' ifTrue: [result := ('; emit: pos; emit: ' text: inputStream position)])'.
    positions release.
]

PPG store :node		"(store name expr)"
[
    self emit: '('; generate: node third; cr; emit: ' and: ['; emit: node second; emit: ' := result. 1])'.
]

PPG zeroOne :node	"(zeroOne expr)"
[
    self emit: '(('; generate: node second; emit: ') ifTrue: [result := TokenGroup with: result] ifFalse: [result := TokenGroup new])'.
]

PPG zeroMany :node	"(zeroMany expr)"
[
    | pos |
    pos := positions reserve.
    self emit: '(('; emit: pos; emit: ' := TokenGroup new)'.
    self cr; emit: ' and: [['; generate: node second; emit: '] whileTrue: [('; emit: pos; emit: ' add: result)].'.
    self emit: ' (result := '; emit: pos; emit: ')])'.
    positions release.
]

PPG oneMany :node	"(oneMany expr)"
[
    | pos |
    pos := positions reserve.
    self emit: '(('; emit: pos; emit: ' := TokenGroup new)'.
    self cr; emit: ' and: [(('; generate: node second; emit: ') ifTrue: [('; emit: pos; emit: ' add: result). 1])'.
    self cr; emit: ' and: [['; generate: node second; emit: '] whileTrue: [('; emit: pos; emit: ' add: result)]. '.
    self emit: '(result := '; emit: pos; emit: '). 1]])'.
    pos := positions release.
]

PPG invoke :node	"(invoke name args...)"
[
    | isThunk |
    (isThunk := node hasSize: 2)
	ifFalse:
	   [self emit: '((inputStream pushGroup: (TokenGroup new'.
	    node from: 2 do: [:arg | self emit: ' add: '; generate: arg] separatedBy: [self emit: ';'].
	    self emit: ')) ifTrue: ['].
    self emit: '(self '; emit: node second; emit: ' :inputStream)'.
    isThunk
	ifFalse:
	   [self emit: '])'].
]

PPG argvar	:node	"(argvar name)"		[ self emit: node second ]
PPG arglit	:node	"(arglit name)"		[ self print: node second ]
PPG result	:node	"(result expr)"		[ self emit: '(('; generate: node second; emit: ') ifTrue: [result] ifFalse: [result])' ]
PPG literal	:node	"(literal object)"	[ self emit: '((inputStream peek == '; print: node second; emit: ') ifTrue: [result := inputStream next. 1])' ]

PPG string	:node	"(string string)"
[
    | string |
    string := node second.
    (string hasSize: 1)
	ifTrue:  [self emit: '((inputStream peek == '; print: string first; emit: ') ifTrue: [result := inputStream next. 1])']
	ifFalse: [self emit: '(self string: '; printEscaped: string; emit: ' :inputStream)']
]

PPG class	:node	"(class string)"
[
    | string |
    string := node second.
    (string hasSize: 1)
	ifTrue:  [self emit: '((inputStream peek == '; print: string first; emit: ') ifTrue: [result := inputStream next. 1])']
	ifFalse: [self emit: '(self class: '; print: string asCharacterClass; emit: ' :inputStream)']
]

PPG structure :node	"(structure expr)"
[
    | pos |
    pos := positions reserve.
    self
	emit: '((('; emit: pos; emit: ' := inputStream)'; cr; emit: ' and: [(inputStream := self beginStructure: inputStream)'; cr; emit: ' and: [';
	generate: node second;
	emit: ']]) ifTrue: [(result := (inputStream := '; emit: pos; emit: ') next)] ifFalse: [(inputStream := '; emit: pos; emit: '). nil])'.
    positions release.
]

PPG action	:node	"(action text)"		[ self emit: '(['; emit: node second; emit: '. 1] value)' ]
PPG predicate	:node	"(predicate text)"	[ self emit: '(['; emit: node second; emit: '] value)' ]
PPG value	:node	"(value text)"		[ self emit: '((result := ['; emit: node second; emit: '] value)'; emit: ' or: [1])' ]
PPG variable	:node	"(variable name)"	[ self emit: '((result := '; emit: node second; emit: ')'; emit: ' or: [1])' ]
PPG character	:node	"(character char)"	[ self emit: '((result := '; print: node second; emit: ')'; emit: ' or: [1])' ]
PPG dot		:node	"(dot)"			[ self emit: '(inputStream notAtEnd and: [result := inputStream next. 1])' ]

PPG group :node	"(group elts...)"
[
    self emit: '((result := TokenGroup new)'.
    node from: 1 do: [:elt | self generate: elt] separatedBy: [self emit: ';'].
    self emit: ')'
]

PPG unigroup :node	"(unigroup elt)"
[
    self emit: '(result := ((TokenGroup new)'.
    node from: 1 do: [:elt | self generate: elt] separatedBy: [self emit: ';'].
    self emit: ') first)'
]

PPG subgroup :node	"(subgroup elts...)"
[
    self emit: ' add: (TokenGroup new'.
    node from: 1 do: [:elt | self generate: elt] separatedBy: [self emit: ';'].
    self emit: ')'
]

PPG symbol		:node	"(symbol sym)"		[ self emit: ' add: ';    print: node second ]
PPG unquote		:node	"(unquote sym)"		[ self emit: ' add: ';    emit:  node second ]
PPG unquoteSplicing	:node	"(unquoteSplicing sym)"	[ self emit: ' concat: '; emit:  node second ]
PPG unquoteString	:node	"(unquoteString sym)"	[ self emit: ' add: (';	  emit:  node second; emit: ' asString)' ]
PPG unquoteSymbol	:node	"(unquoteSymbol sym)"	[ self emit: ' add: (';	  emit:  node second; emit: ' asSymbol)' ]
PPG unquoteNumber	:node	"(unquoteNumber sym)"	[ self emit: ' add: (Integer fromString: '; emit: node second; emit: ')' ]
