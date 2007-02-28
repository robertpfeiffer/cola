{ import: Objects }

Expression : Array ()

Object isExpression		[ ^false ]
Expression isExpression		[ ^true ]

Object asExpression		[]
Expression asExpression		[]

Expression printOn: aStream
[
    super printContentsOn: aStream.
]

Array asExpression
[
    | expr |
    expr := Expression new: self size.
    0 to: self size - 1 do: [:i | expr at: i put: (self at: i) asExpression].
    ^expr
]

Object withParameters: aCollection	[]

Array withParameters: aCollection
[
    | in out |
    in  := ReadStream on: self.
    out := WriteStream on: (self new: self size).
    [in atEnd]
	whileFalse:
	   [out nextPut: ((in peek == #':'
			       ifTrue:  [aCollection at: (in next; next)]
			       ifFalse: [in next])
			      withParameters: aCollection)].
    ^out contents
]
