start		= Grammar

Grammar		= Spacing Definition+ :g EndOfFile	-> g
Definition	= Identifier :i Parameter* LEFTARROW Expression SEMICOLON? -> i
Parameter	= ':' Identifier

Expression	= Sequence (SLASH Sequence)*
Sequence	= Prefix*
Prefix		= (AND | NOT)? Assignment
		| Store
Assignment	= Storable Store*
Storable	= Suffix DOLLAR?
Store		= COLON Identifier
Suffix		= Primary (QUESTION | STAR | PLUS)?
Primary		= Invocation
		| OPEN Expression CLOSE
		| Literal | Class | DOT
		| Answer
Answer		= RIGHTARROW Identifier
Invocation	= Identifier !LEFTARROW
		| LANGLE Identifier Argument* RANGLE
Argument	= Identifier

# LEXICAL syntax
Identifier 	= ( IdentStart IdentCont* )$ :i Spacing -> i
IdentStart 	= [a-zA-Z_]
IdentCont 	= IdentStart | [0-9]
Literal 	= ['] (!['] Char)* ['] Spacing
		| ["] (!["] Char)* ["] Spacing
Class 		= '[' (!']' Range)* ']' Spacing
Range 		= Char '-' Char | Char
Char 		= '\\' [nrt'"\[\]\\]
		| '\\' [0-2][0-7][0-7]
		| '\\' [0-7][0-7]?
		| !'\\' .

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
Comment 	= '#' (!EndOfLine .)* EndOfLine
Space 		= ' ' | '\t' | EndOfLine
EndOfLine 	= '\r\n' | '\n' | '\r'
EndOfFile 	= !.
