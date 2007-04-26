" SlotDictionary.st -- dictionaries optimised for representing objects as lists of named slots

  Copyright (c) 2006, 2007 Ian Piumarta
  All rights reserved.

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the 'Software'),
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, provided that the above copyright notice(s) and this
  permission notice appear in all copies of the Software and that both the
  above copyright notice(s) and this permission notice appear in supporting
  documentation.

  THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.

  Last edited: 2007-04-26 13:33:59 by piumarta on emilia
"

{ import: Objects }

SlotDictionary : Object ( _size _tally _keys _values default )

SlotDictionary new	[ ^self new: nil ]

SlotDictionary new: defaultElement
{
    v_self= (oop)_alloc(v_self, sizeof(struct t_SlotDictionary));
    self->v__size=    (oop)4;
    self->v__tally=   (oop)0;
    self->v__keys=    (oop)_palloc(sizeof(oop) * 4);
    self->v__values=  (oop)_palloc(sizeof(oop) * 4);
    self->v_default=  v_defaultElement;
}

SlotDictionary basicNew
[
    self := self _vtable _alloc: self _sizeof.
    {
	self->v__size=    (oop)2;
	self->v__tally=   (oop)0;
	self->v__keys=    (oop)_palloc(sizeof(oop) * 2);
	self->v__values=  (oop)_palloc(sizeof(oop) * 2);
	self->v_default=  0;
    }
]

SlotDictionary default			[ ^default ]
SlotDictionary default: defaultElement	[  default := defaultElement ]

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

SlotDictionary removeKey: aKey
{
    register long index, lasti= (long)self->v__tally;
    for (index= 0;  index < lasti;  ++index)
    {
	if (((oop *)self->v__keys)[index] == v_aKey)
	{
	    --lasti;
	    for (;  index < lasti;  ++index)
	    {
		((oop *)self->v__keys  )[index]= ((oop *)self->v__keys  )[index + 1];
		((oop *)self->v__values)[index]= ((oop *)self->v__values)[index + 1];
	    }
	    self->v__tally= (oop)lasti;
	    ((oop *)self->v__keys  )[lasti]= 0;
	    ((oop *)self->v__values)[lasti]= 0;
	    return v_self;
	}
    }
    return v_self;
}

SlotDictionary size	[ ^SmallInteger value_: _tally ]

SlotDictionary keys
[
    | keysArray _keysArray |
    _keysArray := (keysArray := Array new: self size) _elements.
    { memcpy(v__keysArray, self->v__keys, sizeof(oop) * (long)self->v__tally); }.
    ^keysArray
]

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

SlotDictionary valuesReverseDo: aBlock
[
    self size - 1 downTo: 0 do: [:index | aBlock value: (self valueAt: index)]
]
