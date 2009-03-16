" TextEditor.st -- an event handler for editing paragraphs

  Copyright (c) 2009 Ian Piumarta
  All rights reserved.

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the 'Software'),
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, provided that the above copyright notice(s) and this
  permission notice appear in all copies of the Software and that both the
  above copyright notice(s) and this permission notice appear in supporting
  documentation.

  THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.

  Last edited: 2009-03-16 16:56:39 by piumarta on emilia
"

{ import: Box }

IdentityDictionary from: start to: stop put: aValue
[
    start to: stop do: [:key | self at: key put: aValue].
]

TextActions := [ IdentityDictionary new
    at: $A - 64 put: #xBOL;
    at: $B - 64 put: #xLeft;
    at: $D - 64 put: #xDelete;
    at: $E - 64 put: #xEOL;
    at: $F - 64 put: #xRight;
    at: $H - 64 put: #xBackspace;
    at: $I - 64 put: #xTab;
    at: $J - 64 put: #xNewline;
    at: $M - 64 put: #xNewline;
    at: $N - 64 put: #xDown;
    at: $P - 64 put: #xUp;
    at: $S - 64 put: #xSlanted;
    at: $U - 64 put: #xUnderlined;
    at:     127 put: #xBackspace;
    "    Mac OS                             Win32   "
    at:  0xF700 put: #xUp;		at:  -273 put: #xUp;
    at:  0xF701 put: #xDown;		at:  -274 put: #xDown;
    at:  0xF702 put: #xLeft;		at:  -276 put: #xLeft;
    at:  0xF703 put: #xRight;		at:  -275 put: #xRight;
    at:  0xF72c put: #xPageUp;		at:  -280 put: #xPageUp;
    at:  0xF72d put: #xPageDown;	at:  -281 put: #xPageDown;
    yourself
]

TextEditor : EventHandler ( dot mark )

Box beEditable
[
    ^self beEditable: self
]

Box beEditable: aBox
[
    | editor |
    self addFirst: ((Surface fromFile: 'caret16.bmp') asBox width: 0; height: 13; depth: 0).
    editor := TextEditor withDot: firstLink.
    aBox
	eventHandlersAt: #keyDownEvent	  put: editor;
	eventHandlersAt: #buttonDownEvent put: editor;
	propertiesAt:    #editor          put: editor
]

TextEditor withDot: aBox
[
    self := self new.
    dot := aBox.
]

Box isGlyph	[ ^surface and: [surface isGlyph] ]
Box isGraphic	[ ^surface and: [surface isGlyph not] ]

TextEditor buttonDownEvent :event :box :point
[
    | target |
    box := dot container container.
    (target := box lineAtPoint: point) ifFalse: [^nil].
    (target := target columnAtPoint: point) ifFalse: [^nil].
    self resetSelection.
    event source eventHandlersAdd: self forBox: box.
    target == dot
	ifFalse:
	   [dot container remove: dot; layoutChanged.
	    target container add: dot before: target; layoutChanged].
]

TextEditor motionEvent :event :box :point
[
    | target |
    box := dot container container.
    point := event position - box globalOrigin.
    (target := box lineAtPoint: point) ifFalse: [^nil].
    (target := target columnAtPoint: point) ifFalse: [^nil].
    target isGlyph ifFalse: [^nil].
    target == mark ifTrue: [^self].
    self selectTo: target.
]

TextEditor selectTo: newMark
[
    mark ifTrue: [self resetSelection].
    newMark == dot ifTrue: [^nil].
    mark := newMark.
    self selectionDo: [:box | (box backgroundColour: ColourGreen; container) layoutChanged].
]

TextEditor resetSelection
[
    mark ifFalse: [^self].
    self selectionDo: [:box | (box backgroundColour: nil; container) layoutChanged].
    mark := nil.
]

TextEditor selectionDo: unaryBlock
[
    | from to |
    mark ifFalse: [^nil].
    from := self selectionStart.
    to   := self selectionEnd.
    [ unaryBlock value: from.
      from ~~ to ]
	whileTrue:
	   [from := from nextInFlow].
]

TextEditor selectionStart
[
    | fwd rev |
    fwd := rev := dot.
    dot == mark ifTrue: [self error: 'the selection is empty'].
    [ fwd == mark ifTrue: [^dot nextInFlow].
      rev == mark ifTrue: [^mark].
      fwd ifTrue: [fwd := fwd nextInFlow].
      rev ifTrue: [rev := rev prevInFlow].
      (fwd or: [rev]) ]
	whileTrue.
    [StdErr nextPutAll: 'the mark cannot be found\n'].
    ^dot
]

TextEditor selectionEnd
[
    | fwd rev |
    fwd := rev := dot.
    [ fwd == mark ifTrue: [^mark].
      rev == mark ifTrue: [^dot prevInFlow].
      fwd ifTrue: [fwd := fwd nextInFlow].
      rev ifTrue: [rev := rev prevInFlow].
      (fwd or: [rev]) ]
	whileTrue.
    [StdErr nextPutAll: 'the mark cannot be found\n'].
    ^dot
]

TextEditor deleteSelection
[
    mark ifFalse: [^self].
    self deleteFrom: self selectionStart to: self selectionEnd.
    mark := nil.
]

TextEditor deleteFrom: first to: last
[
    [ | dead cont |
      dead := first.
      cont := dead container.
      first := dead nextInFlow.
      dead unlink.
      cont isEmpty ifTrue: [cont unlink].
      dead ~~ last ]
	whileTrue
]

TextEditor buttonUpEvent :event :box :point
[
    event source eventHandlersRemove: self
]

Box lineAtPoint: aPoint
[
    | first y minDy minBox |
    (first := self firstVisible) ifFalse: [^nil].
    aPoint := aPoint - origin.
    y := aPoint y.
    minDy  := (first origin y + (first height + first depth / 2) - y) abs.
    minBox := first.
    first to: self lastVisible do: [:box | (box origin y - y) abs < minDy ifTrue:  [minDy := ((minBox := box) origin y + (box height + box depth / 2) - y) abs]].
    ^minBox
]

Box columnAtPoint: aPoint
[
    | x minDx minBox |
    firstLink ifFalse: [^nil].
    aPoint := aPoint - origin.
    x := aPoint x.
    minBox := firstLink.
    minDx  := (minBox origin x - x) abs.
    self do: [:box | ((box origin x - x) abs < minDx and: [box width > 0])
			 ifTrue: [minDx := ((minBox := box) origin x - x) abs]].
    ^minBox
]

TextEditor keyDownEvent :event :box :point
[
    dot container layoutChanged.
    self perform: (TextActions at: event code ifAbsent: [event code > 0 ifTrue: [#xInsert] ifFalse: [#xIgnore]]) with: event.
    dot container layoutChanged.
    dot container container ensureVisible: dot.
]

TextEditor xBold	[ self applyStyle: Family boldStyleMask ]
TextEditor xSlanted	[ self applyStyle: Family italicStyleMask ]
TextEditor xUnderlined	[ self applyStyle: Family underlineStyleMask ]

TextEditor applyFamily: familyName
[
    DefaultFont := DefaultFont withFamily: familyName.
    self selectionDo: [:box |
	box isGlyph
	    ifTrue:
	       [box surface: (box surface withFamily: familyName).
		box container layoutChanged]]
]

TextEditor applyStyle: styleMask
[
    DefaultFont := DefaultFont withStyle: (DefaultFont style bitXor: styleMask).
    self selectionDo: [:box |
	box isGlyph
	    ifTrue:
	       [box surface: (box surface withStyle: (box surface style bitXor: styleMask)).
		box container layoutChanged]]
]

TextEditor applySize: size
[
    DefaultFont := DefaultFont withSize: size.
    self selectionDo: [:box |
	box isGlyph
	    ifTrue:
	       [box surface: (box surface withSize: size).
		box container layoutChanged]]
]

TextEditor xIgnore	:event	[ (event code printsp printStringBase: 16) putln ]
TextEditor xInsert	:event	[ self deleteSelection.  dot container add: (DefaultFont glyphAt: event code) asBox before: dot ]
TextEditor xTab		:event	[ self deleteSelection.  dot container add: ((DefaultFont glyphAt: 160) asBox width: (DefaultFont glyphAt: 32) width * 8) before: dot ]
TextEditor xNewline	:event	[ self deleteSelection.  dot container add: (DefaultFont glyphAt: 10) asBox before: dot ]

TextEditor xBackspace :event
[
    mark ifTrue: [^self deleteSelection].
    dot prevLink ifTrue: [^dot prevLink unlink].
    dot container prevLink ifFalse: [^self].
    dot container prevLink notEmpty ifTrue: [dot container prevLink removeLast; layoutChanged].
    [dot container prevLink and: [dot container prevLink isEmpty]] whileTrue: [dot container prevLink unlink].
]

TextEditor xDelete :event
[
    mark ifTrue: [^self deleteSelection].
    dot nextLink ifTrue: [^dot nextLink unlink].
    dot container nextLink ifFalse: [^self].
    dot container nextLink notEmpty ifTrue: [dot container nextLink removeFirst; layoutChanged].
    [dot container nextLink and: [dot container nextLink isEmpty]] whileTrue: [dot container nextLink unlink].
]

TextEditor xUp :event
[
    | cont |
    self resetSelection.
    cont := dot container.
    (cont prevLink and: [cont prevLink notEmpty])
	ifTrue:  [cont prevLink add: dot unlink before: (cont prevLink columnAtPoint: dot origin)]
	ifFalse: [cont addFirst: dot unlink].
]

"
TextEditor xUp :event
[
    | cont |
    self resetSelection.
    cont := dot container.
    (cont prevLink and: [cont prevLink notEmpty])
	ifTrue:  [cont prevLink add: dot unlink before: (cont prevLink columnAtPoint: dot origin)]
	ifFalse: [cont addFirst: dot unlink].
    dot container container ensureVisible: dot.
]
"

TextEditor xPageUp :event
[
    | cont |
    self resetSelection.
    cont := dot container container firstVisible.
    16 timesRepeat: [cont prevLink ifTrue: [cont := cont prevLink]].
    cont notEmpty
	ifTrue:  [cont add: dot unlink before: (cont columnAtPoint: dot origin)]
	ifFalse: [cont addFirst: dot unlink].
    dot container container firstVisible: cont; layoutChanged.
]

TextEditor xDown :event
[
    | cont |
    self resetSelection.
    cont := dot container.
    (cont nextLink and: [cont nextLink notEmpty])
	ifTrue:  [cont nextLink add: dot unlink before: (cont nextLink columnAtPoint: dot origin)]
	ifFalse: [cont addLast: dot unlink].
]

TextEditor xPageDown :event
[
    | cont |
    "16 timesRepeat: [self xDown :event]."
    self resetSelection.
    cont := dot container container lastVisible.
    cont ifTrue: [cont := cont nextLink].
    cont ifFalse: [^nil].
    cont addFirst: dot unlink.
    dot container container firstVisible: cont; lastVisible: nil; layoutChanged.
]

TextEditor xLeft :event
[
    | prev |
    prev := mark ifTrue: [self selectionStart] ifFalse: [dot prevInFlow].
    self resetSelection.
    prev ifTrue: [dot unlink linkBefore: prev].
]

TextEditor xRight :event
[
    | next |
    next := mark ifTrue: [self selectionEnd] ifFalse: [dot nextInFlow].
    self resetSelection.
    next ifTrue: [dot unlink linkAfter: next].
]

TextEditor xBOL :event
[
    | prev |
    self resetSelection.
    [prev := dot prevLink] whileTrue: [dot unlink linkBefore: prev].
]

TextEditor xEOL :event
[
    | next |
    self resetSelection.
    [(next := dot nextLink) and: [next nextLink]] whileTrue: [dot unlink linkAfter: next].
]

TextEditor save: text as: name
[
    name := name asString.
    (name endsWith: '.doq') ifFalse: [name := name , '.doq'].
    (File create: name) write: text asDoqString; close.
    StdOut nextPutAll: 'saved: '; nextPutAll: name; cr.
]

TextEditor oldLoad: text as: name
[
    | file string |
    [dot container prevLink] whileTrue: [dot container prevLink unlink].
    [dot container nextLink] whileTrue: [dot container nextLink unlink].
    [dot prevLink] whileTrue: [dot prevLink unlink].
    [dot nextLink] whileTrue: [dot nextLink unlink].
    dot container layoutChanged.
    name := name asString.
    (name endsWith: '.doq') ifFalse: [name := name , '.doq'].
    file := File openIfPresent: name.
    file ifFalse: [^StdErr nextPutAll: 'cannot open: '; nextPutAll: name; cr].
    string := file contents.
    file close.
    (DoqReadStream on: string) appendContentsTo: dot container.
    StdOut nextPutAll: 'loaded: '; nextPutAll: name; cr.
]

TextEditor load: text as: name
[
    | file string |
    self resetSelection.
    name := name asString.
    (name endsWith: '.doq') ifFalse: [name := name , '.doq'].
    file := File openIfPresent: name.
    file ifFalse: [^StdErr nextPutAll: 'cannot open: '; nextPutAll: name; cr].
    string := file contents.
    file close.
    text removeFirst; addFirst: (string asParagraph: text); layoutChanged; layOut.
    StdOut nextPutAll: 'loaded: '; nextPutAll: name; cr.
    ^text propertiesAt: #editor
]

TextEditor loadBMP: text as: name
[
    | surface |
    name := name asString.
    ((name endsWith: '.bmp') or: [name endsWith: '.BMP']) ifFalse: [name := name , '.bmp'].
    surface := Surface fromFile: name.
    surface ifFalse: [^nil].
    (surface asBox propertiesAt: #bmpName put: name; yourself) linkBefore: dot.
    dot container layoutChanged.
]

"----------------"

{ import: PostScriptStream }

TextEditor print: text as: name
[
    | stream |
    stream := PostScriptStream on: (String new: 1024).
    text do: [:box | box printTextOn: stream].
    name := name asString.
    (name endsWith: '.ps') ifFalse: [name := name , '.ps'].
    (File create: name) write: stream contents; close.
]

SBox printTextOn: aStream
[
    | p y h |
    y := 0.
    h := height - 108.
    aStream beginDocument: width , height; beginPage: (p := 1).
    self do: [:box |
	box layOutIn: self.
	y := y + (box printTextLineOn: aStream).
	(box nextLink and: [y + box nextLink totalHeight > h])
	    ifTrue:
	       [aStream endPage: p.
		StdOut nextPutAll: 'PAGE '; print: p; cr.
		aStream beginPage: (p := p + 1).
		y := 0]].
    aStream endPage: p; endDocument.
    StdOut nextPutAll: 'PAGE '; print: p; cr.
]

Box printTextLineOn: aStream
[
    | h d |
    h := self inject: 0 into: [:ht :box | ht max: box height].
    d := self inject: 0 into: [:dp :box | dp max: box depth].
    aStream origin: 0,h.
    self do: [:box | box printTextElementOn: aStream].
    aStream origin: 0,d.
    ^h + d
]

Box printTextElementOn: aStream
[
    (prevLink not or: [prevLink isGlue or: [prevLink isTab or: [prevLink isGraphic]]])
	ifTrue: [aStream moveToX: origin x].
    width > 0 ifTrue: [surface printTextElementOn: aStream at: origin]
]

Surface printTextElementOn: aStream at: origin	[ aStream nextPutSurface: self at: origin ]

Glyph printTextElementOn: aStream at: origin
[
    aStream ensureFont: font; nextPutUnicode: unicode.
]

"----------------"

Box asString
[
    | stream |
    stream := WriteStream on: (String new: 64).
    self asStringOn: stream.
    ^stream contents.
]

Box asStringOn: aStream
[
    self isGlyph ifTrue: [aStream nextPut: surface unicode].
    self do: [:box | box asStringOn: aStream].
]

TextEditor printInfo
[
    dot nextLink println
]

"----------------------------------------------------------------"

{ import: UTF8Stream }

DoqWriteStream : UTF8WriteStream ( currentFont )

DoqWriteStream nextPutUnicode: aCode
[
    aCode == 160 ifTrue: [aCode := 9].
    self nextPut: aCode.
    aCode == $\\ ifTrue: [self nextPut: aCode].
]

DoqWriteStream ensureFont: aFont	[ currentFont == aFont ifFalse: [self nextPutFont: (currentFont := aFont)] ]

DoqWriteStream nextPutFont: aFont
[
    self nextPutAll: '\\f'; nextPutArg: aFont name; nextPutArg: aFont style printString; nextPutArg: aFont pointSize printString
]

DoqWriteStream nextPutBMP: name		[ self nextPutAll: '\\g'; nextPutArg: name ]
DoqWriteStream nextPutArg: aString	[ self nextPutAll: aString; nextPut: $\\ ]

Box asDoqString
[
    | stream |
    stream := DoqWriteStream on: (String new: 64).
    self asDoqStringOn: stream.
    ^stream contents.
]

Box asDoqStringOn: aStream
[
    | name |
    surface
	ifTrue:
	   [(name := self propertiesAt: #bmpName)
		ifTrue:  [aStream nextPutBMP: name]
		ifFalse: [surface asDoqStringOn: aStream]].
    self do: [:box | box asDoqStringOn: aStream].
]

Glyph asDoqStringOn: aStream
[
    aStream ensureFont: font.
    aStream nextPutUnicode: unicode.
]

Surface asDoqStringOn: aStream
[
    StdOut nextPutAll: 'unknown surface not written\n'
]

TitleFont := [ #Arial roman @ 16 ]

Box withTitle: titleString
[
    | frame |
    ^(frame := Box new vBox)
	addLast: ((titleString asText: TitleFont) hBox backgroundColour: ColourWhite; borderWidth: 2; beDraggable: frame);
	addLast: self;
	addLast: ((Box withExtent: 10,10) backgroundColour: ColourBlue)
]

"----------------"

DoqReadStream : UTF8ReadStream ( currentFont )

DoqReadStream on: aString
[
    self := super on: aString.
    currentFont := DefaultFont.
]

DoqReadStream appendContentsTo: aList	[ [self atEnd] whileFalse: [self appendNextTo: aList] ]

DoqReadStream appendNextTo: aList
[
    | c |
    c := super next.
    c := c == $\\ ifTrue: [self escape] ifFalse: [self character: c].
    c ifTrue: [aList addLast: c].
]

DoqReadStream character: c
[
    c == 9 ifTrue: [c := 160].
    c == 160 ifTrue: [^(currentFont glyphAt: c) asBox width: (currentFont glyphAt: 32) width * 8].
    ^(currentFont glyphAt: c) asBox
]

DoqReadStream escape
[
    | c |
    ((c := super next) not or: [c == $\\]) ifTrue: [^self character: $\\].
    ^self perform: (String with: c) asSymbol
]

DoqReadStream nextArgument
[
    | c argument |
    argument := WriteStream on: (String new: 16).
    [self atEnd not and: [(c := super next) ~~ $\\]]  whileTrue: [argument nextPut: c].
    ^argument contents
]

DoqReadStream f
[
    | name style size |
    name := self nextArgument.
    style := Integer fromString: self nextArgument.
    size := Integer fromString: self nextArgument.
    currentFont := ((Family withName: name asSymbol) withStyle: style) withSize: size.
    ^nil
]

DoqReadStream g
[
    | name sfc |
    name := self nextArgument.
    name println.
    sfc := Surface fromFile: name.
    ^sfc ifTrue: [sfc asBox propertiesAt: #bmpName put: name; yourself]
]

SequenceableCollection asText	[ ^self asText: DefaultFont ]

SequenceableCollection asText: font
[
    | box |
    box := Box new hBox.
    (DoqReadStream on: self) appendContentsTo: box.
    ^box
]

SequenceableCollection asParagraph	[ ^self asParagraph: nil ]

SequenceableCollection asParagraph: frame
[
    | v h |
    (v := SBox new vBox) addLast: (h := Box new tBox).
    (DoqReadStream on: self) appendContentsTo: h.
    h beEditable: (frame ifNil: [v]).
    ^v
]

Box beButton: aBlock
[
    self
	eventHandlersAt: #buttonDownEvent put: (ButtonHandler withAction: aBlock);
	backgroundColour: (Colour fromHex: 0xE7EBCF);
	borderColour: ColourGreen;
	beHighlighted
]

{ input: SampleText.st }
