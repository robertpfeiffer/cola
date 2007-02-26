{ import: Objects }

SlotDictionary : Object ( _size _tally _keys _values default )

SlotDictionary new	[ ^self new: nil ]

SlotDictionary new: defaultElement
{
    struct t_SlotDictionary *this= (struct t_SlotDictionary *)_alloc(v_self, sizeof(struct t_SlotDictionary));
    this->v__size=    (oop)4;
    this->v__tally=   (oop)0;
    this->v__keys=    (oop)_palloc(sizeof(oop) * 4);
    this->v__values=  (oop)_palloc(sizeof(oop) * 4);
    this->v_default=  v_defaultElement;
    return (oop)this;
}

SlotDictionary at: aKey
{
    if (((oop *)self->v__keys)[0] == v_aKey)
      	return ((oop *)self->v__values)[0];
    else if (((oop *)self->v__keys)[1] == v_aKey)
      {
        register oop v1= ((oop *)self->v__values)[1];
			 ((oop *)self->v__keys  )[1]= ((oop *)self->v__keys  )[0];
			 ((oop *)self->v__values)[1]= ((oop *)self->v__values)[0];
			 ((oop *)self->v__keys  )[0]= v_aKey;
	return  	 ((oop *)self->v__values)[0]= v1;
      }
    else
      {
	register long index, lasti= (long)self->v__tally;
        for (index= 2;  index < lasti;  ++index)
	  {
	    if (((oop *)self->v__keys)[index] == v_aKey)
	      {
	        register oop v1= ((oop *)self->v__values)[index];
				 ((oop *)self->v__keys  )[index]= ((oop *)self->v__keys  )[lasti= index - 1];
				 ((oop *)self->v__values)[index]= ((oop *)self->v__values)[lasti];
				 ((oop *)self->v__keys  )[lasti]= v_aKey;
		return  	 ((oop *)self->v__values)[lasti]= v1;
	      }
	  }
      }
    return self->v_default;
}

SlotDictionary at: aKey put: aValue
{
    if (((oop *)self->v__keys)[0] == v_aKey)
      	return ((oop *)self->v__values)[0]= v_aValue;
    else if (((oop *)self->v__keys)[1] == v_aKey)
    {
		((oop *)self->v__keys  )[1]= ((oop *)self->v__keys  )[0];
		((oop *)self->v__values)[1]= ((oop *)self->v__values)[0];
		((oop *)self->v__keys  )[0]= v_aKey;
	return	((oop *)self->v__values)[0]= v_aValue;
    }
    else
    {
	register long index, lasti= (long)self->v__tally;
        for (index= 2;  index < lasti;  ++index)
	{
	    if (((oop *)self->v__keys)[index] == v_aKey)
	    {
			((oop *)self->v__keys  )[index]= ((oop *)self->v__keys  )[lasti= index - 1];
			((oop *)self->v__values)[index]= ((oop *)self->v__values)[lasti];
			((oop *)self->v__keys  )[lasti]= v_aKey;
		return	((oop *)self->v__values)[lasti]= v_aValue;
	    }
	}
    }
    {
        long tally= (long)self->v__tally;
    	if (tally == (long)self->v__size)
        {
            long oldSize= (long)self->v__size;
            long newSize= oldSize * 2;
	    oop *keys=   (oop *)_palloc(sizeof(oop) * newSize);
	    oop *values= (oop *)_palloc(sizeof(oop) * newSize);
	    memcpy(keys,   self->v__keys,   sizeof(oop) * oldSize);
	    memcpy(values, self->v__values, sizeof(oop) * oldSize);
	    self->v__keys=   (oop)keys;
	    self->v__values= (oop)values;
	    self->v__size=   (oop)newSize;
    	}
	((oop *)self->v__keys  )[tally]= v_aKey;
	((oop *)self->v__values)[tally]= v_aValue;
        self->v__tally= (oop)(tally + 1);
    }
    return v_aValue;
}

SlotDictionary size	[ ^SmallInteger value_: _tally ]

SlotDictionary at: aKey ifAbsent: errorBlock
[
    | value |
    ^(value := self at: aKey) ~~ default ifTrue: [value] ifFalse: [errorBlock value]
]

SlotDictionary valueAt: index
[
    | _index |
    _index := index _integerValue.
    {
	if ((long)v__index < (long)self->v__tally)
	    return ((oop *)self->v__values)[(long)v__index];
    }.
    ^self error: 'index is out of bounds'
]

SlotDictionary valuesDo: aBlock
[
    0 to: self size - 1 do: [:index | aBlock value: (self valueAt: index)]
]