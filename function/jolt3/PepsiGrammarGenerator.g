% PepsiGrammarGenerator -- Pepsi parser generator for COLA grammars					-*- fundamental -*-
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
% Last edited: 2008-07-08 00:03:43 by piumarta on emilia

PepsiGrammarGenerator : GrammarParser ( name depth maxDepth )

start		= header <generate <Grammar>>

header		= { '"THIS FILE WAS GENERATED AUTOMATICALLY -- DO NOT EDIT!"\n\n' put }

generate	= #(#grammar generate*)
		| #(#declaration .:i .:p			{ 123 put. (' import: ', p, ' ') put.  125 putln.
								  ((name := i asString), ' : ', p, ' (') put }
			#( (.:v {v asString put}
			    &(. {' ' put}) )* ) )		{ (')') putln }
		| #(#definition					{ maxDepth := depth := 0 }
			.:i .:p .:l &reserve			{ (name, ' ', i, ' :inputStream [') putln.
								  maxDepth > 0 ifTrue: [1 to: maxDepth do: [:n | l add: 'pos', n printString]].
								  l notEmpty ifTrue: ['|' put.  l do: [:n | (' ', n) put].  ' |' putln].
								  p do: [:n | n asString put.  ' := inputStream next.' putln].
								  '^' put }
			generate)				{ ('\n]') putln }
		| #(#alternatives				{ '(' put }
			&( generate &. {'\n or: [' put})*
			 ( .        &. {       ']' put})*	{ ')' put }
		   )
		| #(#sequence					{ '((' put }
			save	&({'\n and: [' put} generate)*
				 ({        ']' put} .       )*	{ ')\n or: [' put }
			restore					{ '])' put }
		   )
		| #(#and					{ '((' put }
			save					{ '\n and: [' put }
			generate				{ ']) ifTrue: [' put }
			restore)				{ '. 1])' put }
		| #(#not					{ '((' put }
			save					{ '\n and: [' put }
			generate				{ ']) ifTrue: [' put }
			restore)				{ '] ifFalse: [1])' put }
		| #(#store .:id					{ ('(') put }
			generate)				{ ('\n and: [', id, ' := result. 1])') put }
		| #(#text					{ '((' put }
			save					{ '\n and: [' put }
			generate				{ ']) ifTrue: [result := (' put }
			position				{ ' text: inputStream position)])' put }
			release)
		| #(#zeroOne					{ ('((') put }
			generate)				{ (') ifTrue: [result := TokenGroup with: result] ifFalse: [result := TokenGroup new])') put }
		| #(#zeroMany					{ '(' put }
			bgroup					{ '\n and: [[' put }
			generate				{ '] whileTrue: [' put }
			append					{ ']. ' put }
			egroup)					{ '])' put }
		| #(#oneMany .:e				{ '(' put }
			bgroup					{ '\n and: [((' put }
			<generate e>				{ ') ifTrue: [' put }
			append					{ '. 1])\n and: [[' put }
			<generate e>				{ '] whileTrue: [' put }
			append					{ ']. ' put }
			egroup)					{ '. 1]])' put }
		| #(#dot)					{ ('(inputStream notAtEnd and: [result := inputStream next. 1])') put }
		| #(#answer ( #(#action .:a)			{ ('((result := ([', a, '] value))\n or: [1])') put }
			    | .:a { a isSymbol }		{ ('((result := ', a, ')\n or: [1])') put }
			    ) )
		| #(#action .:a)				{ ('([', a, '] value)') put }
		| #(#invoke .:i !.)				{ ('(self ', i, ' :inputStream)') put }
		| #(#invoke .:i					{ ('((inputStream pushGroup: (TokenGroup new') put }
			( &.					{ ' add: (' put }
			  generate				{ ')' put }
			  &(. {';' put})? )* )			{ (')) ifTrue: [(self ', i, ' :inputStream)])') put }
		| #(#argvar .:x)				{ x asString put }
		| #(#arglit .:x)				{ x printString put }
		| #(#literal .:l)				{ ('((inputStream peek == ', l printString, ') ifTrue: [result := inputStream next. 1])') put }
		| #(#string .:s)				{ ('(self string: ', s printString, ' :inputStream)') put }
		| #(#class .:c)					{ ('(self class: ', c printString, ' :inputStream)') put }
		| #(#structure					{ '((' put }
			bstream					{ '\n and: [(inputStream := self beginStructure: inputStream)\n and: [' put }
			generate				{ ']]) ifTrue: [' put }
			nstream					{ '] ifFalse: [' put }
			estream)				{ '. nil])' put }
		| .:x						{ self error: 'unknown expression: ', x printString }

reserve		= #( ( #sequence | #and | #not | #text | #zeroMany | #oneMany | #structure )
		     { maxDepth := maxDepth max: (depth := depth + 1) }
		     reserve*
		     { depth := depth - 1 } )
		| #(. reserve*)
		| .

save		= { ('(pos', (depth := depth + 1) printString, ' := inputStream position)') put }
position	= { ('pos', depth printString) put }
restore		= { ('(inputStream position: pos', depth printString, ')') put.  depth := depth - 1 }
release		= { depth := depth - 1 }

bgroup		= { ('(pos', (depth := depth + 1) printString, ' := TokenGroup new)') put }
append		= { ('(pos', depth printString, ' add: result)') put }
egroup		= { ('(result := pos', depth printString, ')') put.  depth := depth - 1 }

bstream		= { ('(pos', (depth := depth + 1) printString, ' := inputStream)') put }
nstream		= { ('(result := (inputStream := pos', depth printString, ') next)') put }
estream		= { ('(inputStream := pos', depth printString, ')') put.  depth := depth - 1 }
