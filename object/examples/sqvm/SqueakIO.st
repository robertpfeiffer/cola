{ import: st80 }

{ include "io-common.c" }

SqueakIO : Object ()

SqueakIO initialize
[
    super initialize.
    {
	ioInitialise();
    }
]

SqueakIO mSecs
{
    return (oop)(ioMilliSecs() << 1 | 1);
}

SqueakIO lowResMSecs
{
    return (oop)(ioMilliSecs() << 1 | 1);
}

SqueakIO mousePoint
{
    return (oop)((mouseX << 16 | mouseY) << 1 | 1);
}

SqueakIO getButtonState
{
    return (oop)(buttonState << 1 | 1);
}

SqueakIO getKeystroke: remove
{
    return (oop)(ioGetKeystroke((int)v_remove) << 1 | 1);
}

SqueakIO hasDisplayDepth: depth
{
    return (oop)(ioHasDisplayDepth((int)depth >> 1) ? v_self : 0);
}

SqueakIO showDisplayBits_: _bits width_: _w height_: _h depth_: _d left_: _l top_: _t right_: _r bottom_: _b
{
    ioShowDisplayBits((uint32_t *)v__bits, (int)v__w, (int)v__h, (int)v__d, (int)v__l, (int)v__t, (int)v__r, (int)v__b);
}

SqueakIO forceDisplayUpdate
{
    ioForceDisplayUpdate();
}

SqueakIO setCursor: cursorBits withMask: maskBits offsetX: offsetX offsetY: offsetY
[
    self setCursor_: cursorBits _words withMask_: maskBits _words offsetX_: offsetX _integerValue  offsetY_: offsetY _integerValue
]

SqueakIO setCursor_: _cursor withMask_: _mask offsetX_: _x offsetY_: _y
{
    ioSetCursorWithMask((uint32_t *)v__cursor, (uint32_t *)v__mask, (int)v__x, (int)v__y);
}

SqueakIO relinquishProcessor: microSecs
{
    ioRelinquishProcessor((int)v_microSecs >> 1);
}

SqueakIO processEvents
{
    ioProcessEvents(0);
}
