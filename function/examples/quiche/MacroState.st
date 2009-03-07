{ import: Objects }

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
