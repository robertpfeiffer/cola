{ import: st80 }
{ import: Squeak }
{ import: LargeInteger }

[
    | args image |
    (args := Smalltalk arguments) size == 1 ifFalse: [Smalltalk error: 'image name not specified'].
    Squeak interpret: args first.
]
