" LookupKey.st -- keyed data entries

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

  Last edited: 2005-12-15 14:32:03 by piumarta on emilia.local
"

{ import: Object }

LookupKey : Object ( key )

LookupKey isLookupKey	[ ^true ]
Object isLookupKey	[ ^false ]

LookupKey withKey: aKey	[ ^self new key: aKey; yourself ]

LookupKey key: anObject	[ ^key := anObject ]
LookupKey key		[ ^key ]

LookupKey < aLookupKey	[ ^key < aLookupKey key ]
LookupKey = anObject	[ ^anObject isLookupKey and: [key = anObject key] ]
LookupKey hash		[ ^key hash ]

LookupKey printOn: aStream
[
    key printOn: aStream
]
