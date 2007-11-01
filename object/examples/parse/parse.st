{ import: st80 }
{ import: idst }

Compiler program
[
    ^program
]

Compiler withOptions: compilerOptions
[
    self := self new.
    options := compilerOptions.
]

ParseNode	isImported	[ ^false ]
PrototypeNode	isImported	[ ^external ]
ImportNode	isImported	[ ^included ]

[
    | options compiler |
    options := CompilerOptions new.
    options searchPaths add: '.'.
    options searchPaths add: '../../st80'.
    options searchPaths add: '../../idc'.
    compiler := Compiler withOptions: options.
    compiler input: 'parse.st'.
    compiler program do: [:node |
	node isImported
	    ifFalse:
	       [node position file put.
		'\t' put.
		node position line print.
		'\t' put.
		node print.
		'\n' put.
		node println: 4.
	    ]].
]
