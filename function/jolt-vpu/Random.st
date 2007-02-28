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
