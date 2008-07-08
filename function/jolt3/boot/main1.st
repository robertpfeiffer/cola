{ import: Object }
{ import: GrammarParser1 }
{ import: PEGPepsiGenerator }
{ import: PrettyPrint }

[
    | input parser grammar |
    OS arguments do: [:arg |
	input := (File open: arg) tokenStream.
	parser := GrammarParser new.
	(parser start :input) ifFalse: [parser error: 'syntax error near: ', input printString].
	grammar := parser result].
    "StdErr prettyPrint: grammar."
    (PPG on: grammar) generate
]
