{ import: st80 }

[
    | argv |
    (argv := Smalltalk arguments) isEmpty
	ifFalse:
	   [argv do: [:arg | arg put] separatedBy: [' ' put].
	    $\n put]
]
