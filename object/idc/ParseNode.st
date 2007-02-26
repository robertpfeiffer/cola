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

  Last edited: 2006-01-06 15:45:00 by piumarta on emilia.local
"

{ import: Object }

ParseNode : Object (
    position	"ScannerPosition at representative point within node"
    location	"backend cookie for physical location of node value"
)

ParseNode withPosition: aPosition
[
    self := super new.
    position := aPosition.
]

ParseNode initialize
[
    super initialize.
    location := nil.
]

ParseNode new
[
    self error: 'instances of ', self printString, ' are created with #withPosition:'
]

ParseNode location: aLocation
[
    location := aLocation
]

ParseNode position	[ ^position ]
ParseNode location	[ ^location ]

ParseNode printIndent: indent
[
    indent timesRepeat: ['  ' print].
]

ParseNode println: indent
[
    self printIndent: indent.
    self println.
]
