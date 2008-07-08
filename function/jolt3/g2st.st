{ import: Object }
{ import: PepsiGrammarGenerator }

[
    | parser input grammar |
    OS arguments do: [:arg |
	parser := PepsiGrammarGenerator new.
	input := (File open: arg) tokenStream.
	(parser start :input) ifFalse: [parser error: 'syntax error near: ', input printString].
	grammar := parser result].
]
