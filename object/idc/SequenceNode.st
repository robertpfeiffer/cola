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

  Last edited: 2006-01-06 15:46:06 by piumarta on emilia.local
"

{ import: ParseNode }
{ import: OrderedCollection }

SequenceNode : ParseNode (
    temporaries		"a VariableNode for each named local temporary"
    statements		"a ParseNode for each statement within my body"
    scope		"the lexical scope that I represent"
    literals		"all (unique) LiteralNodes occurring within my body"
    blocks		"all BlockNodes occurring within my body"
)

SequenceNode initialize
[
    super initialize.
    temporaries := OrderedCollection new.
    statements := OrderedCollection new.
    scope := nil.
    literals := nil.
    blocks := OrderedCollection new.
]

SequenceNode addTemporary: aVariableNode	[ temporaries add: aVariableNode ]
SequenceNode addStatement: aNode		[ statements add: aNode ]
SequenceNode lastStatement			[ statements last ]
SequenceNode addBlock: blockNode		[ blocks add: blockNode ]

SequenceNode println: indent
[
    self printIndent: indent.
    ('| ', temporaries printString, ' |') println.
    statements do: [:stmt | stmt println: indent + 1].
]
