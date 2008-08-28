{ import: Object }
{ import: Text }
{ import: TextLayout }
{ import: Box }
{ import: SDLSurface }
{ include "SDL_main.h" }

{ import: debug }

"----------------------------------------------------------------"

SampleText1 := ['You''re obliged to pretend respect for people and institutions you think absurd. You live attached in a cowardly fashion to moral and social conventions you despise, condemn, and know lack all foundation. It is that permanent contradiction between your ideas and desires and all the dead formalities and vain pretenses of your civilization which makes you sad, troubled and unbalanced. That''s the poisoned and mortal wound of the civilized world. -- Octave Mirbeau']

SampleText := ['The worship of money is the lowest of all human emotions, but it is shared not only by the bourgeoisie but also by the great majority of us: Little people, humble people, even those who are practically penniless. And I, with all my indignation, all my passion for destruction, I, too, am not free of it. I who am oppressed by wealth, who realise it to be the source of all misery, all my vices and hatred, all the bitterest humiliations that I have to suffer, all my impossible dreams and all the endless torment of my existence, still, all the time, as soon as I find myself in the presence of a rich person, I cannot help looking up to him, as some exceptional and splendid being, a kind of marvelous divinity, and in spite of myself, stronger than either my will or my reason, I feel rising from the very depths of my being, a sort of incense of admiration for this wealthy creature, who is all too often as stupid as he is pitiless. Isn''t it crazy? And why... why? - Octave Mirbeau']

TitleFont := [ (Face named: 'arialbd') fontAt: 16 ]

"----------------"

FrameMoveHandler : EventHandler ( frame )

FrameMoveHandler withFrame: aBox
[
    self := self new.
    frame := aBox.
]

FrameMoveHandler buttonDown :anEvent
[
    frame raise.
    anEvent hand addEventHandler: self.
]

FrameMoveHandler motion :anEvent	[ frame position: frame position + anEvent delta ]
FrameMoveHandler buttonUp :anEvent	[ anEvent hand removeEventHandler: self ]

"----------------"

FrameSizeHandler : EventHandler ( frame reference )

FrameSizeHandler withFrame: aBox
[
    self := self new.
    frame := aBox.
]

FrameSizeHandler buttonDown :anEvent
[
    frame raise.
    reference := anEvent position - frame extent.
    anEvent hand addEventHandler: self.
]

FrameSizeHandler motion :anEvent	[ frame extent: anEvent position - reference ]
FrameSizeHandler buttonUp :anEvent	[ anEvent hand removeEventHandler: self ]

"----------------"

FrameCloseHandler : EventHandler ( frame target )

FrameCloseHandler withFrame: aBox
[
    self := self new.
    frame := aBox.
]

FrameCloseHandler buttonDown :anEvent
[
    target := anEvent target.
    anEvent hand addEventHandler: self.
]

FrameCloseHandler buttonUp :anEvent
[
    anEvent hand removeEventHandler: self.
    anEvent target == target ifTrue: [frame removeFromList].
]

"----------------"

FrameBox : Box ( title resizer closer content )

FrameBox with: aBox title: titleString
[
    self := self new background: ColorGray25.
    self addFront: (title := (titleString asText: TitleFont) position: 4,2; foreground: (Color gray: 95)).
    self addFront: (closer := Box new extent: (title extent y - 6) , (title extent y - 6); background: ColorRed).
    self addFront: (resizer := Box new extent: 8,8; background: self background).
    self addFront: (content := aBox position: 2, (2 + title extent y + 2)).
    self extent: (2 + aBox extent x + 2) , (2 + title extent y + 2 + aBox extent y + 2).
    self    buttonDown: (FrameMoveHandler  withFrame: self).
    closer  buttonDown: (FrameCloseHandler withFrame: self).
    resizer buttonDown: (FrameSizeHandler  withFrame: self).
]

FrameBox extent: aPoint
[
    super extent: aPoint.
    closer position: (aPoint x - title extent y) , 5.
    resizer position: aPoint - (8,8).
    content extent: (aPoint x - 4) , (aPoint y - 2 - title extent y - 2 - 2).
]

Box title: aString	[ ^FrameBox with: self title: aString ]

"----------------------------------------------------------------"

Window boxLayoutExample
[
    | box |
    box := Box new.
    512 timesRepeat: [box add: (Box new extent: 8,8)].
    self addFront: ((box layout:     SimpleLayout;
			 extent:     300,200;
			 border:     ColorWhite;
			 background: ColorGray25;
			 title:      'Box Layout')
			position: hand position).
]

Window simpleTextExample
[
    | box |
    box := SampleText asText: ((Face named: 'profontwindows') fontAt: 18).
    self addFront: ((box layout:     SimpleLayout;
			 extent:     800,500;
			 foreground: ColorBlack;
			 background: ColorWhite;
			 border:     ColorGray75;
			 title:      'Box Layout Text')
			position: hand position).
]

Window kernedTextExample
[
    | box |
    box := SampleText asText: ((Face named: 'verdana') fontAt: 12).
    self addFront: ((box layout:     KerningLayout;
			 extent:     800,500;
			 foreground: ColorBlack;
			 background: ColorWhite;
			 border:     ColorGray75;
			 title:      'Kerned')
			position: hand position).
]

Window justifiedTextExample
[
    | box |
    self addFront: (((TextLayout target: (SampleText asText: ((Face named: 'verdana') fontAt: 12)))
			 layout:     TextLayout;
			 extent:     400,300;
			 background: (Color gray: 99);
			 foreground: (Color gray: 10);
			 title:     'Justified')
			position: hand position).
]

Window textProperties
[
    | box fg bg fn |
    fn := (Face named: 'MacType') fontAt: 32.
    fg := ColorBlack.
    bg := Color gray: 90.
    (box := Box new)
	add: (Box newButton: ' glue+ '  action: [:ev | TextLayout incrGlue]);
	add: (Box newButton: ' glue- '  action: [:ev | TextLayout decrGlue]);
	add: (Box newButton: ' plus+ '  action: [:ev | TextLayout incrPlus]);
	add: (Box newButton: ' plus- '  action: [:ev | TextLayout decrPlus]);
	add: (Box newButton: ' minus+ ' action: [:ev | TextLayout incrMinus]);
	add: (Box newButton: ' minus- ' action: [:ev | TextLayout decrMinus]);
	add: (Box newButton: ' loose+ ' action: [:ev | TextLayout incrLoose]);
	add: (Box newButton: ' loose- ' action: [:ev | TextLayout decrLoose]);
	beMenu.
    self addFront: ((box position:   200,200;
			 extent:     200,400;
			 foreground: fg;
			 background: bg;
			 border:     ColorGray75;
			 title:      'Text Properties')
			position: hand position).
]

[
    | window menu |
    window := Window new: 1024,768.
    window add: ((Box newButton: 'press me' action: [:ev | StdOut nextPutAll: 'OUCH!\n']) position: 200,200).
    window buttonDown: (MenuHandler new
			    label: 'box layout'       action: [:anEvent | anEvent window boxLayoutExample];
			    label: 'text layout'      action: [:anEvent | anEvent window simpleTextExample];
			    label: 'kerned layout'    action: [:anEvent | anEvent window kernedTextExample];
			    label: 'justified layout' action: [:anEvent | anEvent window justifiedTextExample];
			    label: 'text properties'  action: [:anEvent | anEvent window textProperties];
			    label: 'quit'             action: [:anEvent | OS exit: 0]).
    [window draw; dispatchEvent: window nextEvent] repeat.
]
