" Collection.st -- behaviour common to all collections

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

  Last edited: 2008-06-09 12:49:53 by piumarta on emilia
"

{ import: Objects }

Collection isEmpty	[ ^self size == 0 ]
Collection notEmpty	[ ^self isEmpty not ]

Collection emptyCheck
[
    self isEmpty ifTrue: [self error: 'this collection is empty']
]

Collection addAll: aCollection		[ aCollection do: [:elt | self add: elt] ]
Collection removeAll: aCollection	[ aCollection do: [:elt | self remove: elt] ]

Collection minimum: valueBlock
[
    | minElement minValue |
    self emptyCheck.
    minElement := self anyElement.
    minValue := valueBlock value: minElement.
    self do: [:element || value |
	(value := valueBlock value: element) < minValue
	    ifTrue:
	       [minElement := element.
		minValue := value]].
    ^minElement
]

Collection printOn: aStream
[
    aStream nextPutAll: self debugName.
    self printContentsOn: aStream.
]

Collection printContentsOn: aStream
[
    aStream nextPut: $(.
    self do: [:element | element printOn: aStream] separatedBy: [aStream space].
    aStream nextPut: $).
]

Collection do: elementBlock separatedBy: betweenBlock
[
    | first |
    first := true.
    self do: [:element |
	first ifTrue: [first := false] ifFalse: [betweenBlock value].
	elementBlock value: element].
]

Collection includes: anObject
[
    self do: [:element | element == anObject ifTrue: [^true]].
    ^false
]

Collection readStream	[ ^ReadStream on: self ]
Collection writeStream	[ ^WriteStream on: self ]
