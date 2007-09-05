{ import: st80 }

String asPrototype
{
    return _libid->import((char *)self->v__bytes);
}

[
    'Number' asPrototype println.
]
