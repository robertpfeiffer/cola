" Number.st -- behaviour common to all Numbers

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

  Last edited: 2008-06-20 18:41:17 by piumarta on emilia
"

{ import: Objects }

Number min: aNumber		[ ^self < aNumber ifTrue: [self] ifFalse: [aNumber] ]
Number max: aNumber		[ ^self < aNumber ifTrue: [aNumber] ifFalse: [self] ]

Number between: low and: high	[ ^low <= self and: [self <= high] ]

Number quo: aNumber
[
    ^(self / aNumber) truncated
]

Number \\ aNumber 
[
    ^self - (self // aNumber * aNumber)
]

Number compare: aNumber
[
    ^self < aNumber ifTrue: [-1] ifFalse: [self = aNumber ifTrue: [0] ifFalse: [1]].
]

Number < aNumber
[
    self error: 'illegal argument: ', self printString, ' < ', aNumber printString
]

Number  isEven	[ ^self \\ 2 = 0 ]
Integer isEven	[ ^(self bitAnd: 1) = 0 ]

Number timesRepeat: aBlock
[
    | count |
    count := 0.
    [(count := count + 1) <= self] whileTrue: [aBlock value]
]

Number abs	[ ^self < 0 ifTrue: [self negated] ifFalse: [self] ]
Number negated	[ ^0 - self ]

Number squared	[ ^self * self ]
Number cubed	[ ^self * self * self ]

"----------------------------------------------------------------"

Object  isInteger	[ ^false ]
Integer	isInteger	[ ^true ]

Integer asInteger	[]

"----------------------------------------------------------------"

SmallInteger asString [ ^self printString ]

SmallInteger + aNumber
[
    { if ((long)v_aNumber & 1) {
	int s= ((int)(long)v_self >> 1) + ((int)(long)v_aNumber >> 1);
        if ((s ^ (s << 1)) >= 0) { _return (oop)(long)(s << 1 | 1); }
    } }.
    ^super + aNumber
]

SmallInteger - aNumber
[
    { if ((long)v_aNumber & 1) {
	int s= ((int)(long)v_self >> 1) - ((int)(long)v_aNumber >> 1);
        if ((s ^ (s << 1)) >= 0) { _return (oop)(long)(s << 1 | 1); }
    } }.
    ^super - aNumber
]

SmallInteger * aNumber
[
    { if ((long)v_aNumber & 1) {
	int l= (int)(long)v_self >> 1, r= (int)(long)v_aNumber >> 1, s= l * r;
        if (((s ^ (s << 1)) >= 0) && ((r == 0) || (s / r == l))) { _return (oop)(long)(s << 1 | 1); }
    } }.
    ^super * aNumber
]

SmallInteger / aNumber
[
    { if (((long)v_aNumber & 1) && ((long)v_aNumber != 1)) {
	int l= (int)(long)v_self >> 1, r= (int)(long)v_aNumber >> 1, s= l / r;
	if (s * r == l) { _return (oop)(long)(s << 1 | 1); }
    } }.
    aNumber = 0 ifTrue: [^self errorDivisionByZero].
    ^aNumber isSmallInteger
	ifTrue:  [self asFloat / aNumber]
	ifFalse: [super / aNumber]
]

SmallInteger // aNumber
[
    { if (((long)v_aNumber & 1) && ((long)v_aNumber != 1)) {
        int rcvr= (int)(long)v_self >> 1, arg= (int)(long)v_aNumber >> 1, result;
	if (rcvr > 0) {
	  if (arg > 0) {
	    result= rcvr / arg;
	  } else {
	    arg= 0 - arg;
	    result= 0 - ((rcvr + (arg - 1)) / arg);
	  }
	} else {
	  rcvr= 0 - rcvr;
	  if (arg > 0) {
	    result= 0 - ((rcvr + (arg - 1)) / arg);
	  } else {
	    arg= 0 - arg;
	    result= rcvr / arg;
	  }
	}
	if ((result ^ (result << 1)) >= 0)
	  { _return (oop)(long)(result << 1 | 1); }
    } }.
    ^super // aNumber
]

SmallInteger \\ aNumber
[
    { if (((long)v_aNumber & 1) && ((long)v_aNumber != 1)) {
	int num= (int)(long)v_aNumber >> 1, rem= ((int)(long)v_self >> 1) % num;
	if (num < 0) {
	  if (rem > 0) rem += num;
	} else {
	  if (rem < 0) rem += num;
	}
	if ((rem ^ (rem << 1)) >= 0)
	  { _return (oop)(long)(rem << 1 | 1); }
    } }.
    ^super \\ aNumber
]

SmallInteger bitAnd: anInteger
[
    { if (((long)v_anInteger & 1) && ((long)v_self > 0) && ((long)v_anInteger > 0))  { _return (oop)(((long)v_self & (long)v_anInteger) | 1); } }.
    ^super bitAnd: anInteger
]

SmallInteger bitOr: anInteger
[
    { if (((long)v_anInteger & 1) && ((long)v_self > 0) && ((long)v_anInteger > 0))  { _return (oop)(((long)v_self | (long)v_anInteger) | 1); } }.
    ^super bitOr: anInteger
]

SmallInteger bitXor: anInteger
[
    { if (((long)v_anInteger & 1) && ((long)v_self > 0) && ((long)v_anInteger > 0))  { _return (oop)(((long)v_self ^ (long)v_anInteger) | 1); } }.
    ^super bitXor: anInteger
]

SmallInteger bitShift: displacement
[
    displacement isSmallInteger ifFalse: [^self error: 'non-Integer displacement'].
    { int l= (int)(long)v_self >> 1, r= (int)(long)v_displacement >> 1;
      if (r >= 0) {
        if (r <= 31) {
          int s= l << r;
          if ((l == (s >> r)) && ((s ^ (s << 1)) >= 0)) { _return (oop)(long)(s << 1 | 1); }
        }
      } else if (r >= -31) {
  	int s= l >> r;
        _return (oop)(long)(s << 1 | 1);
      }
    }.
    self >= 0 ifTrue: [^super bitShift: displacement].
    ^(self negated bitShift: displacement) negated
]

SmallInteger << displacement
[
    {
      if ((int)(long)v_self & (int)(long)v_displacement & 1) {
	int l= (int)(long)v_self >> 1, r= (int)(long)v_displacement >> 1, s= (l << r);
	if ((r >= 0) && (r <= 31) && ((s ^ (s << 1)) >= 0) && ((s >> r) == l)) { _return (oop)(long)(s << 1 | 1); }
    } }.
    ^super << displacement
]

SmallInteger >> displacement
[
    {
      if ((int)(long)v_self & (int)(long)v_displacement & 1) {
	int l= (int)(long)v_self >> 1, r= (int)(long)v_displacement >> 1, s= (l >> r);
	if ((r >= 0) && (r <= 31)) { _return (oop)(long)(s << 1 | 1); }
    } }.
    ^super >> displacement
]

SmallInteger < aNumber
[
    { if ((int)(long)v_aNumber & 1) { _return ((int)(long)v_self < (int)(long)v_aNumber) ? v_true : v_false; } }.
    ^super < aNumber
]

SmallInteger <= aNumber
[
    { if ((int)(long)v_aNumber & 1) { _return ((int)(long)v_self <= (int)(long)v_aNumber) ? v_true : v_false; } }.
    ^super <= aNumber
]

SmallInteger = aNumber
[
    { if ((int)(long)v_aNumber & 1) { _return ((int)(long)v_self == (int)(long)v_aNumber) ? v_true : v_false; } }.
    ^super = aNumber
]

SmallInteger ~= aNumber
[
    { if ((int)(long)v_aNumber & 1) { _return ((int)(long)v_self != (int)(long)v_aNumber) ? v_true : v_false; } }.
    ^super ~= aNumber
]

SmallInteger >= aNumber
[
    { if ((int)(long)v_aNumber & 1) { _return ((int)(long)v_self >= (int)(long)v_aNumber) ? v_true : v_false; } }.
    ^super >= aNumber
]

SmallInteger > aNumber
[
    { if ((int)(long)v_aNumber & 1) { _return ((int)(long)v_self > (int)(long)v_aNumber) ? v_true : v_false; } }.
    ^super > aNumber
]

SmallInteger | aNumber
[
    { if ((int)(long)v_aNumber & 1) { _return (oop)(long)(((int)(long)v_self | (int)(long)v_aNumber)); } }.
    ^super | aNumber
]

SmallInteger & aNumber
[
    { if ((int)(long)v_aNumber & 1) { _return (oop)(long)(((int)(long)v_self & (int)(long)v_aNumber)); } }.
    ^super & aNumber
]

"----------------------------------------------------------------"

{ include <math.h> }

Object isFloat	[ ^false ]
Float  isFloat	[ ^true ]

Float _sizeof { _return (oop)(long)sizeof(double); }

Float value_: _fp
[
    self := self new.
    { memcpy(self, v__fp, sizeof(double)); }.
]

Float setIntegerValue_: _integer
{
    double d= (double)(long)v__integer;
    memcpy(self, &d, sizeof(d));
}

Float fromString: s
[
    | _s f |
    _s := s _stringValue.
    f := self new.
    {
	double d;
        d= strtod((char *)v__s, 0);
	memcpy(v_f, &d, sizeof(double));
    }.
    ^f
]

Float copy		[ ^self new value_: self ]
SmallInteger copy	[ ]

Float        asFloat	[ ]
SmallInteger asFloat	[ ^Float new setIntegerValue_: self _integerValue ]
Integer      asFloat	[ ^self asFloatScaled: 1.0 ]

Integer asFloatScaled: scale
[
    ^self = 0
	ifTrue:  [0.0]
	ifFalse: [(self >> 1 asFloatScaled: scale * 2.0) + (scale * (self isEven ifTrue: [0.0] ifFalse: [1.0]))]
]

Float        asInteger	[ ^self truncated ]
SmallInteger asInteger	[ ]

Float pi		[ ^3.14159265358978324 ]

Float asString		[ ^self printString ]

Float negated		[ ^0.0 - self ]

Float + aNumber
[
    aNumber isFloat ifFalse: [aNumber := aNumber asFloat].
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
    aNumber isFloat ifFalse: [aNumber := aNumber asFloat].
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
    aNumber isFloat ifFalse: [aNumber := aNumber asFloat].
    self := self copy.
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      a *= b;
      memcpy(v_self, &a, sizeof(double));
    }.
]

Float / aNumber
[
    aNumber isFloat ifFalse: [aNumber := aNumber asFloat].
    self := self copy.
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      a /= b;
      memcpy(v_self, &a, sizeof(double));
    }
]

Float // aNumber
[
    ^self quo: aNumber
]

Float < aNumber
[
    aNumber isFloat ifFalse: [aNumber := aNumber asFloat].
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      _return a < b ? v_self : 0;
    }
]

Float <= aNumber
[
    aNumber isFloat ifFalse: [aNumber := aNumber asFloat].
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      _return a <= b ? v_self : 0;
    }
]

Float = aNumber
[
    aNumber isFloat ifFalse: [aNumber := aNumber asFloat].
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      _return a == b ? v_self : 0;
    }
]

Float ~= aNumber
[
    aNumber isFloat ifFalse: [aNumber := aNumber asFloat].
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      _return a != b ? v_self : 0;
    }
]

Float >= aNumber
[
    aNumber isFloat ifFalse: [aNumber := aNumber asFloat].
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      _return a >= b ? v_self : 0;
    }
]

Float > aNumber
[
    aNumber isFloat ifFalse: [aNumber := aNumber asFloat].
    {
      double a, b;
      memcpy(&a, v_self,    sizeof(double));
      memcpy(&b, v_aNumber, sizeof(double));
      _return a > b ? v_self : 0;
    }
]

Float truncated
{
    double l, i;
    memcpy(&l, self, sizeof(l));
    modf(l, &i);
    _return (oop)((long)i << 1 | 1);
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

Float sin
[
    self := self copy.
    {
	double rcvr;
	memcpy(&rcvr, v_self, sizeof(double));
	rcvr= sin(rcvr);
	memcpy(v_self, &rcvr, sizeof(double));
    }
]

Float cos
[
    self := self copy.
    {
	double rcvr;
	memcpy(&rcvr, v_self, sizeof(double));
	rcvr= cos(rcvr);
	memcpy(v_self, &rcvr, sizeof(double));
    }
]

Float tan
[
   self := self copy.
   {
       double rcvr;
       memcpy(&rcvr, v_self, sizeof(double));
       rcvr= tan(rcvr);
       memcpy(v_self, &rcvr, sizeof(double));
   }
]

Float atan2: y
[
   self := self copy.
   y := y asFloat.
   {
       double x, y;
       memcpy(&x, v_self, sizeof(double));
       memcpy(&y, v_y, sizeof(double));
       x= atan2(x, y);
       memcpy(v_self, &x, sizeof(double));
   }
]

Float sqrt
[
    self := self copy.
    {
	double rcvr;
	memcpy(&rcvr, v_self, sizeof(double));
	rcvr= sqrt(rcvr);
	memcpy(v_self, &rcvr, sizeof(double));
    }
]

Float adaptToInteger: anInteger andSend: aSelector
[
    ^anInteger asFloat perform: aSelector with: self
]

Float printOn: aStream
[
    aStream nextPutAll: self printString
]

Float printString
[
    ^String value_: self _printString
]

Float _printString
{
    double l;
    char buf[1024], *ptr;
    size_t len;
    memcpy(&l, self, sizeof(l));
    sprintf(buf, "%f", l);
    len= strlen(buf);
    ptr= (char *)_libid->balloc(len + 1);
    memcpy(ptr, buf, len);
    ptr[len]= '\0';
    _return (oop)ptr;
}

"----------------------------------------------------------------"

Object	     isLargeInteger	[ ^false ]
LargeInteger isLargeInteger	[ ^true ]

LargeInteger asLargeInteger	[ ^self ]

{ include "mpint.h" }

LargeInteger _sizeof		{ _return (oop)(long)sizeof(mp_int); }

LargeInteger withValue: anInteger
[
    self := super new.
    {
	long val= (long)v_anInteger >> 1;
        mp_init_set_int((mp_int *)self, (unsigned long)abs(val));
	if (val < 0) mp_neg((mp_int *)self, (mp_int *)self);
    }
]

LargeInteger value_: anInteger
[
    self := super new.
    {
        mp_init_set_int((mp_int *)self, (unsigned long)abs((long)v_anInteger));
	if ((long)v_anInteger < 0) mp_neg((mp_int *)self, (mp_int *)self);
    }
]

LargeInteger unsignedValue_: anInteger
[
    self := super new.
    {
        mp_init_set_int((mp_int *)self, (unsigned long)v_anInteger);
    }
]

LargeInteger size_: _size value_: _bytes
[
    self := super new.
    {
	int size= (long)v__size;
	unsigned char *bytes= (unsigned char *)v__bytes;
	mp_int digit;
        mp_init_set_int(&digit, (unsigned long)0);
        mp_init_set_int((mp_int *)self, (unsigned long)0);
	while (size--)
	  {
	    mp_set_int(&digit, bytes[size]);
	    mp_mul_d((mp_int *)self, (mp_digit)256, (mp_int *)self);
	    mp_add((mp_int *)self, &digit, (mp_int *)self);
	  }
        mp_clear(&digit);
    }
]

LargeInteger new
[
    self := super new.
    {
        mp_init((mp_int *)self);
    }
]

LargeInteger copy
[
    | copy |
    copy := super new.
    {
        mp_init_copy((mp_int *)v_copy, (mp_int *)self);
    }.
    ^copy
]

LargeInteger _integerValue
{
    long val= (long)mp_get_int((mp_int *)self);
    _return (MP_LT == mp_cmp_d((mp_int *)self, 0))
	? (oop)-val
	: (oop) val;
}

LargeInteger +  aNumber	[ ^aNumber isInteger ifTrue: [self mpAdd: aNumber asLargeInteger] ifFalse: [super +  aNumber] ]
LargeInteger -  aNumber	[ ^aNumber isInteger ifTrue: [self mpSub: aNumber asLargeInteger] ifFalse: [super -  aNumber] ]
LargeInteger *  aNumber	[ ^aNumber isInteger ifTrue: [self mpMul: aNumber asLargeInteger] ifFalse: [super *  aNumber] ]
LargeInteger // aNumber	[ ^aNumber isInteger ifTrue: [self mpDiv: aNumber asLargeInteger] ifFalse: [super // aNumber] ]
LargeInteger \\ aNumber	[ ^aNumber isInteger ifTrue: [self mpMod: aNumber asLargeInteger] ifFalse: [super \\ aNumber] ]

LargeInteger bitAnd: aNumber	[ ^aNumber isInteger ifTrue: [self mpAnd: aNumber asLargeInteger] ifFalse: [super bitAnd: aNumber] ]
LargeInteger bitOr:  aNumber	[ ^aNumber isInteger ifTrue: [self mpOr:  aNumber asLargeInteger] ifFalse: [super bitOr:  aNumber] ]
LargeInteger bitXor: aNumber	[ ^aNumber isInteger ifTrue: [self mpXor: aNumber asLargeInteger] ifFalse: [super bitXor: aNumber] ]

LargeInteger << anInteger
[
    | result |
    result := self new.
    {
        if ((long)v_anInteger & 1)
        {
	    mp_mul_2d((mp_int *)v_self, (long)v_anInteger >> 1, (mp_int *)v_result);
	    _return v_result;
        }
    }.
    ^self primitiveFailed
]

LargeInteger >> anInteger
[
    | result |
    result := self new.
    {
        if ((long)v_anInteger & 1)
        {
	    mp_div_2d((mp_int *)v_self, (long)v_anInteger >> 1, (mp_int *)v_result, (mp_int *)0);
	    _return v_result;
        }
    }.
    ^self primitiveFailed
]

LargeInteger mpAdd: aLargeInteger
[
    | result |
    result := self new.
    { mp_add((mp_int *)self, (mp_int *)v_aLargeInteger, (mp_int *)v_result); }.
    ^result normalize
]

LargeInteger mpSub: aLargeInteger
[
    | result |
    result := self new.
    { mp_sub((mp_int *)self, (mp_int *)v_aLargeInteger, (mp_int *)v_result); }.
    ^result normalize
]

LargeInteger mpMul: aLargeInteger
[
    | result |
    result := self new.
    { mp_mul((mp_int *)self, (mp_int *)v_aLargeInteger, (mp_int *)v_result); }.
    ^result normalize
]

LargeInteger mpDiv: aLargeInteger
[
    | quo rem |
    quo := self new.
    rem := self new.
    { mp_div((mp_int *)v_self, (mp_int *)v_aLargeInteger, (mp_int *)v_quo, (mp_int *)v_rem); }.
    ^quo normalize
]

LargeInteger mpMod: aLargeInteger
[
    | quo rem |
    quo := self new.
    rem := self new.
    { mp_div((mp_int *)v_self, (mp_int *)v_aLargeInteger, (mp_int *)v_quo, (mp_int *)v_rem); }.
    ^rem normalize
]

LargeInteger mpAnd: aLargeInteger
[
    | result |
    result := self new.
    { mp_and((mp_int *)self, (mp_int *)v_aLargeInteger, (mp_int *)v_result); }.
    ^result normalize
]

LargeInteger mpOr: aLargeInteger
[
    | result |
    result := self new.
    { mp_or((mp_int *)self, (mp_int *)v_aLargeInteger, (mp_int *)v_result); }.
    ^result normalize
]

LargeInteger mpXor: aLargeInteger
[
    | result |
    result := self new.
    { mp_xor((mp_int *)self, (mp_int *)v_aLargeInteger, (mp_int *)v_result); }.
    ^result normalize
]

LargeInteger negated
[
    | result |
    result := self new.
    { mp_neg((mp_int *)self, (mp_int *)v_result); }.
    ^result
]

Integer normalize	[]

LargeInteger normalize
{
    int nBits= mp_count_bits((mp_int *)self);
    if (nBits <= 30)
    {
	long val= (long)mp_get_int((mp_int *)self);
	_return (oop)(val << 1 | 1);
    }
    _return v_self;
}

LargeInteger <  aNumber	[ ^aNumber isInteger ifTrue: [(self mpCmp: aNumber asLargeInteger) <  0] ifFalse: [aNumber adaptToInteger: self andSend: #< ] ]
LargeInteger <= aNumber	[ ^aNumber isInteger ifTrue: [(self mpCmp: aNumber asLargeInteger) <= 0] ifFalse: [aNumber adaptToInteger: self andSend: #<=] ]
LargeInteger  = aNumber	[ ^aNumber isInteger ifTrue: [(self mpCmp: aNumber asLargeInteger) == 0] ifFalse: [aNumber adaptToInteger: self andSend: # =] ]
LargeInteger ~= aNumber	[ ^aNumber isInteger ifTrue: [(self mpCmp: aNumber asLargeInteger) ~~ 0] ifFalse: [aNumber adaptToInteger: self andSend: #~=] ]
LargeInteger >= aNumber	[ ^aNumber isInteger ifTrue: [(self mpCmp: aNumber asLargeInteger) >= 0] ifFalse: [aNumber adaptToInteger: self andSend: #>=] ]
LargeInteger >  aNumber	[ ^aNumber isInteger ifTrue: [(self mpCmp: aNumber asLargeInteger) >  0] ifFalse: [aNumber adaptToInteger: self andSend: #> ] ]

LargeInteger mpCmp: aLargeInteger
{
    _return (oop)(long)(mp_cmp((mp_int *)v_self, (mp_int *)v_aLargeInteger) << 1 | 1);
}

LargeInteger bitSize
{
    _return (oop)((long)mp_count_bits((mp_int *)self) << 1 | 1);
}

Integer bitSize
[
    ^self asLargeInteger bitSize
]

Integer printOn: aStream
[
    self printOn: aStream base: 10
]

Integer printOn: aStream base: base
[
    | num |
    self < 0
	ifTrue:
	   [aStream nextPut: $-.
	    num := self negated]
	ifFalse:
	   [num := self].
    num printUnsignedOn: aStream base: base
]

Integer printOn: aStream base: base width: fieldWidth
[
    | digits num |
    digits := self printStringBase: base.
    fieldWidth - digits size timesRepeat: [aStream nextPut: $0].
    aStream nextPutAll: digits
]

Integer printOn: aStream base: base width: fieldWidth padded: padChar
[
    | digits num |
    digits := self printStringBase: base.
    fieldWidth - digits size timesRepeat: [aStream nextPut: padChar].
    aStream nextPutAll: digits
]

Integer printUnsignedOn: aStream base: base
[
    self >= base ifTrue: [self // base printUnsignedOn: aStream base: base].
    aStream nextPut: (self \\ base) asDigit.
]

Integer printStringBase: base
[
    | stream |
    stream := WriteStream on: (String new: 8).
    self printOn: stream base: base.
    ^stream contents
]

Integer value_: _i
[
    { if (-0x40000000 <= (long)v__i && (long)v__i <= 0x3fffffff) { _return (oop)((long)v__i << 1 | 1); } }.
    ^LargeInteger value_: _i
]

Integer unsignedValue_: _i
[
    { if ((unsigned long)v__i <= 0x3fffffff) { _return (oop)((long)v__i << 1 | 1); } }.
    ^LargeInteger unsignedValue_: _i
]

"----------------------------------------------------------------"

Object isNumber	[ ^false ]
Number isNumber	[ ^true ]

Integer +  	aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger +  	  aNumber] ifFalse: [aNumber adaptToInteger: self andSend: #+      ] ]
Integer -  	aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger -  	  aNumber] ifFalse: [aNumber adaptToInteger: self andSend: #-      ] ]
Integer *  	aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger *  	  aNumber] ifFalse: [aNumber adaptToInteger: self andSend: #*      ] ]
Integer / 	aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger / 	  aNumber] ifFalse: [aNumber adaptToInteger: self andSend: #/      ] ]
Integer // 	aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger // 	  aNumber] ifFalse: [aNumber adaptToInteger: self andSend: #//     ] ]
Integer \\ 	aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger \\ 	  aNumber] ifFalse: [aNumber adaptToInteger: self andSend: #\\\\   ] ]
Integer <  	aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger <  	  aNumber] ifFalse: [aNumber adaptToInteger: self andSend: #<      ] ]
Integer <= 	aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger <= 	  aNumber] ifFalse: [aNumber adaptToInteger: self andSend: #<=     ] ]

Integer  = 	aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger  = 	  aNumber] ifFalse: [aNumber isNumber ifTrue: [aNumber adaptToInteger: self andSend: # =] ifFalse: [super  = aNumber]] ]
Integer ~= 	aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger ~= 	  aNumber] ifFalse: [aNumber isNumber ifTrue: [aNumber adaptToInteger: self andSend: #~=] ifFalse: [super ~= aNumber]] ]

Integer >= 	aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger >= 	  aNumber] ifFalse: [aNumber adaptToInteger: self andSend: #>=     ] ]
Integer >  	aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger >  	  aNumber] ifFalse: [aNumber adaptToInteger: self andSend: #>      ] ]
Integer << 	aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger << 	  aNumber] ifFalse: [aNumber adaptToInteger: self andSend: #<<     ] ]
Integer >> 	aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger >> 	  aNumber] ifFalse: [aNumber adaptToInteger: self andSend: #>>     ] ]
Integer bitAnd: aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger bitAnd: aNumber] ifFalse: [aNumber adaptToInteger: self andSend: #bitAnd:] ]
Integer bitOr:  aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger bitOr:  aNumber] ifFalse: [aNumber adaptToInteger: self andSend: #bitOr: ] ]
Integer bitXor: aNumber	[ ^aNumber isInteger ifTrue: [self asLargeInteger bitXor: aNumber] ifFalse: [aNumber adaptToInteger: self andSend: #bitXor:] ]

Integer & aNumber	[ ^self bitAnd: aNumber ]
Integer | aNumber	[ ^self bitOr:  aNumber ]
Integer ^ aNumber	[ ^self bitXor: aNumber ]

SmallInteger asLargeInteger	[ ^LargeInteger withValue: self ]

Number sqrt		[ ^self asFloat sqrt ]

Number sin		[ ^self asFloat sin ]
Number cos		[ ^self asFloat cos ]
Number tan		[ ^self asFloat tan ]
Number atan2: aNumber	[ ^self asFloat atan2: aNumber ]

Integer rounded		[ ^self ]
Integer truncated	[ ^self ]
Integer floor		[ ^self ]
Integer ceiling		[ ^self ]

Float rounded		[ ^(self + 0.5) truncated ]

Float floor
[
    self := self copy.
    {
	double rcvr;
	memcpy(&rcvr, v_self, sizeof(double));
	rcvr= floor(rcvr);
	memcpy(v_self, &rcvr, sizeof(double));
    }.
    ^self asInteger
]

Float ceiling
[
    self := self copy.
    {
	double rcvr;
	memcpy(&rcvr, v_self, sizeof(double));
	rcvr= ceil(rcvr);
	memcpy(v_self, &rcvr, sizeof(double));
    }.
    ^self asInteger
]

Integer fromString: s
[
    ^self fromString: s base: nil
]

Integer fromString: s base: b
[
    | chars digit sign base value |
    chars := s readStream.
    sign  := 1.
    base  := b ifNil: [10].
    value := 0.
    chars peek == $+
	ifTrue:  [chars next]
	ifFalse:
	   [chars peek == $-
		ifTrue:
		   [sign := -1.
		    chars next]].
    (b isNil and: [chars peek == $0])
	ifTrue:
	   [base := 8.
	    chars next.
	    (chars peek == $x or: [chars peek == $X])
		ifTrue:
		   [base := 16.
		    chars next]].
    [chars atEnd]
	whileFalse:
	   [(digit := chars next digitValue) ifFalse: [^nil].
	    (digit between: 0 and: base - 1) ifFalse: [^nil].
	    value := value * base + digit].
    ^value * sign
]

Integer to: limit doWithIndex: binaryBlock
[
    | i |
    i := -1.
    self to: limit do: [:j | binaryBlock value: j value: (i := i + 1)]
]
