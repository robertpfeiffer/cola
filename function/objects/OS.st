" OS.st -- operating system services

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

  Last edited: 2007-09-03 13:01:03 by piumarta on ubuntu
"

{ import: Objects }

OS : Object ()

OSArgumentCount  := []
OSArgumentVector := []
OSArguments      := []

OS _argumentCount		{ _return (oop)_libid->param(0); }
OS _argumentAt_: _index		{ _return (oop)(((char **)_libid->param(1))[(int)v__index]); }

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

OS arguments		[ ^OSArguments ifNil: [OSArguments := self makeArguments] ]

OS makeArguments
[
    | arguments |
    arguments := OrderedCollection new.
    self argumentVector from: 1 do: [:arg | arguments addLast: arg].
    ^arguments
]

OS errno		[ ^self integerParam: -1 ]
OS architecture		[ ^self stringParam: 5 ]
OS system		[ ^self stringParam: 6 ]

OS integerParam: number	[ ^SmallInteger value_: (self _param_: number _integerValue) ]
OS stringParam: number	[ ^String	value_: (self _param_: number _integerValue) ]

OS _param_: _n		{ _return (oop)_libid->param((int)v__n); }

OS sleep: seconds
{
#  if defined(WIN32)
    Sleep(((long)v_seconds >> 1) * 1000);
#  else
    sleep((long)v_seconds >> 1);
#  endif
}

OS usleep: useconds
{
#  if defined(WIN32)
    Sleep(((long)v_useconds >> 1) / 1000);
#  else
    usleep((long)v_useconds >> 1);
#  endif
}

OS exit: status
{
    exit((long)v_status >> 1);
}
