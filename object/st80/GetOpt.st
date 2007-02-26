" GetOpt.st -- command line parser

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

  Last edited: 2006-02-03 11:13:33 by piumarta on margaux.local
"

{ import: IdentityDictionary }
{ import: ReadStream }

" Smalltalk version of Unix getopt(3)-like command line parser.  Crash
  course:

  1) Create a GetOpt with 'GetOpt new'.
  2) Tell it what options to expect with 'getOpt at: optChar put: optBlock'
     where optChar is a character (the option, duh) and optBlock is a
     unary block (for options without arguments) or a binary block for
     options with arguments.  (The first block parameter is always the
     option letter that was matched; the second, if present, is the
     argument to the option.)
  3) Tell it what to do with option $? if you want to intercept unrecognised
     options.
  4) Send it 'default: unaryBlock' to tell it what to do with non-option
     arguments.
  5) Send it 'parse: aCollection' to parse the arguments in aCollection.

  Note that '-x foo' and '-xfoo' are handled correctly for an option
  'x' that expects an argument (in both cases the argument is 'foo').

  For anyone who didn't understand the crash course, the following:

    | files searchPath outputPath verbose |
    files := OrderedCollection new.
    searchPath := OrderedCollection new.
    outputPath := nil.
    verbose := false.
    GetOpt new
	at: $I put: [ :opt :arg | searchPath add: arg ];
	at: $o put: [ :opt :arg | outputPath := arg ];
	at: $v put: [ :opt | verbose := true ];
	at: $? put: [ :opt | self error: 'illegal option: -' , opt asString ];
	default: [ :arg | files add: arg ];
	parse: Smalltalk arguments startingAt: 1.

  will parse a compiler command line for include directories ('-I dir'
  option, argument appended to 'searchPath'), an output filename
  ('-o filename' option, argument left in 'outputPath'), a verbosity
  flag ('-v' option, setting 'verbose' to true), and zero or more input
  filenames (anything else, appended to 'files').  If you still don't
  understand then you shouldn't be here. "

GetOpt : IdentityDictionary (defaultBlock)

GetOpt new
[
  self := super new.
  defaultBlock := [:arg|].
]

GetOpt default: unaryBlock [ defaultBlock := unaryBlock ]

GetOpt parse: argumentCollection
[
    ^self parse: argumentCollection startingAt: 0
]

GetOpt parse: argumentCollection startingAt: offset
[
    | args |
    args := argumentCollection readStream skip: offset.
    [args atEnd]
	whileFalse:
          [ | arg |
            arg := args next.
            self parseArgument: arg with: args ]
]

GetOpt parseArgument: arg with: rest
[
    (arg first = $- and: [arg size > 1])
        ifTrue:  [self parseOption: arg with: rest]
	ifFalse: [defaultBlock value: arg]
]

GetOpt parseOption: option with: rest
[
    | block |
    block := self at: option second ifAbsent: [self at: $? ifAbsent: [^defaultBlock value: option]].
    ^block arity = 1
	ifTrue:  [self applyOption: option to: block]
	ifFalse: [self applyOption: option to: block with: rest]
]

GetOpt applyOption: anOption to: unaryBlock
[
    ^anOption size = 2
	ifTrue:  [unaryBlock value: anOption second]
	ifFalse: [self error: 'option ' , anOption , ' should not have an argument']
]

GetOpt applyOption: anOption to: binaryBlock with: rest
[
    ^anOption size = 2
	ifTrue:  [rest atEnd
                      ifTrue:  [self error: 'argument missing to option ' , anOption]
                      ifFalse: [binaryBlock value: anOption second value: rest next]]
	ifFalse: [binaryBlock value: anOption second value: (anOption copyFrom: 3)]
]
