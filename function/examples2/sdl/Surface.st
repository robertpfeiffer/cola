{ import: Objects }

Surface : Object ( width height )

Surface new: dimensions
[
    ^self platformSurface new: dimensions
]

Surface basicNew: dimensions
[
    self := super new.
    width := dimensions x rounded.
    height := dimensions y rounded.
]

Surface width	[ ^width ]
Surface height	[ ^height ]
Surface extent	[ ^width,height ]

"----------------------------------------------------------------"

DrawingContext : Object ( surface )

DrawingContext new: aSurface
[
    ^self platformDrawingContext new: aSurface
]

DrawingContext basicNew: aSurface
[
    self := super new.
    surface := aSurface.
]

Surface newContext
[
    ^DrawingContext new: self
]

DrawingContext flush	[ surface flush ]

"----------------------------------------------------------------"

Image : Object ( width height )

Image fromLuminanceMap_: _bits width: w pitch: p height: h
[
    ^self platformImage basicFromLuminanceMap_: _bits width: w pitch: p height: h
]

Image basicNew: extent
[
    self := super new.
    width := extent x.
    height := extent y.
]

Image drawOn: aContext	[ aContext drawImage: self ]
