" Random.st -- streams of random numbers

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

  Last edited: 2007-02-28 14:28:22 by piumarta on emilia
"

{ import: Objects }

Random : Object ( seed a m q r )

Random new
[
    ^super new init
]

Random init
[
    [seed := 666. "(Time millisecondClockValue bitAnd: 16r3FFFFFFF) bitXor: self hash."
     seed = 0] whileTrue.
    a := 16807 asFloat.
    m := 1073741823 asFloat * 2.0.
    q := (m quo: a) asFloat.
    r := (m \\ a) asFloat.
]

Random next
[
    ^(seed := self nextValue) / m.
]

Random nextValue
[
    | lo hi aLoRHi |
    hi := (seed quo: q) asFloat.
    lo := seed - (hi * q).  " = seed rem: q"  
    aLoRHi := (a * lo) - (r * hi).
    ^(aLoRHi > 0.0) ifTrue: [aLoRHi] ifFalse: [aLoRHi + m].
]

Random nextInt: anInteger
[
    ^(self next * anInteger) truncated
]
