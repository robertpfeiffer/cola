" main.st -- jolt shell

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

  Last edited: 2007-04-25 17:17:22 by piumarta on emilia
"

{ import: Object }
{ import: Expression }
{ import: Scanner }
{ import: Compiler }
{ import: CodeGenerator }
{ import: CodeGenerator-local }

Options : Object ( verbose compile list libdir )

Options verbose		[ ^verbose ]
Options compile		[ ^compile ]
Options list		[ ^list ]
Options libdir: aString	[  libdir := aString ]
Options libdir		[ ^libdir ]

Options new
[
    self := super new.
    verbose := false.
]

Options parseOption: aString
[
    aString = '-v'		ifTrue: [^verbose := true].
    aString = '-c'		ifTrue: [^compile := true].
    aString = '-S'		ifTrue: [^list	  := true].
    (aString beginsWith: '-L')	ifTrue: [^libdir  := aString copyFrom: 2].
    ^false
]

[ Options := Options new ]

OSArgumentFiles := []

OS argumentFiles	[ ^OSArgumentFiles ifNil: [OSArgumentFiles := self makeArgumentFiles] ]

OS makeArgumentFiles
[
    | files file |
    files := OrderedCollection new.
    self arguments do: [:path |
	file := (path = '-') ifTrue: [StdIn] ifFalse: [(File openIfPresent: path) ifNil: [File open: Options libdir, '/', path]].
	file isNil ifTrue: [path error: path, ': No such file or directory'].
	files addLast: file].
    ^files
]

OS nextArgumentFile	[ ^OSArgumentFiles isEmpty ifFalse: [OSArgumentFiles removeFirst] ]


[
    | echo args file stream scanner expr interactive |
    Options libdir: (OS argumentAt: 0) dirname.
    interactive := false.
    (args := OS arguments) isEmpty
	ifTrue:
	   [args := OrderedCollection with: '-'.
            interactive := true].
    interactive
	ifTrue:
	   [StdOut
		nextPutAll: 'Welcome to Jolt 2.0 [';
		nextPutAll: CodeGenerator versionString;
		nextPutAll: ']\n'].
    args do: [:path |
	((Options parseOption: path) or: [CompilerOptions parseOption: path])
	    ifFalse:
	       [(path = '-')
		    ifTrue:  [file := StdIn]
		    ifFalse: [(file := File openIfPresent: path) ifFalse: [file := (File open: Options libdir, '/', path)]].
		file isNil ifTrue: [path error: path, ': No such file or directory'].
		stream := file readStream.
		echo := Options verbose or: [file isInteractive].
		" read - eval - print "
		[(expr := CokeScanner read: stream) isNil]
		    whileFalse:
		       [Options verbose ifTrue: [StdErr print: expr; cr].
			Options compile ifTrue: [expr compile].
			expr := expr eval.
			echo ifTrue: [StdErr nextPutAll: ' => '; print: expr; cr]]]].
    interactive
	ifTrue:
	   [StdErr nextPutAll: '\nmorituri te salutant\n'].
"
    StdErr nextPutAll: '; bytes compiled in lamba: '; print: Compiler lambdaCodeSize; cr.
    StdErr nextPutAll: '; bytes reclaimed in eval: '; print: Compiler evalCodeSize; cr.
"
]
