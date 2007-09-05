{ import: st80 }

_object _bind: aSelector	{ return (oop)_libid->bind(v_aSelector, self); }

_selector asString		[ ^String value_: self _string ]

Object doesNotUnderstand: aSelector
[
    ^aSelector == #defaultAnswerForTesting asSelector
	ifTrue:
	   [self error: self debugName, ' doesNotUnderstand: ', aSelector asString]
	ifFalse:
	   [('WARNING: ', self debugName, ' ignoring unimplemented message: ', aSelector asString) putln.
	    self _bind: #defaultAnswerForTesting asSelector]
]

Number defaultAnswerForTesting
[
    ^'this is a default answer supplied for a stub method in ', self debugName,' that is not yet implemented'.
]


[
    42 yourself println.
    42 frobulate println.
    3.1415 frobulate println.
    '42' frobulate println.		"this is SUPPOSED to fail"
]
