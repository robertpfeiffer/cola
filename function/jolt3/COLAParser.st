"THIS FILE WAS GENERATED AUTOMATICALLY -- DO NOT EDIT!"

{ import: Parser }
COLAParser : Parser ()
COLAParser Spacing :inputStream
[
| _ok_ pos1 pos2 pos3 |
_ok_ := ((pos1 := TokenGroup new)
 and: [[((self Space :inputStream)
 or: [(self Comment :inputStream)])] whileTrue: [(pos1 add: result)]. (result := pos1)]).
^_ok_
]
COLAParser Space :inputStream
[
| _ok_ pos1 |
_ok_ := (((inputStream peek == 32) ifTrue: [result := inputStream next. 1])
 or: [((inputStream peek == 9) ifTrue: [result := inputStream next. 1])
 or: [(self EndOfLine :inputStream)]]).
^_ok_
]
COLAParser EndOfLine :inputStream
[
| _ok_ pos1 |
_ok_ := ((self string: '\015\012' :inputStream)
 or: [((inputStream peek == 10) ifTrue: [result := inputStream next. 1])
 or: [((inputStream peek == 13) ifTrue: [result := inputStream next. 1])]]).
^_ok_
]
COLAParser Comment :inputStream
[
| _ok_ pos1 pos2 pos3 pos4 |
_ok_ := (((pos1 := inputStream position)
 and: [(self CommentCharacter :inputStream)
 and: [((pos2 := TokenGroup new)
 and: [[(((pos3 := inputStream position)
 and: [(((pos4 := inputStream position)
 and: [(self EndOfLine :inputStream)]) ifTrue: [(inputStream position: pos4)] ifFalse: [1])
 and: [(inputStream notAtEnd and: [result := inputStream next. 1])]])
 or: [(inputStream position: pos3)])] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [(self EndOfLine :inputStream)]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser CommentCharacter :inputStream
[
| _ok_ pos1 |
_ok_ := ((inputStream peek == 35) ifTrue: [result := inputStream next. 1]).
^_ok_
]
COLAParser EndOfFile :inputStream
[
| _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [(inputStream notAtEnd and: [result := inputStream next. 1])]) ifTrue: [(inputStream position: pos1)] ifFalse: [1]).
^_ok_
]
COLAParser Character :inputStream
[
| s _ok_ pos1 pos2 pos3 pos4 |
_ok_ := ((((pos1 := inputStream position)
 and: [((inputStream peek == 92) ifTrue: [result := inputStream next. 1])
 and: [((((pos2 := inputStream position)
 and: [((inputStream peek == 97) ifTrue: [result := inputStream next. 1])
 and: [((result := 97) or: [1])]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((inputStream peek == 98) ifTrue: [result := inputStream next. 1])
 and: [((result := 98) or: [1])]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((inputStream peek == 101) ifTrue: [result := inputStream next. 1])
 and: [((result := 101) or: [1])]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((inputStream peek == 102) ifTrue: [result := inputStream next. 1])
 and: [((result := 102) or: [1])]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((inputStream peek == 110) ifTrue: [result := inputStream next. 1])
 and: [((result := 10) or: [1])]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((inputStream peek == 114) ifTrue: [result := inputStream next. 1])
 and: [((result := 13) or: [1])]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((inputStream peek == 116) ifTrue: [result := inputStream next. 1])
 and: [((result := 9) or: [1])]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((inputStream peek == 118) ifTrue: [result := inputStream next. 1])
 and: [((result := 118) or: [1])]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((inputStream peek == 39) ifTrue: [result := inputStream next. 1])
 and: [((result := 39) or: [1])]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((inputStream peek == 34) ifTrue: [result := inputStream next. 1])
 and: [((result := 34) or: [1])]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((inputStream peek == 91) ifTrue: [result := inputStream next. 1])
 and: [((result := 91) or: [1])]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((inputStream peek == 93) ifTrue: [result := inputStream next. 1])
 and: [((result := 93) or: [1])]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((inputStream peek == 92) ifTrue: [result := inputStream next. 1])
 and: [((result := 92) or: [1])]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((((pos3 := inputStream position)
 and: [((((pos4 := inputStream position)
 and: [(self class: #[0 0 0 0 0 0 7 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] :inputStream)
 and: [(self class: #[0 0 0 0 0 0 255 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] :inputStream)
 and: [(self class: #[0 0 0 0 0 0 255 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] :inputStream)]]])
 or: [(inputStream position: pos4)])
 or: [(((pos4 := inputStream position)
 and: [(self class: #[0 0 0 0 0 0 255 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] :inputStream)
 and: [(((self class: #[0 0 0 0 0 0 255 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] :inputStream)) ifTrue: [result := TokenGroup with: result] ifFalse: [result := TokenGroup new])]])
 or: [(inputStream position: pos4)])])]) ifTrue: [result := (pos3 text: inputStream position)])
 and: [s := result. 1])
 and: [(result := ((TokenGroup new) add: (Integer fromString: s)) first)]])
 or: [(inputStream position: pos2)])
 or: [((inputStream pushGroup: (TokenGroup new add: 'unknown escape')) ifTrue: [(self error :inputStream)])]]]]]]]]]]]]]])]])
 or: [(inputStream position: pos1)])
 or: [(inputStream notAtEnd and: [result := inputStream next. 1])]).
^_ok_
]
COLAParser SingleString :inputStream
[
| s _ok_ pos1 pos2 pos3 pos4 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 39) ifTrue: [result := inputStream next. 1])
 and: [(((pos2 := TokenGroup new)
 and: [[(((pos3 := inputStream position)
 and: [(((pos4 := inputStream position)
 and: [((inputStream peek == 39) ifTrue: [result := inputStream next. 1])]) ifTrue: [(inputStream position: pos4)] ifFalse: [1])
 and: [(self Character :inputStream)]])
 or: [(inputStream position: pos3)])] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [s := result. 1])
 and: [((inputStream peek == 39) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)
 and: [(result := ((TokenGroup new) add: (s asString)) first)]]]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser DoubleString :inputStream
[
| s _ok_ pos1 pos2 pos3 pos4 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 34) ifTrue: [result := inputStream next. 1])
 and: [(((pos2 := TokenGroup new)
 and: [[(((pos3 := inputStream position)
 and: [(((pos4 := inputStream position)
 and: [((inputStream peek == 34) ifTrue: [result := inputStream next. 1])]) ifTrue: [(inputStream position: pos4)] ifFalse: [1])
 and: [(self Character :inputStream)]])
 or: [(inputStream position: pos3)])] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [s := result. 1])
 and: [((inputStream peek == 34) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)
 and: [(result := ((TokenGroup new) add: (s asString)) first)]]]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser Identifier :inputStream
[
| i _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((self IdentifierName :inputStream)
 and: [i := result. 1])
 and: [(self Spacing :inputStream)
 and: [((result := i) or: [1])]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser IdentifierName :inputStream
[
| i _ok_ pos1 pos2 pos3 pos4 |
_ok_ := (((pos1 := inputStream position)
 and: [((((pos2 := inputStream position)
 and: [(((pos3 := inputStream position)
 and: [(self IdentifierCharacter :inputStream)
 and: [((pos4 := TokenGroup new)
 and: [[(self IdentifierRest :inputStream)] whileTrue: [(pos4 add: result)]. (result := pos4)])]])
 or: [(inputStream position: pos3)])]) ifTrue: [result := (pos2 text: inputStream position)])
 and: [i := result. 1])
 and: [(result := ((TokenGroup new) add: (i asSymbol)) first)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser IdentifierCharacter :inputStream
[
| _ok_ pos1 |
_ok_ := (self class: #[0 0 0 0 0 0 0 0 254 255 255 135 254 255 255 7 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] :inputStream).
^_ok_
]
COLAParser IdentifierRest :inputStream
[
| _ok_ pos1 |
_ok_ := ((self IdentifierCharacter :inputStream)
 or: [(self class: #[0 0 0 0 0 0 255 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] :inputStream)]).
^_ok_
]
COLAParser DecimalDigit :inputStream
[
| _ok_ pos1 |
_ok_ := (self class: #[0 0 0 0 0 0 255 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] :inputStream).
^_ok_
]
COLAParser DecimalInteger :inputStream
[
| n _ok_ pos1 pos2 pos3 |
_ok_ := (((pos1 := inputStream position)
 and: [((((pos2 := inputStream position)
 and: [((pos3 := TokenGroup new)
 and: [(((self DecimalDigit :inputStream)) ifTrue: [(pos3 add: result). 1])
 and: [[(self DecimalDigit :inputStream)] whileTrue: [(pos3 add: result)]. (result := pos3). 1]])]) ifTrue: [result := (pos2 text: inputStream position)])
 and: [n := result. 1])
 and: [(result := ((TokenGroup new) add: (Integer fromString: n)) first)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser EQUAL :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 61) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser RIGHTARROW :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [(self string: '->' :inputStream)
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser BAR :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 124) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser AND :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 38) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser NOT :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 33) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser QUESTION :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 63) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser STAR :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 42) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser PLUS :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 43) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser OPEN :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 40) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser CLOSE :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 41) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser LANGLE :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 60) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser RANGLE :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 62) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser LBRACE :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 123) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser RBRACE :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 125) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser LBRACK :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 91) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser RBRACK :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 93) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser DOT :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 46) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser SEMICOLON :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 59) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser COLON :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 58) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser DOLLAR :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 36) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser BACKQUOTE :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 96) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser COMMA :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 44) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser AT :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 64) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
COLAParser BACKSLASH :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 92) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
