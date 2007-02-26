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

  Last edited: 2006-06-02 14:03:54 by piumarta on emilia-2.local
"

{ import: Object }
{ import: Symbol }
{ import: OrderedCollection }

"I represent a canned set of options for an offline Compiler."

CompilerOptions : Object (
    searchPaths		"OrderedCollection of dir paths to search for included files"
    outputType		"#program, #shared, #object"
    verboseFlag		"whether to print gobs of useless debugging information"
    macroFlag		"whether to expand macro selectors in-line"
    specialFlag		"whether to expand special selector in-line"
    taggedFlag		"whether to expand tagged integer arithmetic in-line"
    cacheLevel		"0 = no cache; 1 = inline cache"
    executionModel	"0 = no cache; 1 = inline cache"
)

CompilerOptions initialize
[
    searchPaths := OrderedCollection new.	"DEFAULTS:"
    outputType := #shared.	"generate a shared library"
    verboseFlag := false.	"don't print lots of debugging noise"
    macroFlag := true.		"do generate inline versions of macro selectors"
    specialFlag := true.	"do generate inline special selectors"
    taggedFlag := true.		"do generate inline tagged arithmetic operators"
    cacheLevel := 0.		"probe the global method cache at ever send site"
    executionModel := #native.	"generate sends on the C stack"
    searchPaths add: '.'.	"look in '.' for included files"
]

"BUG: this should all be in a Dictionary"

CompilerOptions searchPaths		[ ^searchPaths ]

CompilerOptions cacheLevel: aString
[
    aString = '0' ifTrue: [^cacheLevel := 0].
    aString = '1' ifTrue: [^cacheLevel := 1].
    self error: 'illegal cache level: ', aString.
]

CompilerOptions cacheLevel		[ ^cacheLevel ]

CompilerOptions macroFlag: aBoolean	[  macroFlag := aBoolean ]
CompilerOptions macroFlag		[ ^macroFlag ]

CompilerOptions outputType: typeSymbol	[  outputType := typeSymbol ]
CompilerOptions outputType		[ ^outputType ]

CompilerOptions specialFlag: aBoolean	[  specialFlag := aBoolean ]
CompilerOptions specialFlag		[ ^specialFlag ]

CompilerOptions taggedFlag: aBoolean	[  taggedFlag := aBoolean ]
CompilerOptions taggedFlag		[ ^taggedFlag ]

CompilerOptions verboseFlag: aBoolean	[  verboseFlag := aBoolean ]
CompilerOptions verboseFlag		[ ^verboseFlag ]

CompilerOptions executionModel: aString
[
    aString = 'native'  ifTrue: [^executionModel := #native].
    aString = 'managed' ifTrue: [^executionModel := #managed].
    self error: 'illegal execution model: ', aString.
]

CompilerOptions executionModel		[ ^executionModel ]
