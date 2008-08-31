% COLAParser -- common syntax for COLA languages	-*- fundamental -*-
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
% Last edited: 2008-08-09 07:29:17 by piumarta on emilia

COLAParser : Parser ()

Spacing			= (Space | Comment)*

Space	 		= ' ' | '\t' | EndOfLine
EndOfLine	 	= '\r\n' | '\n' | '\r'

Comment		 	= CommentCharacter (!EndOfLine .)* EndOfLine
CommentCharacter 	= '#'

EndOfFile	 	= !.

% To avoid confusion, Character and String literal syntax is shared by
% all subgrammars.  Strings can be single- or double-quoted.

Character		= '\\'	( 'a'						-> \\a	% bel
				| 'b'						-> \\b	% bs
				| 'e'						-> \\e	% esc
				| 'f'						-> \\f	% ff
				| 'n'						-> \\n	% nl
				| 'r'						-> \\r	% cr
				| 't'						-> \\t	% ht
				| 'v'						-> \\v	% vt
				| [']						-> \'
				| ["]						-> \"
				| '['						-> \[
				| ']'						-> \]
				| '\\'						-> \\\
				| ( [0-2][0-7][0-7] | [0-7][0-7]? ) $:s		-> `,=s
				| <error 'unknown escape'>
				)
			| .

SingleString		= ['] (!['] Character)* :s ['] Spacing			-> `,$s
DoubleString		= ["] (!["] Character)* :s ["] Spacing			-> `,$s

% Identifiers are sequences of IdentifierCharacter with digits allowed
% after the initial IdentifierCharacter.

Identifier	 	= IdentifierName :i Spacing				-> i
IdentifierName	 	= ( IdentifierCharacter IdentifierRest* )$ :i		-> `,#i
IdentifierCharacter 	= [a-zA-Z_]
IdentifierRest	 	= IdentifierCharacter | [0-9]

% Common punctuation characters and sequences.

EQUAL	 		= '='  	Spacing
RIGHTARROW 		= '->' 	Spacing
BAR 			= '|'  	Spacing
AND 			= '&'  	Spacing
NOT 			= '!'  	Spacing
QUESTION 		= '?'  	Spacing
STAR 			= '*'  	Spacing
PLUS 			= '+'  	Spacing
OPEN 			= '('  	Spacing
CLOSE 			= ')'  	Spacing
LANGLE 			= '<'  	Spacing
RANGLE 			= '>'  	Spacing
LBRACE 			= '{'  	Spacing
RBRACE 			= '}'  	Spacing
LBRACK 			= '['  	Spacing
RBRACK 			= ']'  	Spacing
DOT 			= '.'  	Spacing
SEMICOLON		= ';'  	Spacing
COLON 			= ':'  	Spacing
DOLLAR 			= '$'  	Spacing
BACKQUOTE		= '`'  	Spacing
COMMA			= ','  	Spacing
AT			= '@'  	Spacing
BACKSLASH		= '\\'  Spacing
