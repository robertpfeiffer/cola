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

  Last edited: 2007-02-21 20:38:53 by piumarta on emilia.lax02.mtt
"

{ import: LocalVariableNode }

ArgumentVariableNode : LocalVariableNode (
    tied	"VariableNode - tied variable for stores"
)

ArgumentVariableNode tied: varNode	[ ^tied := varNode ]
ArgumentVariableNode tied		[ ^tied ]

ArgumentVariableNode freeWithin: innerScope
[
    super freeWithin: innerScope.
    tied ifTrue: [tied freeWithin: innerScope].
]

ArgumentVariableNode generate: gen location: location
[
    gen loadArgument: self location: location
]

ArgumentVariableNode generateStore: gen location: location
[
    gen storeArgument: self location: location.
    tied ifTrue: [tied generateStore: gen location: location]
]

ArgumentVariableNode generateStore: gen freeIn: innerLevel location: location
[
    super generateStore: gen freeIn: innerLevel location: location.
    tied ifTrue: [tied generateStore: gen freeIn: innerLevel location: location].
]
