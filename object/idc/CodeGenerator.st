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

  Last edited: 2006-06-03 13:25:16 by piumarta on emilia.local
"

{ import: Object }
{ import: Symbol }
{ import: IdentityDictionary }
{ import: Encoder }
{ import: Smalltalk }

CodeGenerator : Object ( compiler encoder nextLabel )

CodeGenerators := [ IdentityDictionary new ]

CodeGenerator forExecutionModel: modelSymbol
[
    ^CodeGenerators at: modelSymbol ifAbsent: [self error: 'no code generator available for model ', modelSymbol]
]

CodeGenerator withCompiler: aCompiler encoder: anEncoder
[
    self := self new.
    compiler := aCompiler.
    encoder := anEncoder.
    nextLabel := 0.
]

CodeGenerator encoder	[ ^encoder ]
