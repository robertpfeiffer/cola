{ import: Object }

"Object gives us full implementations of the intrinsic and literal
 types: object nil true false integer character vector string
 byteArray objectArray staticClosure fullClosure."

[
    "object nil true false staticClosure -- if we got past loading Object then they're working"

    "integer string character"

    42 print.
    $\n put.
    'Hello, world' putln.
    ((Character digitValue: 0) == $0) assert.
    ($0 digitValue == 0) assert.

    "objectArray"

    #('hello' ',' 'world') println.
    #(('hello') (',') ('world')) println.

    "byteArray"

    #[ 1 2 3 4 ] println.
    #(#[ 1 2 ] (',') #[ 3 4 ]) println.

    "wordArray"

    #{ 4 5 6 } println.
    #(#[ 1 2 ] (',') #{ 3 4 }) println.

    "vector fullClosure"

    'Closure ' put.

  [ | b |
    b := [:x | [x := x + 1]] value: 0.
    4 timesRepeat: [b value print.  $  put] ] value.

    'ok' putln.
]

[
    | a |

    'Object ' put.

    ((true  ifTrue:  [1]             ) == 1  ) assert.
    ((false ifTrue:  [1]             ) == nil) assert.
    ((true  ifFalse: [1]	     ) == nil) assert.
    ((false ifFalse: [1]	     ) == 1  ) assert.
    ((true  ifTrue:  [1] ifFalse: [2]) == 1  ) assert.
    ((false ifTrue:  [1] ifFalse: [2]) == 2  ) assert.
    ((true  ifFalse: [1] ifTrue:  [2]) == 2  ) assert.
    ((false ifFalse: [1] ifTrue:  [2]) == 1  ) assert.

    '1 ' put.

    ((true  eqv: true )    ) assert.
    ((true  eqv: false) not) assert.
    ((false eqv: true ) not) assert.
    ((false eqv: false)    ) assert.

    '2 ' put.

    [| x | x := 1.  true  and: [x := 2].  x == 2] value assert.
    [| x | x := 1.  false and: [x := 2].  x == 1] value assert.
    [| x | x := 1.  true  or:  [x := 2].  x == 1] value assert.
    [| x | x := 1.  false or:  [x := 2].  x == 2] value assert.

    '3 ' put.

    ((Object isMemberOf: Object      )    ) assert.
    ((42     isMemberOf: SmallInteger)    ) assert.
    ((42     isMemberOf: Integer     ) not) assert.

    '4 ' put.

    ((Object  isKindOf: Object      )    ) assert.
    ((42      isKindOf: SmallInteger)    ) assert.
    ((42      isKindOf: Integer     )    ) assert.
    ((Number  isKindOf: Object	    )    ) assert.
    ((Object  isKindOf: Number	    ) not) assert.
    ((String  isKindOf: Object	    )    ) assert.
    ((Object  isKindOf: String	    ) not) assert.
    ((String  isKindOf: Number	    ) not) assert.
    ((Number  isKindOf: String	    ) not) assert.

    'ok' putln.

    'String ' put.

    ( 'hello' size   == 5    ) assert.
    (('hello' at: 1) == $h   ) assert.
    (('hello' at: 2) == $e   ) assert.
    (('hello' at: 5) == $o   ) assert.
    ( 'hello' == 'hello'     ) assert.
    (('hello' == 'helpo') not) assert.

    '1 ' put.

    (('hello' hash == 'hello' hash)    ) assert.
    '1 ' put.
    (('hello' hash == 'olleh' hash) not) assert.

    '2 ' put.

    (('hello' includes: $l)    ) assert.
    (('hello' includes: $i) not) assert.
    ( ''  isEmpty              ) assert.
    ( 'a' notEmpty             ) assert.

    '3 ' put.

    (('hello'             = 'HELLO'            ) not) assert.
    (('he11o' asUppercase = 'HE11O'            )    ) assert.
    (('he11o'             = 'HE11O' asLowercase)    ) assert.
    (('he11o' == 'he11o'            )    ) assert.
    (('he11o' == 'he11o' asLowercase) not) assert.
    (('he11o' hash == 'he11o' asLowercase hash)) assert.

    '4 ' put.

    ('a', 'b' = 'ab') assert.
    ('abcde', 'fghij' = 'abcdefghij') assert.
    ('ab', 'c', 'def' = 'abcdef') assert.

    'ok' putln.

    'Array ' put.

    ( #(1 '2' '3' 4 5) size   == 5 ) assert.
    ((#(1 '2' '3' 4 5) at: 1) == 1 ) assert.
    ((#(1 '2' '3' 4 5) at: 2) = '2') assert.
    ((#(1 '2' '3' 4 5) at: 5) =  5 ) assert.

    ((#(1 2 3) =   #(1 2 3)		    )    ) assert.
    ((#(1 2 3) =   #(3 2 1)		    ) not) assert.
    ((#(1 2 3) ~=  #(1 2 3)		    ) not) assert.
    ((#(1 2 3) ~=  #(3 2 1)		    )    ) assert.
    ((#(1 2 3) ==  #(1 2 3)		    )    ) assert.
    ((#(1 2 3) ==  #(3 2 1)		    ) not) assert.
    ((#(1 2 3) ~~  #(1 2 3)		    ) not) assert.
    ((#(1 2 3) ~~  #(3 2 1)		    )    ) assert.
    ((#(1 2 3) =  (#(1 2 3) collect: [:e|e]))    ) assert.
    ((#(1 2 3) == (#(1 2 3) collect: [:e|e])) not) assert.

    '1 ' put.

    ((#(1 2 3) hash == #(1 2 3)       hash)    ) assert.
    ((#(1 2 3) hash ~= #(3 2 1)       hash)    ) assert.
    ((#(1 2 3) hash == #('1' '2' '3') hash) not) assert.

    ((#(1 2 3) hash == (#(1 2 3) collect: [:e|e]) hash)) assert.

    '2 ' put.

    ((#(1 '2' '3' 4 5) includes:  1 )	 ) assert.
    ((#(1 '2' '3' 4 5) includes: '1') not) assert.
    ((#(1 '2' '3' 4 5) includes:  2 ) not) assert.
    ((#(1 '2' '3' 4 5) includes: '2')    ) assert.
    ((#(1 '2' '3' 4 5) includes:  3 ) not) assert.
    ((#(1 '2' '3' 4 5) includes: '3')	 ) assert.
    ((#(1 '2' '3' 4 5) includes:  4 )	 ) assert.
    ((#(1 '2' '3' 4 5) includes: '4') not) assert.
    ((#(1 '2' '3' 4 5) includes:  5 )	 ) assert.
    ((#(1 '2' '3' 4 5) includes: '5') not) assert.

    '3 ' put.

    (#()    isEmpty) assert.
    (#(()) notEmpty) assert.

    ((#(()) collect: [:e | e size]) = #(0)) assert.

    '4 ' put.

    ((#('h' 'E' 'l') collect: [:e | e asUppercase]) = #('H' 'E' 'L')) assert.

    (((#($h $E $l) collect: [:e | e asLowercase]) as: String) = 'hel') assert.

    'ok' putln.

    'ByteArray ' put.

    ( #[5 4 3 2 1] size   == 5) assert.
    ((#[5 4 3 2 1] at: 1) == 5) assert.
    ((#[5 4 3 2 1] at: 2) =  4) assert.

    ((#[1 2 3] =   #[1 2 3]		    )    ) assert.
    ((#[1 2 3] =   #[3 2 1]		    ) not) assert.
    ((#[1 2 3] ~=  #[1 2 3]		    ) not) assert.
    ((#[1 2 3] ~=  #[3 2 1]		    )    ) assert.
    ((#[1 2 3] ==  #[1 2 3]		    )    ) assert.
    ((#[1 2 3] ==  #[3 2 1]		    ) not) assert.
    ((#[1 2 3] ~~  #[1 2 3]		    ) not) assert.
    ((#[1 2 3] ~~  #[3 2 1]		    )    ) assert.
    ((#[1 2 3] =  (#[1 2 3] collect: [:e|e]))    ) assert.
    ((#[1 2 3] == (#[1 2 3] collect: [:e|e])) not) assert.

    '1 ' put.

    ((#[1 2 3] hash == #[1 2 3] hash)) assert.
    ((#[1 2 3] hash ~= #[3 2 1] hash)) assert.

    ((#[1 2 3] hash == (#[1 2 3] collect: [:e|e]) hash)) assert.

    '2 ' put.

    ((#[5 3 1] includes:  1)	) assert.
    ((#[5 3 1] includes:  2) not) assert.
    ((#[5 3 1] includes:  3)    ) assert.
    ((#[5 3 1] includes:  4) not) assert.
    ((#[5 3 1] includes:  5)	) assert.

    '3 ' put.

    (#[ ]  isEmpty) assert.
    (#[1] notEmpty) assert.

    '4 ' put.

    ((((#[66 0x4f 79 0x21] as: Array) collect: [:e | (Character value: e) asLowercase]) as: String) = 'boo!') assert.

    'ok' putln.

    'WordArray ' put.

    ( #{5 4 3 2 1} size   == 5) assert.
    ((#{5 4 3 2 1} at: 1) == 5) assert.
    ((#{5 4 3 2 1} at: 2) =  4) assert.

    ((#{1 2 3} =   #{1 2 3}		    )    ) assert.
    ((#{1 2 3} =   #{3 2 1}		    ) not) assert.
    ((#{1 2 3} ~=  #{1 2 3}		    ) not) assert.
    ((#{1 2 3} ~=  #{3 2 1}		    )    ) assert.
    ((#{1 2 3} ==  #{1 2 3}		    )    ) assert.
    ((#{1 2 3} ==  #{3 2 1}		    ) not) assert.
    ((#{1 2 3} ~~  #{1 2 3}		    ) not) assert.
    ((#{1 2 3} ~~  #{3 2 1}		    )    ) assert.
    ((#{1 2 3} =  (#{1 2 3} collect: [:e|e]))    ) assert.
    ((#{1 2 3} == (#{1 2 3} collect: [:e|e])) not) assert.

    '1 ' put.

    ((#{1 2 3} hash == #{1 2 3} hash)) assert.
    ((#{1 2 3} hash ~= #{3 2 1} hash)) assert.

    ((#{1 2 3} hash == (#{1 2 3} collect: [:e|e]) hash)) assert.

    '2 ' put.

    ((#{5 3 1} includes:  1)	) assert.
    ((#{5 3 1} includes:  2) not) assert.
    ((#{5 3 1} includes:  3)    ) assert.
    ((#{5 3 1} includes:  4) not) assert.
    ((#{5 3 1} includes:  5)	) assert.

    '3 ' put.

    (#{ }  isEmpty) assert.
    (#{1} notEmpty) assert.

    '4 ' put.

    ((((#{66 0x4f 79 0x21} as: Array) collect: [:e | (Character value: e) asLowercase]) as: String) = 'boo!') assert.

    'ok' putln.
]

{ import: OrderedCollection }

[
    | a c |

    'OrderedCollection ' put.

    a := #(1 '2' '3' 4 5).
    c := OrderedCollection new
	add:  1;
	add: '2';
	add: '3';
	add:  4;
	add:  5;
	yourself.

    '1 ' put.

    (c size == 5) assert.

    ((a as: OrderedCollection) size == 5) assert.
    ((a as: OrderedCollection) = c) assert.

    '2 ' put.

    ((c at: 1) == 1 ) assert.
    ((c at: 2) = '2') assert.
    ((c at: 5) =  5 ) assert.
    ((c collect: [:e | e]) isKindOf: OrderedCollection) assert.

    '3 ' put.

    (a hash == c hash) not assert.
    a do: [:e | (c includes: e) assert].
    c do: [:e | (a includes: e) assert].
    ((c as: Array) = a) assert.

    a := OrderedCollection new
	add:  5;
	add:  4;
	add: '3';
	add: '2';
	add:  1;
	yourself.

    (a hash == c hash) not assert.

    '4 ' put.

    (c includes:  1 )	  assert.
    (c includes: '1') not assert.
    (c includes:  2 ) not assert.
    (c includes: '2')     assert.
    (c includes:  3 ) not assert.
    (c includes: '3')	  assert.
    (c includes:  4 )	  assert.
    (c includes: '4') not assert.
    (c includes:  5 )	  assert.
    (c includes: '5') not assert.

    '5 ' put.

    (OrderedCollection new isEmpty) assert.
    (c notEmpty) assert.

    ((((OrderedCollection with: #()) collect: [:e | e size]) as: Array) = #(0)) assert.

    '6 ' put.

    c := 'hElLo' as: OrderedCollection.
    (((c collect: [:e | e asUppercase]) as: String) = 'HELLO') assert.
    (((c collect: [:e | e asLowercase]) as: String) = 'hello') assert.

    '7 ' put.

    (c includes: $h) assert.  (c removeFirst == $h) assert.  (c size == 4) assert.  (c includes: $h) not assert.
    (c includes: $o) assert.  (c removeLast  == $o) assert.  (c size == 3) assert.  (c includes: $o) not assert.
    (c includes: $E) assert.  (c removeFirst == $E) assert.  (c size == 2) assert.  (c includes: $E) not assert.
    (c includes: $L) assert.  (c removeLast  == $L) assert.  (c size == 1) assert.  (c includes: $L) not assert.
    (c includes: $l) assert.  (c removeFirst == $l) assert.  (c size == 0) assert.  (c includes: $l) not assert.

    '8 ' put.

    ((('Desperation is the raw material of drastic change.  Only those who can leave behind everything they have ever believed in can hope to escape.'
		inject: c into: [:p :e | p addFirst: e; yourself]) as: String)
	    = '.epacse ot epoh nac ni deveileb reve evah yeht gnihtyreve dniheb evael nac ohw esoht ylnO  .egnahc citsard fo lairetam war eht si noitarepseD')
	assert.
    ((('The minority is sometimes right; the majority always wrong.'
		inject: OrderedCollection new into: [:p :e | p addFirst: e; addLast: e; yourself]) as: String)
	    = '.gnorw syawla ytirojam eht ;thgir semitemos si ytironim ehTThe minority is sometimes right; the majority always wrong.')
	assert.

    'ok' putln.
]

{ import: Set }
{ import: IdentitySet }

[
    | x k |

    'Set ' put.

    x := Set new.

    '1 ' put.

    1 to: 10 do: [:i |
	(x includes: i) not assert.
	x add: i.
	(x size == i) assert.
	(x includes: i) assert].

    '2 ' put.

    2 to: 10 by: 2 do: [:i |
	(x includes: i) assert.
	x remove: i.
	(x includes: i) not assert.
	(x size == (10 - (i // 2))) assert].

    '3 ' put.

    1 to: 10 do: [:i | 1 to: i do: [:j | x add: j]].
    (x size == 10) assert.
    (x notEmpty) assert.

    '4 ' put.

    [x isEmpty]
	whileFalse:
	   [| y |
	    y := x anyOne.
	    (x includes: y) assert.
	    x remove: y.
	    (x includes: y) not assert].

    '5 ' put.

    k := 0.
    #('one' 'two' 'three' 'four' 'five' 'six' 'seven' 'eight' 'nine' 'ten') do: [:i |
	(x includes: i) not assert.
	x add: i.
	(x size == (k := k + 1)) assert.
	(x includes: i) assert].

    '6 ' put.

    #('two' 'four' 'six' 'eight' 'ten') do: [:i |
	(x includes: i) assert.
	x remove: i.
	(x includes: i) not assert.
	(x size == (k := k - 1)) assert].

    '7 ' put.

    1 to: 10 do: [:i | 1 to: i do: [:j | x add: (#('one' 'two' 'three' 'four' 'five' 'six' 'seven' 'eight' 'nine' 'ten') at: j)]].
    (x size == 10) assert.
    (x notEmpty) assert.

    [x isEmpty]
	whileFalse:
	   [| y |
	    y := x anyOne.
	    (x includes: y) assert.
	    x remove: y.
	    (x includes: y) not assert].

    '8 ' put.

    k := IdentitySet new.
    10 timesRepeat:
       [x add: 'hello' asUppercase.
	k add: 'hello' asUppercase].
    (x size = 1) assert.
    (k size = 10) assert.

    'ok' putln.
]

{ import: ReadStream }

[
    | s |

    'ReadStream ' put.

    s := 'Hello' readStream.

    '1 ' put.

    s atEnd not assert.  (s next == $H) assert.
    s atEnd not assert.  (s next == $e) assert.
    s atEnd not assert.  (s next == $l) assert.
    s atEnd not assert.  (s next == $l) assert.
    s atEnd not assert.  (s next == $o) assert.
    s atEnd assert.

    '2 ' put.

    s reset.
    s atEnd not assert.
    (s next == $H) assert.
    s position: 5.
    s atEnd assert.
    s position: 4.
    s atEnd not assert.
    (s next == $o) assert.
    s atEnd assert.

    '3 ' put.

    s skip: -4.
    s atEnd not assert.
    (s next == $e) assert.
    (s contents = 'Hello') assert.

    '4 ' put.

    s position: 1.
    ((s next: 3) = 'ell') assert.

    'ok' putln.
]

{ import: WriteStream }

[
    'WriteStream ' put.

    (((String new: 32) writeStream
	  nextPut: $x;
	  nextPutAll: 'yz';
	  contents) = 'xyz') assert.

    ((   #( 1
           'two'
           #[3  3  3      ]
           #{ 4  4 4  4}
           'five'
           ( 'six' 'seven' $8 $9 )
    ) printString
	= '#(1 ''two'' #[3 3 3] #{4 4 4 4} ''five'' #(''six'' ''seven'' $8 $9))')) assert.

    (12345 printString = '12345') assert.

    'ok' putln.
]

{ import: Association }

[
    | a b |

    'Association ' put.

    a := LookupKey withKey: 42.
    b := LookupKey withKey: 42.

    (a hash = a key hash) assert.
    (a hash = b hash) assert.
    (a = b) assert.

    a := Association withKey: 42 value: nil.
    b := Association withKey: 42 value: nil.

    (a hash = b hash) assert.
    (a = b) assert.
    b value: '42'.
    (a hash = b hash) not assert.
    (a = b) not assert.

    'ok' putln.
]

{ import: Dictionary }
{ import: IdentityDictionary }

[
    | d e |

    'Dictionary ' put.

    d := Dictionary new.
    (d isEmpty) assert.

    '1 ' put.
    d at: 'one' put: 1.
    (d size = 1) assert.
    (d includesKey: 'one') assert.
    (d includes: 1) assert.
    ((d at: 'one') = 1) assert.

    '2 ' put.
    d at: 2 put: 'two'.
    (d size = 2) assert.
    (d includesKey: 2) assert.
    (d includes: 'two') assert.
    ((d at: 'one') = 1) assert.
    ((d at: 2) = 'two') assert.

    '3 ' put.
    d	at: 'three' put: 3;
	at: 'four'  put: 4;
	at: 'five'  put: 5;
	at: 'six'   put: 6;
	at: 'seven' put: 7;
	at: 'eight' put: 8;
	at: 'nine'  put: 9;
	at: 'zero'  put: 0.
    (d size = 10) assert.
    #('zero' 'one' 2 'three' 'four' 'five' 'six' 'seven' 'eight' 'nine') do: [:i | (d includesKey: i) assert].
    #(0 1 'two' 3 4 5 6 7 8 9) do: [:i | (d includes: i) assert].
    #('zero' 'one' 2 'three' 'four' 'five' 'six' 'seven' 'eight' 'nine')
	with: #(0 1 'two' 3 4 5 6 7 8 9)
	do: [:i :j | ((d at: i) = j) assert].

    '4 ' put.
    #('one' 'three' 'five' 'seven' 'nine') with: #(1 3 5 7 9) do: [:i :j |
	(d includesKey: i) assert.
	((d at: i) = j) assert.
	d removeKey: i.
	(d includesKey: i) not assert.
	((d at: i ifAbsent: [42]) = 42) assert].
    (d size = 5) assert.

    #('zero' 2 'four' 'six' 'eight') with: #(0 'two' 4 6 8) do: [:i :j | ((d at: i) = j) assert].

    d keys do: [:i | d removeKey: i].
    d isEmpty assert.

    '5 ' put.

    e := IdentityDictionary new.
    1 to: 4 do: [:i |
	d at: 'key' asLowercase put: i.
	e at: 'key' asLowercase put: i].
    (d size = 1) assert.
    (e size = 4) assert.
    (d keys asArray = #('key')) assert.
    (e keys asArray = #('key' 'key' 'key' 'key')) assert.
    (d values asArray = #(4)) assert.
    1 to: 4 do: [:i | (e values includes: i) assert].

    'ok' putln.
]

{ import: Symbol.st }
{ import: perform.st }

[
    | s |

    'Symbol ' put.

    '1 ' put.

    ('hello' = 'hello' asLowercase) assert.
    ('hello' == 'hello' asLowercase) not assert.
    ((Symbol intern: 'hello') =  (Symbol intern: 'hello')) assert.
    ((Symbol intern: 'hello') == (Symbol intern: 'hello')) assert.
    ((Symbol intern: 'foo')   == #foo) assert.
    ((Symbol intern: 'hello') == #hello) assert.
    (#foo   == #foo)   assert.
    (#hello == #hello) assert.
    (#foo   ~~ #hello) assert.
    (#hello ~~ #foo)   assert.

    '2 ' put.

    (((#('one' 'one' 'two' 'one' 'two' 'three') collect: [:e | e asLowercase]) as: IdentitySet) size = 6) assert.
    (((#('one' 'one' 'two' 'one' 'two' 'three') collect: [:e | e asLowercase asSymbol]) as: IdentitySet) size = 3) assert.

    '3 ' put.

    s := #yourself.
    ((s perform: s) == s) assert.
    (('HellO' perform: #asLowercase) = 'hello') assert.
    (('HellO' asLowercase perform: #at: with: 2) = $e) assert.
    (('HellO' asLowercase perform: #at:put: with: 2 with: $a; perform: s) = 'hallo') assert.

    '4 ' put.

    (Object respondsTo: s) assert.
    (Object respondsTo: #fnark) not assert.
    (42 respondsTo: #+) assert.
    (42 respondsTo: #size) not assert.

    'ok' putln.
]

{ import: tokenization }

[
    'tokenization ' put.

    '1 ' put.
    (('  one  two three  four  ' tokenized: ' ')  asArray = #('one' 'two' 'three' 'four')) assert.
    (('  one  two three  four  ' tokenized: 't')  asArray = #('  one  ' 'wo ' 'hree  four  ')) assert.
    (('  one  two three  four  ' tokenized: 'et') asArray = #('  on' '  ' 'wo ' 'hr' '  four  ')) assert.

    '2 ' put.
    (('  one  two three  four  ' firstToken: ' ')  = 'one'    ) assert.
    (('  one  two three  four  ' firstToken: 't')  = '  one  ') assert.
    (('  one  two three  four  ' firstToken: 'et') = '  on'   ) assert.

    '3 ' put.
    ((#('one' 'two' 'three' 'four') delimited: '/') = #('one' '/' 'two' '/' 'three' '/' 'four')) assert.
    '3 ' put.
    (('' delimited: $+) = '') assert.
    '3 ' put.
    (('1' delimited: $+) = '1') assert.
    '3 ' put.
    (('123456789' delimited: $+) = '1+2+3+4+5+6+7+8+9') assert.

    '4 ' put.
    ((#('path' 'to' 'enlightenment') delimited: '/') flattened = 'path/to/enlightenment') assert.
    ((('//path/to//enlightenment/////' tokenized: '/') asArray delimited: '/') flattened = 'path/to/enlightenment') assert.

    'ok' putln.
]

{ import: Smalltalk }

[
    'Smalltalk ' put.

    '1 ' put.
    Smalltalk argumentVector print.
    Smalltalk arguments print.
    ' ' put.

    '2 ' put.
    { open("/this/file/does/not/exist", O_RDONLY); }.
    Smalltalk osErrorString print.
    ' ' put.

    'ok' putln.
]

[
    Smalltalk argumentCount < 2
	ifTrue:
	   [('(invoke ', Smalltalk argumentVector first, ' with an argument to run memory test)') putln]
	ifFalse:
	   [1 to: 100 do: [:total |
		100 timesRepeat: [String new: 10 * 1024 * 1024].
	        '\rAttempting to fill memory: ' put.
		total print.
		'GB ' put].
	    'ok' putln].
]
