" Dictionary.st -- sets of associations indexable by unequal key

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

  Last edited: 2005-12-19 10:44:44 by piumarta on margaux.local
"

{ import: Set }
{ import: Association }
{ import: OrderedCollection }

Dictionary : Set ()

Dictionary associationAt: key	[ ^self associationAt: key ifAbsent: [self errorKeyNotFound] ]

Dictionary associationAt: key ifAbsent: aBlock
[
    "Answer the association with the given key.  If key is not found,
     return the result of evaluating aBlock."
    | index assoc |
    index := self findElementOrNil: key.
    assoc := array at: index.
    ^nil == assoc
	ifTrue:  [aBlock value]
	ifFalse: [assoc]
]

Dictionary at: key
[
    "Answer the value associated with the key."
    ^self at: key ifAbsent: [self errorKeyNotFound]
]

Dictionary at: key ifAbsent: aBlock 
[
    "Answer the value associated with the key or, if key isn't found,
     answer the result of evaluating aBlock."
    | assoc |
    assoc := array at: (self findElementOrNil: key).
    ^nil == assoc
	ifTrue:  [aBlock value]
	ifFalse: [assoc value]
]

Dictionary at: key put: anObject
[
    "Set the value at key to be anObject.  If key is not found, create
     a new entry for key and set is value to anObject. Answer
     anObject."
    | index assoc |
    index := self findElementOrNil: key.
    assoc := array at: index.
    nil == assoc
	ifTrue:  [self atNewIndex: index put: (Association withKey: key value: anObject)]
	ifFalse: [assoc value: anObject].
    ^anObject
]

Dictionary keys
[
    | keySet |
    keySet := Set new: self size.
    self keysDo: [:key | keySet add: key].
    ^keySet
]

Dictionary values
[
    | valueArray |
    valueArray := Array new: self size.
    self doWithIndex: [:value :index | valueArray at: index put: value].
    ^valueArray
]

Dictionary includesKey: key
[
    self at: key ifAbsent: [^false].
    ^true
]

Dictionary add: anAssociation
[
    | index element |
    index := self findElementOrNil: anAssociation key.
    element := array at: index.
    nil == element
    	ifTrue:  [self atNewIndex: index put: anAssociation]
    	ifFalse: [element value: anAssociation value].
    ^anAssociation
]

Dictionary addAll: aDictionary
[
    aDictionary == self ifFalse: [aDictionary associationsDo: [:assoc | self add: assoc]].
    ^aDictionary.
]

Dictionary associationsDo: aBlock
[
    super do: aBlock
]

Dictionary collect: aBlock
[
    "Evaluate aBlock with each of my values as the argument.  Collect the
    resulting values into a collection that is like me. Answer with the new
    collection."
    | newCollection |
    newCollection := OrderedCollection new: self size.
    self do: [:each | newCollection add: (aBlock value: each)].
    ^newCollection
]

Dictionary do: aBlock
[
    super do: [:assoc | aBlock value: assoc value]
]

Dictionary keysAndValuesDo: aBlock
[
    ^self associationsDo: [:assoc | aBlock value: assoc key value: assoc value]
]

Dictionary keysDo: aBlock
[
    self associationsDo: [:association | aBlock value: association key]
]

Dictionary select: aBlock 
[
    "Evaluate aBlock with each of my values as the argument.  Collect into a
     new Dictionary all associations for which aBlock evaluates to true."
    | newCollection |
    newCollection := self species new.
    self associationsDo: [:assoc | (aBlock value: assoc value) ifTrue: [newCollection add: assoc]].
    ^newCollection
]

Dictionary valuesDo: aBlock 
[
    self associationsDo: [:assoc | aBlock value: assoc value]
]

Dictionary printElementsOn: aStream
[
    aStream nextPut: $(.
    self keysDo: [:key | aStream print: key; nextPutAll: '->'; print: (self at: key); space].
    self isEmpty ifFalse: [aStream skip: -1].
    aStream nextPut: $)
]

Dictionary errorKeyNotFound
[
    self error: 'key not found'
]

Dictionary errorValueNotFound
[
    self error: 'value not found'
]

Dictionary keyAt: index
[
    "May be overridden by subclasses so that fixCollisions will work"
    | assoc |
    assoc := array at: index.
    ^nil == assoc ifFalse: [assoc key]
]

Dictionary noCheckAdd: anObject
[
    array at: (self findElementOrNil: anObject key) put: anObject.
    tally := tally + 1.
]

Dictionary rehash
[
    | newSelf |
    newSelf := self species new: self size.
    self associationsDo: [:each | newSelf noCheckAdd: each].
    array := newSelf array
]

Dictionary scanFor: anObject
[
    "Scan the key array for the first slot containing either a nil
     (indicating an empty slot) or an element that matches
     anObject. Answer the index of that slot or zero if no slot is
     found. This method will be overridden in various subclasses that
     have different interpretations for matching elements."
    | element start finish |
    start := (anObject hash \\ array size) + 1.
    finish := array size.
    "Search from (hash mod size) to the end."
    start to: finish do: [:index |
	((element := array at: index) == nil or: [element key = anObject])
	    ifTrue: [^index]].
    "Search from 1 to where we started."
    1 to: start - 1 do: [:index |
	((element := array at: index) == nil or: [element key = anObject])
	    ifTrue: [^index]].
    ^0
]

Dictionary = aDictionary
[
    aDictionary isDictionary ifFalse: [^false].
    self size = aDictionary size ifFalse: [^false].
    self associationsDo: [:assoc|
	(aDictionary at: assoc key ifAbsent: [^false]) = assoc value
	    ifFalse: [^false]].
    ^true
]

Dictionary removeKey: key 
[
    ^self removeKey: key ifAbsent: [self errorKeyNotFound]
]

Dictionary removeKey: key ifAbsent: aBlock 
[
    "Remove key (and its associated value) from the receiver.  If key
     is not in the receiver, answer the result of evaluating aBlock.
     Otherwise, answer the value named by key."
    | index assoc |
    index := self findElementOrNil: key.
    assoc := array at: index.
    assoc == nil ifTrue: [^aBlock value].
    array at: index put: nil.
    tally := tally - 1.
    self fixCollisionsFrom: index.
    ^assoc value
]
