"							-*- Smalltalk -*-
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

  Last edited: 2005-12-21 21:00:48 by piumarta on emilia.local
"

"I represent an input location: file name and line number."

{ import: Object }

ScannerPosition : Object ( file line )


ScannerPosition withFile: fileName line: lineNumber
[
    self := self new.
    file := fileName.
    line := lineNumber.
]

ScannerPosition position
[
    ^self
]

ScannerPosition printOn: aStream
[
    aStream nextPutAll: file; nextPut: $:; print: line
]
