" Float.st -- support for floating point arithmetic

  Copyright (c) 2005, 2006 Ian Piumarta
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

  Last edited: 2006-08-18 14:36:28 by piumarta on emilia.local
"

{ import: Number }

{ include <math.h> }

Float : Number ()

Float isFloat	[ ^true ]
Object isFloat	[ ^false ]

Float _sizeof { return (oop)sizeof(double); }

Float value_: _fp
[
    self := self new.
    { memcpy(self, v__fp, sizeof(double)); }.
]

Float copy	[ ^self new value_: self ]

Float asFloat		[ ^self ]
SmallInteger asFloat	[ ^Float new setIntegerValue_: self _integerValue ]
Float asInteger		[ ^self truncated ]

Float hash
{
    int hash;
    hash   = ((unsigned int *)self)[0];
    hash  += ((unsigned int *)self)[1];
    hash >>= 7;
    hash  &= 0x01FFFFFE;
    return (oop)(hash | 1);
}

Float setIntegerValue_: _integer
{
    double d= (double)(long)v__integer;
    memcpy(self, &d, sizeof(d));
}

Float + aNumber
[
    aNumber isFloat ifFalse: [^aNumber adaptToFloat: self andSend: #+].
    self := self copy.
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      a += b;
      memcpy(v_self, &a, sizeof(double));
    }.
]

Float - aNumber
[
    aNumber isFloat ifFalse: [^aNumber adaptToFloat: self andSend: #-].
    self := self copy.
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      a -= b;
      memcpy(v_self, &a, sizeof(double));
    }
]

Float * aNumber
[
    aNumber isFloat ifFalse: [^aNumber adaptToFloat: self andSend: #*].
    self := self copy.
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      a *= b;
      memcpy(v_self, &a, sizeof(double));
    }
]

Float / aNumber
[
    aNumber isFloat ifFalse: [^aNumber adaptToFloat: self andSend: #/].
    self := self copy.
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      a /= b;
      memcpy(v_self, &a, sizeof(double));
    }
]

Float < aNumber
[
    aNumber isFloat ifFalse: [^aNumber adaptToFloat: self andSend: #<].
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      return a < b ? v_Object : 0;
    }
]

Float <= aNumber
[
    aNumber isFloat ifFalse: [^aNumber adaptToFloat: self andSend: #<=].
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      return a <= b ? v_Object : 0;
    }
]

Float = aNumber
[
    aNumber isFloat ifFalse: [^aNumber adaptToFloat: self andSend: #=].
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      return a == b ? v_Object : 0;
    }
]

Float ~= aNumber
[
    aNumber isFloat ifFalse: [^aNumber adaptToFloat: self andSend: #~=].
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      return a != b ? v_Object : 0;
    }
]

Float >= aNumber
[
    aNumber isFloat ifFalse: [^aNumber adaptToFloat: self andSend: #>=].
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      return a >= b ? v_Object : 0;
    }
]

Float > aNumber
[
    aNumber isFloat ifFalse: [^aNumber adaptToFloat: self andSend: #>].
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      return a > b ? v_Object : 0;
    }
]

Float truncated
{
    double l, i;
    memcpy(&l, self, sizeof(l));
    modf(l, &i);
    return (oop)((long)i << 1 | 1);
}

Float fractionPart
[
    self := self copy.
    {
	double rcvr, frac, trunc;
	memcpy(&rcvr, v_self, sizeof(double));
	frac= modf(rcvr, &trunc);
	memcpy(v_self, &frac, sizeof(double));
    }
]

Float exponent
{
    double rcvr, frac;
    int pwr;
    memcpy(&rcvr, v_self, sizeof(double));
    frac= frexp(rcvr, &pwr);
    return (oop)(((pwr - 1) << 1) | 1);
}

Float sin
[
    self := self copy.
    {
	double d;
	memcpy(&d, v_self, sizeof(double));
	d= sin(d);
	memcpy(v_self, &d, sizeof(double));
    }
]

Float abs
[
    ^self < 0.0
	ifTrue:  [0.0 - self]
	ifFalse: [self]
]

Float negated
[
    ^0.0 - self
]

Float adaptToInteger: anInteger andSend: operator
[
    ^anInteger asFloat perform: operator with: self
]

Float pi	[ ^3.14159265358979323846264338327950288419716939937510 ]

Float print
{
    double d;
    memcpy(&d, self, sizeof(d));
/*  return (oop)(fprintf(stdout, "%f", d) << 1 | 1);  */
    return (oop)(fprintf(stdout, "%.16g", d) << 1 | 1);
}
