"THIS FILE WAS GENERATED AUTOMATICALLY -- DO NOT EDIT!"

{ import: Parser }
B64Decoder : Parser (s64)
B64Decoder start :inputStream
[
| _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [(self header :inputStream)
 and: [((pos2 := TokenGroup new)
 and: [(((self base64text :inputStream)) ifTrue: [(pos2 add: result). 1])
 and: [[(self base64text :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2). 1]])
 and: [(self footer :inputStream)]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
B64Decoder header :inputStream
[
| _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [((pos2 := TokenGroup new)
 and: [[(self space :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [(self string: 'begin-base64 ' :inputStream)
 and: [(self perm :inputStream)
 and: [((inputStream peek == 32) ifTrue: [result := inputStream next. 1])
 and: [(self filename :inputStream)
 and: [(self nl :inputStream)]]]]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
B64Decoder footer :inputStream
[
| _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [((pos2 := TokenGroup new)
 and: [[(self space :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [(self nl :inputStream)
 and: [((pos2 := TokenGroup new)
 and: [[(self space :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [(self string: '====' :inputStream)]]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
B64Decoder base64text :inputStream
[
| p1 p2 p3 p4 _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((self b64 :inputStream)
 and: [p1 := result. 1])
 and: [((self b64 :inputStream)
 and: [p2 := result. 1])
 and: [((self b64 :inputStream)
 and: [p3 := result. 1])
 and: [((self b64 :inputStream)
 and: [p4 := result. 1])
 and: [((result := [
               s64 := (p1 << 18) + (p2 << 12) + (p3 << 6) + p4.
               StdOut nextPut: ((s64 >> 16) & 255);
               nextPut: (s64 >> 8) & 255;
               nextPut: s64 & 0xff ] value) or: [1])]]]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
B64Decoder b64 :inputStream
[
| c _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((self class: #[0 0 0 0 0 136 255 35 254 255 255 7 254 255 255 7 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] :inputStream)
 and: [c := result. 1])
 and: [((result := [ c base64value ] value) or: [1])]])
 or: [(inputStream position: pos1)]).
^_ok_
]
B64Decoder perm :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [(self class: #[0 0 0 0 0 0 255 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] :inputStream)
 and: [(self class: #[0 0 0 0 0 0 255 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] :inputStream)
 and: [(self class: #[0 0 0 0 0 0 255 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] :inputStream)]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
B64Decoder filename :inputStream
[
| _ok_ pos1 pos2 |
_ok_ := ((pos1 := TokenGroup new)
 and: [(((self class: #[255 251 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255] :inputStream)) ifTrue: [(pos1 add: result). 1])
 and: [[(self class: #[255 251 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255] :inputStream)] whileTrue: [(pos1 add: result)]. (result := pos1). 1]]).
^_ok_
]
B64Decoder nl :inputStream
[
| _ok_ pos1 |
_ok_ := (((inputStream peek == 10) ifTrue: [result := inputStream next. 1])
 or: [((inputStream peek == 13) ifTrue: [result := inputStream next. 1])
 or: [(self string: '\012\015' :inputStream)]]).
^_ok_
]
B64Decoder space :inputStream
[
| _ok_ pos1 |
_ok_ := (self class: #[0 2 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] :inputStream).
^_ok_
]
