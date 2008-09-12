{ import: Object }
{ import: B64Decoder }

Base64Values := [ Array new: 256 ]

[
	$A to: $Z do: [:c | Base64Values at: c put: c - $A +  0].
	$a to: $z do: [:c | Base64Values at: c put: c - $a + 26].
	$0 to: $9 do: [:c | Base64Values at: c put: c - $0 + 52].
	Base64Values at: $+ put: 62.
	Base64Values at: $/ put: 63.
	Base64Values at: $= put: 0.
]

SmallInteger base64value
[
	^Base64Values at: self
]

[
	| parser input |

	OS arguments do: [:arg | parser := B64Decoder new.
	input := (File open: arg) tokenStream.
	(parser start :input)
		ifFalse:
			[parser error: 'parse error near: ', input printString] ].
]
