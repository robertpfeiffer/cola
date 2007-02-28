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
