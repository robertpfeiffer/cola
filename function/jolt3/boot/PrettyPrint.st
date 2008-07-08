{ import: Objects }

File prettyPrint: o		[ o prettyPrintOn: self at: 0.  self cr ]

Object prettyPrintOn: s at: i	[ self printOn: s ]

SequenceableCollection prettyPrintOn: s at: i
[
    | ol nl |
    s nextPut: $(.
    self isEmpty ifTrue: [^s nextPut: $)].
    i := i + 2.
    self do: [:elt |
	(elt prettyPrintsOnNewLine and: [self notEmpty]) ifTrue: [nl := true].
	nl ifTrue: [s cr; space: i] ifFalse: [ol ifTrue: [s space] ifFalse: [ol := true]].
	elt prettyPrintOn: s at: i].
    s nextPut: $)
]

String prettyPrintOn: s at: i	[ s nextPutAll: self ]
Symbol prettyPrintOn: s at: i	[ s nextPutAll: self ]

Object			prettyPrintsOnNewLine	[ ^nil ]
String			prettyPrintsOnNewLine	[ ^nil ]
Symbol			prettyPrintsOnNewLine	[ ^nil ]
SequenceableCollection	prettyPrintsOnNewLine	[ ^self detect: [:e | e isArray] ifAbsent: [] ]
