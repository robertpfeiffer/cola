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

  Last edited: 2007-02-28 14:43:49 by piumarta on emilia
"

{ import: Object }
{ import: Expression }
{ import: Scanner }
{ import: VPU }
{ import: Compiler }

Options : Object ( verbose )

Options verbose	[ ^verbose ]

Options new
[
    self := super new.
    verbose := false.
]

[ Options := Options new ]
    
Options parseOption: aString
[
    aString = '-ve' ifTrue: [^verbose := true].
    ^false
]

OSArgumentFiles := [ OrderedCollection new ]

OS argumentFiles	[ ^OSArgumentFiles ]
OS nextArgumentFile	[ ^OSArgumentFiles isEmpty ifFalse: [OSArgumentFiles removeFirst] ]

[
    | echo args file scanner expr interactive |
    interactive := false.
    (args := OS arguments) isEmpty ifTrue: [args := Array with: '-'].
    args do: [:path |
	((Options parseOption: path) or: [Compiler parseOption: path])
	    ifFalse:
	       [file := (path = '-') ifTrue: [StdIn] ifFalse: [File open: path].
		file isNil ifTrue: [path error: path, ': No such file or directory'].
		file isInteractive ifTrue: [interactive := true].
		OSArgumentFiles addLast: file]].
    interactive
	ifTrue: [StdOut
		     nextPutAll: 'Welcome to Jolt 0.1 [';
		     nextPutAll: VPU versionString;
		     nextPutAll: ']\n'].
    [OSArgumentFiles isEmpty]
	whileFalse:
	   [file := OSArgumentFiles removeFirst.
	    scanner := CokeScanner on: file readStream.
	    echo := Options verbose or: [file isInteractive].
	    " read - eval - print "
	    [(expr := scanner next) isNil]
		whileFalse:
		   [Options verbose ifTrue: [StdErr print: expr; cr].
		    expr := expr eval.
		    echo ifTrue: [StdErr nextPutAll: ' => '; print: expr; cr]]].
    interactive ifTrue: [StdErr nextPutAll: '\nmorituri te salutant\n'].
"
    StdErr nextPutAll: '; bytes compiled in lamba: '; print: Compiler lambdaCodeSize; cr.
    StdErr nextPutAll: '; bytes reclaimed in eval: '; print: Compiler evalCodeSize; cr.
"
]
