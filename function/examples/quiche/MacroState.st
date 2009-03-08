" MacroState.st -- objects with multiple disjoint behaviours

  Copyright (c) 2009 Ian Piumarta
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

  Last edited: 2009-03-07 20:19:53 by piumarta on emilia
"

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
