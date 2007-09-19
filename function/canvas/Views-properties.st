" Views-properties.st -- property lists for Views

  Copyright (c) 2007 Ian Piumarta
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

  Last edited: 2007-09-18 20:13:58 by piumarta on emilia
"

{ import: Views }

"TODO: this needs sideways composition"

CompositeView propertyAt: aKey	[ ^self propertyAt: aKey ifAbsent: [] ]
ComposableView propertyAt: aKey	[ ^self propertyAt: aKey ifAbsent: [] ]


CompositeView propertyAt: aKey ifAbsent: errorBlock
[
    properties ifFalse: [^errorBlock value].
    ^properties at: aKey ifAbsent: errorBlock
]

ComposableView propertyAt: aKey ifAbsent: errorBlock
[
    properties ifFalse: [^errorBlock value].
    ^properties at: aKey ifAbsent: errorBlock
]


CompositeView propertyAt: aKey put: aValue	[ ^(properties ifNil: [properties := IdentityDictionary new]) at: aKey put: aValue ]
ComposableView propertyAt: aKey put: aValue	[ ^(properties ifNil: [properties := IdentityDictionary new]) at: aKey put: aValue ]


CompositeView removeProperty: aKey		[ properties ifTrue: [properties removeKey: aKey ifAbsent: []] ]
ComposableView removeProperty: aKey		[ properties ifTrue: [properties removeKey: aKey ifAbsent: []] ]
