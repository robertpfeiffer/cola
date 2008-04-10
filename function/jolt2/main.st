{ import: Object }

{ import: Expression }
{ import: Compiler }
{ import: CodeGenerator }
{ import: CodeGenerator-local }
{ import: Options }

{ import: ColaGrammar }
{ import: Parser }

{ import: ParsingExpression-printing }

ColaParser := [ nil ]

_object doesNotUnderstand: aSelector
[
    | _cName _cSelector |
    _cName := self _debugName.
    _cSelector := aSelector _stringValue.
    {
	fprintf(stderr, "\n");
	fputs(_backtrace(), stderr);
	fprintf(stderr, "\n%s does not understand '%s'\n\n", (char *)v__cName, (char *)v__cSelector);
    }.
    ColaParser backtrace.
    {
	exit(1);
    }
]

Object error: reason
[
    StdErr cr.
    StdErr backtrace.
    StdErr cr; nextPutAll: reason; cr; cr.
    ColaParser backtrace.
    { exit(1); }.
]

Grammar translate: aCompiler
[
"
    ^(Expression
	  with: #send
	  with: (Expression with: #quote with: #parse:)
	  with: (Expression with: #quote with: self)
	  with: (Expression with: #quote with: ColaParser))
	translate: aCompiler
"
    ^(Expression
	  with: #'apply-grammar'
	  with: self
	  with: ColaParser)
	translate: aCompiler
"
    ^(Expression with: #quote with: self)
	translate: aCompiler
"
]

Grammar parse: aParser
[
    ^startRule ifTrue: [(startRule parse: aParser) ifTrue: [aParser result]]
]

Grammar match: anObject
[
    ^startRule ifTrue: [startRule match: anObject]
]

ParsingExpression match: anObject
[
    | parser |
    parser := Parser on: anObject.
    "StdOut nextPutAll: 'MATCH '; println: anObject."
    ^(self parse: parser) ifTrue: [parser result]
]


ColaEvaluator : Object ()

ColaEvaluator map: aBlock
[
    | expr |
    [expr := ColaParser next]
	whileTrue:
	   [expr := aBlock value: expr].
    ^expr
]

ColaEvaluator readFileNamed: fileName
[
    self readFile: (fileName = '-' ifTrue: [StdIn] ifFalse: [File open: fileName])
]

ColaEvaluator readFile: aFile
[
    | outer |
    outer := ColaParser.
    ColaParser := ColaFunctionGrammar parserOn: aFile.		"xxx NOT REENTRANT! xxx"
    self map: [:expr |
	Options verbose ifTrue: [expr println].
	expr := expr eval.
	Options verbose ifTrue: [StdOut nextPutAll: ' => '; println: expr]].
    ColaParser := outer.
]


[
    | done |
    "ColaFunctionGrammar println."
    Options libdir: '.'.
    OS arguments do: [:arg | (Options parseOption: arg) ifFalse: [ColaEvaluator readFileNamed: (done := arg)]].
    done ifFalse: [ColaEvaluator readFile: StdIn].
]
