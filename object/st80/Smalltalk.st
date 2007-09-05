" Smalltalk.st -- clearinghouse for system-wide information

  Copyright (c) 2005, 2006 Ian Piumarta
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

  Last edited: 2007-09-03 11:32:13 by piumarta on ubuntu
"

{ import: Object }
{ import: SmallInteger }
{ import: String }
{ import: Array }

Smalltalk : Object (
    argumentCount
    argumentVector
)

[
   Smalltalk := Smalltalk new.
]

Smalltalk quit
{
  exit(0);
}

Smalltalk abort
{
  fflush(stdout);
  fprintf(stderr, "\nSmalltalk abort\n");
  fflush(stderr);
  abort();
}

Smalltalk _osError			{ return (oop)_libid->param(-1); }
Smalltalk _argumentCount		{ return (oop)_libid->param(0); }
Smalltalk _argumentAt_: _index		{ return (oop)(((char **)_libid->param(1))[(int)v__index]); }
Smalltalk _osErrorString_: _errno	{ return (oop)strerror((int)v__errno); }
Smalltalk _directoryDelimiter		{ return (oop)_libid->param(7); }

Smalltalk directoryDelimiter		[ ^Character value_: self _directoryDelimiter ]

Smalltalk  osError			[ ^SmallInteger value_: self _osError ]
Smalltalk  osErrorString		[ ^self osErrorString_: self _osError ]
Smalltalk  osErrorString: errno		[ ^self osErrorString_: errno _integerValue ]
Smalltalk  osErrorString_: _errno	[ ^ImmutableString value_: (self _osErrorString_: _errno) ]

Smalltalk osWarning: message		[ (message, ': ', self osErrorString) putln ]
Smalltalk osError: message		[ self osWarning: message; quit ]

Smalltalk argumentCount		[ ^argumentCount  ifNil: [argumentCount := SmallInteger value_: self _argumentCount] ]
Smalltalk argumentVector	[ ^argumentVector ifNil: [argumentVector := self makeArgumentVector] ]

Smalltalk makeArgumentVector
[
    | argc argv |
    argc := self argumentCount.
    argv := Array new: argc.
    1 to: argc do: [:i | argv at: i put: (ImmutableString value_: (self _argumentAt_: (i - 1) _integerValue))].
    ^argv
]

Smalltalk argumentAt: index	[ ^(index > 0 and: [index <= self argumentVector size]) ifTrue: [argumentVector at: index] ]
Smalltalk arguments		[ ^self argumentVector copyFrom: 2 to: self argumentCount ]
