{ import: st80-imports }

[
    | words tree |
    words := #( Peter Piper picked a peck of pickled peppers
	       	A peck of pickled peppers Peter Piper picked
	       	If Peter Piper picked a peck of pickled peppers
	       	Where is the peck of pickled peppers Peter Piper picked? ).
    tree := AVLTree new.
    tree addAll: words.
    tree printString putln.
    tree := AVLTree withSortBlock: [:a :b | b < a].
    tree addAll: words.
    tree printString putln.
]
