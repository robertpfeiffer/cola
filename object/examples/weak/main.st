{ import: st80 }
{ import: WeakArray }


Smalltalk garbageCollect
{
    GC_gcollect();
}


Foo : Object ( value )

Foo value: v
[
    self := self new.
    value := v.
]

Foo printOn: aStream
[
    aStream nextPutAll: 'Foo('; print: value; nextPut: $)
]


[
    | size weak |
    size := 4.
    weak := WeakArray new: size.
    1 to: size do: [:i | weak at: i put: (Foo value: i)].
    Smalltalk garbageCollect.	1    to:  size do: [:i | (weak at: i) printString putln].
    Smalltalk garbageCollect.	1    to:  size do: [:i | (weak at: i) printString putln].
    Smalltalk garbageCollect.	1    to:  size do: [:i | (weak at: i) printString putln].
]
