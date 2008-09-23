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
% Last edited: 2008-09-23 14:37:20 by piumarta on emilia.local

PepsiGrammarGenerator : GrammarParser ( name attribute attributes depth maxDepth )

start		= Header <Generate <Grammar>>

Header		= { '"THIS FILE WAS GENERATED AUTOMATICALLY -- DO NOT EDIT!"\n\n' put }

Generate	= #(#grammar Generate*)
		| #(#declaration .:i .:p			{ ('{ import: ', p, ' }') putln.  ((name := i asString), ' : ', p, ' (') put }
			#( (.:v {v asString put}
			    &(. {' ' put}) )* ) )		{ (')') putln.  optionTrace ifTrue: ['TraceIndent := [0]' putln] }
		| #(#definition .:i .:p
			   { maxDepth := depth := 0 }		&reserve
			-> { IdentityDictionary new } :locals	&<collect locals>
								{ (attribute := p notEmpty) ifTrue:
								     [((attribute := name, '_', i), ' : Object (') put.
								      attributes := p.
								      p do: [:n | ' ' put.  n asString put].
								      ' )' putln.
								      (attribute, ' new') put.
								      p do: [:n | (' :_', n) put].
								      ' [self := super new' put.
								      p do: [:n | ('. ', n, ' := _', n) put].
								      ']' putln.
								      p do: [:n | (attribute, ' ', n, ' [^', n, ']') putln]].
								  (name, ' ', i, ' :inputStream\n[') putln.
								  p do: [:n | locals at: n put: true].
								  locals at: #_ok_ put: true.
								  optionMemo ifTrue: [locals at: #_memo_ put: true].
								  locals := locals keys.
								  maxDepth > 0 ifTrue: [1 to: maxDepth do: [:n | locals add: 'pos', n printString]].
								  locals notEmpty ifTrue: ['|' put.  locals do: [:n | (' ', n) put].  ' |' putln].
								  "p do: [:n | n asString put.  ' := inputStream next.' putln]."
								  optionTrace ifTrue: [('StdErr space: (TraceIndent := TraceIndent + 2); println: ''', i, '''.') putln].
								  optionMemo ifTrue: [('(_memo_ := self memoized: #',i,' :inputStream) ifTrue: [^_memo_ success ifTrue: [inputStream position: _memo_ next.  result := _memo_ result.  self]].\n_memo_ := inputStream position.') putln].
								  '_ok_ := ' put. }
		  generate)					{ '.\n' put.
		  						  attribute ifTrue:
								     ['_ok_ ifTrue: [' put.
								      ('result := ', attribute, ' new') put.
								      attributes do: [:n | (' :', n) put].
								      '].' putln].
								  optionTrace ifTrue:
								     [('StdErr space: TraceIndent; print: ''',i,'''; nextPutAll: (_ok_ ifTrue: ['' ok''] ifFalse: ['' FAIL'']); cr.\nTraceIndent := TraceIndent - 2.\n') put].
								  optionMemo ifTrue: [('self memoize: #',i,' at: _memo_ success: _ok_ result: result :inputStream.') putln].
								  '^_ok_\n]' putln. }

generate	= #(#alternatives
		      ( &(. !.) generate
		      |						{ '(' put }
			&( generate &. {'\n or: [' put})*
			 ( .        &. {       ']' put})*	{ ')' put }
		      ) )
		| #(#sequence !.)				{ 'true' put }
		| #(#sequence
		      ( &(. !.) generate
		      | 					{ '((' put }
			save	&({'\n and: [' put} generate)*
				 ({        ']' put} .       )*	{ ')\n or: [' put }
			restore					{ '])' put }
		      ) )
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
		| #(#value .:v)					{ ('((result := [', v, '] value) or: [1])') put }
		| #(#variable .:v)				{ ('((result := ' , v,             ') or: [1])') put }
		| #(#character .:c)				{ ('((result := ' , c printString, ') or: [1])') put }
		| #(#action .:a)				{ ('([', a, '. 1] value)') put }
		| #(#predicate .:p)				{ ('([', p, '] value)') put }
		| #(#group					{ ('((result := TokenGroup new)') put }
			( element &(. {';' put}) )* )		{ (')') put }
		| #(#unigroup					{ ('(result := ((TokenGroup new)') put }
			element )				{ (') first)') put }
		| #(#format					{ '((result := TokenGroup new)' put }
			generate*)				{ ' yourself)' put }
		| #(#formatChar .:c)				{ ' add: '    put.  c print.         ';' put }
		| #(#formatVariable .:i)			{ ' addAll: ' put.  i asString put.  ';' put }
		| #(#formatString .:i)				{ ' addAll: ' put.  i asString put.  ' asString;' put }
		| #(#invoke .:i !.)				{ ('(self ', i, ' :inputStream)') put }
		| #(#invoke .:i					{ ('((inputStream pushGroup: (TokenGroup new') put }
			( &.					{ ' add: ' put }
			  argument &(. {';' put})? )* )		{ (')) ifTrue: [(self ', i, ' :inputStream)])') put }
		| #(#literal .:l)				{ ('((inputStream peek == ', l printString, ') ifTrue: [result := inputStream next. 1])') put }
		| #(#string
			( #(.:s !.)				{ ('((inputStream peek == ', s printString, ') ifTrue: [result := inputStream next. 1])') put }
			| .:s					{ ('(self string: ', s printStringEscaped, ' :inputStream)') put }
			) )
		| #(#class
			( #(.:s !.)				{ ('((inputStream peek == ', s printString, ') ifTrue: [result := inputStream next. 1])') put }
			| .:s					{ ('(self class: ', s unescaped asCharacterClass printString, ' :inputStream)') put }
			) )
		| #(#structure					{ '((' put }
			bstream					{ '\n and: [(inputStream := self beginStructure: inputStream)\n and: [' put }
			generate				{ ']]) ifTrue: [' put }
			nstream					{ '] ifFalse: [' put }
			estream)				{ '. nil])' put }
		| .:x						{ self error: 'unknown expression: ', x printString }

argument	= #(#argvar .:x)				{ x asString put }
		| #(#arglit .:x)				{ x printString put }
		| #(#argsym .:x)				{ x printString put }
		| #(#result {'((' put} generate)		{ ') ifTrue: [result] ifFalse: [result])' put }

element		= #(#subgroup					{ (' add: (TokenGroup new') put }
			( element &(. {';' put}) )* )		{ (')') put }
		| #(#symbol .:s)				{ (' add: ', s printString) put }
		| #(#literalString   .:s)			{ (' add: ', s printString) put }
		| #(#unquote .:s)				{ (' add: ', s) put }
		| #(#unquoteSplicing .:s)			{ (' concat: ', s) put }
		| #(#unquoteString   .:s)			{ (' add: (', s, ' asString)') put }
		| #(#unquoteSymbol   .:s)			{ (' add: (', s, ' asSymbol)') put }
		| #(#unquoteNumber   .:s)			{ (' add: (Integer fromString: ', s, ')') put }
		| .:x						{ self error: 'malformed group element: ', x printString }
		;

% collect all store node variable names within expression tree

collect		= .:locals
		  ( #( #store .:n { locals at: n put: true } <collect locals>
		     | .				     <collect locals>* )
		  | .
		  )

% reserve temporaries for saved input positions

reserve		= #( ( #sequence | #and | #not | #text | #zeroMany | #oneMany | #structure )
		     { maxDepth := maxDepth max: (depth := depth + 1) }
		     reserve*
		     { depth := depth - 1 } )
		| #(. reserve*)
		| .

save		= { ('(pos', (depth := depth + 1) printString, ' := inputStream position)') put }
position	= { ('pos', depth printString) put }
backup		= { ('(inputStream position: pos', depth printString, ')') put }
restore		= { ('(inputStream position: pos', depth printString, ')') put.  depth := depth - 1 }
release		= { depth := depth - 1 }

bgroup		= { ('(pos', (depth := depth + 1) printString, ' := TokenGroup new)') put }
append		= { ('(pos', depth printString, ' add: result)') put }
egroup		= { ('(result := pos', depth printString, ')') put.  depth := depth - 1 }

bstream		= { ('(pos', (depth := depth + 1) printString, ' := inputStream)') put }
nstream		= { ('(result := (inputStream := pos', depth printString, ') next)') put }
estream		= { ('(inputStream := pos', depth printString, ')') put.  depth := depth - 1 }
