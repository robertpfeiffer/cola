{ import: Object }

MacroStateVT : _vtable ( states )

MacroStateVT states	[ ^states ]

MacroStateVT delegated
[
    self := super delegated.
    states := IdentityDictionary new.
    states at: #default put: self.
]

MacroStateVT withStates: stateDict
[
    self := super copyEmpty.
    states := stateDict.
]

MacroState : Object ()

[ MacroState _vtable: (MacroStateVT new copyEmpty: MacroState _vtable) ]

MacroState _delegated: _size	[ ^self _vtable delegated _alloc: _size ]

MacroState reset			[ self state: #default ]
MacroState state: stateName		[ self _vtable: (self stateNamed: stateName) ]
MacroState stateNamed: stateName	[ ^self _vtable states at: stateName ifAbsent: [self newStateNamed: stateName] ]
MacroState newStateNamed: stateName	[ ^self _vtable states at: stateName put: (self _vtable withStates: self _vtable states) ]

MacroState new
[
    self := super new.
    self reset.
]

"----------------------------------------------------------------"

Test : MacroState ( name )

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
