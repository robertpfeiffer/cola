" OS.st -- operating system access

  Copyright (c) 2006, 2007 Ian Piumarta
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

  Last edited: 2007-02-28 14:42:12 by piumarta on emilia
"

{ import: Objects }

OS : Object ()

OSArgumentCount  := []
OSArgumentVector := []

OS _argumentCount		{ return (oop)_param(0); }
OS _argumentAt_: _index		{ return (oop)(((char **)_param(1))[(int)v__index]); }

OS argumentCount		[ ^OSArgumentCount  ifNil: [OSArgumentCount := SmallInteger value_: self _argumentCount] ]
OS argumentVector		[ ^OSArgumentVector ifNil: [OSArgumentVector := self makeArgumentVector] ]

OS makeArgumentVector                    
[
    | argc argv |
    argc := self argumentCount. 
    argv := Array new: argc.
    0 to: argc - 1 do: [:i | argv at: i put: (String value_: (self _argumentAt_: i _integerValue))].
    ^argv
]

OS argumentAt: index	[ ^(index >= 0 and: [index < self argumentVector size]) ifTrue: [OSArgumentVector at: index] ]
OS arguments		[ ^self argumentVector copyFrom: 1 to: self argumentCount - 1]

OS errno		[ ^self integerParam: -1 ]
OS architecture		[ ^self stringParam: 5 ]
OS system		[ ^self stringParam: 6 ]

OS integerParam: number	[ ^SmallInteger value_: (self _param_: number _integerValue) ]
OS stringParam: number	[ ^String	value_: (self _param_: number _integerValue) ]

OS _param_: _n		{ return (oop)_param((int)v__n); }

OS sleep: seconds
{
    sleep((long)v_seconds >> 1);
}

OS usleep: useconds
{
    usleep((long)v_useconds >> 1);
}

OS exit: status
{
    exit((long)v_status >> 1);
}
