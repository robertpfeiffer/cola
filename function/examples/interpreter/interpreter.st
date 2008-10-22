{ import: Object }
{ import: interpret }

" Demonstrations... "

[
    | Point aPoint MyArray |

    Object _interpretedMethodAt: #testInterp0 put: #(push 'Hello, interpreted world!' send1 putln return).

    Object testInterp0.

    Object _interpretedMethodAt: #testInterp1 put: #(push 6 push 7 send2  * return).	"small nArgs"
    Object _interpretedMethodAt: #testInterp2 put: #(push 6 push 7 send 2 * return).	"arbitrary nArgs"

    Object testInterp1 println.
    Object testInterp2 println.

    Point := Object newSubtypeNamed: #Point withSlotNames: #( x y ).

    Point _interpretedMethodAt: #r put: #(
	self send1 x dup send2 *	" x^2 "
	self send1 y dup send2 *	" y^2 "
	send2 +				" x^2 + y^2 "
	send1 sqrt			" sqrt(x^2 + y^2) "
	return).

    Point _interpretedMethodAt: #scaleBy: put: #(
	self self send1 x arg1 send2 * send2 x: pop	" self x: self x * arg1 "
	self self send1 y arg1 send2 * send2 y: pop	" self y: self y * arg1 "
	self return).

    (aPoint := Point new) x: 3; y: 4.
    aPoint r println.
    aPoint scaleBy: 2.
    aPoint r println.

    #Fooble bePrototype: #(foo ble).
    Point _interpretedMethodAt: #testInterp3 put: #(pushGlobal Fooble return).
    Point testInterp3 println.

    MyArray := Array newSubtypeNamed: #MyArray withSlotNames: #( mySlot ).
    MyArray debugName println.
    Array   allSlotNames println.
    MyArray allSlotNames println.
    MyArray sizeof println.
    MyArray mySlot: 12345.
    MyArray mySlot println.
    MyArray := MyArray withNewSlotNamed: #anotherSlot.
    MyArray debugName println.
    MyArray allSlotNames println.
    MyArray sizeof println.
    MyArray mySlot println.
    MyArray anotherSlot println.

    Integer _interpretedMethodAt: #nfibs put: #(
	self push 2 send2 < brf 3
	push 1 return
	self push 1 send2 - send1 nfibs
	self push 2 send2 - send1 nfibs
	push 1 send2 + send2 + return).

    (Time millisecondsToRun: [23 nfibs println]) println.
    "about 100,000 sends/second on my Q9450, compiled -O -g"
    "about 300,000 sends/second compiled -Op"
]
