{ import: Object }
{ import: Match }

{ import: Expression }
{ import: Compiler }
{ import: CodeGenerator }
{ import: CodeGenerator-local }
{ import: Options }


MatchName : Match ( ruleName grammarName )

MatchName withName: nameString
[
    self := self new.
    ruleName := nameString.
]

MatchName withName: nameString grammar: grammarString
[
    self := self new.
    ruleName := nameString.
    grammarName := grammarString.
]

MatchName printOn: aStream
[
    grammarName ifTrue: [aStream print: grammarName; nextPut: $-].
    ruleName printOn: aStream
]

MatchRule resolveMatchNamesIn: aGrammar	[ match := match resolveNamesIn: aGrammar ]

Match resolveNamesIn: aGrammar		[]
MatchSingle resolveNamesIn: aGrammar	[ match := match resolveNamesIn: aGrammar ]
MatchMultiple resolveNamesIn: aGrammar	[ submatches := submatches collect: [:m | m resolveNamesIn: aGrammar] ]
MatchRule resolveNamesIn: aGrammar	[]

MatchName resolveNamesIn: aGrammar
[
    ^(grammarName ifTrue: [aGrammar grammarAt: grammarName] ifFalse: [aGrammar])
	ruleAt: ruleName
]


Grammars := [ IdentityDictionary new ]

Grammar : IdentityDictionary ( grammarName startRule subGrammars )

Grammar new
[
    self := super new.
    subGrammars := IdentityDictionary new.
]

Grammar name: aSymbol		[ grammarName := aSymbol ]

Grammar startRule		[ ^startRule ]

Grammar startRule: aRule
[
    startRule := aRule resolveNamesIn: self.
    self do: [:assoc | assoc value resolveMatchNamesIn: self].
]

Grammar grammarAt: nameString			[ ^Grammars at: nameString asSymbol ]
Grammar grammarAt: nameString put: aGrammar	[ ^Grammars at: nameString asSymbol put: aGrammar ]

Grammar at: ruleName put: rule	[ ^(self at: ruleName asSymbol) matches: rule ]

Grammar at: ruleName
[
    ruleName := ruleName asSymbol.
    ^super at: ruleName ifAbsent: [super at: ruleName put: (self newRuleNamed: ruleName)]
]

Grammar ruleAt: ruleName
[
    ruleName := ruleName asSymbol.
    ^super at: ruleName asSymbol ifAbsent: [subGrammars do: [:assoc | assoc value ruleAt: ruleName]]
]

Grammar addRule: matchRule	[ super at: matchRule name put: matchRule ]

Grammar newRuleNamed: ruleName	[ ^self subtypeResponsibility: #newRuleNamed: ]

Grammar printOn: aStream
[
    grammarName
	ifTrue: [aStream nextPutAll: '{ '; nextPutAll: grammarName; nextPutAll: ' }']
	ifFalse:
	   [aStream nextPutAll: '{\n'.
	    self do: [:assoc |
		aStream nextPutAll: '  '.
		assoc key printOn: aStream.
		aStream nextPutAll: ' -> '.
		assoc value printMatchOn: aStream.
		aStream nextPutAll: ' ;\n'].
	    startRule
		ifTrue:
		    [aStream nextPutAll: '  '.
		     startRule printOn: aStream.
		     aStream cr].
	    aStream nextPutAll: '}\n']
]

Grammar match: aStream		[ ^startRule match: aStream ]


ParsingExpressionGrammar : Grammar ()

ParsingExpressionGrammar newRuleNamed: ruleName		[ ^Match named: ruleName ]


Parser : Object ( grammar parseStream )

Parser on: aCollection
[
    ^self withGrammar: self defaultGrammar on: aCollection
]

Parser withGrammar: aGrammar on: aCollection
[
    self := super new.
    grammar := aGrammar.
    parseStream := aCollection parseStream.
]

Parser parseStream	[ ^ParseStream on: self ]
Parser collectionType	[ ^Array ]
Parser readStream	[ ^self ]

Parser getParseStream	[ ^parseStream ]
Parser next		[ ^grammar match: parseStream ]

"
Parser checkSanity
[
    self valuesDo: [:rule |
	StdErr print: rule; println: 'recursion'.
	rule consumesInput.
	StdErr print: rule; println: 'loop'.
	rule loopsForever].
]
"

"----------------------------------------------------------------"

Grammar pegGrammar
[
    | error eof eol space comment _ equal minus colon semicolon bar and not query
      star plus open close dot begin end lbrace rbrace rarrow
      plainChar escapeChar escapeSeq char range class literal
      identifier number action primary suffix prefix sequence expression definition grammar |

    self := ParsingExpressionGrammar new.
    
    expression	:= self at: #expression.	"forward"
    grammar	:= self at: #grammar.		"forward"

    error	:= self at: #error	put: (	[:p | p error: 'syntax error near: <', p contents, '>'] matchImmediate  ).

    "lexical syntax"

    eof		:= self at: #eof	put: (	MatchAny not  ).
    eol		:= self at: #eol	put: (	( '\r' match , '\n' match zeroOrMore ) | ( '\n' match , '\r' match zeroOrMore )  ).
    space	:= self at: #space	put: (	' \t' matchClass | eol  ).
    comment	:= self at: #comment	put: (	'#' match , (eol not , MatchAny) zeroOrMore , eol  ).
    _		:= self at: #_		put: (	( space | comment ) zeroOrMore  ).

    equal	:= self at: #equal	put: (	'=' match , _  ).
    minus	:= self at: #minus	put: (	'-' match , _  ).
    colon	:= self at: #colon	put: (	':' match , _  ).
    semicolon	:= self at: #semicolon	put: (	';' match , _  ).
    bar		:= self at: #bar	put: (	'|' match , _  ).
    and		:= self at: #and	put: (	'&' match , _  ).
    not		:= self at: #not	put: (	'!' match , _  ).
    query	:= self at: #query	put: (	'?' match , _  ).
    star	:= self at: #star	put: (	'*' match , _  ).
    plus	:= self at: #plus	put: (	'+' match , _  ).
    open	:= self at: #open	put: (	'(' match , _  ).
    close	:= self at: #close	put: (	')' match , _  ).
    dot		:= self at: #dot	put: (	'.' match , _  ).
    begin	:= self at: #begin	put: (	'<' match , _  ).
    end		:= self at: #end	put: (	'>' match , _  ).
    lbrace	:= self at: #lbrace	put: (	'{' match , _  ).
    rbrace	:= self at: #rbrace	put: (	'}' match , _  ).

    rarrow	:= self at: #rarrow	put: (	'->' match , _  ).

    plainChar	:= self at: #plainChar	put: (	MatchBegin , MatchAny , MatchEnd -> [:p | p text first]  ).
    escapeChar	:= self at: #escapeChar	put: (	( 'a' match	-> [$\a] )
					     |	( 'b' match	-> [$\b] )
					     |	( 'e' match	-> [$\e] )
					     |	( 'f' match	-> [$\f] )
					     |	( 'n' match	-> [$\n] )
					     |	( 'r' match	-> [$\r] )
					     |	( 't' match	-> [$\t] )
					     |	( 'v' match	-> [$\v] )  ).
    escapeSeq	:= self at: #escapeSeq	put: (	'\\' match , ( escapeChar | plainChar )  ).
    char	:= self at: #char	put: (	escapeSeq | plainChar  ).

    range	:= self at: #range	put: (	char->0->1 , ( '-' match , char->1 ) zeroOrOne -> [:p | String with: p@0 with: $- with: p@1]  ).

    class	:= self at: #class	put: (	    '[' match -> [WriteStream on: (String new: 32)]->0
						, ( ']' match not , range->1	-> [:p | (p@0) nextPutAll: (p@1)] ) zeroOrMore
						,   ']' , _			-> [:p | (p@0) contents matchClass] ).

    literal	:= self at: #literal	put: (	(     '"'  match -> [WriteStream on: (String new: 32)]->0
						  , ( '"'  match not , char->1	-> [:p | (p@0) nextPut: (p@1)] ) zeroOrMore
						  ,   '"'  , _			-> [:p | (p@0) contents match] )
					     |	(     '''' match -> [WriteStream on: (String new: 32)]->0
						  , ( '''' match not , char->1	-> [:p | (p@0) nextPut: (p@1)] ) zeroOrMore
						  ,   '''' , _			-> [:p | (p@0) contents match] )  ).

    identifier	:= self at: #identifier	put: (	MatchBegin , 'a-zA-Z_' matchClass , '0-9a-zA-Z_' matchClass zeroOrMore , MatchEnd , _ ->[:p | p text]  ).

    number	:= self at: #number	put: (	MatchBegin , '0-9' matchClass oneOrMore , MatchEnd , _ ->[:p | p text inject: 0 into: [:n :c | n * 10 + c digitValue]]  ).

    action	:= self at: #action	put: (	rarrow , ( ( number->0 	->[:p | MatchImmediateStore withIndex: p@0]->0 )
							 | ( [:p || body |
							     (body := ((CokeGrammar at: #expr) match: p))
								 ifTrue: [MatchImmediateValue
									      withMethod_: (Expression with: #lambda
												       with: #(_closure self parser)
												       with: body) _eval]] matchImmediate ->0 , _ )
							 )
						-> [:p|p@0]  ).

    "hierarchical syntax"

    primary	:= self at: #primary	put: (	( identifier->0 , '-' , identifier->1 	->[:p | MatchName withName: (p@1) asSymbol grammar: (p@0) asSymbol] )
					     |	( identifier->0 , equal not		->[:p | MatchName withName: (p@0) asSymbol] )
					     |	( open   , expression->0 , close		->[:p | p@0] )
					     |	( begin  , expression->0 , end		->[:p | MatchBegin , (p@0) , MatchEnd] )
					    "|	( lbrace , grammar->0 , rbrace		->[:p | MatchGrammar withTarget: (p@0)] )"
					     |	( literal )
					     |	( class )
					     |	( dot					->[MatchAny] )
					     |	( action )  ).

    suffix	:= self at: #suffix	put: (	primary->0 , ( ( query ->[:p|(p@0) zeroOrOne ]->0 )
							     | ( star  ->[:p|(p@0) zeroOrMore]->0 )
							     | ( plus  ->[:p|(p@0) oneOrMore ]->0 ) ) zeroOrOne ->[:p|p@0]  ).

    prefix	:= self at: #prefix	put: (	( not , suffix ->[:p|p result not] )
					     |	( and , suffix ->[:p|p result peek] )
					     |	suffix  ).
    
    sequence	:= self at: #sequence	put: (	prefix->0 , ( prefix->1 ->[:p|(p@0),(p@1)]->0 ) zeroOrMore ->[:p|p@0]  ).

    expression	:= self at: #expression	put: (	sequence->0 , ( bar , sequence->1 ->[:p|(p@0)|(p@1)]->0 ) zeroOrMore ->[:p|p@0]  ).

    definition	:= self at: #definition	put: (	_ , ( identifier->0 , equal , expression->1 , semicolon zeroOrOne ->[:p | (p@1) print named: (p@0) asSymbol] )
						    | eof
						    | error  ).

    grammar	:= self at: #grammar	put: (	_ ->[PEGGrammar new]->0
						, ( ( identifier->1 , colon , equal		  	->[:p | Grammars at: (p@1) asSymbol put: (p@0 name: p@1)] )
						  | ( identifier->1 , colon , identifier->2 , equal	->[:p | Grammars at: (p@1) asSymbol put: (p@0 name: p@1)] )
						  | ( identifier->1 , minus				->[:p | Grammars at: (p@1) asSymbol]->0 ) ) zeroOrOne
						, ( identifier->1 , equal , expression->2 , semicolon zeroOrMore ->[:p | (p@0) at: (p@1) asSymbol put: (p@2)] ) zeroOrMore
						, ( expression->1 ->[:p | p@0 startRule: p@1] )	zeroOrOne
						  ->[:p|p@0]  ).

    self startRule: grammar.
]

"----------------------------------------------------------------"

Grammar cokeGrammar
[
    | expr error eof eol space comment _
      digit letter number name escapeChar escapeSeq plainChar char string literal atom list
      alpha other unary binary keyword unymsg binmsg keyarg keymsg message send
      syntax
      expression |

    self := ParsingExpressionGrammar new.
    
    expr	:= self at: #expr.	"forward"

    error	:= self at: #error	put: (	[:p | p error: 'syntax error near: <', p "reset" contents, '>'] matchImmediate  ).

    eof		:= self at: #eof	put: (	MatchAny not  									).
    eol		:= self at: #eol	put: (	('\n' match , '\r' match zeroOrMore) |  ('\r' match , '\n' match zeroOrMore)	).
    space	:= self at: #space	put: (	' \t' matchClass | eol  							).
    comment	:= self at: #comment	put: (	';' match , ( eol not , MatchAny ) zeroOrMore , eol  				).
    _		:= self at: #_		put: (	( space | comment ) zeroOrMore  						).

    "lambda syntax"

    digit	:= self at: #digit	put: (	'0123456789' matchClass  ).
    letter	:= self at: #letter	put: (	'-!#$%&*+./:<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ\\^_abcdefghijklmnopqrstuvwxyz|~' matchClass  ).

    number	:= self at: #number	put: (	MatchBegin , '-+' matchClass zeroOrOne , digit oneOrMore , MatchEnd	-> [:p | Integer fromString: p text]  ).
    name	:= self at: #name	put: (	MatchBegin , letter , ( letter | digit ) zeroOrMore , MatchEnd		-> [:p | p text asSymbol]  	      ).
    plainChar	:= self at: #plainChar	put: (	MatchBegin , MatchAny , MatchEnd -> [:p | p text first]  ).
    escapeChar	:= self at: #escapeChar	put: (	( 'a' match	-> [$\a] )
					     |	( 'b' match	-> [$\b] )
					     |	( 'e' match	-> [$\e] )
					     |	( 'f' match	-> [$\f] )
					     |	( 'n' match	-> [$\n] )
					     |	( 'r' match	-> [$\r] )
					     |	( 't' match	-> [$\t] )
					     |	( 'v' match	-> [$\v] )  ).
    escapeSeq	:= self at: #escapeSeq	put: (	'\\' match , ( escapeChar | plainChar )  ).
    char	:= self at: #char	put: (	escapeSeq | plainChar  ).
    string	:= self at: #string	put: (	'"' match -> [WriteStream on: (String new: 32)]->0
						    , ('"' match not , char->1	-> [:p | (p@0) nextPut: (p@1)] ) zeroOrMore
						    , '"' 			-> [:p | (p@0) contents]  ).
    literal	:= self at: #literal	put: (	( '''' match , expr->1 -> [:p | Expression with: #quote		     with: p@1] )
					     |	( '`'  match , expr->1 -> [:p | Expression with: #quasiquote	     with: p@1] )
					     |	( ',@' match , expr->1 -> [:p | Expression with: #'unquote-splicing' with: p@1] )
					     |	( ','  match , expr->1 -> [:p | Expression with: #unquote	     with: p@1] )  ).

    atom	:= self at: #atom	put: (	number | name | string | literal  ).

    list	:= self at: #list	put: (	'(' match	-> [WriteStream on: (Expression new: 4)]->0
					     ,	( expr->1	-> [:p | p@0 nextPut: p@1]
						) zeroOrMore
					     ,	_ , ')'		-> [:p | (p@0) contents]  ).
    "object syntax"

    alpha	:= self at: #alpha	put: (	'ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz' matchClass  	).
    other	:= self at: #other	put: (	'-!%&*+,/<=>?@\\|~' matchClass  					).
    
    unary	:= self at: #unary	put: (	MatchBegin , alpha , ( alpha | digit ) zeroOrMore ,	  MatchEnd , _	-> [:p | p text]	).
    binary	:= self at: #binary	put: (	MatchBegin , other oneOrMore			  ,	  MatchEnd , _	-> [:p | p text]	).
    keyword	:= self at: #keyword	put: (	MatchBegin , alpha , ( alpha | digit ) zeroOrMore , ':' , MatchEnd , _	-> [:p | p text]	).

    unymsg	:= self at: #unymsg	put: (	unary->0 			-> [:p | Array with: p@0]			).
    binmsg	:= self at: #binmsg	put: (	binary->0  , expr->1 , _	-> [:p | Array with: p@0 with: p@1]		).
    keyarg	:= self at: #keyarg	put: (	keyword->0 , expr->1 , _	-> [:p | OrderedCollection with: p@0 with: p@1]	).
    keymsg	:= self at: #keymsg	put: (	keyarg->0
                                                , ( keyword->1 , expr->2 , _	-> [:p | (p@0) first: (p@0) first, (p@1); add: (p@2); yourself]
						  ) zeroOrMore			-> [:p | (p@0)]
						).

    message	:= self at: #message	put: (	keymsg | binmsg | unymsg  ).

    send	:= self at: #send	put: (	'[' match , expr->0 , _ , message->1 , ']'
						    -> [:p | Expression with:    #send
									with:    (Expression with: #quote with: (p@1) first asSymbol)
									with:    (p@0)
									withAll: (p@1) from: 1]	 ).
    "syntax syntax"

    syntax	:= self at: #syntax	put: (	'{' match ->[:p | PEGGrammar match: p]->0 , '}' ->[:p|p@0]  ).

    "union"

    expr	:= self at: #expr	put: (	_ , ( list | send | syntax | atom )  ).

    expression	:= self at: #expression	put: (	_ , ( ( eof -> [nil] ) | expr | error )  ).

    self startRule: expression.
]


CokeGrammar := [ ParsingExpressionGrammar cokeGrammar ]

CokeParser : Parser ()

CokeParser defaultGrammar	[ ^CokeGrammar ]

[ CokeParser := CokeParser on: StdIn ]


PEGGrammar := [ ParsingExpressionGrammar pegGrammar ]

PEGParser : Parser ()

PEGParser defaultGrammar	[ ^PEGGrammar ]

[ PEGParser := PEGParser on: StdIn ]


Grammar translate: aCompiler
[
    ^(Expression
	  with: #send
	  with: (Expression with: #quote with: #match:)
	  with: (Expression with: #quote with: self)
	  with: (Expression with: #send with: (Expression with: #quote with: #getParseStream) with: #CokeParser))
	translate: aCompiler
]

Grammar parseStream	[ ^ParseStream on: self ]
Grammar collectionType	[ ^Array ]

{ import: NetworkPseudoInterface }

NetworkPseudoInterface collectionType	[ ^Array ]
NetworkPseudoInterface readStream	[ ^self ]

[
    | expr |
    "StdOut println: CokeGrammar."
    "StdOut println: PEGGrammar."

    false ifTrue: [[[CokeParser next] whileTrue] statisticalProfile report put].
    false ifTrue: [[CokeParser next println] whileTrue].

    false ifTrue: [
	| g r |
	g := ParsingExpressionGrammar new.
	[r := PEGParser next println] whileTrue: [g addRule: r].
	StdOut println: g.
	OS exit.
	].

    Options libdir: '.'.
    "Options parseOption: '-v'."

    [expr := CokeParser next]
	whileTrue:
	   [Options verbose ifTrue: [expr println].
	    expr := expr eval.
	    Options verbose ifTrue: [StdOut nextPutAll: ' => '; println: expr]].
]
