{ import: Object }

ParserAction : Object (
    "I represent a semantic action to be run when a parser has recognised a complete sentence."
    block	"Block implementing my semantic action"
    start	"Integer index of start of saved source range"
    end		"Integer index of (one past) end of saved source range"
    stream	"ParseStream"
    text	"ArrayedCollection"
)

ParserAction withBlock: aBlock from: firstIndex to: lastIndex
[
    self := self new.
    block  := aBlock.
    start  := firstIndex.
    end    := lastIndex.
]

ParserAction runWithStream: aStream
[
    stream := aStream.
    ^block value: self
]

ParserAction text				[ ^text ifNil: [text := stream copyFrom: start to: end - 1] ]
ParserAction store: integerIndex		[  stream store: integerIndex ]
ParserAction @ integerIndex			[ ^stream @ integerIndex ]

"----------------------------------------------------------------"

File collectionType			[ ^String ]
ArrayedCollection collectionType	[ ^self ]
OrderedCollection collectionType	[ ^Array ]
ReadStream collectionType		[ ^collection collectionType ]

IndexableStream : Object (
    "This should be a kind of WriteStream."
    collection		"ArrayedCollection of the objects that I stream over."
    readPosition	"Integer index of the next position to read from my collection."
    writePosition	"Integer index of the next position to written to my collection."
    writeLimit		"Integer index of the position after the last writable object in my collection."
)

IndexableStream on: aCollection
[
    self := self new.
    writeLimit := (collection := aCollection) size.
    readPosition := writePosition := 0.
]

IndexableStream readPosition			[ ^readPosition ]
IndexableStream readPosition: integerIndex	[ ^readPosition := integerIndex]
IndexableStream writePosition			[ ^writePosition ]

IndexableStream next
[
    | token |
    (token := self peek) ifTrue: [readPosition := readPosition + 1].
    ^token
]

IndexableStream peek			[ ^(readPosition < writePosition or: [self refill]) ifTrue: [collection at: readPosition] ]
IndexableStream refill			[ ^nil ]
IndexableStream skip: integerOffset	[ readPosition := readPosition + integerOffset ]

IndexableStream at: offset
[
    | index |
    index := readPosition + offset.
    [writePosition <= index and: [self refill]] whileTrue.
    ^index < writePosition ifTrue: [collection at: index].
]

IndexableStream nextPut: token
[
    writePosition == writeLimit ifTrue: [self grow].
    collection at: writePosition put: token.
    writePosition := writePosition + 1.
    ^token
]

IndexableStream grow
[
    collection := (collection new: writeLimit * 2)
	replaceFrom: 0
	to:	     writeLimit - 1
	with:	     collection
	startingAt:  0.
    writeLimit := writeLimit * 2.
]

IndexableStream reset
[
    readPosition := 0.
]

IndexableStream truncate
[
    readPosition > (writePosition // 2)
	ifTrue:
	   [collection replaceFrom: 0 to: writePosition - readPosition - 1 with: collection startingAt: readPosition.
	    writePosition := writePosition - readPosition.
	    readPosition  := 0]
]

IndexableStream contents
[
    ^collection copyFrom: readPosition to: writePosition - 1
]

"-----------------------------------------------------------"

ParseStream : IndexableStream (
    source		"Stream from which I fetch new objects to write to my collection."
    start		"Integer position last saved as token range start."
    end			"Integer position last saved as token range end."
    actions		"WriteStream containing ParserActions to be evaluated when changes are committed."
    result		"Object result from last action."
    results		"OrderedCollection (indexable) of saved results from previous actions."
)

ParseStream on: aStreamOrCollection
[
    self := super on: (aStreamOrCollection collectionType new: 32).
    source := aStreamOrCollection readStream.
    start := end := 0.
    actions := WriteStream on: (Array new: 32).
    results := OrderedCollection new: 32.
]

ParseStream source			[ ^source ]

ParseStream result: anObject		[ ^result := anObject ]
ParseStream result			[ ^result ]

ParseStream noteStart			[ start := readPosition ]
ParseStream noteEnd			[ end   := readPosition ]
ParseStream noteDelayedValue: aBlock	[ actions nextPut: (ParserAction withBlock: aBlock from: start to: end) ]

ParseStream text			[ ^end > start ifTrue: [collection copyFrom: start to: end - 1] ]

ParseStream actionPosition		[ ^actions position ]

ParseStream readPosition: sourcePosition actionPosition: actionPosition
[
    readPosition := sourcePosition.
    actions position: actionPosition.
]

ParseStream refill
[
    | token |
    ^(token := source next) ifTrue: [self nextPut: token "put"]
]

"
ParseStream nextPut: anObject	[ StdOut nextPut: $<; print: anObject; nextPut: $>.  ^super nextPut: anObject ]
ParseStream peek		[ | c |  c := super peek.  StdOut nextPut: ${; print: c; nextPut: $}.  ^c ]
"

ParseStream pushImmediate: count	[ count timesRepeat: [results addFirst: nil].  ^result ]
ParseStream popImmediate: count		[ count timesRepeat: [results removeFirst].    ^result ]

ParseStream store: index		[ "StdOut print: index; nextPutAll: ' := '; println: result."			 results at: index put: result ]
ParseStream @ index			[ "StdOut print: index; nextPutAll: ' == '; println: (results at: index)."	^results at: index ]

ParseStream copyFrom: first to: last
[
    ^first <= last ifTrue: [collection copyFrom: first to: last]
]

ParseStream accept
[
    actions collection
	from: 0
	to:   actions position - 1
	do:   [:action | result := action runWithStream: self].
    actions reset.
    super truncate.
    ^result
]

File			parseStream	[ ^ParseStream on: self ]
SequenceableCollection	parseStream	[ ^ParseStream on: self ]
ParseStream		parseStream	[ ^self ]
