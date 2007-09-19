" hello.st -- not-quite-the-simplest graphical hello world program

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

  Last edited: 2007-09-18 20:10:37 by piumarta on emilia
"

{ import: View }
{ import: Text }

[
    WorldView new
	fillColour: (Colour withR: 0.4 G: 0.6 B: 0.8);
	add: ((('Hello world' asCompositeViewWithFont: (Font serif bold pointSize: 72)) translateBy: 100,260)
		  propertyAt: #pointerDownEvent put: [:v :event | event handler beginDragging: v from: event];
		  yourself);
	propertyAt: #pointerUpEvent put: [:v :e | OS exit: 0];
	open: 800,600;
	run
]
