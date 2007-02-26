" AVLTree.st -- balanced trees

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

  Last edited: 2007-01-25 03:17:27 by piumarta on emilia.local
"

{ import: Object }

AVLTreeNode : Object ( left right height value )

AVLTreeNode left		[ ^left ]
AVLTreeNode left: aNode		[ ^left := aNode ]
AVLTreeNode right		[ ^right ]
AVLTreeNode right: aNode	[ ^right := aNode ]
AVLTreeNode height		[ ^height ]
AVLTreeNode value		[ ^value ]

AVLTreeNode initialize
[
    super initialize.
    left := right := nil.
    height := 0.
    value := nil.
]

AVLTreeNode withValue: anObject
[
    self := self new.
    value := anObject.
]

AVLTreeNode precedes: aNode orderedBy: binaryBlock 	[ ^binaryBlock value: self value value: aNode value ]

AVLTreeNode equals: aNode orderedBy: binaryBlock
[
    | l r lr rl |
    l  := self value.
    r  := aNode value.
    lr := binaryBlock value: l value: r.
    rl := binaryBlock value: r value: l.
    "Partial order (<=): l = r  =>      (l <= r) and     (l >= r)  =>       lr  and      rl."
    "Strict  order (< ): l = r  =>  not (l <  r) and not (l >  r)  =>  not (lr) and not (rl)."
    "Augustus tells us the latter really means l = r  =>  not (lr or rl), saving us one send."
    ^(lr and: [rl]) or: [(lr or: [rl]) not]
]

UndefinedObject avlTreeNodeInsert: aNode orderedBy: binaryBlock
[
    ^aNode
]

AVLTreeNode avlTreeNodeInsert: aNode orderedBy: binaryBlock
[
    (aNode precedes: self orderedBy: binaryBlock)
	ifTrue:  [left  := left  avlTreeNodeInsert: aNode orderedBy: binaryBlock]
	ifFalse: [right := right avlTreeNodeInsert: aNode orderedBy: binaryBlock].
    ^self balance
]

UndefinedObject avlTreeNodeHeight	[ ^0 ]
AVLTreeNode avlTreeNodeHeight		[ ^height ]

AVLTreeNode delta			[ ^left avlTreeNodeHeight - right avlTreeNodeHeight ]

AVLTreeNode balance
[
    | delta |
    delta := self delta.
    delta < -1
	ifTrue:
	   [right delta > 0 ifTrue: [right := right rotateRight].
	    ^self rotateLeft].
    delta > 1
	ifTrue:
	   [left delta < 0 ifTrue: [left := left rotateLeft].
	    ^self rotateRight].
    height := 0.
    (left  notNil and: [left  height > height]) ifTrue: [height := left  height].
    (right notNil and: [right height > height]) ifTrue: [height := right height].
    height := height + 1.
]

AVLTreeNode rotateLeft
[
    | pivot |
    pivot := right.
    right := pivot left.
    pivot left: self balance.
    ^pivot balance
]

AVLTreeNode rotateRight
[
    | pivot |
    pivot := left.
    left := pivot right.
    pivot right: self balance.
    ^pivot balance
]

UndefinedObject avlTreeNodeFind: aNode
[
    ^nil
]

AVLTreeNode avlTreeNodeFind: aNode orderedBy: binaryBlock
[
    (self equals:aNode orderedBy: binaryBlock) ifTrue: [^self].
    ^(aNode precedes: self orderedBy: binaryBlock)
	ifTrue:  [left  avlTreeNodeFind: aNode orderedBy: binaryBlock]
	ifFalse: [right avlTreeNodeFind: aNode orderedBy: binaryBlock]
]

UndefinedObject avlTreeNodeRemove: aNode orderedBy: binaryBlock
[
    ^nil
]

AVLTreeNode remove: aNode orderedBy: binaryBlock
[
    (aNode equals: self orderedBy: binaryBlock)
	ifTrue:
	   [| temp |
	    temp := left avlTreeNodeMoveRight: right.
	    left := right := nil.
	    ^temp].
    (aNode precedes: self orderedBy: binaryBlock)
	ifTrue:  [left  := left  avlTreeNodeRemove: aNode orderedBy: binaryBlock]
	ifFalse: [right := right avlTreeNodeRemove: aNode orderedBy: binaryBlock].
    ^self balance
]

UndefinedObject avlTreeNodeMoveRight: aNode
[
    ^aNode
]

AVLTreeNode avlTreeNodeMoveRight: aNode
[
    right := right avlTreeNodeMoveRight: aNode.
    ^self balance
]

UndefinedObject avlTreeNodeDo: unaryBlock
[
    ^nil
]

AVLTreeNode avlTreeNodeDo: unaryBlock
[
    left avlTreeNodeDo: unaryBlock.
    unaryBlock value: value.
    right avlTreeNodeDo: unaryBlock.
]

UndefinedObject avlTreeNodeReverseDo: unaryBlock
[
    ^nil
]

AVLTreeNode avlTreeNodeReverseDo: unaryBlock
[
    right avlTreeNodeReverseDo: unaryBlock.
    unaryBlock value: value.
    left avlTreeNodeReverseDo: unaryBlock.
]

AVLTreeNode print
[
    ^value print.
]

AVLTreeNode printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPut: $(;
	print: value;
	nextPut: $)
]


AVLTree : SequenceableCollection ( rootNode orderBlock )

AVLTree withSortBlock: binaryBlock
[
    self := self new.
    orderBlock := binaryBlock.
]

AVLTree initialize
[
    super initialize.
    rootNode   := nil.
    orderBlock := [:a :b | a < b].
]

AVLTree isEmpty
[
    ^rootNode isNil
]

AVLTree add: anObject
[
    self addNode: (AVLTreeNode withValue: anObject).
    ^anObject
]

AVLTree addNode: aNode
[
    rootNode := rootNode avlTreeNodeInsert: aNode orderedBy: orderBlock.
    ^aNode
]

AVLTree depth			[ ^rootNode avlTreeNodeHeight ]

AVLTree find: anObject		[ ^self findNode: (AVLTreeNode with: anObject) ]
AVLTree findNode: aNode		[ ^rootNode avlTreeNodeFind: aNode orderedBy: orderBlock ]

AVLTree remove: anObject	[ ^self removeNode: (AVLTreeNode withValue: anObject) ]
AVLTree removeNode: aNode	[ ^rootNode := rootNode avlTreeNodeRemove: aNode orderedBy: orderBlock ]

AVLTree do: unaryBlock		[ ^rootNode avlTreeNodeDo: unaryBlock ]
AVLTree reverseDo: unaryBlock	[ ^rootNode avlTreeNodeReverseDo: unaryBlock ]

AVLTree print			[ ^rootNode print ]
