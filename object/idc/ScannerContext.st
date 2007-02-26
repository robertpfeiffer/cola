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

  Last edited: 2005-12-21 21:00:35 by piumarta on emilia.local
"


"I represent a source of input characters: a file name, line number,
 and a stream over the contents of the named file."

{ import: Object }

ScannerContext : Object ( file line stream )

ScannerContext onFileNamed: pathName
[
    self := super new.
    file := pathName.
    line := 1.
    stream := file fileContents readStream.
]

ScannerContext file	[ ^file ]
ScannerContext line	[ ^line ]
ScannerContext atEnd	[ ^stream atEnd ]
ScannerContext peek	[ ^stream peek ]

ScannerContext next
[
    | c |
    (c := stream next) == $\n ifTrue: [line := line + 1].
    ^c
]
