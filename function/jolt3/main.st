{ import: Object }
{ import: PEGParser }
{ import: PEGInterpreter }

File prettyPrint: o		[ o prettyPrintOn: self at: 0.  self cr ]

Object prettyPrintOn: s at: i	[ self printOn: s ]

SequenceableCollection prettyPrintOn: s at: i
[
    | ol nl |
    s nextPut: $(.
    self isEmpty ifTrue: [^s nextPut: $)].
    i := i + 2.
    self do: [:elt |
	(elt isComplex and: [self notEmpty]) ifTrue: [nl := true].
	nl ifTrue: [s cr; space: i] ifFalse: [ol ifTrue: [s space] ifFalse: [ol := true]].
	elt prettyPrintOn: s at: i].
    s nextPut: $)
]

String prettyPrintOn: s at: i	[ s nextPutAll: self ]
Symbol prettyPrintOn: s at: i	[ s nextPutAll: self ]

Object			isComplex	[ ^nil ]
String			isComplex	[ ^nil ]
Symbol			isComplex	[ ^nil ]
SequenceableCollection	isComplex	[ ^self detect: [:e | e isArray] ifAbsent: [] ]

"----------------------------------------------------------------"

{ import: PEGPepsiGenerator }

PEGParser test
[
    | parser grammar |
    self := self on: (File open: (OS argumentAt: 1)).
    self grammar ifFalse: [^nil].
    grammar := result.
    StdErr prettyPrint: grammar.
""
    parser := PEGInterpreter on: grammar.
    (parser parse: StdIn) ifFalse: [StdErr nextPutAll: 'FAIL\n'].
    StdErr println: parser result.
""
    (PPG on: grammar) generate
]

[ PEGParser test ]
