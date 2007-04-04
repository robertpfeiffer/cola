{ import: Object }

Integer nfibs
[
    ^self < 2 ifTrue: [1] ifFalse: [(self - 1) nfibs + (self - 2) nfibs + 1]
]

[
    StdOut print: 35 nfibs; cr.
    StdOut print: 35 nfibs; cr.
    StdOut print: 35 nfibs; cr.
    StdOut print: 35 nfibs; cr.
    StdOut print: 35 nfibs; cr.
    StdOut print: 35 nfibs; cr.
    StdOut print: 35 nfibs; cr.
    StdOut print: 35 nfibs; cr.
    StdOut print: 35 nfibs; cr.
    StdOut print: 35 nfibs; cr.
]
