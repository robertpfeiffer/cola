{ import: Object }

IdentityDictionary loadFrom: aStream
[
    | key value |
    [aStream atEnd]
	whileFalse:
	   [key := aStream upTo: $,.
	    value := aStream upTo: $\n.
	    self at: key asSymbol put: (Integer fromString: value)].
]

[
    | file stream dict |
    file := File open: 'storage.txt'.
    stream := file contents asString readStream.
    file close.
    (dict := IdentityDictionary new) loadFrom: stream.
    dict println.
]
