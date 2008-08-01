{ import: Object }

[
    | words set dict |
    words := #(	peter piper picked a peck of pickled peppers
		if peter piper picked peck of pickled peppers
		where is the peck of pickled peppers
		that peter piper picked	).
    set := Set new.
    words do: [:sym | set add: sym asString].
    set println.
    dict := Dictionary new.
    words do: [:sym | dict at: sym asString put: (dict at: sym asString ifAbsent: [0]) + 1].
    dict println.
    StdOut cr.

    'a' hash println.
    'b' hash println.
    'c' hash println.
    'abc' hash println.
    'acb' hash println.
    'bac' hash println.
    'bca' hash println.
    'cab' hash println.
    'cba' hash println.
    StdOut cr.

    Float pi println hash println.
     0.00 hash println.
     0.01 hash println.
     0.10 hash println.
     1.00 hash println.
     2.00 hash println.
     3.00 hash println.
    10.00 hash println.
]
