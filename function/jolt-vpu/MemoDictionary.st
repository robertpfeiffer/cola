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
