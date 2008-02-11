" WeakArray.st -- support for arrays of weak (disappearing) pointers

  Copyright (c) 2006 Ian Piumarta
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

  Last edited: 2007-11-16 16:29:32 by piumarta on emilia.local
"

{ import: Array }

WeakArray : Array ()

Object _newWeakPointers: anInteger
{
    void *ptrs;
    size_t size= (size_t)v_anInteger >> 1;
    ptrs= _libid->balloc(sizeof(oop) * size);
    memset(ptrs, 0, sizeof(oop) * size);
    return ptrs;
}

WeakArray _newPointers: pointersSize
[
    ^self _newWeakPointers: pointersSize
]

WeakArray at: anInteger put: anObject
[
    {
        if (((int)v_anInteger & 1) && ((int)v_anInteger > 1) && ((int)v_anInteger <= (int)self->v_size))
	    {
		void *ptr= (void *)(self->v__pointers) + ((int)v_anInteger >> 1) - 1;
	        if (*(oop *)ptr)
	            _libid->gc_unregisterDisappearingLink(ptr);
	    }
    }.
    super at: anInteger put: anObject.
    {
	if (v_anObject && !((long)v_anObject & 1))
	    {
		void *ptr= (void *)(self->v__pointers) + ((int)v_anInteger >> 1) - 1;
	        _libid->gc_generalRegisterDisappearingLink(ptr, &(v_anObject->_vtable[-1]));
	    }
    }.
    ^anObject
]
