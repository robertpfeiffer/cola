{ import: Objects }

ArrayedCollection with: a
[
    ^(self new: 1)
	at: 0 put: a;
	yourself
]

ArrayedCollection with: a with: b
[
    ^(self new: 2)
	at: 0 put: a;
	at: 1 put: b;
	yourself
]

ArrayedCollection with: a with: b with: c
[
    ^(self new: 3)
	at: 0 put: a;
	at: 1 put: b;
	at: 2 put: c;
	yourself
]

ArrayedCollection with: a with: b with: c with: d
[
    ^(self new: 4)
	at: 0 put: a;
	at: 1 put: b;
	at: 2 put: c;
	at: 3 put: d;
	yourself
]

ArrayedCollection with: a with: b with: c with: d with: e
[
    ^(self new: 5)
	at: 0 put: a;
	at: 1 put: b;
	at: 2 put: c;
	at: 3 put: d;
	at: 4 put: e;
	yourself
]

ArrayedCollection new: capacity
[
    self := super new.
    size := capacity.
]

ArrayedCollection isEmpty
[
    ^size == 0.
]

ArrayedCollection size
[
    ^size.
]
