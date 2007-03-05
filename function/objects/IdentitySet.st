" IdentitySet.st -- sets of non-identical objects

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

  Last edited: 2007-03-05 13:05:17 by piumarta on emilia.local
"

{ import: Objects }

IdentitySet : Collection ( tally lists )

IdentitySet lists
[
    ^lists
]

IdentitySet new
[
    ^self new: 1.
]

IdentitySet new: width
[
    self := super new.
    tally := 0.
    lists := Array new: width.
]

IdentitySet size	[ ^tally ]

IdSetDebug := [ 0 ]

IdentitySet add: anObject
[
    | listOffset list |
    listOffset := anObject identityHash \\ lists size.
    list := lists at: listOffset.
    list isNil
	ifTrue:
	   [list := lists at: listOffset put: self newList.
	    tally := tally + 1.
	    ^list at: 0 put: anObject].
    0 to: list size - 1 do: [:offset |
	| elt |
	elt := list at: offset.
	elt == nil
	    ifTrue:
	       [tally := tally + 1.
		^list at: offset put: anObject].
	(self compare: elt with: anObject)
	    ifTrue: [^elt]].
    (IdSetDebug := IdSetDebug + 1) = 20 ifTrue: [self error: 'recursion'].
    self
	grow: list at: listOffset;
	add: anObject.
    IdSetDebug := IdSetDebug - 1.
    ^anObject
]

IdentitySet remove: anObject	[ ^self remove: anObject ifAbsent: [self errorNotFound: anObject] ]

IdentitySet remove: anObject ifAbsent: errorBlock
[
    | listOffset list size |
    listOffset := anObject identityHash \\ lists size.
    list := lists at: listOffset.
    list isNil ifTrue: [^errorBlock value].
    0 to: (listOffset := list size - 1) do: [:offset |
	| elt |
	elt := list at: offset.
	elt == nil ifTrue: [^errorBlock value].
	(self compare: elt with: anObject)
	    ifTrue:
	       [offset to: listOffset - 1 do: [:index | list at: index put: (list at: index + 1)].
		list at: listOffset put: nil.
		^anObject]].
    ^errorBlock value
]

IdentitySet newList	[ ^Array new: 4 ]

IdentitySet grow: list at: listOffset
[
"
    list size * 4 > lists size
	ifTrue:  [self widen]
	ifFalse: [self deepen: list at: listOffset]
"
    self deepen: list at: listOffset
]

IdentitySet findElement: anObject
[
    | listOffset list |
    listOffset := anObject identityHash \\ lists size.
    list := lists at: listOffset.
    list isNil ifTrue: [^nil].
    0 to: list size - 1 do: [:offset |
	| elt |
	elt := list at: offset.
	elt == nil ifTrue: [^nil].
	(self compare: elt with: anObject) ifTrue: [^elt]].
    ^nil
]

IdentitySet compare: anEntry with: anObject
[
    ^anEntry == anObject
]


IdentitySet widen
[
    "StdOut nextPutAll: 'WIDEN '; print: self size; space; print: lists size + 1 * 2 - 1; cr."
    lists := (self new: lists size + 1 * 2 - 1) addAll: self; lists.
]

IdentitySet deepen: list at: listOffset
[
    | newList |
    "StdOut nextPutAll: 'DEEPEN '; print: self size; space; print: self lists size; space; print: list size * 2; cr."
    newList := list new: list size * 2.
    newList replaceFrom: 0 to: list size - 1 with: list startingAt: 0.
    lists at: listOffset put: newList.
]

IdentitySet do: unaryBlock
[
    lists do: [:list | list notNil ifTrue: [list do: [:elt | elt notNil ifTrue: [unaryBlock value: elt]]]]
]

IdentitySet reverseDo: unaryBlock
[
    lists reverseDo: [:list | list notNil ifTrue: [list reverseDo: [:elt | elt notNil ifTrue: [unaryBlock value: elt]]]]
]

IdentitySet includes: anObject
[
    ^(self findElement: anObject) notNil
]


FastIdentitySet : IdentitySet ()

FastIdentitySet newList	[ ^Array new: 1 ]

FastIdentitySet grow: list at: listOffset
[
"
    list size >= 4
	ifTrue:  [self widen]
	ifFalse: [self deepen: list at: listOffset]
"
    self deepen: list at: listOffset
]
