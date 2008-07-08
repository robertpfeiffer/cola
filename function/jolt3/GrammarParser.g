% GrammarParser -- Parser for COLA grammars								-*- fundamental -*-
% 
% Copyright (c) 2008 Ian Piumarta
% All rights reserved.
% 
% Permission is hereby granted, free of charge, to any person obtaining a
% copy of this software and associated documentation files (the 'Software'),
% to deal in the Software without restriction, including without limitation
% the rights to use, copy, modify, merge, publish, distribute, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, provided that the above copyright notice(s) and this
% permission notice appear in all copies of the Software and that both the
% above copyright notice(s) and this permission notice appear in supporting
% documentation.
% 
% THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.
% 
% Last edited: 2008-07-08 00:03:02 by piumarta on emilia

GrammarParser : Parser ()

start		= Grammar

Grammar		= Spacing Declaration :d Definition+ :g EndOfFile		-> { (TokenGroup with: #grammar) add: d; concat: g }

Declaration	= Identifier :n COLON Identifier :b OPEN Identifier* :v CLOSE	-> { (TokenGroup with: #declaration) add: n; add: b; add: v }
		|								-> { TokenGroup new }

Definition	= Identifier :i Parameter* :p LEFTARROW Expression :e SEMICOLON?
		    -> { IdentityDictionary new } :locals <collect locals e>
		    -> { p do: [:n | locals at: n put: true].
		         (TokenGroup with: #definition) add: i; add: p; add: (TokenGroup withAll: locals keys); add: e.
		       }
Parameter	= ':' Identifier

Expression	= Sequence :h (SLASH Sequence)* :t		-> { t isEmpty ifTrue: [h] ifFalse: [(TokenGroup with: #alternatives) add: h; concat: t] }
Sequence	= Prefix* :p					-> { (p hasSize: 1) ifTrue: [p first] ifFalse: [(TokenGroup with: #sequence) concat: p] }
Prefix		= AND Assignment :a				-> { (TokenGroup with: #and) add: a }
		| NOT Assignment :a				-> { (TokenGroup with: #not) add: a }
		| Assignment
		| Store :i					-> { (TokenGroup with: #store) add: i; add: (TokenGroup with: #dot) }
Assignment	= Storable :s ( Store :i			-> { (TokenGroup with: #store) add: i; add: s } :s
			      ) *				-> s

Storable	= Suffix :s ( DOLLAR				-> { (TokenGroup with: #text) add: s } :s
			    ) ?					-> s
Store		= COLON Identifier
Suffix		= Primary :p ( QUESTION				-> { (TokenGroup with: #zeroOne)  add: p } :p
			     | STAR				-> { (TokenGroup with: #zeroMany) add: p } :p
			     | PLUS				-> { (TokenGroup with: #oneMany)  add: p } :p
			     ) ?				-> p
Primary		= Invocation
		| OPEN Expression :e CLOSE			-> e
		| Literal
		| Class
		| Structure
		| Symbol
		| DOT						-> { TokenGroup with: #dot }
		| Action
		| Answer
Answer		= RIGHTARROW ( Identifier | Action ) :a		-> { (TokenGroup with: #answer) add: a }
Action		= '{' (!'}' .)* $:a '}' Spacing			-> { (TokenGroup with: #action) add: a }
Invocation	= Identifier :i !LEFTARROW			-> { (TokenGroup with: #invoke) add: i }
		| Application
Application	= LANGLE Identifier :i Argument* :a RANGLE	-> { (TokenGroup with: #invoke) add: i; concat: a }
Argument	= Application
		| Identifier:x					-> { (TokenGroup with: #argvar) add: x }
		| Symbol:x					-> { (TokenGroup with: #arglit) add: x }

Identifier 	= ( IdentStart IdentCont* )$ :i Spacing		-> { i asSymbol }
IdentStart 	= [a-zA-Z_]
IdentCont 	= IdentStart | [0-9]
Literal 	= ( ['] (!['] Char)* :s ['] Spacing
		  | ["] (!["] Char)* :s ["] Spacing )		-> { (s hasSize: 1) ifTrue:  [(TokenGroup with: #literal) add: s asString first]
										    ifFalse: [(TokenGroup with: #string)  add: s asString] }
Class 		= '[' (!']' Range)* $:c ']' Spacing		-> { (c size == 1)  ifTrue:  [(TokenGroup with: #literal) add: c asString first]
										    ifFalse: [(TokenGroup with: #class)   add: c asString asCharacterClass] }
Range 		= ( Char '-' Char | Char ) $
Char 		= '\\'	( 'n'					-> { $\n }
			| 'r'					-> { $\r }
			| 't'					-> { $\t }
			| [']					-> { $'  }
			| ["]					-> { $"  }
			| '['					-> { $[  }
			| ']'					-> { $]  }
			| '\\'					-> { $\\ }
			| ( [0-2][0-7][0-7] | [0-7][0-7]? ) $:s	-> { s inject: 0 into: [:c :digit | c * 8 + digit - $0] }
			| . $:s					-> { self error: 'unknown escape: ', s }
			)
		| .

Structure	= '#' OPEN Expression:e CLOSE			-> { (TokenGroup with: #structure) add: e }
Symbol		= '#' Identifier:i				-> { (TokenGroup with: #literal)   add: i }

LEFTARROW 	= '='  Spacing
RIGHTARROW 	= '->' Spacing
SLASH 		= '|'  Spacing
AND 		= '&'  Spacing
NOT 		= '!'  Spacing
QUESTION 	= '?'  Spacing
STAR 		= '*'  Spacing
PLUS 		= '+'  Spacing
OPEN 		= '('  Spacing
CLOSE 		= ')'  Spacing
LANGLE 		= '<'  Spacing
RANGLE 		= '>'  Spacing
DOT 		= '.'  Spacing
SEMICOLON	= ';'  Spacing
COLON 		= ':'  Spacing
DOLLAR 		= '$'  Spacing

Spacing 	= (Space | Comment)*
Comment 	= '%' (!EndOfLine .)* EndOfLine
Space 		= ' ' | '\t' | EndOfLine
EndOfLine 	= '\r\n' | '\n' | '\r'
EndOfFile 	= !. ;

% collect all store node variable names within expression tree

collect :locals	= ( #( #store .:n { locals at: n put: true } <collect locals>
		     | .				     <collect locals>* )
		  | .
		  )
