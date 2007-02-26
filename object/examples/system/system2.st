{ import: st80 }

String system
[
    ^SmallInteger value_: self _system
]

String _system
{
    return (oop)system((char *)self->v__bytes);
}

[
    Smalltalk arguments do: [:arg | (' => ', arg system printString) putln].
]

