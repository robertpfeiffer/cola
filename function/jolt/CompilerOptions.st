{ import: Objects }

CompilerOptions : Object ( verboseList verboseTree verboseRegs verboseExec verboseSyntax )

CompilerOptions verboseList		[ ^verboseList ]
CompilerOptions verboseTree		[ ^verboseTree ]
CompilerOptions verboseRegs		[ ^verboseRegs ]
CompilerOptions verboseExec		[ ^verboseExec ]
CompilerOptions verboseSyntax		[ ^verboseSyntax ]

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
