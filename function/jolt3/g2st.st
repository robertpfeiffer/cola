{ import: Object }
{ import: GrammarParser }
{ import: PepsiGrammarGenerator }

[
    | parser input |
    OS arguments do: [:arg |
	parser := PepsiGrammarGenerator new.
	input := (File open: arg) tokenStream.
	(parser start :input) ifFalse: [parser error: 'syntax error near: ', input printString]].
]
