" Expression.st -- symbolic expressions

  Copyright (c) 2006, 2007 Ian Piumarta
  All rights reserved.

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the 'Software'),
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, provided that the above copyright notice(s) and this
  permission notice appear in all copies of the Software and that both the
  above copyright notice(s) and this permission notice appear in supporting
  documentation.

  THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.

  Last edited: 2007-02-28 14:45:22 by piumarta on emilia
"

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
