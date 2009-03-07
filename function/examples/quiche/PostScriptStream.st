{ import: Stream }

PostScriptStream : WriteStream ( currentFont )

PostScriptStream beginDocument
[
    self
	nextPutAll: '/BOP { 36 756 translate 0 0 moveto } def\n';
	nextPutAll: '/EOP { 4 string cvs dup stringwidth pop initgraphics 2 div neg 306 add 36 moveto show showpage } def\n';
	nextPutAll: '/readstring { currentfile exch readhexstring pop } bind def\n'.
]

PostScriptStream beginPage: pageNumber
[
    self
	nextPutAll: '%%Page: '; print: pageNumber;
	nextPutAll: '\nBOP\n'
]

PostScriptStream origin: aPoint
[
    self print: aPoint x; space; print: aPoint y negated; space; nextPutAll: 'translate 0 0 moveto'; cr
]

PostScriptStream ensureFont: aFont
[
    currentFont == aFont ifTrue: [^self].
    self nextPut: $/; nextPutAll: aFont name.
    aFont isPlain	ifTrue: [self nextPutAll: '-Roman'].
    aFont isBold	ifTrue: [self nextPutAll: '-Bold'].
    aFont isItalic	ifTrue: [self nextPutAll: '-Italic'].
    self nextPutAll: ' findfont '; print: aFont pointSize; nextPutAll: ' scalefont setfont'; cr.
    currentFont := aFont.
]

PostScriptStream moveToX: x	[ self print: x; nextPutAll: ' 0 moveto ' ]

PostScriptStream nextPutUnicode: unicode
[
    (unicode == $( or: [unicode == $) or: [unicode == $\\]])
	ifTrue:  [self nextPutAll: '(\\'; nextPut: unicode; nextPutAll: ') show'; cr]
	ifFalse: [self nextPutAll: '('; nextPut: unicode; nextPutAll: ') show'; cr].
]

PostScriptStream nextPutSurface: aSurface
[
    | w h |
    w := aSurface width.
    h := aSurface height.
    self
	nextPutAll: 'save\n';
	nextPutAll: '/rpicstr '; print: w; nextPutAll: ' string def\n';
	nextPutAll: '/gpicstr '; print: w; nextPutAll: ' string def\n';
	nextPutAll: '/bpicstr '; print: w; nextPutAll: ' string def\n';
	print: w; space; print: h; nextPutAll: ' scale ';
	print: w; space; print: h; nextPutAll: ' 8 [ ';
	print: w; nextPutAll: ' 0 0 '; print: h negated; nextPutAll: ' 0 '; print: h; nextPutAll: ']'; cr;
	nextPutAll: '{ rpicstr readstring } { gpicstr readstring } { bpicstr readstring } true 3 colorimage\n'.
    0 to: h - 1 do: [:y |
	0 to: w - 1 do: [:x | self nextPutHex8: (aSurface redAt:   x at: y)].  self cr.
	0 to: w - 1 do: [:x | self nextPutHex8: (aSurface greenAt: x at: y)].  self cr.
	0 to: w - 1 do: [:x | self nextPutHex8: (aSurface blueAt:  x at: y)].  self cr].
    self nextPutAll: 'restore\n'.
]

PostScriptStream nextPutHex8: anInteger	[ anInteger printOn: self base: 16 width: 2 padded: $0 ]

PostScriptStream endPage: pageNumber	[ self print: pageNumber; nextPutAll: ' EOP\n' ]

PostScriptStream endDocument		[]
