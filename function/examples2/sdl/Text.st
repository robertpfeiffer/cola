{ import: Objects }

Faces := [ IdentityDictionary new ]

Face : Object ( name fonts unitsPerEM ascender descender height underline maxAdvance )

Face name	[ ^name ]
Face ascender	[ ^ascender ]
Face descender	[ ^descender ]
Face height	[ ^height ]
Face underline	[ ^underline ]
Face maxAdvance	[ ^maxAdvance ]

Face default	[ ^Face named: 'verdana' ]

Face named: nameString
[
    nameString := nameString asSymbol.
    ^Faces at: nameString ifAbsent: [Faces at: nameString put: (self newFaceNamed: nameString)]
]

Face newFaceNamed: nameSymbol	[ ^self platformFace basicNewFaceNamed: nameSymbol ]

Face basicNewFaceNamed: nameSymbol
[
    self := super new.
    name := nameSymbol.
    fonts := IdentityDictionary new.
]

Face printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPut:    $(;		print: name;
	nextPutAll: ' ';	print: unitsPerEM;
	nextPutAll: ' +';	print: ascender;
	nextPutAll: ' ';	print: descender;
	nextPutAll: ' =';	print: height;
	nextPutAll: ' ';	print: maxAdvance;
	nextPutAll: ' ';	print: underline;
	nextPut:    $).
]

"----------------------------------------------------------------"

Font : Object ( face size ascender descender height underline maxAdvance glyphs )

Font face	[ ^face ]
Font size	[ ^size ]
Font ascender	[ ^ascender ]
Font descender	[ ^descender ]
Font height	[ ^height ]
Font underline	[ ^underline ]
Font maxAdvance	[ ^maxAdvance ]

Font default	[ ^Face default fontAt: 12 ]

Face fontAt: pointSize
[
    pointSize := pointSize rounded.
    ^fonts at: pointSize ifAbsent: [fonts at: pointSize put: (Font withFace: self size: pointSize)]
]

Font withFace: aFace size: pointSize	[ ^self platformFont basicWithFace: aFace size: pointSize ]

Font basicWithFace: aFace size: pointSize
[
    self := super new.
    face	:= aFace.
    size	:= pointSize.
    ascender	:= pointSize * face ascender.
    descender	:= pointSize * face descender.
    height	:= pointSize * face height.
    underline	:= pointSize * face underline.
    maxAdvance	:= (pointSize * face maxAdvance x) , (pointSize * face maxAdvance y).
    glyphs	:= IdentityDictionary new.
]

Font glyphAt: ucs4	[ ^glyphs at: ucs4 ifAbsent: [glyphs at: ucs4 put: (Glyph withFont: self ucs4: ucs4)] ]

Font printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPut: $(;		print: face name;
	nextPutAll: ' @';	print: size;
	nextPutAll: ' ^';	print: height;
	nextPut: $)
]

"----------------------------------------------------------------"

Glyph : Object ( font ucs4 extent offset image advance kerning )

Glyph font	[ ^font ]
Glyph ucs4	[ ^ucs4 ]
Glyph extent	[ ^extent ]
Glyph offset	[ ^offset ]
Glyph image	[ ^image ]
Glyph advance	[ ^advance ]

Glyph withFont: aFont ucs4: ucs4code	[ ^self platformGlyph basicWithFont: aFont ucs4: ucs4code ]

Glyph basicWithFont: aFont ucs4: ucs4code
[
    self := super new.
    font := aFont.
    ucs4 := ucs4code.
]

Glyph kerningFor: nextGlyph
[
    kerning ifFalse: [kerning := IdentityDictionary new].
    ^kerning at: nextGlyph ifAbsent: [kerning at: nextGlyph put: (self basicKerningFor: nextGlyph)].
]

Glyph drawOn: aContext
[
    aContext saveTransform; translate: offset.
    image drawOn: aContext.
    aContext restoreTransform.
]

Glyph basicDrawOn: aContext
[
    image drawOn: aContext.
]

Glyph printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPut:    $(;		print: font face name;
	nextPutAll: ' ';	print: font size;
	nextPutAll: ' ';	print: ucs4;
	nextPutAll: ' ';	print: extent;
	nextPutAll: ' @';	print: offset;
	nextPutAll: ' +';	print: advance;
	nextPut:    $)
]

"----------------------------------------------------------------"

{ import: Box }

GlyphBox : Box ( glyph )

GlyphBox glyph	[ ^glyph ]

GlyphBox withGlyph: aGlyph
[
    | font |
    self := self new.
    self foreground: ColorWhite.
    font := aGlyph font.
    position := aGlyph offset x , font ascender.
    extent := aGlyph advance x , font height.
    glyph := aGlyph.
]

GlyphBox drawOn: aContext
[
    "super drawOn: aContext."
    aContext saveTransform; translate: position.
    glyph drawOn: aContext.
    aContext restoreTransform.
]

"----------------"

TextBox : Box ()

TextBox kernContents
[
    self do: [:gbox || previous |
	gbox position: ((previous := gbox prevLink)
			     ifTrue:  [previous position + previous glyph advance + (previous glyph kerningFor: gbox glyph)]
			     ifFalse: [0,0])]
]

TextBox fitContents
[
    extent := self naturalExtent.
]

TextBox naturalExtent
[
    | x y |
    x := y := 0.
    self do: [:g |
	x := x max: g position x + g extent x.
	y := y max: g position y + g extent y].
    ^x ceiling , y ceiling
]

"----------------"

String asText: aFont
[
    | text |
    text := TextBox new position: 0,0.
    self do: [:char | text add: (GlyphBox withGlyph: (aFont glyphAt: char))].
    ^text kernContents fitContents
]

String asText	[ ^self asText: Font default ]
