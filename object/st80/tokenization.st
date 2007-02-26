" tokenization.st -- Stream-based tokenisation

  Copyright (c) 2005 Ian Piumarta
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

  Last edited: 2006-03-31 14:01:01 by piumarta on emilia.local
"

{ import: Array }
{ import: OrderedCollection }
{ import: WriteStream }

SequenceableCollection firstToken: delimiters
[
    | in out |
    in := self readStream.
    out := self species new writeStream.
    [in atEnd not and: [delimiters includes: in peek]] whileTrue: [in next].
    [in atEnd not and: [(delimiters includes: in peek) not]] whileTrue: [out nextPut: in next].
    ^out contents
]

SequenceableCollection tokenized: delimiters
[
    | in out tokens |
    in := self readStream.
    out := self species new writeStream.
    tokens := OrderedCollection new.
    [in atEnd]
	whileFalse:
	  [ [in atEnd not and: [delimiters includes: in peek]] whileTrue: [in next].
	    [in atEnd not and: [(delimiters includes: in peek) not]] whileTrue: [out nextPut: in next].
	    out isEmpty ifFalse: [tokens add: out contents].
	    out resetToStart ].
    ^tokens
]

SequenceableCollection delimited: delimiter
[
    | first out |
    out := self species new writeStream.
    first := true.
    self do: [:element |
        first ifTrue: [first := false] ifFalse: [out nextPut: delimiter].
        out nextPut: element].
    ^out contents
]

SequenceableCollection flattened
[
    | len out |
    self emptyCheck.
    len := 0.
    self do: [:element | len := len + element size].
    out := (self first species new: len) writeStream.
    self do: [:element | out nextPutAll: element].
    ^out contents
]
