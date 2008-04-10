{ import: Object }

Parser : Object ( input mark rule result results actions debug )

Parser on: aCollection
[
    self := self new.
    input := aCollection readStream.
    mark := 0.
    results := OrderedCollection new.
    actions := WriteStream on: (Array new: 8).
    debug := OrderedCollection new.
]

Parser on: aCollection rule: aRule
[
    self := self on: aCollection.
    rule := aRule.
]

Parser next
[
    rule ifFalse: [self error: 'parser has no default rule'].
    ^self next: rule
]

Parser next: aRule
[
    result := nil.
    ^(aRule parse: self) ifTrue: [self commit]
]

Parser newInput: aStream
[
    | prev |
    prev := Array with: input with: mark.
    input := aStream.
    mark := 0.
    ^prev
]

Parser oldInput: aStreamAndMark
[
    input := aStreamAndMark first.
    mark := aStreamAndMark second.
]

"
depth := [ 0 ]
Parser enter: aSymbol	[ StdOut space: depth; nextPutAll: '-> '.  debug addLast: aSymbol println.  depth := depth + 1 ]
Parser leave: aSymbol	[ StdOut space: depth; nextPutAll: '<- '.  debug removeLast println.  depth := depth - 1 ]
"
Parser enter: aSymbol	[ debug addLast: aSymbol ]
Parser leave: aSymbol	[ debug removeLast ]

Parser backtrace
[
    debug do: [:s | s println].
]

Parser readPosition	[ ^input position ]
Parser actionPosition	[ ^actions position ]

Parser readPosition: rp actionPosition: ap
[
    input position: rp.
    actions position: ap.
    ^nil
]

Parser noteAction: pe		[ actions nextPut: pe ]

Parser result: anObject		[  result := anObject ]
Parser result			[ ^result ]

Parser push: n			[ n timesRepeat: [results addFirst: nil] ]
Parser pop: n			[ n timesRepeat: [results removeFirst] ]
Parser storeResult: anInteger	[  results at: anInteger put: result ]
Parser @ anInteger		[ ^results at: anInteger ]

Parser input				[ ^input ]
Parser last				[ ^input last ]
Parser atEnd				[ ^input atEnd ]
Parser contents				[ ^input contentsFrom: input position to: mark ]
Parser contentsFrom: anIndex		[ ^input contentsFrom: anIndex ]
Parser contentsFrom: anIndex to: aLimit	[ ^input contentsFrom: anIndex to: aLimit ]

Parser matchAny			[ mark := mark max: input position.  ^(input matchAny) ]
Parser matchRest		[ mark := mark max: input position.  ^(input matchRest) ]
Parser match: anObject		[ mark := mark max: input position.  ^(input match: anObject) ]
Parser matchEqual: anObject	[ mark := mark max: input position.  ^(input matchEqual: anObject) ]
Parser matchClass: cClass	[ mark := mark max: input position.  ^(input matchClass: cClass) ]

Parser commit
[
    results size > 0 ifTrue: [StdErr nextPutAll: 'parser results not empty before commit'].
    actions contents do: [:action | action parse: self].
    results size > 0 ifTrue: [StdErr nextPutAll: 'parser results not empty after commit'].
    ^result
]

Parser error: message
[
    StdOut cr.
    self backtrace.
    super error: message , ' near: ', self errorContents asString
]

Parser errorContents
[
    ^self contentsFrom: ((mark - 10 max: 0) min: input position) to: mark
]

Parser setResultFromFunction_: _function
{
    self->v_result= ((oop(*)())v__function)(v__closure, self, self, self->v_result);
}
