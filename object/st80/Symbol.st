" Symbol.st -- hashed Strings

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

  Last edited: 2006-04-01 11:26:53 by piumarta on emilia.local
"

{ import: String }
{ import: Dictionary }

Symbol : ImmutableString ()

Symbol size_: _size value_: _value
[
    ^self intern: (String size_: _size value_: _value).
]

SymbolTable : Dictionary ()
[
    SymbolTable := SymbolTable new.
]

Symbol intern: aString
[
    | symbol |
    symbol := SymbolTable at: aString ifAbsent: [SymbolTable at: aString put: (self basicNewFromString: aString)].
    "'intern: ' put.  aString put.  ' -> ' put.  symbol print.  '  ' put.  symbol identityHash println."
    ^symbol
]

Symbol basicNewFromString: aString
[
    | length |
    length := aString size.
    self := self _clone initialize: length.
    1 to: length do: [:index | self byteAt: index put: (aString byteAt: index)].
]

Symbol , aSymbolOrString
[
    ^self intern: super , aSymbolOrString
]

Symbol printOn: aStream
[
  aStream nextPutAll: '#'''; nextPutAll: self; nextPut: $'.
]

"----------------------------------------------------------------"

String asSymbol
[
    ^Symbol intern: self
]
