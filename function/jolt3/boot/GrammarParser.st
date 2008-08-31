"THIS FILE WAS GENERATED AUTOMATICALLY -- DO NOT EDIT!"

{ import: COLAParser }
GrammarParser : COLAParser (optionMemo optionDebug optionTrace)
GrammarParser CommentCharacter :inputStream
[
| _ok_ pos1 |
_ok_ := ((inputStream peek == 37) ifTrue: [result := inputStream next. 1]).
^_ok_
]
GrammarParser start :inputStream
[
| _ok_ pos1 |
_ok_ := (self Grammar :inputStream).
^_ok_
]
GrammarParser Grammar :inputStream
[
| d g _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [(self Spacing :inputStream)
 and: [((pos2 := TokenGroup new)
 and: [[(self Option :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [((self Declaration :inputStream)
 and: [d := result. 1])
 and: [(((pos2 := TokenGroup new)
 and: [(((self Definition :inputStream)) ifTrue: [(pos2 add: result). 1])
 and: [[(self Definition :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2). 1]])
 and: [g := result. 1])
 and: [(self EndOfFile :inputStream)
 and: [([ optionDebug ifTrue: [d println.  g println] . 1] value)
 and: [((result := TokenGroup new) add: #grammar; add: d; concat: g)]]]]]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Option :inputStream
[
| _ok_ pos1 |
_ok_ := ((((pos1 := inputStream position)
 and: [(self string: '+memo' :inputStream)
 and: [(self Spacing :inputStream)
 and: [([ optionMemo  := true . 1] value)]]])
 or: [(inputStream position: pos1)])
 or: [(((pos1 := inputStream position)
 and: [(self string: '-memo' :inputStream)
 and: [(self Spacing :inputStream)
 and: [([ optionMemo  := false . 1] value)]]])
 or: [(inputStream position: pos1)])
 or: [(((pos1 := inputStream position)
 and: [(self string: '+debug' :inputStream)
 and: [(self Spacing :inputStream)
 and: [([ optionDebug := true . 1] value)]]])
 or: [(inputStream position: pos1)])
 or: [(((pos1 := inputStream position)
 and: [(self string: '-debug' :inputStream)
 and: [(self Spacing :inputStream)
 and: [([ optionDebug := false . 1] value)]]])
 or: [(inputStream position: pos1)])
 or: [(((pos1 := inputStream position)
 and: [(self string: '+trace' :inputStream)
 and: [(self Spacing :inputStream)
 and: [([ optionTrace := true . 1] value)]]])
 or: [(inputStream position: pos1)])
 or: [(((pos1 := inputStream position)
 and: [(self string: '-trace' :inputStream)
 and: [(self Spacing :inputStream)
 and: [([ optionTrace := false . 1] value)]]])
 or: [(inputStream position: pos1)])]]]]]).
^_ok_
]
GrammarParser Declaration :inputStream
[
| n b v _ok_ pos1 pos2 |
_ok_ := ((((pos1 := inputStream position)
 and: [((self Identifier :inputStream)
 and: [n := result. 1])
 and: [(self COLON :inputStream)
 and: [((self Identifier :inputStream)
 and: [b := result. 1])
 and: [(self OPEN :inputStream)
 and: [(((pos2 := TokenGroup new)
 and: [[(self Identifier :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [v := result. 1])
 and: [(self CLOSE :inputStream)
 and: [((result := TokenGroup new) add: #declaration; add: n; add: b; add: v)]]]]]]])
 or: [(inputStream position: pos1)])
 or: [((result := TokenGroup new))]).
^_ok_
]
GrammarParser Definition :inputStream
[
| i p e _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [(((pos2 := TokenGroup new)
 and: [[(self Parameter :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [p := result. 1])
 and: [(self EQUAL :inputStream)
 and: [((self Expression :inputStream)
 and: [e := result. 1])
 and: [(((self SEMICOLON :inputStream)) ifTrue: [result := TokenGroup with: result] ifFalse: [result := TokenGroup new])
 and: [((result := TokenGroup new) add: #definition; add: i; add: p; add: e)]]]]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Parameter :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 58) ifTrue: [result := inputStream next. 1])
 and: [(self Identifier :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Expression :inputStream
[
| h t _ok_ pos1 pos2 pos3 |
_ok_ := (((pos1 := inputStream position)
 and: [((self Sequence :inputStream)
 and: [h := result. 1])
 and: [(((pos2 := TokenGroup new)
 and: [[(((pos3 := inputStream position)
 and: [(self BAR :inputStream)
 and: [(self Sequence :inputStream)]])
 or: [(inputStream position: pos3)])] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [t := result. 1])
 and: [((result := TokenGroup new) add: #alternatives; add: h; concat: t)]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Sequence :inputStream
[
| p _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [(((pos2 := TokenGroup new)
 and: [[(self Prefix :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [p := result. 1])
 and: [((result := TokenGroup new) add: #sequence; concat: p)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Prefix :inputStream
[
| p a i _ok_ pos1 |
_ok_ := ((((pos1 := inputStream position)
 and: [(self AND :inputStream)
 and: [((self Predicate :inputStream)
 and: [p := result. 1])
 and: [((result := p) or: [1])]]])
 or: [(inputStream position: pos1)])
 or: [(((pos1 := inputStream position)
 and: [(self AND :inputStream)
 and: [((self Assignment :inputStream)
 and: [a := result. 1])
 and: [((result := TokenGroup new) add: #and; add: a)]]])
 or: [(inputStream position: pos1)])
 or: [(((pos1 := inputStream position)
 and: [(self NOT :inputStream)
 and: [((self Assignment :inputStream)
 and: [a := result. 1])
 and: [((result := TokenGroup new) add: #not; add: a)]]])
 or: [(inputStream position: pos1)])
 or: [(self Assignment :inputStream)
 or: [(((pos1 := inputStream position)
 and: [((self Store :inputStream)
 and: [i := result. 1])
 and: [((result := TokenGroup new) add: #store; add: i; add: (TokenGroup new add: #dot))]])
 or: [(inputStream position: pos1)])]]]]).
^_ok_
]
GrammarParser Predicate :inputStream
[
| b _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((self Block :inputStream)
 and: [b := result. 1])
 and: [((result := TokenGroup new) add: #predicate; add: b)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Assignment :inputStream
[
| s i _ok_ pos1 pos2 pos3 |
_ok_ := (((pos1 := inputStream position)
 and: [((self Storable :inputStream)
 and: [s := result. 1])
 and: [((pos2 := TokenGroup new)
 and: [[(((pos3 := inputStream position)
 and: [((self Store :inputStream)
 and: [i := result. 1])
 and: [(((result := TokenGroup new) add: #store; add: i; add: s)
 and: [s := result. 1])]])
 or: [(inputStream position: pos3)])] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [((result := s) or: [1])]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Storable :inputStream
[
| s _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [((self Suffix :inputStream)
 and: [s := result. 1])
 and: [(((((pos2 := inputStream position)
 and: [(self DOLLAR :inputStream)
 and: [(((result := TokenGroup new) add: #text; add: s)
 and: [s := result. 1])]])
 or: [(inputStream position: pos2)])) ifTrue: [result := TokenGroup with: result] ifFalse: [result := TokenGroup new])
 and: [((result := s) or: [1])]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Store :inputStream
[
| _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [(self COLON :inputStream)
 and: [(self Identifier :inputStream)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Suffix :inputStream
[
| p _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [((self Primary :inputStream)
 and: [p := result. 1])
 and: [((((((pos2 := inputStream position)
 and: [(self QUESTION :inputStream)
 and: [(((result := TokenGroup new) add: #zeroOne; add: p)
 and: [p := result. 1])]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [(self STAR :inputStream)
 and: [(((result := TokenGroup new) add: #zeroMany; add: p)
 and: [p := result. 1])]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [(self PLUS :inputStream)
 and: [(((result := TokenGroup new) add: #oneMany; add: p)
 and: [p := result. 1])]])
 or: [(inputStream position: pos2)])]])) ifTrue: [result := TokenGroup with: result] ifFalse: [result := TokenGroup new])
 and: [((result := p) or: [1])]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Primary :inputStream
[
| e _ok_ pos1 |
_ok_ := ((self Invocation :inputStream)
 or: [(((pos1 := inputStream position)
 and: [(self OPEN :inputStream)
 and: [((self Expression :inputStream)
 and: [e := result. 1])
 and: [(self CLOSE :inputStream)
 and: [((result := e) or: [1])]]]])
 or: [(inputStream position: pos1)])
 or: [(self Literal :inputStream)
 or: [(self Class :inputStream)
 or: [(self Structure :inputStream)
 or: [(self Symbol :inputStream)
 or: [(((pos1 := inputStream position)
 and: [(self DOT :inputStream)
 and: [((result := TokenGroup new) add: #dot)]])
 or: [(inputStream position: pos1)])
 or: [(self Action :inputStream)
 or: [(self Answer :inputStream)]]]]]]]]).
^_ok_
]
GrammarParser Action :inputStream
[
| b _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((self Block :inputStream)
 and: [b := result. 1])
 and: [((result := TokenGroup new) add: #action; add: b)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Answer :inputStream
[
| _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [(self RIGHTARROW :inputStream)
 and: [((self Variable :inputStream)
 or: [(self Value :inputStream)
 or: [(self Rewrite :inputStream)
 or: [(self LiteralChar :inputStream)]]])]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Variable :inputStream
[
| i _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [((result := TokenGroup new) add: #variable; add: i)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Value :inputStream
[
| b _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((self Block :inputStream)
 and: [b := result. 1])
 and: [((result := TokenGroup new) add: #value; add: b)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Block :inputStream
[
| b _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 123) ifTrue: [result := inputStream next. 1])
 and: [((((pos2 := inputStream position)
 and: [(self BlockBody :inputStream)]) ifTrue: [result := (pos2 text: inputStream position)])
 and: [b := result. 1])
 and: [((inputStream peek == 125) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)
 and: [((result := b) or: [1])]]]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser BlockBody :inputStream
[
| _ok_ pos1 pos2 pos3 pos4 |
_ok_ := ((pos1 := TokenGroup new)
 and: [[(((pos2 := inputStream position)
 and: [(((pos3 := inputStream position)
 and: [((inputStream peek == 125) ifTrue: [result := inputStream next. 1])]) ifTrue: [(inputStream position: pos3)] ifFalse: [1])
 and: [((((pos3 := inputStream position)
 and: [((inputStream peek == 123) ifTrue: [result := inputStream next. 1])
 and: [(self BlockBody :inputStream)
 and: [((inputStream peek == 125) ifTrue: [result := inputStream next. 1])]]])
 or: [(inputStream position: pos3)])
 or: [(inputStream notAtEnd and: [result := inputStream next. 1])])]])
 or: [(inputStream position: pos2)])] whileTrue: [(pos1 add: result)]. (result := pos1)]).
^_ok_
]
GrammarParser Rewrite :inputStream
[
| e _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [(self BACKQUOTE :inputStream)
 and: [((self Group :inputStream)
 or: [(self Format :inputStream)
 or: [(((pos2 := inputStream position)
 and: [((self Element :inputStream)
 and: [e := result. 1])
 and: [((result := TokenGroup new) add: #unigroup; add: e)]])
 or: [(inputStream position: pos2)])]])]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Group :inputStream
[
| e _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [(self OPEN :inputStream)
 and: [(((pos2 := TokenGroup new)
 and: [[(self Element :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [e := result. 1])
 and: [(self CLOSE :inputStream)
 and: [((result := TokenGroup new) add: #group; concat: e)]]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Element :inputStream
[
| i _ok_ pos1 |
_ok_ := ((((pos1 := inputStream position)
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [((result := TokenGroup new) add: #symbol; add: i)]])
 or: [(inputStream position: pos1)])
 or: [(self Unquote :inputStream)
 or: [(self Subgroup :inputStream)]]).
^_ok_
]
GrammarParser Unquote :inputStream
[
| i _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [(self COMMA :inputStream)
 and: [((((pos2 := inputStream position)
 and: [(self AT :inputStream)
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [((result := TokenGroup new) add: #unquoteSplicing; add: i)]]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [(self DOLLAR :inputStream)
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [((result := TokenGroup new) add: #unquoteString; add: i)]]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((inputStream peek == 35) ifTrue: [result := inputStream next. 1])
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [((result := TokenGroup new) add: #unquoteSymbol; add: i)]]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((inputStream peek == 61) ifTrue: [result := inputStream next. 1])
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [((result := TokenGroup new) add: #unquoteNumber; add: i)]]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [((result := TokenGroup new) add: #unquote; add: i)]])
 or: [(inputStream position: pos2)])]]]])]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Subgroup :inputStream
[
| e _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [(self OPEN :inputStream)
 and: [(((pos2 := TokenGroup new)
 and: [[(self Element :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [e := result. 1])
 and: [(self CLOSE :inputStream)
 and: [((result := TokenGroup new) add: #subgroup; concat: e)]]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Format :inputStream
[
| s _ok_ pos1 pos2 pos3 pos4 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 39) ifTrue: [result := inputStream next. 1])
 and: [(((pos2 := TokenGroup new)
 and: [[(((pos3 := inputStream position)
 and: [(((pos4 := inputStream position)
 and: [((inputStream peek == 39) ifTrue: [result := inputStream next. 1])]) ifTrue: [(inputStream position: pos4)] ifFalse: [1])
 and: [(self FormatChar :inputStream)]])
 or: [(inputStream position: pos3)])] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [s := result. 1])
 and: [((inputStream peek == 39) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)
 and: [((result := TokenGroup new) add: #format; concat: s)]]]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser FormatChar :inputStream
[
| i c _ok_ pos1 |
_ok_ := ((((pos1 := inputStream position)
 and: [(self BACKSLASH :inputStream)
 and: [(self OPEN :inputStream)
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [(self CLOSE :inputStream)
 and: [((result := TokenGroup new) add: #formatVariable; add: i)]]]]])
 or: [(inputStream position: pos1)])
 or: [(((pos1 := inputStream position)
 and: [(self BACKSLASH :inputStream)
 and: [(self DOLLAR :inputStream)
 and: [(self OPEN :inputStream)
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [(self CLOSE :inputStream)
 and: [((result := TokenGroup new) add: #formatString; add: i)]]]]]])
 or: [(inputStream position: pos1)])
 or: [(((pos1 := inputStream position)
 and: [((self Char :inputStream)
 and: [c := result. 1])
 and: [((result := TokenGroup new) add: #formatChar; add: c)]])
 or: [(inputStream position: pos1)])]]).
^_ok_
]
GrammarParser LiteralChar :inputStream
[
| c _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [(self BACKSLASH :inputStream)
 and: [((self Character :inputStream)
 and: [c := result. 1])
 and: [(self Spacing :inputStream)
 and: [((result := TokenGroup new) add: #character; add: c)]]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Invocation :inputStream
[
| i _ok_ pos1 pos2 |
_ok_ := ((((pos1 := inputStream position)
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [(((pos2 := inputStream position)
 and: [(self EQUAL :inputStream)]) ifTrue: [(inputStream position: pos2)] ifFalse: [1])
 and: [((result := TokenGroup new) add: #invoke; add: i)]]])
 or: [(inputStream position: pos1)])
 or: [(self Application :inputStream)]).
^_ok_
]
GrammarParser Application :inputStream
[
| i a _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [(self LANGLE :inputStream)
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [(((pos2 := TokenGroup new)
 and: [[(self Argument :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [a := result. 1])
 and: [(self RANGLE :inputStream)
 and: [((result := TokenGroup new) add: #invoke; add: i; concat: a)]]]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Argument :inputStream
[
| a x s _ok_ pos1 |
_ok_ := ((((pos1 := inputStream position)
 and: [((self Application :inputStream)
 and: [a := result. 1])
 and: [((result := TokenGroup new) add: #result; add: a)]])
 or: [(inputStream position: pos1)])
 or: [(((pos1 := inputStream position)
 and: [((self Identifier :inputStream)
 and: [x := result. 1])
 and: [((result := TokenGroup new) add: #argvar; add: x)]])
 or: [(inputStream position: pos1)])
 or: [(((pos1 := inputStream position)
 and: [((inputStream peek == 35) ifTrue: [result := inputStream next. 1])
 and: [((self Identifier :inputStream)
 and: [x := result. 1])
 and: [((result := TokenGroup new) add: #argsym; add: x)]]])
 or: [(inputStream position: pos1)])
 or: [(((pos1 := inputStream position)
 and: [((self SingleString :inputStream)
 and: [s := result. 1])
 and: [((result := TokenGroup new) add: #arglit; add: s)]])
 or: [(inputStream position: pos1)])]]]).
^_ok_
]
GrammarParser Literal :inputStream
[
| s _ok_ pos1 pos2 |
_ok_ := (((pos1 := inputStream position)
 and: [(((self SingleString :inputStream)
 or: [(self DoubleString :inputStream)])
 and: [s := result. 1])
 and: [((result := TokenGroup new) add: #string; add: s)]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Class :inputStream
[
| c _ok_ pos1 pos2 pos3 pos4 pos5 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 91) ifTrue: [result := inputStream next. 1])
 and: [((((pos2 := inputStream position)
 and: [((pos3 := TokenGroup new)
 and: [[(((pos4 := inputStream position)
 and: [(((pos5 := inputStream position)
 and: [((inputStream peek == 93) ifTrue: [result := inputStream next. 1])]) ifTrue: [(inputStream position: pos5)] ifFalse: [1])
 and: [(self Range :inputStream)]])
 or: [(inputStream position: pos4)])] whileTrue: [(pos3 add: result)]. (result := pos3)])]) ifTrue: [result := (pos2 text: inputStream position)])
 and: [c := result. 1])
 and: [((inputStream peek == 93) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)
 and: [((result := TokenGroup new) add: #class; add: (c asString))]]]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Range :inputStream
[
| _ok_ pos1 pos2 |
_ok_ := ((((pos1 := inputStream position)
 and: [(self Character :inputStream)
 and: [((inputStream peek == 45) ifTrue: [result := inputStream next. 1])
 and: [(self Character :inputStream)]]])
 or: [(inputStream position: pos1)])
 or: [(self Character :inputStream)]).
^_ok_
]
GrammarParser Structure :inputStream
[
| e _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 35) ifTrue: [result := inputStream next. 1])
 and: [(self OPEN :inputStream)
 and: [((self Expression :inputStream)
 and: [e := result. 1])
 and: [(self CLOSE :inputStream)
 and: [((result := TokenGroup new) add: #structure; add: e)]]]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
GrammarParser Symbol :inputStream
[
| i _ok_ pos1 |
_ok_ := (((pos1 := inputStream position)
 and: [((inputStream peek == 35) ifTrue: [result := inputStream next. 1])
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [((result := TokenGroup new) add: #literal; add: i)]]])
 or: [(inputStream position: pos1)]).
^_ok_
]
