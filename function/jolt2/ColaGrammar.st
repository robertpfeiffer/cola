{ import: ParsingExpression-bootstrap }
{ import: Grammar }

{ import: Expression }

ColaFunctionGrammar	:= [ Grammar new ]
ColaMessageGrammar	:= [ Grammar new ]
ColaParsingGrammar	:= [ Grammar new ]

[
    | g _ |
    g := ColaParsingGrammar name: #PEG.
    g	at: #error	put: [:p | p error: 'grammar syntax error'] setResult.
    g	at: #eof	put: ( PeAny not );
	at: #eol	put: ( ('\r' parse , '\n' parse zeroMore) | ('\n' parse , '\r' parse zeroMore) );
	at: #space	put: ( ' \t' parseClass | #eol parse );
	at: #comment	put: ( '//' parse , (#eol parse not , PeAny) zeroMore , #eol parse);
	at: #_		put: ( _ := ( (#space parse | #comment parse) zeroMore ) ).
    g	at: #pling	put: '!'  parse , _;
    	at: #lparen	put: '('  parse , _;
    	at: #rparen	put: ')'  parse , _;
    	at: #query	put: '?'  parse , _;
    	at: #star	put: '*'  parse , _;
    	at: #plus	put: '+'  parse , _;
    	at: #dollar	put:  $$  parse , _;
    	at: #bar	put: '|'  parse , _;
    	at: #hash	put: '#'  parse , _;
    	at: #equal	put: '='  parse , _;
    	at: #rarrow	put: '->' parse , _;
    	at: #rimply	put: '=>' parse , _;
    	at: #larrow	put: '<-' parse , _;
    	at: #limply	put: '<=' parse , _;
    	at: #dot	put: '.'  parse , _;
    	at: #semicolon	put: ';'  parse , _.
    g	at: #number	put: ( '0-9' parseClass oneMore ) textResult , _ <- [:p | Integer fromString: p result base: 10].
    g	at: #identifier	put: ( 'a-zA-Z_' parseClass , 'a-zA-Z_0-9' parseClass zeroMore ) textResult , _ <- [:p | p result asSymbol].
    g   at: #escapeChar	put: ( ( 'a' parse <- [$\a] ) | ( 'b' parse <- [$\b] ) | ( 'e' parse <- [$\e] ) | ( 'f' parse <- [$\f] )
			     | ( 'n' parse <- [$\n] ) | ( 'r' parse <- [$\r] ) | ( 't' parse <- [$\t] ) | ( 'v' parse <- [$\v] )
			     | ( '\\' parse <- [$\\] ) ).
    g   at: #char	put: ( ( '\\' parse , #escapeChar parse )
			     | ( PeAny textResult <- [:p | p last] ) ).
    g	at: #string	put: ( ( '''' parse , ( ( '''' parse not , #char parse ) zeroMore ->0 ) , '''' parse )
			     | ( '"'  parse , ( ( '"'  parse not , #char parse ) zeroMore ->0 ) , '"'  parse ) ) , _ <- [:p | (p@0) asString].
    g	at: #class	put: (   '['  parse , ( ( ']'  parse not , #char parse ) zeroMore ->0 ) , ']'  parse )   , _ <- [:p | (p@0) parseClass].
    g	at: #literal	put: ( #hash parse , ( ( ( #lparen parse , #expression parse , #rparen parse )	<- [:p | p result parseStructure] )
					     | ( ( #identifier parse )					<- [:p | p result parseLiteral] )
					     | ( ( #string parse )					<- [:p | p result asSymbol parseLiteral] ) ) ).
    g	at: #store	put: ( ( #rarrow parse , #number parse <- [:p | p result storeResult] )
			     | ( #rimply parse , #number parse <- [:p | p result storeResult action] )
			     | ( #larrow parse , ( ColaFunctionGrammar-#expression ) <- [:p | (PeSetResult withExpression: p result)] , _ )
			     | ( #limply parse , ( ColaFunctionGrammar-#expression ) <- [:p | (PeSetResult withExpression: p result) action] , _ ) ).
    g	at: #match	put: ( ( #identifier parse ->0 , '-' parse , #identifier parse ->1 <- [:p | (Grammar named: p@0) - (p@1)] )
			     | ( #identifier parse , '=' parse not <- [:p | p result parse] )
			     | ( #string parse <- [:p | p result parse] )
			     | #class parse
			     | #literal parse
			     | #store parse
			     | ( #dot parse <- [PeAny] )
			     | ( #lparen parse , #expression parse , #rparen parse ) ).
    g	at: #prefix	put: ( ( #pling parse , #match parse <- [:p | p result not] )
			     |                  #match parse                 ).
    g	at: #repeat	put: ( #prefix parse , ( ( #query  parse <- [:p | p result zeroOne    ] )
					       | ( #star   parse <- [:p | p result zeroMore   ] )
					       | ( #plus   parse <- [:p | p result oneMore    ] )
					       | ( #dollar parse <- [:p | p result textResult ] ) ) zeroMore ).
    g	at: #suffix	put: ( #repeat   parse ->0 , ( ( ( #rarrow parse , #number   parse <- [:p | (p@0) -> p result] ->0 ) zeroOne  <- [:p | p@0] )
						     | ( ( #larrow parse , #number   parse <- [:p | (p@0) <- p result] ->0 ) zeroOne  <- [:p | p@0] ) ) ).
    g	at: #sequence	put: ( #suffix   parse ->0 , (                 #suffix   parse <- [:p | (p@0) ,  p result] ->0 ) zeroMore <- [:p | p@0] ).
    g	at: #expression	put: ( #sequence parse ->0 , ( #bar parse    , #sequence parse <- [:p | (p@0) |  p result] ->0 ) zeroMore <- [:p | p@0] ).
    g	at: #grammar	put: ( [Grammar new] setResult ->0
			     , ( #identifier parse ->1 , #equal parse , #expression parse , #semicolon parse zeroOne	<- [:p | p@0 at: p@1 put: p result]	) zeroMore
			     , ( #expression parse									<- [:p | p@0 startRule: p result]	) zeroOne
			     ) <- [:p | (p@0) finalise "println"].
]

[
    | g _ |
    g := ColaFunctionGrammar name: #COLA.
    g	at: #error	put: [:p | p error: 'function syntax error'] setResult.
    g	at: #eof	put: ( PeAny not );
	at: #eol	put: ( ('\r' parse , '\n' parse zeroMore) | ('\n' parse , '\r' parse zeroMore) );
	at: #space	put: ( ' \t' parseClass | #eol parse );
	at: #comment	put: ( ';' parse , (#eol parse not , PeAny) zeroMore , #eol parse);
	at: #_		put: ( _ := ( (#space parse | #comment parse) zeroMore ) ).
    g	at: #digit	put: '0-9'			parseClass;
	at: #bigit	put: '0-1'			parseClass;
	at: #hex	put: 'A-Fa-f'			parseClass;
	at: #alpha	put: 'a-zA-Z_'			parseClass;
	at: #other	put: '-+!#$%&*./:<=>?@\\^|~'	parseClass.
    g	at: #identifier	put: ( ( #alpha parse | #other parse ) , ( #alpha parse | #digit parse | #other parse ) zeroMore ) textResult <- [:p | p result asSymbol].
    g	at: #decimal	put: ( #digit parse oneMore textResult							<- [:p | p result inject: 0 into: [:n :c | n * 10 + c digitValue]] );	
	at: #heximal	put: ( ( '0x' parse , ( #digit parse | #hex parse ) oneMore textResult )		<- [:p | p result inject: 0 into: [:n :c | n * 16 + c digitValue]] );
	at: #binimal	put: ( ( '0b' parse , ( #bigit parse              ) oneMore textResult )		<- [:p | p result inject: 0 into: [:n :c | n *  2 + c digitValue]] );
	at: #posfloat	put: ( #decimal parse -> 0 , '.' parse , ( #digit parse oneMore textResult ) -> 1	<- [:p | (p@1 reverseInject: 0.0 into: [:n :c | n / 10.0 + c digitValue]) / 10.0 + (p@0)] );
	at: #posnumber	put: ( #posfloat parse | #heximal parse | #binimal parse | #decimal parse );
	at: #number	put: ( ( '-' parse          , #posnumber parse						<- [:p | p result negated] )
			     | ( '+' parse zeroMore , #posnumber parse ) ).
    g	at: #plainChar	put: ( PeAny textResult <- [:p | p last] );
	at: #escapeChar	put: ( ( 'a' parse <- [$\a] ) | ( 'b' parse <- [$\b] ) | ( 'e' parse <- [$\e] ) | ( 'f' parse <- [$\f] )
			     | ( 'n' parse <- [$\n] ) | ( 'r' parse <- [$\r] ) | ( 't' parse <- [$\t] ) | ( 'v' parse <- [$\v] )
			     | ( '\\' parse <- [$\\] ) );
	at: #escapeSeq	put: ( '\\' parse , ( #escapeChar parse | #plainChar parse ) );
	at: #char	put: ( #escapeSeq parse | #plainChar parse ).
    g	at: #string	put: ( '"' parse , ( ( '"' parse not , #char parse ) zeroMore ->0 ) , '"' parse <- [:p | (p@0) asString] ).
    g	at: #list	put: ( '(' parse , ( ( _ , #expr parse ) zeroMore ->0 ) , _ , ')' parse <- [:p | (p@0) asExpression] ).
    g	at: #quotation	put: ( ( '''' parse , _ , #expr parse	<- [:p | Expression with: #quote with: p result] )
			     | ( '`'  parse , _ , #expr parse	<- [:p | Expression with: #quasiquote with: p result] )
			     | ( ',@' parse , _ , #expr parse	<- [:p | Expression with: #'unquote-splicing' with: p result] )
			     | ( ','  parse , _ , #expr parse	<- [:p | Expression with: #unquote with: p result] ) ).
    "message syntax"
    g	at: #unary	put: ( ( #alpha parse , ( #alpha parse | #digit parse ) zeroMore ) textResult, _ );
	at: #binary	put: ( ( '-+!%&*,/<=>?@\\|~' parseClass oneMore ) textResult , _ );
	at: #keyword	put: ( ( #alpha parse , ( #alpha parse | #digit parse ) zeroMore , ':' parse ) textResult , _ ).
    g	at: #unymsg	put: ( #unary   parse ->0						<- [:p | Array with: p@0] );
	at: #binmsg	put: ( #binary  parse ->0 , #expr parse ->1 , _				<- [:p | Array with: p@0 with: p@1] );
	at: #keyarg	put: ( #keyword parse ->0 , #expr parse ->1 , _				<- [:p | OrderedCollection with: p@0 with: p@1] );
	at: #keymsg	put: ( #keyarg  parse ->0 , ( #keyword parse ->1 , #expr parse ->2 , _	<- [:p | (p@0) first: (p@0) first, (p@1); add: (p@2); yourself]
							  ) zeroMore				<- [:p | (p@0)]
				   ).
    g	at: #message	put: ( #keymsg parse | #binmsg parse | #unymsg parse );
	at: #send	put: ( '[' parse , _ , #expr parse ->0 , _ , #message parse ->1 , ']' parse
				    <- [:p | Expression with:    #send
							with:    (Expression with: #quote with: (p@1) first asSymbol)
							with:    (p@0)
							withAll: (p@1) from: 1]	).
    "grammar syntax"
    g	at: #grammar	put: ( '{' parse , _ , ( ColaParsingGrammar-#grammar ) , '}' parse ).
    "cola syntax"
    g	at: #atom	put: ( #number parse | #identifier parse | #string parse | #grammar parse );
	at: #expr	put: ( #atom parse | #list parse | #quotation parse | #send parse );
	at: #expression	put: _ , ( #expr parse | #eof parse | #error parse ).
]

"mutually recursive rules between the above grammars can now be resolve"

[
    ColaParsingGrammar startSymbol: #grammar.
    ColaFunctionGrammar startSymbol: #expression.
]
