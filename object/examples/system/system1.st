{ import: st80 }

Object system: aString
[
    ^SmallInteger value_: (self _system_: aString _stringValue)
]

Object _system_: _aString
{
    return (oop)system((char *)v__aString);
}

[
    Smalltalk arguments do: [:arg | (' => ', (Object system: arg) printString) putln].
]

