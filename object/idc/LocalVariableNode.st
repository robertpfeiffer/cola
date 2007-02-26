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

  Last edited: 2005-12-21 20:38:58 by piumarta on emilia.local
"

{ import: EncodedVariableNode }

"I represent a local variable: an argument or a named temporay."

LocalVariableNode : EncodedVariableNode (
    index	"1-based index (arguments and temporaries DISJOINT)"
)

LocalVariableNode withName: nameString position: aPosition scope: aScope
[
    self := super withName: nameString position: aPosition scope: aScope.
    index := nil.
]

LocalVariableNode index: anIndex	[  index := anIndex ]
LocalVariableNode index			[ ^index ]
