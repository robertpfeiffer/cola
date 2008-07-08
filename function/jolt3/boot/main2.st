{ import: Object }
{ import: GrammarParser2 }
{ import: PepsiGrammarGenerator2 }

[
    | input parser grammar |
    OS arguments do: [:arg |
	input := (File open: arg) tokenStream.
	parser := PepsiGrammarGenerator new.
	(parser start :input) ifFalse: [parser error: 'syntax error near: ', input printString].
	grammar := parser result].
]
