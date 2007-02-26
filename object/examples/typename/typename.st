{ import: st80 }

String asPrototype
{
    return _local_import((char *)self->v__bytes);
}

[
    'Number' asPrototype println.
]
