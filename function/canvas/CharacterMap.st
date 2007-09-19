" CharacterMap.st -- translation between glyph names and code points

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

  Last edited: 2007-09-18 20:21:08 by piumarta on emilia
"

{ import: Object }

CharacterMap : Object ( namesToCodePoints codePointsToNames size )

CharacterMap withNames: names
[
    self := self new.
    self addNames: names.
]

CharacterMap new
[
    self := super new.
    namesToCodePoints := IdentityDictionary new.
    codePointsToNames := IdentityDictionary new.
    size              := 0.
]

CharacterMap addNames: names
[
    | codePoint |
    codePoint := 0.
    names do: [:nameOrInteger |
	codePoint := nameOrInteger isInteger
	    ifTrue:
		[nameOrInteger]
	    ifFalse:
		[self at: codePoint put: nameOrInteger.
		 codePoint + 1]].
]

CharacterMap at: codePoint put: name
[
    | nameSymbol |
    codePoint < 0 ifTrue: [^self].
    nameSymbol := name asSymbol.
    codePointsToNames at: codePoint put: nameSymbol.
    namesToCodePoints at: nameSymbol ifAbsentPut: codePoint.
    codePoint > size ifTrue: [size := codePoint].
]

CharacterMap size	[ ^size ]

CharacterMap includesCodePoint: codePoint	[ ^self nameAtCodePoint: codePoint ifAbsent: [] ]
CharacterMap includesName: name			[ ^self codePointAtName: name ifAbsent: [] ]

CharacterMap nameAtCodePoint: codePoint		[ ^self nameAtCodePoint: codePoint ifAbsent: [#'.notdef'] ]
CharacterMap codePointAtName: name		[ ^self codePointAtName: name ifAbsent: [0] ]

CharacterMap nameAtCodePoint: codePoint ifAbsent: errorBlock	[ ^codePointsToNames at: codePoint ifAbsent: errorBlock ]
CharacterMap codePointAtName: name ifAbsent: errorBlock		[ ^namesToCodePoints at: name asSymbol ifAbsent: errorBlock ]

CharacterMap_ISO8859_15 := [ CharacterMap withNames: #(
         "0"       "1"        "2"         "3"           "4"         "5"       "6"       "7"        "8"       "9"         "A"          "B"            "C"        "D"          "E"          "F"
    "0" '.notdef' '.notdef'  '.notdef'   '.notdef'     '.notdef'   '.notdef' '.notdef' '.notdef'  '.notdef' '.notdef'   '.notdef'    '.notdef'      '.notdef'  '.notdef'    '.notdef' 	 '.notdef'
    "1" '.notdef' '.notdef'  '.notdef'   '.notdef'     '.notdef'   '.notdef' '.notdef' '.notdef'  '.notdef' '.notdef'   '.notdef'    '.notdef'      '.notdef'  '.notdef'    '.notdef' 	 '.notdef'
    "2"   space     exclam     quotedbl    numbersign    dollar      percent   ampersand quoteright parenleft parenright  asterisk     plus           comma      minus        period       slash
    "3"   zero      one        two         three         four        five      six       seven      eight     nine        colon        semicolon      less       equal        greater      question
    "4"   at        A          B           C             D           E         F         G          H         I           J            K              L          M            N            O
    "5"   P         Q          R           S             T           U         V         W          X         Y           Z            bracketleft    backslash  bracketright asciicircum  underscore
    "6"   quoteleft a          b           c             d           e         f         g          h         i           j            k              l          m            n            o
    "7"   p         q          r           s             t           u         v         w          x         y           z            braceleft      bar        braceright   asciitilde '.notdef'
    "8" '.notdef' '.notdef'  '.notdef'   '.notdef'     '.notdef'   '.notdef' '.notdef' '.notdef'  '.notdef' '.notdef'   '.notdef'    '.notdef'      '.notdef'  '.notdef'    '.notdef'    '.notdef'
    "9" '.notdef' '.notdef'  '.notdef'   '.notdef'     '.notdef'   '.notdef' '.notdef' '.notdef'  '.notdef' '.notdef'   '.notdef'    '.notdef'      '.notdef'  '.notdef'    '.notdef'    '.notdef'
    "A"   space     exclamdown cent        sterling      Euro        yen       Scaron    section    scaron    copyright   ordfeminine  guillemotleft  logicalnot hyphen       registered   macron
    "B"   degree    plusminus  twosuperior threesuperior Zcaron      mu        paragraph bullet     zcaron    onesuperior ordmasculine guillemotright OE         oe           Ydieresis    questiondown
    "C"   Agrave    Aacute     Acircumflex Atilde        Adieresis   Aring     AE        Ccedilla   Egrave    Eacute      Ecircumflex  Edieresis      Igrave     Iacute       Icircumflex  Idieresis
    "D"   Eth       Ntilde     Ograve      Oacute        Ocircumflex Otilde    Odieresis multiply   Oslash    Ugrave      Uacute       Ucircumflex    Udieresis  Yacute       Thorn        germandbls
    "E"   agrave    aacute     acircumflex atilde        adieresis   aring     ae        ccedilla   egrave    eacute      ecircumflex  edieresis      igrave     iacute       icircumflex  idieresis
    "F"   eth       ntilde     ograve      oacute        ocircumflex otilde    odieresis divide     oslash    ugrave      uacute       ucircumflex    udieresis  yacute       thorn        ydieresis )
]

CharacterMap iso8859_15	[ ^CharacterMap_ISO8859_15 ]

CharacterMap default	[ ^CharacterMap_ISO8859_15 ]
