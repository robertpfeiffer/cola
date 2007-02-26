"							-*- Smalltalk -*-
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

  Last edited: 2006-02-24 11:08:56 by piumarta on emilia.local
"

{ import: LocalVariableNode }

"I represent a named temporary (automatic) variable."

TemporaryVariableNode : LocalVariableNode ()

TemporaryVariableNode generate: gen location: location
[
    gen loadTemporary: self location: location
]

TemporaryVariableNode generateStore: gen location: location
[
    ^gen storeTemporary: self location: location
]
