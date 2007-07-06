" idc1.st -- command-line (offline) compiler main program	-*- Smalltalk -*-

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

  Last edited: 2007-07-05 14:02:44 by piumarta on emilia.lax04.mtt
"

{ import: st80 }
{ import: idst }

[
    | files options outputPath |
    files := OrderedCollection new.
    options := CompilerOptions new.
    outputPath := nil.
    "parse command-line options"
    GetOpt new
	at: $c put: [ :opt      | options outputType: #object ];
	at: $g put: [ :opt      | options debugging: true ];
	at: $I put: [ :opt :arg | options searchPaths addFirst: arg ];
	at: $m put: [ :opt      | options outputType: #program ];
	at: $M put: [ :opt      | options macroFlag: false ];
	at: $N put: [ :opt :arg | options cacheLevel: arg ];
	at: $o put: [ :opt :arg | outputPath := arg ];
	at: $s put: [ :opt      | options outputType: #shared ];
	at: $S put: [ :opt      | options specialFlag: false ];
	at: $T put: [ :opt      | options taggedFlag: false ];
	at: $v put: [ :opt      | options verboseFlag: true ];
	at: $x put: [ :opt :arg | options executionModel: arg ];
	at: $? put: [ :opt      | Compiler error: 'illegal option: -' , opt asString ];
	default: [ :arg | files add: arg ];
	parse: Smalltalk arguments startingAt: 0.
    files size < 1 ifTrue: [Compiler error: 'no source file specified'].
    files size > 1 ifTrue: [Compiler error: 'multiple source files specified'].
    "search '.' for included files first, unless order specified explicitly"
    (options searchPaths includes: '.') ifFalse: [options searchPaths addFirst: '.'].
    "run the compiler"
"   ('compiling ', files first printString, ' to ', outputPath printString, ' searching ', options searchPaths printString) putln."
    Compiler
	compileFile: files first
	toFile:      outputPath
	withOptions: options
]
