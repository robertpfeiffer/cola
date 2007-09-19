" Text.st -- String and CompositeView additions to support rendered text

  Copyright (c) 2007 Ian Piumarta
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

  Last edited: 2007-09-18 20:16:14 by piumarta on emilia
"

{ import: Object }
{ import: Colour }
{ import: Font }
{ import: Views }

String asCompositeView
[
    ^self asCompositeViewWithFont: Font default
]

String asCompositeViewWithFont: aFont
[
    | text |
    text := CompositeView new.
    self inject: 0 into: [:x :codePoint |
	| glyph |
	text addLast: (((glyph := aFont glyphAt: codePoint) shapedView fillColour: Colour black)
			   transformView translation: x , 0).
	x + glyph metrics hAdvance].
    ^text
]

CompositeView asString
[
    | stream |
    stream := WriteStream on: (String new: 32).
    self do: [:view |
	| glyph |
	(view isTransformView
		and: [view notEmpty
		and: [(glyph := view first) isShapedView
		and: [(glyph := glyph shape) isGlyph]]])
	    ifTrue: [stream nextPut: glyph codePoint & 255]].
    ^stream contents
]

"----------------------------------------------------------------"

" A StringView provides its displayable path via a String. "

StringView : View (
    string	"String selecting the Glyphs of my displayable path"
    font	"Font controling the shape of those Glyphs"
)

StringView withString: aString
[
    ^self withString: aString font: Font default
]

StringView withString: aString font: aFont
[
    self := super new.
    string := aString.
    font := aFont.
    fillColour := Colour black.
]

StringView string		[ ^string ]
StringView string: aString	[  string := aString ]

StringView font			[ ^font ]
StringView font: aFont		[  font := aFont ]

String stringView
[
    ^StringView withString: self
]

String stringView: aFont
[
    ^StringView withString: self font: aFont
]

StringView bounds		[ ^string boundsWithFont: font ]

String boundsWithFont: aFont
[
    | x bounds |
    x := 0.
    bounds := Rectangle zero.
    self do: [:char |
	| gm |
	bounds := bounds union: ((gm := (aFont glyphAt: char) metrics) bounds translatedBy: x , 0).
	x := x + gm hAdvance].
    ^bounds
]

StringView pathOn: aCanvas
[
    aCanvas
	save;
	string: string font: font;
	restore
]

StringView serif	[ font := font family: 'serif' ]
StringView sans		[ font := font family: 'sans' ]
StringView mono		[ font := font family: 'mono' ]

StringView light	[ font := font series: 'light' ]
StringView medium	[ font := font series: 'medium' ]
StringView bold		[ font := font series: 'bold' ]
StringView black	[ font := font series: 'black' ]

StringView roman	[ font := font shape:  'roman' ]
StringView italic	[ font := font shape:  'italic' ]
StringView sloped	[ font := font shape:  'sloped' ]

"----------------------------------------------------------------"

TextCaret : Shape ( font )

TextCaret withFont: aFont
[
    self := self new.
    font := aFont.
]

TextCaret bounds		[ ^0 , -4 corner: 0 , font metrics unitsPerEm ]
TextCaret hAdvance		[ ^0 ]
TextCaret layoutWidth		[ ^0 ]
TextCaret layoutHeight		[ ^font metrics unitsPerEm ]

TextCaret pathOn: aCanvas	[ ^aCanvas rectangle: (-1 , -1 corner: 1 , font metrics unitsPerEm)]
"TextCaret pathOn: aCanvas	[ aCanvas moveTo: -2 , -2; lineTo:  0 ,  0; lineTo:  2 , -2; lineTo:  2 , -4; lineTo:  0 , -2; lineTo: -2 , -4; lineTo: -2 , -2 ]"

"----------------------------------------------------------------"

TextEditor : Object ( view caret characterMap selecting clickPosition clickTime clickCount )

ComposableView textEditor
[
    | editor |
    editor := TextEditor withView: self.
    self propertyAt: #keyDownEvent
	 put: [:view :event |
	     (editor inputEvent: event)
		 ifTrue:
		     [view layout; scrollTo: editor caret bounds; damaged]].
    self propertyAt: #pointerDownEvent   put: [:view :event | editor pointerDown: event].
    self propertyAt: #pointerMotionEvent put: [:view :event | editor pointerMotion: event].
    self propertyAt: #pointerUpEvent     put: [:view :event | editor pointerUp: event].
    self propertyAt: #layout             put: #pageLayout.
    ^editor
]

TextEditor withView: aView
[
    self := self new.
    view  := aView.
    caret := view add: ((TextCaret withFont: Font) shapedView fillColour: Colour green) transformView.
    (characterMap := IdentityDictionary new)
	at:  0 put: #xIgnore:;		"C-@"
	at:  1 put: #xBOL:;		"C-a"
	at:  2 put: #xLeft:;		"C-b"
	at:  3 put: #xInterrupt:;	"C-c"
	at:  4 put: #xDelete:;		"C-d"
	at:  5 put: #xEOL:;		"C-e"
	at:  6 put: #xRight:;		"C-f"
	at:  7 put: #xDoit:;		"C-g"
	at:  8 put: #xBackspace:;	"C-h, backspace"
	at:  9 put: #xIgnore:;		"C-i, tab"
	at: 10 put: #xReturn:;		"C-j"
	at: 11 put: #xKill:;		"C-k"
	at: 12 put: #xCentre:;		"C-l"
	at: 13 put: #xReturn:;		"C-m"
	at: 14 put: #xDown:;		"C-n"
	at: 15 put: #xOpen:;		"C-o"
	at: 16 put: #xUp:;		"C-p, home"
	at: 17 put: #xLeft:;		"C-q, left arrow"
	at: 18 put: #xUp:;		"C-r, up arrow"
	at: 19 put: #xRight:;		"C-s, right arrow"
	at: 20 put: #xDown:;		"C-t, down arrow"
	at: 21 put: #xPrior:;		"C-u, page up"
	at: 22 put: #xNext:;		"C-v, page down"
	at: 23 put: #xDown:;		"C-w, end"
	at: 24 put: #xIgnore:;		"C-x"
	at: 25 put: #xIgnore:;		"C-y"
	at: 26 put: #xSelectAll:;	"C-z"
	at: 27 put: #xIgnore:;		"C-["
	at: 28 put: #xIgnore:;		"C-\"
	at: 29 put: #xIgnore:;		"C-]"
	at: 30 put: #xIgnore:;		"C-^"
	at: 31 put: #xIgnore:.		"C-_"
    clickTime := 0.
    clickCount := 0.
]

TextEditor caret	[ ^caret ]

TextEditor pointerDown: event
[
    | position closestGlyph |
    position := event localPosition.
    view remove: caret.
    (closestGlyph := self glyphNearest: position)
	ifTrue:
	   [position x < closestGlyph bounds centre x
		ifTrue:  [view add: caret before: closestGlyph]
		ifFalse: [view add: caret after: closestGlyph]]
	ifFalse:
	   [view add: caret].
    self clearSelection.
    selecting := true.
    view
	layout;
	scrollTo: caret bounds;
	damaged.
    (clickPosition = event position and: [clickTime - event time < 1000])
	ifTrue:  [(clickCount := clickCount + 1) > 0 ifTrue: [self click: clickCount]]
	ifFalse:
	    [clickCount := 0.
	     clickPosition := event position.
	     clickTime := event time]
]

TextEditor pointerMotion: event
[
    | glyph position bounds |
    (selecting and: [glyph := self glyphNearest: (position := event localPosition)])
	ifTrue:
	   [view scrollTo: (bounds := glyph bounds).
	    (caret bounds followsPoint: bounds origin)
		ifTrue:  [self setSelectionFrom: glyph to: caret prevLink]
		ifFalse: [self setSelectionFrom: caret nextLink
			       to: (position x > bounds centre x
					ifTrue:  [glyph nextNonLineBreak]
					ifFalse: [glyph])]]
]

ComposableView nextNonLineBreak
[
    | view |
    view := self.
    [(view := view nextLink) and: [view isLineBreak]] whileTrue.
    ^view
]

TextEditor pointerUp: event
[
    selecting := false.
]

TextEditor glyphNearest: position
[
    | closestGlyph closestDistance |
    closestDistance := (caret bounds centre - position) r + 10000.
    view contents do: [:v |
	| d |
	d := (v layoutBounds centre - position) r.
	(d < closestDistance and: [v notLineBreak and: [v ~~ caret]])
	    ifTrue:
	       [closestGlyph := v.
		closestDistance := d]].
    ^closestGlyph
]

TextEditor setSelectionFrom: start to: end
[
    view
	propertyAt: #selectionStart put: start;
	propertyAt: #selectionEnd put: end;
	damaged
]

TextEditor deleteSelection
[
    | start end next |
    ^((start := view propertyAt: #selectionStart) and: [end := view propertyAt: #selectionEnd])
	ifTrue:
	   [view removeFrom: start to: end.
	    self clearSelection].
    self clearSelection.
]

TextEditor clearSelection
[
    view
	removeProperty: #selectionStart;
	removeProperty: #selectionEnd;
	damaged
]

TextEditor click: count
[
    count == 1 ifTrue: [^self selectWord].
    count == 2 ifTrue: [^self selectLine].
    clickCount := 0.
]

TextEditor selectWord
[
    | start end |
    (((start := caret prevLink) and: [start isAlphaNumeric]) or: [(start := caret nextLink) and: [start isAlphaNumeric]]) ifFalse: [^self].
    view remove: caret.
    [start prevLink and: [start prevLink isAlphaNumeric]] whileTrue: [start := start prevLink].
    end := start.
    [end nextLink and: [end nextLink isAlphaNumeric]] whileTrue: [end := end nextLink].
    self setSelectionFrom: start to: end.
    view add: caret after: end.
]

TextEditor selectLine
[
    | start end |
    (((start := caret prevLink) and: [start notLineBreak]) or: [(start := caret nextLink) and: [start notLineBreak]]) ifFalse: [^self].
    view remove: caret.
    [start prevLink and: [start prevLink notLineBreak]] whileTrue: [start := start prevLink].
    end := start.
    [end nextLink and: [end nextLink notLineBreak]] whileTrue: [end := end nextLink].
    self setSelectionFrom: start to: end.
    view add: caret after: end.
]

CompositeView codePoint		[ ^self first codePoint ]
ComposableView codePoint	[ ^contents first codePoint ]
ShapedView codePoint		[ ^shape codePoint ]

CompositeView isAlphaNumeric	[ | cp | ^((cp := self codePoint) between: $a and: $z) or: [(cp between: $A and: $Z) or: [cp between: $0 and: $9]]]
ComposableView isAlphaNumeric 	[ | cp | ^((cp := self codePoint) between: $a and: $z) or: [(cp between: $A and: $Z) or: [cp between: $0 and: $9]]]

TextEditor inputEvent: anEvent
[
    self inputCharacter: anEvent ucs4.
    anEvent handled: self
]

TextEditor inputString: aString		[ aString do: [:c | self inputCharacter: c] ]
TextEditor inputCharacter: aCharacter	[ ^aCharacter ifTrue: [self perform: (characterMap at: aCharacter ifAbsent: [#xInsert:]) with: aCharacter] ]

TextEditor xIgnore: aChar	[ ]

TextEditor xInterrupt: aChar	[ self error: 'Interrupt' ]

TextEditor xInsert: aChar	[ self deleteSelection.  view add: ((Font glyphAt: aChar) shapedView fillColour: Colour black)  transformView before: caret ]
TextEditor xReturn: aChar	[ self deleteSelection.  view add:  (Font glyphAt: 10) shapedView				transformView before: caret ]
TextEditor xOpen: aChar		[ self deleteSelection.  view add:  (Font glyphAt: 10) shapedView				transformView after: caret ]

TextEditor xBackspace: aChar	[ self deleteSelection ifFalse: [(aChar := caret prevLink) ifTrue: [view remove: aChar]] ]
TextEditor xDelete: aChar	[ self deleteSelection ifFalse: [(aChar := caret nextLink) ifTrue: [view remove: aChar]] ]

TextEditor xCentre: aChar	[ view centreOn: caret bounds ]

TextEditor xBOL: aChar		[ self clearSelection.  [caret and: [caret prevLink and: [caret prevLink notLineBreak]]] whileTrue: [self xLeft:  aChar] ]
TextEditor xEOL: aChar		[ self clearSelection.  [caret and: [caret nextLink and: [caret nextLink notLineBreak]]] whileTrue: [self xRight: aChar] ]

TextEditor xPrior: aChar	[ 10 timesRepeat: [self xUp:   aChar].  view centreOn: caret bounds ]
TextEditor xNext: aChar		[ 10 timesRepeat: [self xDown: aChar].  view centreOn: caret bounds ]

TextEditor xLeft: aChar		[ self clearSelection.  (aChar := caret prevLink) ifTrue: [view add: (view remove: caret) before: aChar] ]
TextEditor xRight: aChar	[ self clearSelection.  (aChar := caret nextLink) ifTrue: [view add: (view remove: caret) after: aChar] ]

TransformView translation	[ ^transform transform: 0.0, 0.0 ]

TextEditor xUp: aChar
[
    | link |
    self clearSelection.
    (link := caret prevLink) ifFalse: [^self].
    view remove: caret.
    [link and: [link notLineBreak]] whileTrue: [link := link prevLink].
    link ifTrue: [link := link prevLink].
    [link and: [link notLineBreak and: [link translation x > caret translation x]]] whileTrue: [link := link prevLink].
    link
	ifTrue:  [view add: caret before: link]
	ifFalse: [view addFirst: caret]
]

TextEditor xDown: aChar
[
    | link |
    self clearSelection.
    (link := caret nextLink) ifFalse: [^self].
    view remove: caret.
    [link and: [link notLineBreak]] whileTrue: [link := link nextLink].
    link ifTrue: [link := link nextLink].
    [link and: [link notLineBreak and: [link translation x < caret translation x]]] whileTrue: [link := link nextLink].
    link
	ifTrue:  [view add: caret before: link]
	ifFalse: [view addLast: caret]
]

TextEditor xKill: aChar
[
    self clearSelection.
    caret nextLink ifFalse: [^nil].
    caret nextLink isLineBreak
	ifTrue:
	    [view remove: caret nextLink]
	ifFalse:
	    [[caret nextLink and: [caret nextLink notLineBreak]]
		 whileTrue: [view remove: caret nextLink]]
]

TextEditor xSelectAll: aChar
[
    self clearSelection.
    view remove: caret; add: caret.
    caret prevLink ifTrue: [self setSelectionFrom: view first to: caret prevLink].
]

TextEditor selectionContents
[
    | start end text |
    ((start := view propertyAt: #selectionStart) and: [end := view propertyAt: #selectionEnd])
	ifFalse:
	   [start := end := caret.
	    [start prevLink and: [start prevLink notLineBreak]] whileTrue: [start := start prevLink].
	    [end   nextLink and: [end   nextLink notLineBreak]] whileTrue: [end   := end   nextLink]].
    text := WriteStream on: (String new: 1024).
    [start == caret ifFalse: [text nextPut: start codePoint].
     start == end]
	whileFalse:
	    [start := start nextLink].
    ^text contents
]

{ import: Scanner }
{ import: Compiler }
{ import: CodeGenerator-local }

TextEditor xDoit: aChar
[
    | start end text result expr |
    text := self selectionContents readStream.
    self clearSelection.
    [text atEnd not and: [expr := CokeScanner read: text]]
	whileTrue:
	   [StdOut println: expr.
	    result := expr eval printString].
    result
	ifTrue:
	   [self xEOL: 0; xReturn: 10.
	    result do: [:c | self xInsert: c].
	    self xBOL: 0.
	    start := caret nextLink.
	    self xEOL: 0.
	    end := caret prevLink.
	    self setSelectionFrom: start to: end]
]

"----------------------------------------------------------------"

String workspace: titleString
[
    | text editor |
    text := (Rectangle zero corner: 400,300) scrollingView fillColour: Colour white.
    editor := text textEditor.
    editor inputString: self.
    text layout; scrollTo: editor caret bounds.
    ^text withVerticalScrollBar withTitle: titleString
]
