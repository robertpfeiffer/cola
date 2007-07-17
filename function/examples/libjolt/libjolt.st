" jolt.st -- jolt library shell

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

  Last edited: 2007-07-16 20:22:15 by piumarta on emilia
"

{ import: Object }
{ import: Scanner }
{ import: Compiler }
{ import: CodeGenerator-local }
{ import: Options }

{ include "boot.h" }

Jolt : Object ()

Jolt initialise
[
    | _boot stream expr result |

    { v__boot= (oop)boot; }.

    stream := (String value_: _boot) readStream.
    [(expr := CokeScanner read: stream)] whileTrue: [expr _eval].

    stream :=
        '(lambda (_string)
           (let ((string  [String value_: _string])
                 (stream  [string readStream])
                 (expr    0)
                 (result  0))
             (while (set expr [CokeScanner read: stream])
               (set result [expr _eval]))
             result))' readStream.
    ^(CokeScanner read: stream) _eval
]
