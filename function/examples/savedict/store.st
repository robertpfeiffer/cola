{ import: Object }

IdentityDictionary saveTo: aStream
[
    self do: [:assoc | aStream nextPutAll: assoc key; nextPut: $,; print: assoc value; cr]
]

[
    | dict file |
    (dict := IdentityDictionary new)
	at: #one	put: 1;
	at: #two	put: 2;
	at: #three	put: 3;
	at: #four	put: 4;
	at: #five	put: 5;
	at: #six	put: 6.

    file := File create: 'storage.txt'.
    dict saveTo: file.
    file close.
]
