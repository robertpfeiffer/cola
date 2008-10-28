% GrammarParser -- Parser for COLA grammars		-*- fundamental -*-
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
% Last edited: 2008-10-04 13:56:30 by piumarta on emilia.local

GrammarParser : COLAParser ( optionMemo optionDebug optionTrace )

CommentCharacter 	= '%'

start		= Grammar

Grammar		= Spacing Option* Declaration :d Definition+ :g EndOfFile	{ optionDebug ifTrue: [d println.  g println] } -> `(grammar ,d ,@g)

Option		= '+memo'  Spacing { optionMemo  := true }	| '-memo'  Spacing	{ optionMemo  := false }
		| '+debug' Spacing { optionDebug := true }	| '-debug' Spacing	{ optionDebug := false }
		| '+trace' Spacing { optionTrace := true }	| '-trace' Spacing	{ optionTrace := false }

Declaration	= Identifier :n COLON Identifier :b OPEN Identifier* :v CLOSE	-> `(declaration ,n ,b ,v)
		|								-> `()

Definition	= Identifier :i Parameter* :p EQUAL Expression :e SEMICOLON?	-> `(definition ,i ,p ,e)

Parameter	= ':' Identifier

Expression	= Sequence :h (BAR Sequence)* :t		-> `(alternatives ,h ,@t)
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
Answer		= RIGHTARROW ( Variable | Value
			     | Rewrite | LiteralChar )
Variable 	= Identifier:i					-> `(variable ,i)
Value		= Block:b					-> `(value ,b)
Block		= '{' BlockBody $:b '}' Spacing			-> b
BlockBody	= (!'}' ('{' BlockBody '}' | '\\{' | '\\}' | .))*
Rewrite		= BACKQUOTE ( Group
			    | Format
			    | Element:e				-> `(unigroup ,e)
			    )
Group		= OPEN Element*:e CLOSE				-> `(group ,@e)
Element		= Identifier:i					-> `(symbol ,i)
		| Unquote
		| Subgroup
		| ( SingleString | DoubleString ) :s		-> `(literalString ,s)
Unquote		= COMMA ( AT	 Identifier:i			-> `(unquoteSplicing ,i)
			| DOLLAR Identifier:i			-> `(unquoteString ,i)
			| '#'	 Identifier:i			-> `(unquoteSymbol ,i)
			| '='	 Identifier:i			-> `(unquoteNumber ,i)
			|	 Identifier:i			-> `(unquote ,i)
			)
Subgroup	= OPEN Element*:e CLOSE				-> `(subgroup ,@e)
Format		= ['] (!['] FormatChar)* :s ['] Spacing		-> `(format ,@s)
FormatChar	= BACKSLASH OPEN Identifier:i CLOSE		-> `(formatVariable ,i)
		| BACKSLASH DOLLAR OPEN Identifier:i CLOSE	-> `(formatString ,i)
		| Char:c					-> `(formatChar ,c)
LiteralChar	= BACKSLASH Character:c Spacing			-> `(character ,c)
Invocation	= Identifier :i !EQUAL				-> `(invoke ,i)
		| Application
Application	= LANGLE Identifier :i Argument* :a RANGLE	-> `(invoke ,i ,@a)
Argument	= Application:a					-> `(result ,a)
		| Identifier:x					-> `(argvar ,x)
		| '#' Identifier:x				-> `(argsym ,x)
		| SingleString:s				-> `(arglit ,s)

Literal 	= ( SingleString | DoubleString ) :s		-> `(string ,s)
Class 		= '[' (!']' Range)* $:c ']' Spacing		-> `(class  ,$c)
Range 		= ( Character '-' Character | Character )

Structure	= '#' OPEN Expression:e CLOSE			-> `(structure ,e)
Symbol		= '#' Identifier:i				-> `(literal   ,i)
