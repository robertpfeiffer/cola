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

PEGInterpreter addGrammar: aGrammar		[ aGrammar from: 1 do: [:defn | rules at: defn second put: defn third] ]

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
    result := env at: expr second
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
    (self eval: expr second on: in in: env) ifFalse: [^nil].
    pos := in position.
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

"----------------"

PEGDebugger : PEGInterpreter ()

PEGDebugger invoke	:expr :in :env
[
    | ok |
    ok := super invoke :expr :in :env.
    ok
	ifTrue:  [StdOut print: expr second; nextPutAll: ' -> '; print: result; cr]
	ifFalse: [StdOut print: expr second; nextPutAll: ' -> FAIL'; cr].
    ^ok
]
