" SmallInteger.st -- support for fixed integer arithmetic

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

  Last edited: 2007-03-27 18:52:00 by piumarta on ubuntu
"

{ import: Integer }

SmallInteger : Integer ()				{ pragma: type integer SmallInteger }

[ SmallInteger    _beTagType ]

SmallInteger isSmallInteger	[ ^true ]
Object isSmallInteger		[ ^false ]

SmallInteger hash		[ ^self bitAnd: 0x00FFFFFF ]
SmallInteger identityHash	[ ^self bitAnd: 0x00FFFFFF ]

SmallInteger maxVal	{ return (oop)(-1UL >> 1); }
SmallInteger minVal	{ return (oop)(-1L); }

SmallInteger digitLength
[
    (self < 16r0000100 and: [self > -16r0000100]) ifTrue: [^1].
    (self < 16r0010000 and: [self > -16r0010000]) ifTrue: [^2].
    (self < 16r1000000 and: [self > -16r1000000]) ifTrue: [^3].
    ^4
]

SmallInteger digitAt: n 
[
    n > 4 ifTrue: [^0].
    self < 0
	ifTrue: 
	   [self = self minVal
		ifTrue:
		   ["Can't negate minVal -- treat specially"
		    ^#[0 0 0 64] at: n].
	     ^((0 - self) bitShift: (1 - n) * 8) bitAnd: 16rFF]
	ifFalse:
	   [^(self bitShift: (1 - n) * 8) bitAnd: 16rFF]
]

SmallInteger + aNumber
[
    { if ((int)v_aNumber & 1) {
	int s= ((int)v_self >> 1) + ((int)v_aNumber >> 1);
        if ((s ^ (s << 1)) >= 0) return (oop)(s << 1 | 1);
    } }.
    ^super + aNumber
]

SmallInteger - aNumber
[
    { if ((int)v_aNumber & 1) {
	int s= ((int)v_self >> 1) - ((int)v_aNumber >> 1);
        if ((s ^ (s << 1)) >= 0) return (oop)(s << 1 | 1);
    } }.
    ^super - aNumber
]

SmallInteger * aNumber
[
    { if ((int)v_aNumber & 1) {
	int l= (int)v_self >> 1, r= (int)v_aNumber >> 1, s= l * r;
        if (((s ^ (s << 1)) >= 0) && ((r == 0) || (s / r == l))) return (oop)(s << 1 | 1);
    } }.
    ^super * aNumber
]

SmallInteger / aNumber
[
    { if (((int)v_aNumber & 1) && ((int)v_aNumber != 1)) {
	int l= (int)v_self >> 1, r= (int)v_aNumber >> 1, s= l / r;
	if (s * r == l) return (oop)(s << 1 | 1);
    } }.
    aNumber = 0 ifTrue: [^self errorDivisionByZero].
    ^aNumber isSmallInteger
	ifTrue:  [(Fraction numerator: self denominator: aNumber) reduced]
	ifFalse: [super / aNumber]
]

SmallInteger // aNumber
[
    { if (((int)v_aNumber & 1) && ((int)v_aNumber != 1)) {
        int rcvr= (int)v_self >> 1, arg= (int)v_aNumber >> 1, result;
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
	  return (oop)(result << 1 | 1);
    } }.
    ^super // aNumber
]

SmallInteger \\ aNumber
[
    { if (((int)v_aNumber & 1) && ((int)v_aNumber != 1)) {
	int rem= ((int)v_self >> 1) % ((int)v_aNumber >> 1);
	if ((int)v_aNumber < 0) {
	  if (rem > 0) rem += ((int)v_aNumber >> 1);
	} else {
	  if (rem < 0) rem += ((int)v_aNumber >> 1);
	}
	if ((rem ^ (rem << 1)) >= 0)
	  return (oop)(rem << 1 | 1);
    } }.
    ^super \\ aNumber
]

SmallInteger quo: aNumber 
[
    {
      if ((int)v_self & (int)v_aNumber & 1)
        {
	  int integerRcvr   = (int)v_self    >> 1;
	  int integerArg    = (int)v_aNumber >> 1;
	  int integerResult = ((integerRcvr > 0)
	    ? (((integerArg > 0) ? (integerRcvr / integerArg) : (0 - (integerRcvr / (0 - integerArg)))))
            : (((integerArg > 0) ? (0 - ((0 - integerRcvr) / integerArg)) : ((0 - integerRcvr) / (0 - integerArg)))));
	  if ((integerResult ^ (integerResult << 1)) >= 0)
	    return (oop)(integerResult << 1 | 1);
        }
    }.
    aNumber = 0 ifTrue: [self errorZeroDivide].
    (aNumber isSmallInteger) ifFalse: [^super quo: aNumber].
    (aNumber == -1 and: [self == self minVal]) ifTrue: [^self negated].
    ^self primitiveFailed
]

SmallInteger bitAnd: anInteger
[
    { if (((int)v_anInteger & 1) && ((int)v_self > 0) && ((int)v_anInteger > 0))
        return (oop)(((int)v_self & (int)v_anInteger) | 1); }.
    self >= 0 ifTrue: [^anInteger bitAnd: self].
    ^(self bitInvert bitOr: anInteger bitInvert) bitInvert
]

SmallInteger bitOr: anInteger
[
    { if (((int)v_anInteger & 1) && ((int)v_self > 0) && ((int)v_anInteger > 0))
        return (oop)(((int)v_self | (int)v_anInteger) | 1); }.
    self >= 0 ifTrue: [^anInteger bitOr: self].
    ^anInteger < 0
	ifTrue:  [(self bitInvert bitAnd: anInteger bitInvert) bitInvert]
	ifFalse: [(self bitInvert bitClear: anInteger) bitInvert]
]

SmallInteger bitXor: anInteger
[
    { if (((int)v_anInteger & 1) && ((int)v_self > 0) && ((int)v_anInteger > 0))
        return (oop)(((int)v_self ^ (int)v_anInteger) | 1); }.
    self >= 0 ifTrue: [^anInteger bitXor: self].
    ^anInteger < 0
	ifTrue:  [self bitInvert bitXor: anInteger bitInvert]
	ifFalse: [(self bitInvert bitClear: anInteger) bitInvert]
]

SmallInteger bitShift: displacement
[
    displacement isSmallInteger ifFalse: [^self error: 'non-Integer displacement'].
    { int l= (int)v_self >> 1, r= (int)v_displacement >> 1;
      if (r >= 0) {
        if (r <= 31) {
          int s= l << r;
          if ((l == (s >> r)) && ((s ^ (s << 1)) >= 0)) return (oop)(s << 1 | 1);
        }
      } else if (r >= -31) {
  	int s= l >> r;
        return (oop)(s << 1 | 1);
      }
    }.
    self >= 0 ifTrue: [^super bitShift: displacement].
    ^(self negated bitShift: displacement) negated
]

SmallInteger << displacement
[
    {
      if ((int)v_self & (int)v_displacement & 1) {
	int l= (int)v_self >> 1, r= (int)v_displacement >> 1, s= (l << r);
	if ((r >= 0) && (r <= 31) && ((s ^ (s << 1)) >= 0) && ((s >> r) == l)) return (oop)(s << 1 | 1);
    } }.
    ^super << displacement
]

SmallInteger >> displacement
[
    {
      if ((int)v_self & (int)v_displacement & 1) {
	int l= (int)v_self >> 1, r= (int)v_displacement >> 1, s= (l >> r);
	if ((r >= 0) && (r <= 31)) return (oop)(s << 1 | 1);
    } }.
    ^super >> displacement
]

SmallInteger < aNumber
[
    { if ((int)v_aNumber & 1) return ((int)v_self < (int)v_aNumber) ? v_true : v_false; }.
    ^super < aNumber
]

SmallInteger <= aNumber
[
    { if ((int)v_aNumber & 1) return ((int)v_self <= (int)v_aNumber) ? v_true : v_false; }.
    ^super <= aNumber
]

SmallInteger = aNumber
[
    { if ((int)v_aNumber & 1) return ((int)v_self == (int)v_aNumber) ? v_true : v_false; }.
    ^super = aNumber
]

SmallInteger ~= aNumber
[
    { if ((int)v_aNumber & 1) return ((int)v_self != (int)v_aNumber) ? v_true : v_false; }.
    ^super ~= aNumber
]

SmallInteger >= aNumber
[
    { if ((int)v_aNumber & 1) return ((int)v_self >= (int)v_aNumber) ? v_true : v_false; }.
    ^super >= aNumber
]

SmallInteger > aNumber
[
    { if ((int)v_aNumber & 1) return ((int)v_self > (int)v_aNumber) ? v_true : v_false; }.
    ^super > aNumber
]

SmallInteger highBitOfMagnitude
[
    ^self abs highBitOfPositiveReceiver
]

SmallInteger highBitOfPositiveReceiver
[
    | shifted bitNo |
    shifted := self.
    bitNo := 0.
    [shifted < 16]
	whileFalse: 
	   [shifted := shifted >> 4.
	    bitNo := bitNo + 4].
    [shifted = 0]
	whileFalse: 
	   [shifted := shifted >> 1.
	    bitNo := bitNo + 1].
    ^bitNo
]

SmallInteger gcd: anInteger
[
    | n m |
    n := self.
    m := anInteger.
    [n = 0] whileFalse: [n := m \\ (m := n)].
    ^m abs
]




SmallInteger to: anInteger do: unaryBlock
[
    | index |
    index := self.
    [index <= anInteger]
	whileTrue:
	   [unaryBlock value: index.
	    index := index + 1].
]

SmallInteger downTo: anInteger do: unaryBlock
[
    | index |
    index := self.
    [index >= anInteger]
	whileTrue:
	   [unaryBlock value: index.
	    index := index - 1].
]

SmallInteger to: anInteger by: stepInteger do: unaryBlock
[
    stepInteger < 0
	ifTrue:  [self downTo: anInteger by: stepInteger do: unaryBlock]
	ifFalse: [self   upTo: anInteger by: stepInteger do: unaryBlock]
]

SmallInteger upTo: anInteger by: stepInteger do: unaryBlock
[
    | index |
    index := self.
    [index <= anInteger]
	whileTrue:
	   [unaryBlock value: index.
	    index := index + stepInteger].
]

SmallInteger downTo: anInteger by: stepInteger do: unaryBlock
[
    | index |
    index := self.
    [index >= anInteger]
	whileTrue:
	   [unaryBlock value: index.
	    index := index + stepInteger].
]

SmallInteger timesRepeat: aBlock
[
    | count |
    count := self.
    [(count := count - 1) < 0] whileFalse: [aBlock value].
]
