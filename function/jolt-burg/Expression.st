" Expression.st -- symbolic expressions

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

  Last edited: 2007-02-28 14:49:08 by piumarta on emilia
"

{ import: Objects }

Expression : Array ( type )

Object isExpression		[ ^false ]
Expression isExpression		[ ^true ]

Expression type		[ ^type ]
Expression type: aType	[ ^type := aType ]

Object asExpression		[]
Expression asExpression		[]

Expression printOn: aStream
[
    super printContentsOn: aStream.
]

Array asExpression
[
    | expr |
    expr := Expression new: self size.
    0 to: self size - 1 do: [:i | expr at: i put: (self at: i) asExpression].
    ^expr
]

Object withParameters: aCollection	[]

Array withParameters: aCollection
[
    | in out |
    in  := ReadStream on: self.
    out := WriteStream on: (self new: self size).
    [in atEnd]
	whileFalse:
	   [out nextPut: ((in peek == #':'
			       ifTrue:  [aCollection at: (in next; next)]
			       ifFalse: [in next])
			      withParameters: aCollection)].
    ^out contents
]

Expression leftAssociated
[
    size < 4 ifTrue: [^self].
    ^self leftAssociated: size - 1
]

Expression leftAssociated: n
[
    n == 2 ifTrue: [^Expression with: self first with: self second with: self third].
    ^Expression with: self first with: (self leftAssociated: n - 1) with: (self at: n).
]

"----------------------------------------------------------------"

Type : Object ()

Type printOn: aStream	[ aStream nextPutAll: self name ]

VoidType : Type ()	VoidType name [ ^#V ]

NumericType : Type ()

Type	    isNumeric	[ ^false ]
NumericType isNumeric	[ ^true ]

IntegralType : NumericType ()

IntegralType signed	[ ^true ]

I1 : IntegralType ()	I1 name [ ^#I1 ]	I1 width [ ^1 ]		U1 : I1 ()	U1 name [ ^#U1 ]	U1 signed [ ^false ]
I2 : IntegralType ()	I2 name [ ^#I2 ]	I2 width [ ^2 ]		U2 : I2 ()	U2 name [ ^#U2 ]	U2 signed [ ^false ]
I4 : IntegralType ()	I4 name [ ^#I4 ]	I4 width [ ^4 ]		U4 : I4 ()	U4 name [ ^#U4 ]	U4 signed [ ^false ]
I8 : IntegralType ()	I8 name [ ^#I8 ]	I8 width [ ^8 ]		U8 : I8 ()	U8 name [ ^#U8 ]	U8 signed [ ^false ]

I1 qualify: anObject [ ^anObject I1 ]	U1 qualify: anObject [ ^anObject U1 ]
I2 qualify: anObject [ ^anObject I2 ]	U2 qualify: anObject [ ^anObject U2 ]
I4 qualify: anObject [ ^anObject I4 ]	U4 qualify: anObject [ ^anObject U4 ]
I8 qualify: anObject [ ^anObject I8 ]	U8 qualify: anObject [ ^anObject U8 ]

FloatingType : NumericType ()

F4 : FloatingType ()	F4 name [ ^#F4 ]	F4 width [ ^4 ]		F4 qualify: anObject [ ^anObject F4 ]
F8 : FloatingType ()	F8 name [ ^#F8 ]	F8 width [ ^8 ]		F8 qualify: anObject [ ^anObject F8 ]

PointerType : Type ( referentType )

Type        isPointer	[ ^false ]
PointerType isPointer	[ ^true ]

PointerType withReferentType: aType	[ ^self new referentType: aType ]

PointerType referentType: aType		[  referentType := aType ]
PointerType referentType		[ ^referentType ]

P4 : PointerType ()	P4 name [ ^#P4 ]	P4 width [ ^4 ]		P4 qualify: anObject [ ^anObject P4 ]	P4 asIntegerType [ ^U4 ]
P8 : PointerType ()	P8 name [ ^#P8 ]	P8 width [ ^8 ]		P8 qualify: anObject [ ^anObject P8 ]	P8 asIntegerType [ ^U4 ]

"ISO/IEC 9899:1999 §6.3.1.8 - Usual arithmetic conversions"

"If either operand has type long double, the other operand is converted to long double."
"Otherwise, if either operand has type double, the other operand is converted to double."

F8	     convertedWith: aType	[ ^aType convertedWithF8 ]
F4	     convertedWith: aType	[ ^aType convertedWithF4 ]

F8	     convertedWithF8		[ ^F8 ]
F8	     convertedWithF4		[ ^F8 ]
F4	     convertedWithF8		[ ^F8 ]
IntegralType convertedWithF8		[ ^F8 ]

"Otherwise, if either operand has type float, the other operand is converted to type float."

F4	     convertedWithF4		[ ^F4 ]
IntegralType convertedWithF4		[ ^F4 ]

Type	     convertedWithF8		[ ^self error: 'cannot convert ', self name, ' to double' ]
Type	     convertedWithF4		[ ^self error: 'cannot convert ', self name, ' to float' ]

"Otherwise, the integral promotions are first applied to both operands and then the following rules are applied."

IntegralType convertedWith: aType		[ ^aType convertedWithIntegral: self ]
FloatingType convertedWithIntegral: aType	[ ^self ]
IntegralType convertedWithIntegral: aType	[ ^self promoted convertedWithInt: aType promoted ]

U8 promoted	[ ^self ]
I8 promoted	[ ^self ]
U4 promoted	[ ^self ]
I4 promoted	[ ^self ]
U2 promoted	[ ^U4 ]
I2 promoted	[ ^I4 ]
U1 promoted	[ ^U4 ]
I1 promoted	[ ^I4 ]

U8 convertedWithInt: aType	[ ^aType convertedWithU8 ]
I8 convertedWithInt: aType	[ ^aType convertedWithI8 ]
U4 convertedWithInt: aType	[ ^aType convertedWithU4 ]
I4 convertedWithInt: aType	[ ^aType convertedWithI4 ]

Type convertedWithU8	[ ^self error: 'cannot convert ', self name, ' to unsigned long' ]
Type convertedWithI8	[ ^self error: 'cannot convert ', self name, ' to long' ]
Type convertedWithU4	[ ^self error: 'cannot convert ', self name, ' to unsigned int' ]
Type convertedWithI4	[ ^self error: 'cannot convert ', self name, ' to int' ]

"If either operand has type unsigned long int, the other operand is converted to unsigned long int."

U8 convertedWithU8	[ ^U8 ]
U8 convertedWithI8	[ ^U8 ]
U8 convertedWithU4	[ ^U8 ]
U8 convertedWithI4	[ ^U8 ]
I8 convertedWithU8	[ ^U8 ]
U4 convertedWithU8	[ ^U8 ]
I4 convertedWithU8	[ ^U8 ]

"Otherwise, if one operand has type long int and the other has type
 unsigned int, if a long int can represent all values of an unsigned
 int, the operand of type unsigned int is converted to long int; if a
 long int cannot represent all the values of an unsigned int, both
 operands are converted to unsigned long int."

I8 convertedWithU4	[ ^I8 ]
U4 convertedWithI8	[ ^I8 ]

"Otherwise, if either operand has type long int, the other operand is converted to long int."

I8 convertedWithI8	[ ^I8 ]
I8 convertedWithI4	[ ^I8 ]
I4 convertedWithI8	[ ^I8 ]

"Otherwise, if either operand has type unsigned int, the other operand is converted to unsigned int."

U4 convertedWithU4	[ ^U4 ]
U4 convertedWithI4	[ ^U4 ]
I4 convertedWithU4	[ ^U4 ]

"Otherwise, both operands have type int."

I4 convertedWithI4	[ ^I4 ]

"----------------------------------------------------------------"

StructureType : Type ( size alignment members )

MemberType : Type ( offset type )

"----------------------------------------------------------------"

"
Type test : x : y	[ StdOut print: x; tab; print: y; tab; print: (x convertedWith: y); cr ]
[
    | types |
    (types := OrderedCollection new) add: F8; add: F4; add: U8; add: I8; add: U4; add: I4; add: U2; add: I2; add: U1; add: I1.
    types do: [:l | types do: [:r | Type test : l : r ]].
]
"
