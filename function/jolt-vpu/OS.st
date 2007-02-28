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
