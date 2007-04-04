" VPU-i386 -- x86 instruction generator for VPU

  Copyright (c) 2006, 2007 Ian Piumarta
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

  Last edited: 2007-04-03 18:34:10 by piumarta on alan-kays-computer.local
"

{ input: VPU-common }

{ include "asm-i386.h" }

VPU targetString	[ ^'i386 generic' ]

VPU _asmPass		{ return (oop)asm_pass; }
VPU _asmPass_: _n	{ return (oop)(asm_pass= (long)v__n); }
VPU _asmPC		{ return (oop)asm_pc; }
VPU _asmPC_: _n		{ return (oop)(asm_pc= (void *)v__n); }

VPU linkageSize		[ ^8 ]

VPU allocateFrame
[
    tempBase  := paramCount  * 4.
    stackBase := tempCount  * 4 + tempBase.
    frameSize := (paramCount + tempCount + stackCount) * 4 + self linkageSize + 15 bitAnd: 0xffff0.
    argBase   := frameSize.	"args relative to %esp"
]

IEnter	emit: vpu
[
    | frameSize |
    frameSize := vpu frameSize.
    { 
	PUSHLr	(_EBP);
	MOVLrr	(_ESP, _EBP);
	SUBLir	((((long)v_frameSize >> 1) - 8), _ESP);

#	define ARG()	(((long)self->v_argLocation >> 1)	   )
#	define TMP()	(((long)self->v_tmpLocation >> 1)	   )
#	define LOC(N)	(((long)self->v_location    >> 1) + ((N)*4))
    }.
]

Ret	emit: vpu	{ MOVLmr	(	LOC(1),_ESP,0,0, _EAX);
			  LEAVE		();
			  RET		(); }

ITmp	emit: vpu	{ MOVLim	(0, TMP(),_ESP,0,0); }

LdFP	emit: vpu	[ | _loc | _loc := (vpu frameSize - 8) _integerValue.
			{ LEALmr	((long)v__loc,_ESP,0,0, _EAX);
			  MOVLrm	(_EAX, LOC(0),_ESP,0,0	    ); } ]

LdInt	emit: vpu	[ | _int | _int := value _integerValue.
			{ MOVLim	((long)v__int, LOC(0),_ESP,0,0); } ]

LdPtr	emit: vpu	{ MOVLim	((long)self->v_value	 , LOC(0),_ESP,0,0); }

AddrArg	emit: vpu	{ LEALmr	(	ARG( ),_ESP,0,0, _EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

LdArg	emit: vpu	{ MOVLmr	(	ARG( ),_ESP,0,0, _EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

StArg	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  MOVLrm	(_EAX,	ARG( ),_ESP,0,0	     ); }

AddrTmp	emit: vpu	{ LEALmr	(	TMP( ),_ESP,0,0, _EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

LdTmp	emit: vpu	{ MOVLmr	(	TMP( ),_ESP,0,0, _EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

StTmp	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  MOVLrm	(_EAX,	TMP( ),_ESP,0,0	     ); }

Dup	emit: vpu	{ MOVLmr	(      LOC(-1),_ESP,0,0, _EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

Rdb	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  MOVZBLmr	(	   (0),_EAX,0,0, _EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

Rdh	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  MOVZWLmr	(	   (0),_EAX,0,0, _EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

Rdw	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  MOVLmr	(	   (0),_EAX,0,0, _EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

Wrb	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  MOVLmr	(	LOC(1),_ESP,0,0, _ECX);
			  MOVBrm	(_AL,	   (0),_ECX,0,0	     ); }

Wrh	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  MOVLmr	(	LOC(1),_ESP,0,0, _ECX);
			  MOVWrm	(_AX,	   (0),_ECX,0,0	     ); }

Wrw	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  MOVLmr	(	LOC(1),_ESP,0,0, _ECX);
			  MOVLrm	(_EAX,	   (0),_ECX,0,0	     ); }

Add	emit: vpu	{ MOVLmr	(	LOC(1),_ESP,0,0, _EAX);
			  ADDLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

Sub	emit: vpu	{ MOVLmr	(	LOC(1),_ESP,0,0, _EAX);
			  SUBLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

Mul	emit: vpu	{ MOVLmr	(	LOC(1),_ESP,0,0, _EAX);
			  IMULLmr	(	LOC(0),_ESP,0,0, _EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

Div	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  CLTD		();
			  IDIVLmr	(	LOC(1),_ESP,0,0, _EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

Mod	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  CLTD		();
			  IDIVLmr	(	LOC(1),_ESP,0,0, _EAX);
			  MOVLrm	(_EDX,	LOC(0),_ESP,0,0	     ); }

And	emit: vpu	{ MOVLmr	(	LOC(1),_ESP,0,0, _EAX);
			  ANDLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

Or	emit: vpu	{ MOVLmr	(	LOC(1),_ESP,0,0, _EAX);
			  ORLrm		(_EAX,	LOC(0),_ESP,0,0	     ); }

Xor	emit: vpu	{ MOVLmr	(	LOC(1),_ESP,0,0, _EAX);
			  XORLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

Lsl	emit: vpu	{ MOVLmr	(	LOC(1),_ESP,0,0, _ECX);
			  SHLLrm	(_CL,	LOC(0),_ESP,0,0	     ); }

Lsr	emit: vpu	{ MOVLmr	(	LOC(1),_ESP,0,0, _ECX);
			  SHRLrm	(_CL,	LOC(0),_ESP,0,0	     ); }

Asr	emit: vpu	{ MOVLmr	(	LOC(1),_ESP,0,0, _ECX);
			  SARLrm	(_CL,	LOC(0),_ESP,0,0	     ); }

Lt	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  CMPLmr	(	LOC(1),_ESP,0,0, _EAX);
			  SETLr		(_AL);
			  MOVZBLrr	(_AL,	_EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0); }

Le	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  CMPLmr	(	LOC(1),_ESP,0,0, _EAX);
			  SETLEr	(_AL);
			  MOVZBLrr	(_AL,	_EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0); }

Eq	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  CMPLmr	(	LOC(1),_ESP,0,0, _EAX);
			  SETEr		(_AL);
			  MOVZBLrr	(_AL,	_EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0); }

Ne	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  CMPLmr	(	LOC(1),_ESP,0,0, _EAX);
			  SETNEr	(_AL);
			  MOVZBLrr	(_AL,	_EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0); }

Ge	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  CMPLmr	(	LOC(1),_ESP,0,0, _EAX);
			  SETGEr	(_AL);
			  MOVZBLrr	(_AL,	_EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0); }

Gt	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  CMPLmr	(	LOC(1),_ESP,0,0, _EAX);
			  SETGr		(_AL);
			  MOVZBLrr	(_AL,	_EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0); }

Not	emit: vpu	{ XORLrr	(_EAX,	_EAX);
			  CMPLim	(0,	LOC(0),_ESP,0,0);
			  SETEr		(_AL);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0); }

Br	emit: vpu
[
    | _addr |
    _addr := label _address.	{ JMPm		(v__addr,0,0,0); }
]

Bt	emit: vpu
[
    | _addr |
    _addr := label _address.	{ CMPLim	(0,	LOC(1),_ESP,0,0);
				  JNEm		(	  v__addr,0,0,0); }
]

Bf	emit: vpu
[
    | _addr |
    _addr := label _address.	{ CMPLim	(0,	LOC(1),_ESP,0,0);
				  JEm		(	  v__addr,0,0,0); }
]

ICall	emit: vpu
[
    | _addr |
    _addr := label _address.
    {
	int arity= (long)self->v_arity >> 1;
	int i;
	for (i= 0;  i < arity;	++i) {	MOVLmr	(	LOC(arity - i - 1),_ESP,0,0, _EAX);
					MOVLrm	(_EAX,	   (	    4 * i),_ESP,0,0	 );  }
				  CALLm		(		   v__addr,0   ,0,0	 );
				  MOVLrm	(_EAX,	LOC(		0),_ESP,0,0	 );
    }.
]

ICalli	emit: vpu
[
    {
	int arity= (long)self->v_arity >> 1;
	int i;
	for (i= 0;  i < arity;	++i) {	MOVLmr	(	LOC(arity - i - 1),_ESP,0,0, _EAX);
					MOVLrm	(_EAX,	   (	    4 * i),_ESP,0,0	 );  }
				  MOVLmr	(	LOC(arity	 ),_ESP,0,0, _EAX);
				  CALLm		(	   (		0),_EAX,0,0	 );
				  MOVLrm	(_EAX,	LOC(		0),_ESP,0,0	 );
    }.
]

" fixed-point arithmetic ---------------------------------------------------------------- "

FixMul	emit: vpu	{ MOVLmr	(	LOC(1),_ESP,0,0, _EAX);
			  IMULLm	(	LOC(0),_ESP,0,0);
			  SHLLir	(16,	_EDX);
			  SHRLir	(16,	_EAX);
			  ORLrr		(_EDX,	_EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0); }

FixDiv	emit: vpu	{ MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  MOVLrr	(_EAX,	_EDX);
			  SHLLir	(16,	_EAX);
			  SARLir	(16,	_EDX);
			  IDIVLmr	(	LOC(1),_ESP,0,0, _EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

" saturated arithmetic ---------------------------------------------------------------- "

PixAdd	emit: vpu	{ MOVLmr	(	LOC(1),_ESP,0,0, _EAX);
			  MOVDrq	(_EAX,	_MM1);
			  MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  MOVDrq	(_EAX,	_MM0);
			  PADDUSBqq	(_MM1,	_MM0);
			  MOVDqr	(_MM0,	_EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

PixSub	emit: vpu	{ MOVLmr	(	LOC(1),_ESP,0,0, _EAX);
			  MOVDrq	(_EAX,	_MM1);
			  MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  MOVDrq	(_EAX,	_MM0);
			  PSUBUSBqq	(_MM1,	_MM0);
			  MOVDqr	(_MM0,	_EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

PixMul	emit: vpu	{ MOVLmr	(	LOC(1),_ESP,0,0, _EAX);
			  MOVDrq	(_EAX,	_MM1);
			  MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  MOVDrq	(_EAX,	_MM0);
			  PMULLWqq	(_MM1,	_MM0);
			  MOVDqr	(_MM0,	_EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

" Porter-Duff pixel operations ---------------------------------------------------------------- "

" C' = Csrc * Amsk
  A' = Asrc * Amsk "

PixIn	emit: vpu	{ PXORqq	(_MM0,	_MM0);	/* mm0 := 0 */
			  /* mm1 := source pixel */
			  MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  MOVDrq	(_EAX,	_MM1);
			  /* mm2 := mask alpha channel replicated 8.8.8.8 */
			  XORLrr	(_EAX,	_EAX);
			  MOVBmr	(	LOC(1),_ESP,0,0, _AL);
			  MOVBrr	(_AL,	_AH);
			  MOVLrr	(_EAX,	_ECX);
			  SHLLir	(16,	_ECX);
			  ORLrr		(_ECX,	_EAX);
			  MOVDrq	(_EAX,	_MM2);
			  /* source, mask 8.8.8.8 -> 16.16.16.16 */
			  PUNPCKLBWqq	(_MM0,	_MM1);
			  PUNPCKLBWqq	(_MM0,	_MM2);
			  /* source pixel *= mask */
			  PMULLWqq	(_MM2,	_MM1);
			  /* source pixel += 0x80808080 unpacked 16.16.16.16 */
			  MOVLir	(0x80808080, _EAX);
			  MOVDrq	(_EAX,	_MM2);
			  PUNPCKLBWqq	(_MM0,	_MM2);
			  PADDUSWqq	(_MM2,	_MM1);
			  /* mm2 := source pixel */
			  MOVQqq	(_MM1,	_MM2);
			  /* source pixel += source pixel / 256 */
			  PSRLWiq	(8,	_MM2);
			  PADDUSWqq	(_MM2,	_MM1);
			  /* source pixel /= 256 */
			  PSRLWiq	(8,	_MM1);
			  /* source pixel 16.16.16.16 -> 8.8.8.8 */
			  PACKUSWBqq	(_MM1,	_MM1);
			  /* store result */
			  MOVDqr	(_MM1,	_EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

" C' = Csrc + Cdst * (1 - Asrc)
  A' = Asrc + Adst * (1 - Asrc) "

PixOver	emit: vpu	{ PXORqq	(_MM0,	_MM0);	/* mm0 := 0 */
			  /* mm1 := source pixel */
			  MOVLmr	(	LOC(0),_ESP,0,0, _EAX);
			  MOVDrq	(_EAX,	_MM1);				/* mm1 = src */
			  XORLrr	(_EAX,	_EAX);
			  MOVBmr	(	LOC(0),_ESP,0,0, _AL);
			  NOTBr		(_AL);					/* al  = 1 - Asrc */
			  MOVBrr	(_AL,	_AH);				/* ax  = 1 - Asrc (8.8) */
			  MOVLrr	(_EAX,	_ECX);
			  SHLLir	(16,	_ECX);
			  ORLrr		(_ECX,	_EAX);				/* eax = 1 - Asrc (8.8.8.8) */
			  MOVDrq	(_EAX,	_MM2);				/* mm2 = 1 - Asrc */
			  PUNPCKLBWqq	(_MM0,	_MM2);				/* mm2 = 1 - Asrc [16] */
			  /* mm3 := dest pixel */
			  MOVLmr	(	LOC(1),_ESP,0,0, _EAX);
			  MOVDrq	(_EAX,	_MM3);				/* mm3 = dst */
			  PUNPCKLBWqq	(_MM0,	_MM3);				/* mm3 = dst [16] */
			  PMULLWqq	(_MM3,	_MM2);				/* mm2 = dst * (1 - Asrc) */
			  /* round */
			  MOVLir	(0x80808080, _EAX);
			  MOVDrq	(_EAX,	_MM3);
			  PUNPCKLBWqq	(_MM0,	_MM3);
			  PADDUSWqq	(_MM3,	_MM2);				/* mm2 = dst * (1 - Asrc) + 0x80 */
			  MOVQqq	(_MM2,	_MM3);
			  PSRLWiq	(8,	_MM3);
			  PADDUSWqq	(_MM3,	_MM2);				/* mm2 = dst * (1 - Asrc) + 0x80 + (dst * (1 - Asrc) / 256) */
			  PSRLWiq	(8,	_MM2);
			  PACKUSWBqq	(_MM2,	_MM2);
			  PADDUSBqq	(_MM2,	_MM1);				/* mm2 = src + dst * (1 - Asrc) rounded */
			  /* store result */
			  MOVDqr	(_MM1,	_EAX);
			  MOVLrm	(_EAX,	LOC(0),_ESP,0,0	     ); }

"----------------------------------------------------------------"

VPU flush_: _first to_: _last	{ iflush((insn *)v__first, (insn *)v__last); }


{ (void)_W; (void)_D1; (void)_D4; }	"defined but not used"

"----------------------------------------------------------------"

"{ import: VPU-i386-dsm }"

VPU disassemble_: _first to_: _last	[]
