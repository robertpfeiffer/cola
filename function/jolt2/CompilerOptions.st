" CompilerOptions.st -- holder for command-line options

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

  Last edited: 2007-04-26 14:10:38 by piumarta on emilia
"

{ import: Objects }

CompilerOptions : Object ( verboseList verboseTree verboseRegs verboseExec verboseSyntax )

CompilerOptions verboseList		[ ^verboseList ]
CompilerOptions verboseList: flag	[ ^verboseList := flag ]
CompilerOptions verboseTree		[ ^verboseTree ]
CompilerOptions verboseTree: flag	[ ^verboseTree := flag ]
CompilerOptions verboseRegs		[ ^verboseRegs ]
CompilerOptions verboseRegs: flag	[ ^verboseRegs := flag ]
CompilerOptions verboseExec		[ ^verboseExec ]
CompilerOptions verboseExec: flag	[ ^verboseExec := flag ]
CompilerOptions verboseSyntax		[ ^verboseSyntax ]
CompilerOptions verboseSyntax: flag	[ ^verboseSyntax := flag ]

CompilerOptions parseOption: aString
[
    aString = '-vl' ifTrue: [^verboseList   := true].
    aString = '-vt' ifTrue: [^verboseTree   := true].
    aString = '-vr' ifTrue: [^verboseRegs   := true].
    aString = '-vx' ifTrue: [^verboseExec   := true].
    aString = '-vs' ifTrue: [^verboseSyntax := true].
    ^false
]

[ CompilerOptions := CompilerOptions new ]
