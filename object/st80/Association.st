" Association.st -- key-value tuples

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

  Last edited: 2006-01-06 15:48:57 by piumarta on emilia.local
"

{ import: LookupKey }

Association : LookupKey ( value )

Association withKey: aKey value: anObject
[
    ^(super withKey: aKey) value: anObject; yourself
]

Association value		[ ^value ]
Association value: anObject	[ ^value := anObject ]

Association = anAssociation	[ ^super = anAssociation and: [value = anAssociation value] ]
Association hash		[ ^key hash bitXor: value hash ]

Association printOn: aStream
[
    super printOn: aStream.
    aStream nextPutAll: '->'.
    value printOn: aStream.
]


Object -> anObject	[ ^Association withKey: self value: anObject ]
