" MemoDictionary.st -- SlotDictionary whose keys are added precisely once

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

  Last edited: 2007-02-28 14:43:36 by piumarta on emilia
"

{ import: Objects }

MemoDictionary : SlotDictionary ()

MemoDictionary at: aKey
{
    register long index, lasti= (long)self->v__tally - 1;
    if (lasti < 0)					return self->v_default;
    if (((oop *)self->v__keys)[lasti] == v_aKey)	return ((oop *)self->v__values)[lasti];
    for (index= lasti - 1;  index >= 0;  --index)
      {
	if (((oop *)self->v__keys)[index] == v_aKey)
	  {
	    register oop v0= ((oop *)self->v__values)[index];
			     ((oop *)self->v__keys  )[index]= ((oop *)self->v__keys  )[lasti= index + 1];
			     ((oop *)self->v__values)[index]= ((oop *)self->v__values)[lasti];
			     ((oop *)self->v__keys  )[lasti]= v_aKey;
	    return	     ((oop *)self->v__values)[lasti]= v0;
	  }
      }
    return self->v_default;
}

MemoDictionary at: aKey put: aValue
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
    return v_aValue;
}
