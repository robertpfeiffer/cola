{ import: st80 }

{ include "BitBltPlugin.c" }

SqueakBitBlt : Object ( _vmProxy combinationRule bitCount )

SqueakBitBlt combinationRule	[ ^combinationRule ]
SqueakBitBlt bitCount		[ ^bitCount ]

SqueakBitBlt withInterpreter: _proxy
{
    setInterpreter((struct VirtualMachine *)v__proxy);
    initialiseModule();
}

SqueakBitBlt copyBits
{
    primitiveCopyBits();
    self->v_combinationRule= (oop)(combinationRule << 1 | 1);
    self->v_bitCount= (oop)(bitCount << 1 | 1);
}
