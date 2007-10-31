"							-*- Smalltalk -*-
  Copyright (c) 2005 Ian Piumarta
  All rights reserved.

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the 'Software'),
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, provided that the above copyright notice(s) and this
  permission notice appear in all copies of the Software and that both the
  above copyright notice(s) and this permission notice appear in supporting
  documentation.

  THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.

  Last edited: 2007-10-31 16:28:03 by piumarta on emilia
"

{ import: Scanner }
{ import: OrderedCollection }
{ import: ByteArrayNode }
{ import: WordArrayNode }
{ import: ArrayNode }
{ import: SymbolNode }
{ import: StringNode }
{ import: IntegerNode }
{ import: FloatNode }
{ import: CharacterNode }
{ import: VariableNode }
{ import: VarargNode }
{ import: SendNode }
{ import: AssignmentNode }
{ import: ReturnNode }
{ import: BlockNode }
{ import: MethodNode }
{ import: ExecNode }
{ import: IncludeNode }
{ import: ImportNode }
{ import: ExternNode }
{ import: PrimitiveNode }
{ import: PrototypeNode }
{ import: DefinitionNode }
{ import: perform }
{ import: tokenization }

"I am a (proper superset of a) Smalltalk-80 parser."

Parser : Scanner (
    client	"a Compiler, willing to field directives and error messages"
)

Parser on: aScannerContext notifying: aCompiler
[
    self := super on: aScannerContext.
    client := aCompiler.
    self scan
]

Parser note: marker
[
"
    marker print.  ' ' print.
    type print.  ' -> ' print.
    token contents println.
"
]

Parser error: message
[
    "decorate errors with input file:line and last token scanned"
    | detail |
    (detail := token contents) notEmpty ifTrue: [detail := ' near ''', detail, ''''].
    ^client error: message, detail at: self position
]

Parser parseByteArray
[
    | position elements |
    position := self position.
    elements := OrderedCollection new.
    [type == #']']
	whileFalse:
	   [self note: 'PARSE_BYTE_ARRAY-1'.
	    type == #integer ifFalse: [self error: 'ByteArrays can only contain integers'].
	    ((elements add: (IntegerNode fromString: token contents position: self position)) value between: 0 and: 255)
		ifFalse: [self error: 'ByteArray element not between 0 and 255'].
	    self scan].
    self scan.
    ^ByteArrayNode withElements: elements position: position
]

Parser parseWordArray
[
    | position elements |
    position := self position.
    elements := OrderedCollection new.
    [type == #'}']
	whileFalse:
	   [self note: 'PARSE_WORD_ARRAY-1'.
	    type == #integer ifFalse: [self error: 'WordArrays can only contain integers'].
	    elements add: (IntegerNode fromString: token contents position: self position).
	    self scan].
    self scan.
    ^WordArrayNode withElements: elements position: position
]

Parser parseArrayLiteral
[
    | node |
    "first try normal literal, then try to make selector into a symbol"
    (node := self parseLiteralP) notNil ifTrue: [^node].
    ((#(identifier binary keyword) includes: type) or: [type == #':'])
	ifTrue:
	   [self note: 'PARSE_ARRAY_LITERAL-1'.
	    type == #keyword ifTrue: [self scanKeywords].
	    node := (SymbolNode fromString: token contents position: self position).
	    self scan.
	    ^node].
    type == #'('    ifTrue: [^self scan; parseArray].
    ^nil
]

Parser parseArray
[
    | position elements element |
    position := self position.
    elements := OrderedCollection new.
    [(element := self parseArrayLiteral) notNil] whileTrue: [elements add: element].
    self note: 'ARRAY-1'.
    type == #')' ifFalse: [self error: ''')'' expected at end of literal Array'].
    self scan.
    ^ArrayNode withElements: elements position: position
]

Parser parseLiteralP
[
    self note: 'LITERAL-1'.
    type == #integer	ifTrue: [| node | node := IntegerNode   fromString: token contents        position: self position.  self scan.  ^node].
    type == #float	ifTrue: [| node | node := FloatNode     fromString: token contents        position: self position.  self scan.  ^node].
    type == #string	ifTrue: [| node | node := StringNode    fromString: token contents        position: self position.  self scan.  ^node].
    type == #character	ifTrue: [| node | node := CharacterNode withValue:  token contents first  position: self position.  self scan.  ^node].
    self note: 'LITERAL-2'.
    type == #'#'
	ifFalse: [^nil].
    self scan.
    self note: 'LITERAL-3'.
    (#(identifier binary keyword string) includes: type)
	ifTrue:
	    [| node |
	     type == #keyword ifTrue: [self scanKeywords].
	     node := SymbolNode fromString: token contents position: self position.
	     self scan.
	     ^node].
    self note: 'LITERAL-4'.
    type == #'(' ifTrue: [^self scan; parseArray].
    type == #'{' ifTrue: [^self scan; parseWordArray].
    type == #'[' ifTrue: [^self scan; parseByteArray].
    self error: 'illegal literal following ''#'''
]

Parser parsePrimary
[
    | node |
    self note: 'PRIMARY-1'.
    type == #identifier
	ifTrue:
	    [node := VariableNode withName: token contents position: self position.
	     self scan.
	     ^node].
    type == #'('
	ifTrue:
	    [node := self scan; parseExpression.
	     type == #')' ifFalse: [self error: ''')'' expected'].
	     self scan.
	     ^node].
    type == #'['
	ifTrue:
	    [^self scan; parseBlock].
    type == #ellipsis
	ifTrue:
	    [node := VarargNode withPosition: self position.
	     self scan.
	     ^node].
    self note: 'PRIMARY-2'.
    node := self parseLiteralP.
    self note: 'PRIMARY-3'.
    node notNil ifTrue: [^node].
    "not an identifier, primary, block or literal"
    self note: 'PRIMARY-ABORT'.
    self error: 'syntax error'
]

Parser parseUnary
[
    | node |
    node := self parsePrimary.
    [type == #identifier]
	whileTrue:
	   [node := SendNode withReceiver: node selector: token contents position: self position.
	    self scan.
"
	    [type == #':'] whileTrue: [node addArgument: (self scan; parsePrimary)]
"
	    ].
    ^node
]

Parser parseBinary
[
    | node |
    node := self parseUnary.
    [type == #binary]
	whileTrue:
	    [node := SendNode withReceiver: node selector: token contents position: self position.
	     node addArgument: (self scan; parseUnary)].
    ^node
]

Parser parseExpression
[
    | node |
    self note: 'EXPR-1'.
    node := self parseBinary.
    self note: 'EXPR-2'.
    type == #keyword
	ifTrue:
	    [node := SendNode withReceiver: node selector: token contents position: self position.
	     node addArgument: (self scan; parseBinary).
	     self note: 'EXPR-3'.
	     [type == #keyword]
		 whileTrue:
		     [node addKeyword: token contents; addArgument: (self scan; parseBinary)]].
    [type == #':' and: [node isSendNode]]
	whileTrue: [node addArgument: (self scan; parseBinary)].
    (type == #assign and: [node isVariableNode])
	ifTrue: [^AssignmentNode withVariable: node value: (self scan; parseExpression) position: node position].
    (type == #';' and: [node isSendNode not])
	ifTrue: [self error: 'cascade does not follow a message send'].
    [type == #';']
	whileTrue:
	    [| cascade |
	     cascade := SendNode withReceiver: nil selector: '' position: self position.
	     self scan.
	     type == #keyword
		 ifTrue:
		     [[type == #keyword]
			  whileTrue:
			      [cascade addKeyword: token contents; addArgument: (self scan; parseBinary)]]
		 ifFalse:
		     [type == #binary
			  ifTrue: [cascade addKeyword: token contents; addArgument: (self scan; parseUnary)]
			  ifFalse:
			      [type == #identifier
				   ifTrue:
				       [cascade addKeyword: token contents.
					self scan]
				   ifFalse: [self error: 'syntax error in cascade']]].
	     [type == #':'] whileTrue: [cascade addArgument: (self scan; parseBinary)].
	     node addCascade: cascade].
    ^node
]

Parser parseTemporaries: block
[
    [type == #identifier]
	whileTrue:
	  [block addTemporary: token contents.
	   self scan].
    (type == #binary and: [token contents = '|'])
	ifFalse: [self error: 'identifier or ''|'' expected in temporaries'].
    self scan.
    ^block
]

Parser parseSequence: block
[
    self note: 'SEQ-1'.
    (type == #binary and: [token contents = '|'])
	ifTrue: [self scan; parseTemporaries: block].
    self note: 'SEQ-2'.
    [type == #']']
	whileFalse:
	    [self note: 'SEQ-3'.
	     block addStatement: (type == #extern
				      ifTrue:  [self parsePrimitive]
				      ifFalse: [((type == #binary and: [token contents = '^'])
						     ifTrue:  [ReturnNode withValue: (self scan; parseExpression) position: self position]
						     ifFalse: [self parseExpression])]).
	     (type == #'.' or: [type == #']' "or: [type == #ellipsis]"]) ifFalse: [self error: '''.'' or '']'' expected in block'].
	     [type == #'.' "or: [type == #ellipsis]"] whileTrue: [self scan].
	     (block lastStatement isReturnNode and: [type ~~ #']']) ifTrue: [self error: ''']'' expected at end of block']].
    self note: 'SEQ-4'.
    self scan.
    self note: 'SEQ-5'.
    ^block
]

Parser parseBlockParameters: block
[
    [type == #':']
	whileTrue:
	    [self scan.
	     type == #identifier ifFalse: [self error: 'parameter name expected'].
	     block addArgument: token contents.
	     self scan].
    (type == #binary and: [token contents = '||'])
	ifTrue: [token resetToStart; nextPut: $|]		"convert to temp delimiter"
	ifFalse:
	    [(type == #binary and: [token contents = '|'])
		 ifFalse: [self error: '''|'' expected at end of block parameters'].
	     self scan]
]

Parser parseBlock
[
    | block |
    block := BlockNode withPosition: self position.
    type == #':' ifTrue: [self parseBlockParameters: block].
    ^self parseSequence: block
]

Parser parseExec
[
    | position |
    position := self position.
    ^self scan; parseSequence: (ExecNode withPosition: position).
]

Parser parseExtern
[
    | text node |
    text := token contents.
    node := nil.
    (              text beginsWith: ' import:'  ) ifTrue: [client import:   (text tokenized: ' ') second]
	ifFalse: [(text beginsWith: ' include:' ) ifTrue: [client include:  (text tokenized: ' ') second]
	ifFalse: [(text beginsWith: ' input:'   ) ifTrue: [client input:    (text tokenized: ' ') second]
	ifFalse: [(text beginsWith: ' include <') ifTrue: [node := IncludeNode withName: '<', (text tokenized: ' <>') second, '>' position: self position]
	ifFalse: [(text beginsWith: ' include "') ifTrue: [node := IncludeNode withName: '"', (text tokenized:  ' "') second, '"' position: self position]
	ifFalse: [(text beginsWith: ' pragma:'  ) ifTrue: [client pragma:    text]
	ifFalse: [(text beginsWith: ' external ') ifTrue: [client external:  text]
	ifFalse: [(text beginsWith: ' internal ') ifTrue: [client internal:  text]
	ifFalse:                                          [node := ExternNode withCode: text position: self position]]]]]]]].
    self scan.
    ^node
]

Parser parsePrimitive
[
    | node |
    node := PrimitiveNode withCode: token contents position: self position.
    self scan.
    ^node
]

Parser parsePrototype: name
[
    | position base slots |
    position := self position.
    base := nil.
    slots := OrderedCollection new.
    type == #':'
	ifTrue:
	    [self scan.
	     type == #identifier ifFalse: [self error: 'base type name expected in declaration'].
	     base := token contents.
	     self scan].
    type == #'(' ifFalse: [self error: 'slot names expected in type declaration'].
    self scan.
    [type == #identifier]
	whileTrue:
	  [slots add: token contents.
	   self scan].
    type == #')' ifFalse: [self error: ''')'' expected after slot names in type declaration'].
    self scan.
    ^PrototypeNode withName: name base: base slots: slots position: position
]

Parser parseVarParams: params
[
    [type == #':']
	whileTrue:
	   [self scan.
	    type == #identifier ifFalse: [self error: 'parameter name expected'].
	    params add: token contents.
	    self scan]
]

Parser parseMethod: typeName
[
    | position selector arguments node |
    self note: 'METHOD-1'.
    position := self position.
    selector := ''.
    arguments := OrderedCollection new.
    type == #keyword
	ifTrue:
	   [[type == #keyword]
	       whileTrue:
		   [selector := selector , token contents.
		    self scan.
		    type == #identifier ifFalse: [self error: 'missing parameter name'].
		    arguments add: token contents.
		    self scan].
	    self parseVarParams: arguments]
	ifFalse:
	    [type == #binary
		 ifTrue:
		     [selector := selector , token contents.
		      self scan.
		      type == #identifier ifFalse: [self error: 'missing parameter name'].
		      arguments add: token contents.
		      self scan]
		 ifFalse:
		     [type == #identifier
			  ifTrue:
			      [selector := token contents.
			       self scan; parseVarParams: arguments]
			  ifFalse:
			      [self error: 'method pattern expected']]].
    node := MethodNode withType: typeName selector: selector arguments: arguments position: position.
    self note: 'METHOD-2'.
    type == #ellipsis
	ifTrue:
	    [node beVariadic.
	     self scan].
    type == #'['
	ifTrue:
	   [self scan.
	    "----v---- non-positional arguments ----v----"
	    type == #':'
		ifTrue:
		    [self parseVarParams: arguments.
		    (type == #binary and: [token contents = '|'])
			ifFalse: [self error: '''|'' expected after block arguments'].
		    self scan].
	    "----^---- non-positional arguments ----^----"
	    self parseSequence: node]
	ifFalse: [type == #extern
		      ifTrue:  [node external: self parsePrimitive]
		      ifFalse: [self error: 'method body expected']].
    self note: 'METHOD-3'.
    ^node
]

Parser parseDefinition: name
[
    | position node |
    position := self position.
    self scan.
    type == #'[' ifTrue: [^node := DefinitionNode withName: name exec: self parseExec position: position].
    self error: 'literal block expected'.
]

Parser parseDeclaration
[
    type == #extern ifTrue: [^self parseExtern].
    type == #'[' ifTrue: [^self parseExec].
    type == #identifier
	ifTrue:
	   [| name |
	    name := token contents.
	    self scan.
	    ^(type == #':' or: [type == #'('])
		ifTrue:  [self parsePrototype: name]
		ifFalse:
		   [type == #assign
		        ifTrue:  [self parseDefinition: name]
			ifFalse: [self parseMethod: name]]].
    self error: 'syntax error'
]

Parser parse
[
    | node |
    "loop needed to avoid returning nil after { include } or { input }"
    node := nil.
    [node isNil and: [type notNil or: [self atEnd not]]]
	whileTrue:
	   [[type isNil and: [self atEnd not]] whileTrue: [self scan].
	    type notNil ifTrue: [node := self parseDeclaration]].
    ^node
]
