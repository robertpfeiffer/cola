" Options.st -- Jolt options

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

  Last edited: 2007-07-16 21:26:58 by piumarta on emilia
"

{ import: Objects }

Options : Object ( verbose compile list libdir )

Options verbose		[ ^verbose ]
Options compile		[ ^compile ]
Options list		[ ^list ]
Options libdir: aString	[  libdir := aString ]
Options libdir		[ ^libdir ]

Options new
[
    self := super new.
    verbose := false.
]

Options parseOption: aString
[
    aString = '-v'		ifTrue: [^verbose := true].
    aString = '-c'		ifTrue: [^compile := true].
    aString = '-S'		ifTrue: [^list	  := true].
    (aString beginsWith: '-L')	ifTrue: [^libdir  := aString copyFrom: 2].
    ^false
]

[ Options := Options new ]
