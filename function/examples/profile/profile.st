{ import: Object }

[
    | count |
    count := 5.
    [ 1 to: count do: [:i |
	  StdErr nextPutAll: 'iteration '; print: i; nextPutAll: ' of '; println: count.
	  0 to: 100000 do: [:j | j printString]]]
	statisticalProfile report put.
]
