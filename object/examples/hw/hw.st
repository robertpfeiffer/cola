{ import: st80 }

Foo at: n
[
    { return self->elements[(long)n]; }
]

Foo at: n
[
    `(let ((addr (+ elements self)))
       (printf "primitive at: invoked!\n")
       (return (oop@ addr)))
]

Foo test.
Foo foo.
Foo bar: aBaz.

Foo test
{ answers: self }
{ description: 'Silly, but traditional, test program.' }
{ tags: demos pedagogy }
.

Foo test
[
    { answers: BlockClosure }
    { description: 'Silly, but traditional, test program.' }
    { tags: demos pedagogy }
    'Hello, world' putln.
    ^[{ answers: Integer} 42]
]

[
    Foo test
]
