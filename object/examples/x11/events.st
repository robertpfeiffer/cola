{ import: st80 }
{ import: xwin }

[
    | dpy size win gc evt mask xwa |
    dpy  := X11Display open.
    size := 400@400.
    win  := dpy createWindow: (100@100 extent: size) borderWidth: 0 border: 0 background: (dpy whitePixel).
    xwa  := X11WindowAttributes new.
    xwa  eventMask: (X11Event anyEventMask bitXor: X11Event resizeRedirectMask).
    dpy  changeWindowAttributes: win mask: X11WindowAttributes cwEventMask attributes: xwa.
    dpy  mapWindow: win.
    gc   := win createGC.
    evt  := X11Event new.
    [evt isUnmapNotify or: [evt isKeyPress and: [(dpy keycodeToKeysym: evt) == X11Event xkEscape]]]
	whileFalse:
	   [dpy nextEvent: evt.
	    (evt isExpose or: [evt isConfigureNotify])
		ifTrue:
		   [evt isConfigureNotify ifTrue: [size := evt xconfigureExtent].
		    gc	setForeground: 0xe0e0e0;
			fillRectangle: (5@5 corner: (size - (5@5)));
			setForeground: 0x8080c0;
			drawString: 'unmap (iconify) me, or' at: 10@28;
			drawString: 'press ESCAPE, to exit.' at: 10@42;
			setForeground: 0xc0c080;
			fillRectangle: (50@50 corner: 100@100)].
	    evt name println.].
    dpy destroyWindow: win.
    dpy close.
]
