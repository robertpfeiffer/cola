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
% Last edited: 2008-07-12 12:16:55 by piumarta on emilia

GrammarParser : Parser ()

start		= Grammar

Grammar		= Spacing Declaration :d Definition+ :g EndOfFile		-> `(grammar ,d ,@g)

Declaration	= Identifier :n COLON Identifier :b OPEN Identifier* :v CLOSE	-> `(declaration ,n ,b ,v)
		|								-> `()

Definition	= Identifier :i Parameter* :p EQUAL Expression :e SEMICOLON?	-> `(definition ,i ,p ,e)

Parameter	= ':' Identifier

Expression	= Sequence :h (SLASH Sequence)* :t		-> `(alternatives ,h ,@t)
Sequence	= Prefix* :p					-> `(sequence ,@p)
Prefix		= AND Predicate :p				-> p
		| AND Assignment :a				-> `(and ,a)
		| NOT Assignment :a				-> `(not ,a)
		| Assignment
		| Store :i					-> `(store ,i (dot))
Predicate	= Block:b					-> `(predicate ,b)
Assignment	= Storable :s ( Store :i			-> `(store ,i ,s) :s
			      ) *				-> s

Storable	= Suffix :s ( DOLLAR				-> `(text ,s) :s
			    ) ?					-> s
Store		= COLON Identifier
Suffix		= Primary :p ( QUESTION				-> `(zeroOne  ,p) :p
			     | STAR				-> `(zeroMany ,p) :p
			     | PLUS				-> `(oneMany  ,p) :p
			     ) ?				-> p
Primary		= Invocation
		| OPEN Expression :e CLOSE			-> e
		| Literal
		| Class
		| Structure
		| Symbol
		| DOT						-> `(dot)
		| Action
		| Answer
Action		= Block:b					-> `(action ,b)
Answer		= RIGHTARROW ( Variable | Value | Rewrite )
Variable 	= Identifier:i					-> `(variable ,i)
Value		= Block:b					-> `(value ,b)
Block		= '{' BlockBody $:b '}' Spacing			-> b
BlockBody	= (!'}' ('{' BlockBody '}' | .))*
Rewrite		= BACKQUOTE ( Group
			    | Element:e				-> `(unigroup ,e)
			    )
Group		= OPEN Element*:e CLOSE				-> `(group ,@e)
Element		= Identifier:i					-> `(symbol ,i)
		| Unquote
		| Subgroup
Unquote		= COMMA ( AT	 Identifier:i			-> `(unquoteSplicing ,i)
			| DOLLAR Identifier:i			-> `(unquoteString ,i)
			| '#'	 Identifier:i			-> `(unquoteSymbol ,i)
			|	 Identifier:i			-> `(unquote ,i)
			)
Subgroup	= OPEN Element*:e CLOSE				-> `(subgroup ,@e)
Invocation	= Identifier :i !EQUAL				-> `(invoke ,i)
		| Application
Application	= LANGLE Identifier :i Argument* :a RANGLE	-> `(invoke ,i ,@a)
Argument	= Application:a					-> `(result ,a)
		| Identifier:x					-> `(argvar ,x)
		| '#' Identifier:x				-> `(arglit ,x)
		| ['] (!['] Char)* :s ['] Spacing		-> `(arglit ,$s)

Identifier 	= ( IdentStart IdentCont* )$ :i Spacing		-> `,#i
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

Structure	= '#' OPEN Expression:e CLOSE			-> `(structure ,e)
Symbol		= '#' Identifier:i				-> `(literal   ,i)

EQUAL	 	= '='  Spacing
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
BACKQUOTE	= '`'  Spacing
COMMA		= ','  Spacing
AT		= '@'  Spacing

Spacing 	= (Space | Comment)*
Comment 	= '%' (!EndOfLine .)* EndOfLine
Space 		= ' ' | '\t' | EndOfLine
EndOfLine 	= '\r\n' | '\n' | '\r'
EndOfFile 	= !. ;
