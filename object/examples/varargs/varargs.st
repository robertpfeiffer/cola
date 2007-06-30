{ import: st80 }

Object foo: a ...
[
   'Object.foo:' putln.
   a println.
   ... println.
]

[
    Object foo: 42 : 666.
]


Object sum ...
[
    | sum next |
    sum := 0.
    [next := ...] whileTrue: [sum := sum + next].
    ^sum
]

[
    (Object sum : 1 : 2 : 3 : 4 : nil) println.
]
