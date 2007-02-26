" IdentitySet.st -- uncounted, unorder collections of non-identical elements

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

  Last edited: 2005-12-19 10:32:40 by piumarta on margaux.local
"

{ import: Set }

IdentitySet : Set ()

IdentitySet scanFor: anObject
[
    "Scan the array for the first slot containing either a nil
     (indicating an empty slot) or an element that matches anObject.
     Answer the index of that slot or 0 if no slot is found.  This
     method will be overridden in various subtypes that have
     different interpretations for matching elements. "
    | finish start |
    finish := array size.
    start := anObject identityHash \\ finish + 1.
    "search from (hash mod size) to the end"
    start to: finish do: [:index |
	| element |
	((element := array at: index) isNil or: [element == anObject])
	    ifTrue: [^index]].
    "search from start to (hash mod size)"
    1 to: start do: [:index |
	| element |
        ((element := array at: index) isNil or: [element == anObject])
	    ifTrue: [^index]].
    ^0.	"no match AND no empty slot"
]
