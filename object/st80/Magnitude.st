" Magnitude.st -- support for scalar quantities

  Copyright (c) 2005 Ian Piumarta
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

  Last edited: 2006-02-02 23:13:40 by piumarta on margaux.local
"

{ import: Object }

Magnitude : Object ()

Magnitude min: aMagnitude	[ ^self < aMagnitude ifTrue: [self] ifFalse: [aMagnitude] ]
Magnitude max: aMagnitude	[ ^self < aMagnitude ifTrue: [aMagnitude] ifFalse: [self] ]

Magnitude between: lower and: upper
[
    ^self >= lower and: [self <= upper]
]

Magnitude <  aMagnitude		[ ^self subclassResponsibility: '<' ]
Magnitude <= aMagnitude		[ ^self < aMagnitude or: [self = aMagnitude] ]
Magnitude ~= aMagnitude		[ ^(self = aMagnitude) not ]
Magnitude >= aMagnitude		[ ^(self < aMagnitude) not ]
Magnitude >  aMagnitude		[ ^(self <= aMagnitude) not ]
