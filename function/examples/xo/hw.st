{ import: Object }

[
    'Hello world' putln.
    1 to: 10 do: [:i |
	1 to: 10 do: [:j | (i * j) print.  '\t' put].
	$\n put].
]
