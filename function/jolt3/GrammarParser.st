"THIS FILE WAS GENERATED AUTOMATICALLY -- DO NOT EDIT!"

{ import: Parser }
GrammarParser : Parser ()
GrammarParser start :inputStream
[
| pos1 |
^(self Grammar :inputStream)
]
GrammarParser Grammar :inputStream
[
| d g pos1 pos2 |
^(((pos1 := inputStream position)
 and: [(self Spacing :inputStream)
 and: [((self Declaration :inputStream)
 and: [d := result. 1])
 and: [(((pos2 := TokenGroup new)
 and: [(((self Definition :inputStream)) ifTrue: [(pos2 add: result). 1])
 and: [[(self Definition :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2). 1]])
 and: [g := result. 1])
 and: [(self EndOfFile :inputStream)
 and: [((result := TokenGroup new) add: #grammar; add: d; concat: g)]]]]])
 or: [(inputStream position: pos1)])
]
GrammarParser Declaration :inputStream
[
| n b v pos1 pos2 |
^((((pos1 := inputStream position)
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
 or: [((result := TokenGroup new))])
]
GrammarParser Definition :inputStream
[
| i p e pos1 pos2 |
^(((pos1 := inputStream position)
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
 or: [(inputStream position: pos1)])
]
GrammarParser Parameter :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 58) ifTrue: [result := inputStream next. 1])
 and: [(self Identifier :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser Expression :inputStream
[
| h t pos1 pos2 pos3 |
^(((pos1 := inputStream position)
 and: [((self Sequence :inputStream)
 and: [h := result. 1])
 and: [(((pos2 := TokenGroup new)
 and: [[(((pos3 := inputStream position)
 and: [(self SLASH :inputStream)
 and: [(self Sequence :inputStream)]])
 or: [(inputStream position: pos3)])] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [t := result. 1])
 and: [((result := TokenGroup new) add: #alternatives; add: h; concat: t)]]])
 or: [(inputStream position: pos1)])
]
GrammarParser Sequence :inputStream
[
| p pos1 pos2 |
^(((pos1 := inputStream position)
 and: [(((pos2 := TokenGroup new)
 and: [[(self Prefix :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [p := result. 1])
 and: [((result := TokenGroup new) add: #sequence; concat: p)]])
 or: [(inputStream position: pos1)])
]
GrammarParser Prefix :inputStream
[
| p a i pos1 |
^((((pos1 := inputStream position)
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
 or: [(inputStream position: pos1)])]]]])
]
GrammarParser Predicate :inputStream
[
| b pos1 |
^(((pos1 := inputStream position)
 and: [((self Block :inputStream)
 and: [b := result. 1])
 and: [((result := TokenGroup new) add: #predicate; add: b)]])
 or: [(inputStream position: pos1)])
]
GrammarParser Assignment :inputStream
[
| s i pos1 pos2 pos3 |
^(((pos1 := inputStream position)
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
 or: [(inputStream position: pos1)])
]
GrammarParser Storable :inputStream
[
| s pos1 pos2 |
^(((pos1 := inputStream position)
 and: [((self Suffix :inputStream)
 and: [s := result. 1])
 and: [(((((pos2 := inputStream position)
 and: [(self DOLLAR :inputStream)
 and: [(((result := TokenGroup new) add: #text; add: s)
 and: [s := result. 1])]])
 or: [(inputStream position: pos2)])) ifTrue: [result := TokenGroup with: result] ifFalse: [result := TokenGroup new])
 and: [((result := s) or: [1])]]])
 or: [(inputStream position: pos1)])
]
GrammarParser Store :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [(self COLON :inputStream)
 and: [(self Identifier :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser Suffix :inputStream
[
| p pos1 pos2 |
^(((pos1 := inputStream position)
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
 or: [(inputStream position: pos1)])
]
GrammarParser Primary :inputStream
[
| e pos1 |
^((self Invocation :inputStream)
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
 or: [(self Answer :inputStream)]]]]]]]])
]
GrammarParser Action :inputStream
[
| b pos1 |
^(((pos1 := inputStream position)
 and: [((self Block :inputStream)
 and: [b := result. 1])
 and: [((result := TokenGroup new) add: #action; add: b)]])
 or: [(inputStream position: pos1)])
]
GrammarParser Answer :inputStream
[
| pos1 pos2 |
^(((pos1 := inputStream position)
 and: [(self RIGHTARROW :inputStream)
 and: [((self Variable :inputStream)
 or: [(self Value :inputStream)
 or: [(self Rewrite :inputStream)
 or: [(self Character :inputStream)]]])]])
 or: [(inputStream position: pos1)])
]
GrammarParser Variable :inputStream
[
| i pos1 |
^(((pos1 := inputStream position)
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [((result := TokenGroup new) add: #variable; add: i)]])
 or: [(inputStream position: pos1)])
]
GrammarParser Value :inputStream
[
| b pos1 |
^(((pos1 := inputStream position)
 and: [((self Block :inputStream)
 and: [b := result. 1])
 and: [((result := TokenGroup new) add: #value; add: b)]])
 or: [(inputStream position: pos1)])
]
GrammarParser Block :inputStream
[
| b pos1 pos2 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 123) ifTrue: [result := inputStream next. 1])
 and: [((((pos2 := inputStream position)
 and: [(self BlockBody :inputStream)]) ifTrue: [result := (pos2 text: inputStream position)])
 and: [b := result. 1])
 and: [((inputStream peek == 125) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)
 and: [((result := b) or: [1])]]]]])
 or: [(inputStream position: pos1)])
]
GrammarParser BlockBody :inputStream
[
| pos1 pos2 pos3 pos4 |
^((pos1 := TokenGroup new)
 and: [[(((pos2 := inputStream position)
 and: [(((pos3 := inputStream position)
 and: [((inputStream peek == 125) ifTrue: [result := inputStream next. 1])]) ifTrue: [(inputStream position: pos3)] ifFalse: [1])
 and: [((((pos3 := inputStream position)
 and: [((inputStream peek == 123) ifTrue: [result := inputStream next. 1])
 and: [(self BlockBody :inputStream)
 and: [((inputStream peek == 125) ifTrue: [result := inputStream next. 1])]]])
 or: [(inputStream position: pos3)])
 or: [(inputStream notAtEnd and: [result := inputStream next. 1])])]])
 or: [(inputStream position: pos2)])] whileTrue: [(pos1 add: result)]. (result := pos1)])
]
GrammarParser Rewrite :inputStream
[
| e pos1 pos2 |
^(((pos1 := inputStream position)
 and: [(self BACKQUOTE :inputStream)
 and: [((self Group :inputStream)
 or: [(((pos2 := inputStream position)
 and: [((self Element :inputStream)
 and: [e := result. 1])
 and: [((result := TokenGroup new) add: #unigroup; add: e)]])
 or: [(inputStream position: pos2)])])]])
 or: [(inputStream position: pos1)])
]
GrammarParser Group :inputStream
[
| e pos1 pos2 |
^(((pos1 := inputStream position)
 and: [(self OPEN :inputStream)
 and: [(((pos2 := TokenGroup new)
 and: [[(self Element :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [e := result. 1])
 and: [(self CLOSE :inputStream)
 and: [((result := TokenGroup new) add: #group; concat: e)]]]])
 or: [(inputStream position: pos1)])
]
GrammarParser Element :inputStream
[
| i pos1 |
^((((pos1 := inputStream position)
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [((result := TokenGroup new) add: #symbol; add: i)]])
 or: [(inputStream position: pos1)])
 or: [(self Unquote :inputStream)
 or: [(self Subgroup :inputStream)]])
]
GrammarParser Unquote :inputStream
[
| i pos1 pos2 |
^(((pos1 := inputStream position)
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
 or: [(inputStream position: pos1)])
]
GrammarParser Subgroup :inputStream
[
| e pos1 pos2 |
^(((pos1 := inputStream position)
 and: [(self OPEN :inputStream)
 and: [(((pos2 := TokenGroup new)
 and: [[(self Element :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [e := result. 1])
 and: [(self CLOSE :inputStream)
 and: [((result := TokenGroup new) add: #subgroup; concat: e)]]]])
 or: [(inputStream position: pos1)])
]
GrammarParser Character :inputStream
[
| c pos1 |
^(((pos1 := inputStream position)
 and: [(self BACKSLASH :inputStream)
 and: [((self Char :inputStream)
 and: [c := result. 1])
 and: [(self Spacing :inputStream)
 and: [((result := TokenGroup new) add: #character; add: c)]]]])
 or: [(inputStream position: pos1)])
]
GrammarParser Invocation :inputStream
[
| i pos1 pos2 |
^((((pos1 := inputStream position)
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [(((pos2 := inputStream position)
 and: [(self EQUAL :inputStream)]) ifTrue: [(inputStream position: pos2)] ifFalse: [1])
 and: [((result := TokenGroup new) add: #invoke; add: i)]]])
 or: [(inputStream position: pos1)])
 or: [(self Application :inputStream)])
]
GrammarParser Application :inputStream
[
| i a pos1 pos2 |
^(((pos1 := inputStream position)
 and: [(self LANGLE :inputStream)
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [(((pos2 := TokenGroup new)
 and: [[(self Argument :inputStream)] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [a := result. 1])
 and: [(self RANGLE :inputStream)
 and: [((result := TokenGroup new) add: #invoke; add: i; concat: a)]]]]])
 or: [(inputStream position: pos1)])
]
GrammarParser Argument :inputStream
[
| a x s pos1 pos2 pos3 pos4 |
^((((pos1 := inputStream position)
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
 and: [((result := TokenGroup new) add: #arglit; add: x)]]])
 or: [(inputStream position: pos1)])
 or: [(((pos1 := inputStream position)
 and: [((inputStream peek == 39) ifTrue: [result := inputStream next. 1])
 and: [(((pos2 := TokenGroup new)
 and: [[(((pos3 := inputStream position)
 and: [(((pos4 := inputStream position)
 and: [((inputStream peek == 39) ifTrue: [result := inputStream next. 1])]) ifTrue: [(inputStream position: pos4)] ifFalse: [1])
 and: [(self Char :inputStream)]])
 or: [(inputStream position: pos3)])] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [s := result. 1])
 and: [((inputStream peek == 39) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)
 and: [((result := TokenGroup new) add: #arglit; add: (s asString))]]]]])
 or: [(inputStream position: pos1)])]]])
]
GrammarParser Identifier :inputStream
[
| i pos1 pos2 pos3 pos4 |
^(((pos1 := inputStream position)
 and: [((((pos2 := inputStream position)
 and: [(((pos3 := inputStream position)
 and: [(self IdentStart :inputStream)
 and: [((pos4 := TokenGroup new)
 and: [[(self IdentCont :inputStream)] whileTrue: [(pos4 add: result)]. (result := pos4)])]])
 or: [(inputStream position: pos3)])]) ifTrue: [result := (pos2 text: inputStream position)])
 and: [i := result. 1])
 and: [(self Spacing :inputStream)
 and: [(result := ((TokenGroup new) add: (i asSymbol)) first)]]])
 or: [(inputStream position: pos1)])
]
GrammarParser IdentStart :inputStream
[
| pos1 |
^(self class: #[0 0 0 0 0 0 0 0 254 255 255 135 254 255 255 7 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] :inputStream)
]
GrammarParser IdentCont :inputStream
[
| pos1 |
^((self IdentStart :inputStream)
 or: [(self class: #[0 0 0 0 0 0 255 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] :inputStream)])
]
GrammarParser Literal :inputStream
[
| s pos1 pos2 pos3 pos4 pos5 |
^(((pos1 := inputStream position)
 and: [((((pos2 := inputStream position)
 and: [((inputStream peek == 39) ifTrue: [result := inputStream next. 1])
 and: [(((pos3 := TokenGroup new)
 and: [[(((pos4 := inputStream position)
 and: [(((pos5 := inputStream position)
 and: [((inputStream peek == 39) ifTrue: [result := inputStream next. 1])]) ifTrue: [(inputStream position: pos5)] ifFalse: [1])
 and: [(self Char :inputStream)]])
 or: [(inputStream position: pos4)])] whileTrue: [(pos3 add: result)]. (result := pos3)])
 and: [s := result. 1])
 and: [((inputStream peek == 39) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]]]])
 or: [(inputStream position: pos2)])
 or: [(((pos2 := inputStream position)
 and: [((inputStream peek == 34) ifTrue: [result := inputStream next. 1])
 and: [(((pos3 := TokenGroup new)
 and: [[(((pos4 := inputStream position)
 and: [(((pos5 := inputStream position)
 and: [((inputStream peek == 34) ifTrue: [result := inputStream next. 1])]) ifTrue: [(inputStream position: pos5)] ifFalse: [1])
 and: [(self Char :inputStream)]])
 or: [(inputStream position: pos4)])] whileTrue: [(pos3 add: result)]. (result := pos3)])
 and: [s := result. 1])
 and: [((inputStream peek == 34) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]]]])
 or: [(inputStream position: pos2)])])
 and: [((result := TokenGroup new) add: #string; add: (s asString))]])
 or: [(inputStream position: pos1)])
]
GrammarParser Class :inputStream
[
| c pos1 pos2 pos3 pos4 pos5 |
^(((pos1 := inputStream position)
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
 or: [(inputStream position: pos1)])
]
GrammarParser Range :inputStream
[
| pos1 pos2 pos3 |
^(((pos1 := inputStream position)
 and: [((((pos2 := inputStream position)
 and: [(self Char :inputStream)
 and: [((inputStream peek == 45) ifTrue: [result := inputStream next. 1])
 and: [(self Char :inputStream)]]])
 or: [(inputStream position: pos2)])
 or: [(self Char :inputStream)])]) ifTrue: [result := (pos1 text: inputStream position)])
]
GrammarParser Char :inputStream
[
| s pos1 pos2 pos3 pos4 |
^((((pos1 := inputStream position)
 and: [((inputStream peek == 92) ifTrue: [result := inputStream next. 1])
 and: [((((pos2 := inputStream position)
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
 or: [((inputStream pushGroup: (TokenGroup new add: 'unknown escape')) ifTrue: [(self error :inputStream)])]]]]]]]]])]])
 or: [(inputStream position: pos1)])
 or: [(inputStream notAtEnd and: [result := inputStream next. 1])])
]
GrammarParser Structure :inputStream
[
| e pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 35) ifTrue: [result := inputStream next. 1])
 and: [(self OPEN :inputStream)
 and: [((self Expression :inputStream)
 and: [e := result. 1])
 and: [(self CLOSE :inputStream)
 and: [((result := TokenGroup new) add: #structure; add: e)]]]]])
 or: [(inputStream position: pos1)])
]
GrammarParser Symbol :inputStream
[
| i pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 35) ifTrue: [result := inputStream next. 1])
 and: [((self Identifier :inputStream)
 and: [i := result. 1])
 and: [((result := TokenGroup new) add: #literal; add: i)]]])
 or: [(inputStream position: pos1)])
]
GrammarParser EQUAL :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 61) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser RIGHTARROW :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [(self string: '->' :inputStream)
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser SLASH :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 124) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser AND :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 38) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser NOT :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 33) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser QUESTION :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 63) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser STAR :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 42) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser PLUS :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 43) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser OPEN :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 40) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser CLOSE :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 41) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser LANGLE :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 60) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser RANGLE :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 62) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser DOT :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 46) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser SEMICOLON :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 59) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser COLON :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 58) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser DOLLAR :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 36) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser BACKQUOTE :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 96) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser COMMA :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 44) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser AT :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 64) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser BACKSLASH :inputStream
[
| pos1 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 92) ifTrue: [result := inputStream next. 1])
 and: [(self Spacing :inputStream)]])
 or: [(inputStream position: pos1)])
]
GrammarParser Spacing :inputStream
[
| pos1 pos2 pos3 |
^((pos1 := TokenGroup new)
 and: [[((self Space :inputStream)
 or: [(self Comment :inputStream)])] whileTrue: [(pos1 add: result)]. (result := pos1)])
]
GrammarParser Comment :inputStream
[
| pos1 pos2 pos3 pos4 |
^(((pos1 := inputStream position)
 and: [((inputStream peek == 37) ifTrue: [result := inputStream next. 1])
 and: [((pos2 := TokenGroup new)
 and: [[(((pos3 := inputStream position)
 and: [(((pos4 := inputStream position)
 and: [(self EndOfLine :inputStream)]) ifTrue: [(inputStream position: pos4)] ifFalse: [1])
 and: [(inputStream notAtEnd and: [result := inputStream next. 1])]])
 or: [(inputStream position: pos3)])] whileTrue: [(pos2 add: result)]. (result := pos2)])
 and: [(self EndOfLine :inputStream)]]])
 or: [(inputStream position: pos1)])
]
GrammarParser Space :inputStream
[
| pos1 |
^(((inputStream peek == 32) ifTrue: [result := inputStream next. 1])
 or: [((inputStream peek == 9) ifTrue: [result := inputStream next. 1])
 or: [(self EndOfLine :inputStream)]])
]
GrammarParser EndOfLine :inputStream
[
| pos1 |
^((self string: '\015\012' :inputStream)
 or: [((inputStream peek == 10) ifTrue: [result := inputStream next. 1])
 or: [((inputStream peek == 13) ifTrue: [result := inputStream next. 1])]])
]
GrammarParser EndOfFile :inputStream
[
| pos1 pos2 |
^(((pos1 := inputStream position)
 and: [(inputStream notAtEnd and: [result := inputStream next. 1])]) ifTrue: [(inputStream position: pos1)] ifFalse: [1])
]
