{ import: Object }
{ import: PEGParser }

PEGInterpreter : Object ( rules result )

PEGInterpreter result	[ ^result ]

PEGInterpreter on: aGrammar
[
    self := self new.
    rules := SlotDictionary new.
    self addGrammar: aGrammar.
]

PEGInterpreter addGrammar: aGrammar		[ aGrammar from: 2 do: [:defn | rules at: defn second put: defn third] ]

PEGInterpreter parse: aCollection		[ ^self eval: (rules at: #start) on: aCollection parserStream in: nil ]
PEGInterpreter eval: expr on: input in: env	[ ^self perform: expr first with: expr with: input with: env ]

"----------------"

PEGInterpreter dot	:expr :in :env
[
    in atEnd ifTrue: [^nil].
    result := in next
]

PEGInterpreter literal	:expr :in :env
[
    in peek == expr second ifFalse: [^nil].
    result := in next.
]

PEGInterpreter string	:expr :in :env
[
    | pos |
    pos := in position.
    expr second do: [:c | c == in next ifFalse: [^in position: pos]].
    result := expr second.
]

PEGInterpreter class	:expr :in :env	[ | c | ^((c := in peek) and: [expr second includes: c]) ifTrue: [result := in next] ]

PEGInterpreter invoke	:expr :in :env	[ ^self eval: (rules at: expr second ifAbsent: [self error: 'no rule named ', expr second]) on: in in: nil ]

PEGInterpreter zeroOne	:expr :in :env
[
    result := (self eval: expr second on: in in: env) ifTrue: [Array with: result] ifFalse: [#()]
]

PEGInterpreter zeroMany	:expr :in :env
[
    | o |
    o := OrderedCollection new.
    [self eval: expr second on: in in: env] whileTrue: [o add: result].
    result := o.
]

PEGInterpreter oneMany	:expr :in :env
[
    | o |
    (self eval: expr second on: in in: env) ifFalse: [^nil].
    o := OrderedCollection with: result.
    [self eval: expr second on: in in: env] whileTrue: [o add: result].
    result := o.
]

PEGInterpreter text	:expr :in :env
[
    | pos |
    pos := in position.
    (self eval: expr second on: in in: env) ifFalse: [^nil].
    result := pos text: in position.
]

PEGInterpreter answer	:expr :in :env
[
    | ans sub |
    ans := expr second.
    ans isSymbol ifTrue: [^result := env at: ans].
    ans isArray
	ifTrue:
	   [sub := ans first.
	    sub == #action ifTrue: [self error: 'cannot perform action: ', expr second]].
    self error: 'malformed answer: ', expr printString.
]

PEGInterpreter action	:expr :in :env
[
    self error: 'cannot perform action: ', expr second.
]

PEGInterpreter store	:expr :in :env
[
    (self eval: expr third on: in in: env) ifFalse: [^nil].
    env at: expr second put: result.
]

PEGInterpreter and	:expr :in :env
[
    | pos |
    pos := in position.
    (self eval: expr second on: in in: env) ifFalse: [^nil].
    in position: pos.
]

PEGInterpreter not	:expr :in :env
[
    | pos |
    pos := in position.
    (self eval: expr second on: in in: env) ifTrue: [^in position: pos].
]

PEGInterpreter sequence :expr :in :env
[
    | pos |
    pos := in position.
    (self eval: expr second on: in in: env) ifFalse: [^nil].
    expr from: 2 do: [:e | (self eval: e on: in in: env) ifFalse: [^in position: pos]].
]

PEGInterpreter alternatives	:expr :in :env
[
    expr from: 1 do: [:e | (self eval: e on: in in: env) ifTrue: [^e] ].
    ^nil
]

PEGInterpreter parameters	:expr :in :env
[
    env := SlotDictionary new.
    expr second do: [:name | env at: name put: in next].
    ^self eval: expr fourth on: in in: env
]

PEGInterpreter definition	:expr :in :env	[ self error: 'not implemented: definition' ]

"----------------------------------------------------------------"

PEGDebugger : PEGInterpreter ( depth )

PEGDebugger on: aGrammar
[
    self := super on: aGrammar.
    depth := 0.
]

PEGDebugger enter: name on: in
[
    StdErr space: 2 * depth; nextPutAll: name; cr.
    depth := depth + 1.
]

PEGDebugger leave: name on: in with: ok
[
    depth := depth - 1.
    StdErr space: 2 * depth; nextPutAll: name; space; nextPutAll: ' -> '.
    ok
	ifTrue:  [StdErr print: result.  self echo: result]
	ifFalse: [StdErr nextPutAll: 'FAIL'].
    StdErr nextPutAll: ' @ '.
    self echo: in peek.
    StdErr cr.
    ^ok
]

PEGDebugger echo: c
[
    (c and: [c isInteger and: [32 <= c and: [c < 127]]]) ifTrue: [StdErr space; nextPut: c]
]

"----------------"
"
PEGDebugger dot	:expr :in :env
[
]
"
PEGDebugger literal	:expr :in :env
[
    ^self enter: expr first on: in; leave: expr first on: in with: (super literal :expr :in :env)
]
"
PEGDebugger string	:expr :in :env
[
]

PEGDebugger class	:expr :in :env
[
]
"
PEGDebugger invoke	:expr :in :env
[
    ^self enter: expr second on: in; leave: expr second on: in with: (super invoke :expr :in :env)
]
"
PEGDebugger zeroOne	:expr :in :env
[
]

PEGDebugger zeroMany	:expr :in :env
[
]

PEGDebugger oneMany	:expr :in :env
[
]

PEGDebugger text	:expr :in :env
[
]

PEGDebugger action	:expr :in :env
[
]

PEGDebugger answer	:expr :in :env
[
]

PEGDebugger store	:expr :in :env
[
]

PEGDebugger and	:expr :in :env
[
]

PEGDebugger not	:expr :in :env
[
]

PEGDebugger sequence :expr :in :env
[
]

PEGDebugger alternatives	:expr :in :env
[
]

PEGDebugger parameters	:expr :in :env
[
]

PEGDebugger definition	:expr :in :env
[
]
"
