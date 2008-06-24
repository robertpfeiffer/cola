{ import: Objects }

ScriptVT : _vtable ( states )

ScriptVT states	[ ^states ]

ScriptVT delegated
[
    StdOut nextPutAll: '** ScriptVT._delegated\n'.
    self := super delegated.
    states := IdentityDictionary new.
    states at: #default put: self.
]

ScriptVT withStates: stateDict
[
    self := super copyEmpty.
    states := stateDict.
]

Script : Object ()

[ Script _vtable: (ScriptVT new copyEmpty: Script _vtable) ]

Script reset			[ self state: #default ]
Script state: stateName		[ self _vtable: (self stateNamed: stateName) ]
Script stateNamed: stateName	[ ^self _vtable states at: stateName ifAbsent: [self newStateNamed: stateName] ]
Script newStateNamed: stateName	[ ^self _vtable states at: stateName put: (self _vtable withStates: self _vtable states) ]

Script new
[
    self := super new.
    self reset.
]

"----------------------------------------------------------------"
"
Test : Script ( name )

Test new: nameString
[
    self := super new.
    name := nameString.
]

Test test
[
    StdOut nextPutAll: name, ' in default\n'.
    self state: #nextState.
]

[ Test state: #nextState ]

Test test
[
    StdOut nextPutAll: name, ' in nextState\n'.
    self state: #lastState.
]

[ Test state: #lastState ]

Test test
[
    StdOut nextPutAll: name, ' in lastState\n'.
    self reset.
]

[ Test state: #default ]

[
    | a b |
    a := Test new: 'a'.
    b := Test new: 'b'.
    a test test.
    b test.
    a test test.
    b test.
    a test test.
    b test.
    a test test.
    b test.
    a test test.
]
"

