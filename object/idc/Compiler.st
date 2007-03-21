"							-*- Smalltalk -*-
  Copyright (c) 2005, 2006 Ian Piumarta
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

  Last edited: 2007-03-21 16:05:34 by piumarta on emilia.local
"

{ import: Object }
{ import: OrderedCollection }
{ import: Dictionary }
{ import: CCodeGenerator }
{ import: CManagedCodeGenerator }
{ import: ImportNode }
{ import: Parser }
{ import: ScannerContext }
{ import: StringIO }

"I represent an (offline) compiler."

"BUG: Compiler should be a supertype assuming interactive, incremental
 compilation: intelligent error handling, no includes, no pragmas, global
 context is the real global environment, and the CompilerOptions are set
 appropriately for the 'frozen' assumptions at the time the runtime kernel was
 compiled.  Then...
    FileCompiler (or OfflineCompiler or whatever) should be a subtype that
 implements console error/warning messages, termination on errors, pragmas for
 designating built-in types, imports/includes from files, and a global context
 built by culling type and external variable declarations from included files."

"BUG: the CodeGenerator and backend-specific portions of the Encoder are not
 pluggable."

Compiler : Object (
    parser		"a Parser gobbling some input text"
    options		"CompilerOptions"
    including		"whether to ignore all declarations except types"
    program		"OrderedCollection of ParseNodes in the top-level"
    types		"Dictionary mapping all known type names to their declarations"
    sources		"paths of files already scanned (to avoid multiple inclusion)"
    imports		"names of libraries already imported (to avoid redundant imports)"
    externalFlags	"stack of flags indicating whether declarations are local or external"
    intrinsicTypes	"built-in type names and method selectors for cloning them"
)

Compiler initialize
[
    super initialize.
    including := false.
    program := OrderedCollection new.
    types := Dictionary new.
    sources := Set new.
    imports := Set new.
    externalFlags := OrderedCollection new.
    intrinsicTypes := (Dictionary new: 64)	"trade some space for speed"
	at: 'object'	    	    put: '_object'	  	  -> nil;
	at: 'nil'	    	    put: '_nil'		  	  -> nil;
	at: 'true'	    	    put: '_true'	  	  -> nil;
	at: 'false'	    	    put: '_false'	  	  -> nil;
	at: 'integer'	    	    put: '_integer'	  	  -> 'value_:';
	at: 'largePositiveInteger'  put: '_largePositiveInteger'  -> 'size_:value_:';
	at: 'largeNegativeInteger'  put: '_largeNegativeInteger'  -> 'size_:value_:';
	at: 'float'	    	    put: '_float'	  	  -> 'value_:';
	at: 'character'     	    put: '_character'	  	  -> 'value_:';
	at: 'vector'	    	    put: '_vector'	  	  -> 'new_:';
	at: 'symbol'	    	    put: '_symbol'	  	  -> 'size_:value_:';
	at: 'string'	    	    put: '_string'	  	  -> 'size_:value_:';
	at: 'byteArray'     	    put: '_byteArray'	  	  -> 'size_:value_:';
	at: 'wordArray'     	    put: '_wordArray'	  	  -> 'size_:value_:';
	at: 'objectArray'   	    put: '_objectArray'	  	  -> 'size_:value_:';
	at: 'staticClosure' 	    put: '_staticClosure' 	  -> 'function_:arity_:';
	at: 'fullClosure'   	    put: '_fullClosure'	  	  -> 'function_:arity_:outer:state:nlr_:';
	yourself.
]

Compiler compileFile: fileName toFile: outputName withOptions: compilerOptions
[
    "Compile fileName into a C program according to compilerOptions and write
     the result in outputName."
    | output codeGenerator |
    self := self new.
    options := compilerOptions.
    self input: fileName.	"implicit { input: <fileName> } at the top level"
    output := String new writeStream.
    codeGenerator := CodeGenerator forExecutionModel: compilerOptions executionModel.
    codeGenerator new generate: program on: output for: self outputType: options outputType fileName: fileName baseName.
    output := output contents.
    "if no outputName, write to standard output"
    outputName isNil ifTrue: [output print] ifFalse: [output writeToFileNamed: outputName].
]

Compiler input: fileName	"take input from fileName, then resume in current file"
[
    self readFrom: fileName including: including.
]

Compiler include: fileName	"input fileName but ignore definitions"
[
    self readFrom: fileName including: true.
]

Compiler import: fileName	"include fileName and try to find a corresponding library at runtime"
[
    | libName |
    libName := fileName withoutSuffix: '.st'.
    (imports includes: libName)
	ifFalse:
	   [program add: (ImportNode withName: libName position: parser position).
	    imports add: libName].
    self readFrom: fileName including: true.
]

"Common to input:, include:, import:."

Compiler readFrom: fileName including: includingFlag
[
    | path outer node savedIncluding |
    "find the file"
    path := fileName findFileSearching: options searchPaths withSuffixes: #('' '.st').
    (sources includes: path) ifTrue: [^nil].	"ignore if already scanned"
    sources add: path.				"never scan it again"
    outer := parser.				"push a new parser for included file"
    parser := Parser on: (ScannerContext onFileNamed: path) notifying: self.
    options searchPaths addLast: path directoryName.	"implicitly search file's directory"
    savedIncluding := including.
    including := includingFlag.

    [(node := parser parse) notNil]		"parse the file"
	whileTrue:
	    [node addTo: self].

    parser := outer.				"pop the parser"
    options searchPaths removeLast.		"stop searching file's directory"
    including := savedIncluding.		"restore previous include mode"
]

Compiler external: text				"explicitly turn on 'include' mode"
[
    externalFlags addLast: including.
    including := true.
]

Compiler internal: text				"turn off 'include' mode"
[
    externalFlags isEmpty ifTrue: [self error: 'not in external section' at: parser position].
    including := externalFlags removeLast.
]

Compiler pragma: text				"{ pragma: directive ... }"
[
    | args |
    args := text tokenized: ' '.
    args size >= 2
	ifTrue:
	   [(args second = 'type' and: [args size >= 4]) ifTrue:  [^self pragmaType: args]].
    self warn: 'unknown pragma: ', text at: parser position.
]

Compiler pragmaType: args			"{ pragma: type builtInName userDefinedType }"
[
    | constructor |
    constructor := intrinsicTypes at: args third ifAbsent: [].
    constructor isNil ifTrue: [self error: 'unknown type: ''', args third, '''' at: parser position].
    constructor key: args fourth.
    args size > 4 ifTrue: [constructor value: args fifth].
]

Compiler addExtern: externNode			"{ ...anything... }"
[
    options verboseFlag ifTrue: [externNode println: 0].
    including ifFalse: [program add: externNode].
]

Compiler addExec: execNode			"[ ...sequence... ]"
[
    options verboseFlag ifTrue: [execNode println: 0].
"
    (program notEmpty and: [program last isPrototypeNode and: [program last isExternal not]])
	ifTrue: [execNode inDeclaration: program last].
"
    including ifFalse: [program add: execNode].
]

Compiler addInclude: includeNode		"{ include <fileName.h> } "
[
    options verboseFlag ifTrue: [includeNode println: 0].
    including ifFalse: [program add: includeNode].
]

Compiler addMethod: methodNode			""
[
    | base |
    options verboseFlag ifTrue: [methodNode println: 0].
    base := types at: methodNode type ifAbsent: [self errorUndefined: methodNode type at: methodNode].
    base isPrototypeNode ifFalse: [self errorNoType: methodNode type at: methodNode].
    including ifFalse: [program add: methodNode].
]

Compiler addType: typeNode			"Proto [ : Base ] ( [slots...] )"
[
    | name base slots |
    options verboseFlag ifTrue: [typeNode println: 0].
    slots := OrderedCollection new.
    name := typeNode name.
    (base := typeNode base) isNil
	ifFalse:
	   [base := types at: base ifAbsent: [self errorUndefined: typeNode base at: typeNode].
	    base isPrototypeNode ifFalse: [self errorNoType: typeNode base at: typeNode].
	    slots addAll: base slots].
    "look for name conflicts with base type"
    typeNode slots do: [:slot |
	(slots includes: slot) ifTrue: [self errorRedefined: slot at: typeNode].
	slots add: slot].
    typeNode slots: slots.
    "add type to global declarations, looking for name conflicts"
    (base := types at: name ifAbsent: []) isNil
	ifTrue:  [program add: (types at: name put: typeNode)]
	ifFalse: [base = typeNode ifFalse: [self errorConflict: name at: typeNode at: base]].
    including ifTrue: [typeNode beExternal].
]

Compiler addDefinition: definitionNode		"Var := expr"
[
    | name prior |
    options verboseFlag ifTrue: [definitionNode println: 0].
    "add defn to global declarations, looking for name conflicts"
    name := definitionNode name.
    (prior := types at: name ifAbsent: []) isNil
	ifTrue:  [program add: (types at: name put: definitionNode)]
	ifFalse: [self errorConflict: name at: definitionNode at: prior].
    including ifTrue: [definitionNode beExternal].
]

Compiler encode: nameString
[
    "Answer a global declaration corresponding to nameString."
    ^types at: nameString ifAbsent: []
]

Compiler constructorFor: typeName
[
    "Answer (typeName -> selectorName) for cloning a built-in type, obeying
     pragmas redirecting to a user-defined type."
    ^intrinsicTypes
	at: typeName
	ifAbsent: [self error: 'internal compiler error #10 (', typeName, ')'].
]

Compiler inlineMacroSelectors	[ ^options macroFlag ]
Compiler inlineSpecialSelectors	[ ^options specialFlag ]
Compiler inlineTaggedArithmetic	[ ^options taggedFlag ]
Compiler cacheLevel		[ ^options cacheLevel ]

"Sundry barfing in various situations..."

Compiler warn: message at: parseNode
[
    (parseNode position printString, ': ', message) putln	"continue"
]

Compiler error: message at: parseNode
[
    self error: parseNode position printString, ': ', message.	"terminate"
]

Compiler errorUndefined: name at: parseNode
[
    self error:	name printString, ' is undefined' at: parseNode
]

Compiler errorNoType: name at: parseNode
[
    self error:	name printString, ' is not a type' at: parseNode
]

Compiler errorRedefined: name at: parseNode at: prevNode
[
    self error:	name printString, ' previously defined at ', prevNode position printString at: parseNode
]

Compiler errorRedefined: name at: parseNode
[
    self error:	name printString, ' is already used' at: parseNode
]

Compiler errorConflict: name at: parseNode at: prevNode
[
    self error:	'declaration of ', name printString, ' conflict with ', prevNode position printString at: parseNode
]

Compiler errorNoSuper: name at: parseNode
[
    self error:	'\'super\' is undefined' at: parseNode
]
