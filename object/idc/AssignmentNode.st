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

  Last edited: 2007-02-21 20:22:45 by piumarta on emilia.lax02.mtt
"

{ import: ParseNode }

"I represent an assignment to a variable."

AssignmentNode : ParseNode (
    value	"ParseNode containing the value to assign from"
    variable	"VariableNode naming the location to be assigned to"
)

AssignmentNode withVariable: variableNode value: valueNode position: aPosition
[
    self := self withPosition: aPosition.
    value := valueNode.
    variable := variableNode.
]

AssignmentNode encode: encoder
[
    location := value encode: encoder; location.
    variable encodeLvalue: encoder location: location.
]

AssignmentNode generate: gen
[
    value generate: gen.
    variable generateStore: gen.
]

AssignmentNode println: indent
[
    self printIndent: indent.
    ':=' println.
    variable println: indent + 1.
    value println: indent + 1.
]
