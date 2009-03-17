" main.st -- Quick User Interface Clumsily Hacked for Editing

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

  Last edited: 2009-03-17 10:48:30 by piumarta on emilia.local
"

{ import: Box }
{ import: TextEditor }

[
    | argv fileName content present window w h frame face text name editor |

    w := 612.
    h := 792.
    fileName := 'file name'.
    argv := OS arguments.
    [argv isEmpty]
	whileFalse:
	   [| arg |
	    arg := argv removeFirst.
	    arg = '-present'
		ifTrue:  [present := true]
		ifFalse:
		   [arg = '-landscape'
			ifTrue:  [| t | t := h.  h := w.  w := t]
			ifFalse:
			   [| file |
			    (file := File open: arg ifAbsent: [File open: arg , '.doq'])
				ifTrue:
				   [content := file contents.
				    fileName := arg.
				    file close]]]].
    content ifFalse: [content := SampleText].
    face := #Times roman @ 14.
    window := Window withExtent: (present ifTrue: [ w , h] ifFalse: [(w + 56) , (h - 6)]).
    present ifTrue: [window backgroundColour: ColourWhite].
    window addFirst: ((Box withBounds: (52,(present ifTrue: [0] ifFalse: [26]) extent: (w) , (h - 36)))
			  backgroundColour: ColourWhite;
			  addFirst: ((text := Box withBounds: (present
								   ifTrue:  [ 0,36 extent:  w       , (h - 108)]
								   ifFalse: [36,36 extent: (w - 72) , (h - 108)]))
					 backgroundColour: ColourWhite;
					 borderWidth: 10;
					 addLast: (content asParagraph: text))).
    editor := text propertiesAt: #editor.
    present
	ifFalse:
	   [window
		addLast: ((frame := Box new) width: (w + 48);
			      height: 16; depth: 2; backgroundColour: ColourWhite; moveTo: 4, 4;
			      addLast: ((name := fileName asText) beEditable: frame));
		addLast: (Box new vBox width: 1; moveTo: 4, 26;
			      addLast: (' load '   asText beButton: [editor := editor load: text as: name]);
			      smallSep;
			      addLast: (' save '   asText beButton: [editor save: text as: name]);
			      smallSep;
			      addLast: (' image '  asText beButton: [editor loadBMP: text as: name]);
			      smallSep;
			      addLast: (' print '  asText beButton: [editor print: text as: name]);
			      bigSep;
			      addLast: (' Times '  asText beButton: [editor applyFamily: #Times]);
			      addLast: (' Helv   ' asText beButton: [editor applyFamily: #Helvetica]);
			      addLast: (' Cour   ' asText beButton: [editor applyFamily: #Courier]);
			      smallSep;
			      addLast: (' bold '   asText beButton: [editor xBold]);
			      addLast: (' italic ' asText beButton: [editor xSlanted]);
			      smallSep;
			      addLast: ('   8pt '  asText beButton: [editor applySize:  8]);
			      addLast: ('   9pt '  asText beButton: [editor applySize:  9]);
			      addLast: (' 10pt '   asText beButton: [editor applySize: 10]);
			      addLast: (' 11pt '   asText beButton: [editor applySize: 11]);
			      addLast: (' 12pt '   asText beButton: [editor applySize: 12]);
			      addLast: (' 14pt '   asText beButton: [editor applySize: 14]);
			      addLast: (' 16pt '   asText beButton: [editor applySize: 16]);
			      addLast: (' 18pt '   asText beButton: [editor applySize: 18]);
			      addLast: (' 20pt '   asText beButton: [editor applySize: 20]);
			      addLast: (' 24pt '   asText beButton: [editor applySize: 24]);
			      addLast: (' 28pt '   asText beButton: [editor applySize: 28]);
			      addLast: (' 34pt '   asText beButton: [editor applySize: 34]);
			      addLast: (' 40pt '   asText beButton: [editor applySize: 40]);
			      bigSep;
			      addLast: (' info '   asText beButton: [editor printInfo]);
			      bigSep;
			      addLast: (' quit '   asText beButton: [OS exit: 0]);
			      yourself)].
    window
	layOut;
	draw;
	mainLoop.
]

{ include <SDL/SDL_main.h> }
