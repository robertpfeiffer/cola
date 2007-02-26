" IdentityDictionary.st -- sets of associations indexable by non-identical key

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

  Last edited: 2005-12-19 10:38:11 by piumarta on margaux.local
"

{ import: Dictionary }
{ import: IdentitySet }

IdentityDictionary : Dictionary ()

IdentityDictionary scanFor: anObject
[
    "Scan the key array for the first slot containing either a nil
     (indicating an empty slot) or an element that matches
     anObject. Answer the index of that slot or zero if no slot is
     found. This method will be overridden in various subclasses that
     have different interpretations for matching elements."
    | element start finish |
    start := (anObject identityHash \\ array size) + 1.
    finish := array size.
    "Search from (hash mod size) to the end."
    start to: finish do: [:index |
	((element := array at: index) == nil or: [element key == anObject])
	    ifTrue: [^index]].
    "Search from 1 to where we started."
    1 to: start - 1 do: [:index |
	((element := array at: index) == nil or: [element key == anObject])
	    ifTrue: [^index]].
    ^0
]

IdentityDictionary keys
[
    | keySet |
    keySet := IdentitySet new: self size.
    self keysDo: [:key | keySet add: key].
    ^keySet
]
