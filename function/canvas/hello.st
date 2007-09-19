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
