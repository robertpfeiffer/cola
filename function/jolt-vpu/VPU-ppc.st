{ include: VPU-common }

{ include "asm-ppc.h" }

VPU targetString	[ ^'PowerPC generic' ]

VPU _asmPass		{ return (oop)asm_pass; }
VPU _asmPass_: _n	{ return (oop)(asm_pass= (long)v__n); }
VPU _asmPC		{ return (oop)asm_pc; }
VPU _asmPC_: _n		{ return (oop)(asm_pc= (void *)v__n); }

VPU linkageSize		[ ^24 ]

VPU allocateFrame
[
    paramCount := 8 max: paramCount.	"always leave space for 8 arg registers"
    tempBase   := 24       + (4 * paramCount).
    stackBase  := tempBase + (4 * tempCount).
    frameSize  := (24 + (4 * (paramCount + tempCount + stackCount))) + 15 bitAnd: 0xffff0.
    argBase    := frameSize + 24.	"args relative to r1"
]

" |                 |
  +-----------------+
  | parameter  area |
  +-----------------+
  |  linkage  area  |
  +=================+ <- SP + 24 + (4 * paramCount + tempCount + registerCount)
  | saved registers |
  +-----------------+ <- SP + 24 + (4 * paramCount + tempCount)
  | local variables |
  +-----------------+ <- SP + 24 + (4 * paramCount)
  | parameter  area |
  +-----------------+ <- SP + 24
  |    reserved     |
  |    reserved     |
  |    reserved     |
  |       LR        |
  |       CCR       |
  |       SP'       | <- SP
  +=================+
  |                 | "

IEnter	emit: vpu
[
    | frameSize |
    frameSize := vpu frameSize.
    { 
	MFLRr	(0);
	STWrm	(0, 8, 1);
	STWUrm	(1, -((long)v_frameSize >> 1), 1);

#	define ARG()	(((long)self->v_argLocation >> 1) 	   )
#	define TMP()	(((long)self->v_tmpLocation >> 1)	   )
#	define LOC(N)	(((long)self->v_location    >> 1) + ((N)*4))
#	define OUT(N)	(24 + (4 * (N)))
#	define Bx_RANGE		0x02000000
#	define BCx_RANGE	0x00008000
    }
]

IArg	emit: vpu
[
    | frameSize |
    frameSize := vpu frameSize.
    { 
	long frameSize= (long)v_frameSize >> 1;
	long arg= (long)self->v_index >> 1;
        if (arg < 8) {
	    STWrm	(3+arg,	(frameSize + OUT(arg)), 1);
	}
    }
]

Ret	emit: vpu
[
    | frameSize |
    frameSize := vpu frameSize.
    { 
	LWZrm	(3,	LOC(1), 1);
	LWZrm	(0,	((long)v_frameSize >> 1) + 8, 1);
	MTLRr	(0);
	ADDIrri	(1, 1,	((long)v_frameSize >> 1));
	BLR	();
    }
]

ITmp	emit: vpu	{ LIri		(0,	0);
			  STWrm		(0,	TMP(), 1); }

LdFP	emit: vpu	[ | _loc | _loc := vpu frameSize _integerValue.
			{ LArm		(3,	(long)v__loc, 1);
			  STWrm		(3,	LOC(0), 1); } ]

LdInt	emit: vpu	[ | _int | _int := value _integerValue.
			{ long val= (long)v__int;
			  if (-0x8000 <= val && val < 0x8000) {
			    LIri	(3,	  val);
			  } else {
			    long lo= val & 0xffff;
			    long hi= val >> 16;
			    LISri	(3,	   hi);
			    ORIrri	(3,	3, lo);
			  }
			  STWrm		(3,	LOC(0), 1); } ]

LdPtr	emit: vpu	{ long val= (long)self->v_value;
			  long lo= val & 0xffff;
			  long hi= val >> 16;
			  LISri		(3,	   hi);
			  ORIrri	(3,	3, lo);
			  STWrm		(3,	LOC(0), 1); }

LdArg	emit: vpu	{ LWZrm		(3,	ARG( ), 1);
			  STWrm		(3,	LOC(0), 1); }

StArg	emit: vpu	{ LWZrm		(3,	LOC(0), 1);
			  STWrm		(3,	ARG( ), 1); }

LdTmp	emit: vpu	{ LWZrm		(3,	TMP( ), 1);
			  STWrm		(3,	LOC(0), 1); }

StTmp	emit: vpu	{ LWZrm		(3,	LOC(0), 1);
			  STWrm		(3,	TMP( ), 1); }

Dup	emit: vpu	{ LWZrm		(3,	LOC(-1), 1);
			  STWrm		(3,	LOC( 0), 1); }

Rdb	emit: vpu	{ LWZrm		(3,	LOC(0), 1);
			  LBZrm		(3,	   (0), 3);
			  STWrm		(3,	LOC(0), 1); }

Rdh	emit: vpu	{ LWZrm		(3,	LOC(0), 1);
			  LHZrm		(3,	   (0), 3);
			  STWrm		(3,	LOC(0), 1); }

Rdw	emit: vpu	{ LWZrm		(3,	LOC(0), 1);
			  LWZrm		(3,	   (0), 3);
			  STWrm		(3,	LOC(0), 1); }

Wrb	emit: vpu	{ LWZrm		(3,	LOC(0), 1);
			  LWZrm		(4,	LOC(1), 1);
			  STBrm		(3,	   (0), 4); }

Wrh	emit: vpu	{ LWZrm		(3,	LOC(0), 1);
			  LWZrm		(4,	LOC(1), 1);
			  STHrm		(3,	   (0), 4); }

Wrw	emit: vpu	{ LWZrm		(3,	LOC(0), 1);
			  LWZrm		(4,	LOC(1), 1);
			  STWrm		(3,	   (0), 4); }

Add	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  ADDrrr	(3, 3,	4);
			  STWrm		(3,	LOC(0), 1); }

Sub	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  SUBrrr	(3, 3,	4);
			  STWrm		(3,	LOC(0), 1); }

Mul	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  MULLWrrr	(3, 3,	4);
			  STWrm		(3,	LOC(0), 1); }

Div	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  DIVWrrr	(3, 3,	4);
			  STWrm		(3,	LOC(0), 1); }

Mod	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  DIVWrrr	(0, 3,	4);
			  MULLWrrr	(0, 0,	4);
			  SUBFrrr	(3, 0,	3);
			  STWrm		(3,	LOC(0), 1); }

And	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  ANDrrr	(3, 3,	4);
			  STWrm		(3,	LOC(0), 1); }

Or	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  ORrrr		(3, 3,	4);
			  STWrm		(3,	LOC(0), 1); }

Xor	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  XORrrr	(3, 3,	4);
			  STWrm		(3,	LOC(0), 1); }

Lsl	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  SLWrrr	(3, 3,	4);
			  STWrm		(3,	LOC(0), 1); }

Lsr	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  SRWrrr	(3, 3,	4);
			  STWrm		(3,	LOC(0), 1); }

Asr	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  SRAWrrr	(3, 3,	4);
			  STWrm		(3,	LOC(0), 1); }

Lt	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  CMPWirr	(cr7,	3, 4);
			  MFCRr		(3);
			  RLWINMrriii	(3, 3,	29, 31, 31);
			  STWrm		(3,	LOC(0), 1); }

Le	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  CMPWirr	(cr7,	3, 4);
			  CRNOTii	(4*cr7+eq, 4*cr7+gt);
			  MFCRr		(3);
			  RLWINMrriii	(3, 3,	31, 31, 31);
			  STWrm		(3,	LOC(0), 1); }

Eq	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  XORrrr	(3,	3, 4);
			  SUBFICrri	(0,	3, 0);
			  ADDErrr	(3,	0, 3);
			  STWrm		(3,	LOC(0), 1); }

Ne	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  XORrrr	(3,	3, 4);
			  ADDICrri	(2,	3,-1);
			  SUBFErrr	(0,	2, 3);
			  MRrr		(3,	0);
			  STWrm		(3,	LOC(0), 1); }

Ge	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  CMPWirr	(cr7,	3, 4);
			  CRNOTii	(4*cr7+eq, 4*cr7+lt);
			  MFCRr		(3);
			  RLWINMrriii	(3, 3,	31, 31, 31);
			  STWrm		(3,	LOC(0), 1); }

Gt	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  CMPWirr	(cr7,	3, 4);
			  MFCRr		(3);
			  RLWINMrriii	(3, 3,	30, 31, 31);
			  STWrm		(3,	LOC(0), 1); }

Not	emit: vpu	{ LWZrm		(3,	LOC(0), 1);
			  SUBFICrri	(0,	3, 0);
			  ADDErrr	(3,	0, 3);
			  STWrm		(3,	LOC(0), 1); }

Br	emit: vpu
[
    | _addr |
    _addr := label _address.
    {
	long dest= (long)v__addr;
	long disp= (long)dest - (long)asm_pc;
	if (-Bx_RANGE <= disp && disp < Bx_RANGE)
	    {
			  Bi		(dest);
			  NOP		();
			  NOP		();
			  NOP		();
	    } else {
			  LISri		(0,	(((long)(dest) >> 16) & 0xffff));
			  ORIrri	(0, 0,	( (long)(dest)        & 0xffff));
			  MTCTRr	(0);
			  BCTR		();
	    }
    }
]

Bt	emit: vpu
[
    | _addr |
    _addr := label _address.
    {
	long dest= (long)v__addr;
	long disp= (long)dest - (long)asm_pc;
			  LWZrm		(3,	LOC(1), 1);
			  CMPWIiri	(cr7,	3, 0);
	if (-BCx_RANGE <= disp && disp < BCx_RANGE)
	    {
			  BNEii		(cr7, dest);
			  NOP		();
			  NOP		();
			  NOP		();
			  NOP		();
	    } else {
			  BEQii		(cr7, (long)asm_pc + 20);
			  LISri		(0,	(((long)(dest) >> 16) & 0xffff));
			  ORIrri	(0, 0,	( (long)(dest)        & 0xffff));
			  MTCTRr	(0);
			  BCTR		();
	    }
    }
]

Bf	emit: vpu
[
    | _addr |
    _addr := label _address.
    {
	long dest= (long)v__addr;
	long disp= (long)dest - (long)asm_pc;
			  LWZrm		(3,	LOC(1), 1);
			  CMPWIiri	(cr7,	3, 0);
	if (-BCx_RANGE <= disp && disp < BCx_RANGE)
	    {
			  BEQii		(cr7, dest);
			  NOP		();
			  NOP		();
			  NOP		();
			  NOP		();
	    } else {
			  BNEii		(cr7, (long)asm_pc + 20);
			  LISri		(0,	(((long)(dest) >> 16) & 0xffff));
			  ORIrri	(0, 0,	( (long)(dest)        & 0xffff));
			  MTCTRr	(0);
			  BCTR		();
	    }
    }
]

ICall	emit: vpu
[
    | _addr |
    _addr := label _address.
    {
	long dest= (long)v__addr;
	long disp= (long)dest - (long)asm_pc;
	int  arity= (long)self->v_arity >> 1;
	int  i;
	for (i= 0;  i < arity;	++i)
	    {
		if (i < 8) {
			  LWZrm		(3+i,	LOC(arity - i - 1), 1);
		} else {
			  LWZrm		(0,	LOC(arity - i - 1), 1);
			  STWrm		(0,	OUT(	    i    ), 1);
		}
	    }
	if (-Bx_RANGE <= disp && disp < Bx_RANGE)
	    {
			  BLi		(dest);
			  NOP		();
			  NOP		();
			  NOP		();
	    } else {
			  LISri		(0,	(((long)(dest) >> 16) & 0xffff));
			  ORIrri	(0, 0,	( (long)(dest)        & 0xffff));
			  MTCTRr	(0);
			  BCTRL		();
	    }
			  STWrm		(3,	LOC(0), 1);
    }
]

ICalli	emit: vpu
{
    int  arity= (long)self->v_arity >> 1;
    int  i;
			  LWZrm		(0,	LOC(arity	 ), 1);
			  MTLRr		(0);
    for (i= 0;  i < arity;  ++i)
        {
	    if (i < 8) {
			  LWZrm		(3+i,	LOC(arity - i - 1), 1);
	    } else {
			  LWZrm		(0,	LOC(arity - i - 1), 1);
			  STWrm		(0,	OUT(	    i    ), 1);
	    }
        }
			  BLRL		();
			  STWrm		(3,	LOC(0), 1);
}

VPU flush_: _first to_: _last	{ iflush((insn *)v__first, (insn *)v__last); }

" saturated arithmetic ---------------------------------------------------------------- "

PixAdd	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  ADDIrri	(2,	  1, -32);
			  STWrm		(4,	-32, 1);
			  LVXrx		(4,	  0, 2);
			  STWrm		(3,	-32, 1);
			  LVXrx		(3,	  0, 2);
			  VADDUBSrrr	(3,	  3, 4);
			  STVXrx	(3,	  0, 2);
			  LWZrm		(3,	-32, 1);
			  STWrm		(3,	LOC(0), 1); }

PixSub	emit: vpu	{ LWZrm		(4,	LOC(1), 1);
			  LWZrm		(3,	LOC(0), 1);
			  ADDIrri	(2,	  1, -32);
			  STWrm		(4,	-32, 1);
			  LVXrx		(4,	  0, 2);
			  STWrm		(3,	-32, 1);
			  LVXrx		(3,	  0, 2);
			  VSUBUBSrrr	(3,	  3, 4);
			  STVXrx	(3,	  0, 2);
			  LWZrm		(3,	-32, 1);
			  STWrm		(3,	LOC(0), 1); }

" Porter-Duff pixel operations ---------------------------------------------------------------- "

PixIn	emit: vpu	{ LBZrm		(4,	LOC(1)+3, 1);	/* r4 := mask.alpha */
			  LWZrm		(3,	LOC(0), 1);	/* r3 := source pixel */
			  ADDIrri	(5,	 1, -32);	/* r5 := &temp */
			  STWrm		(4,	12, 5);		/* temp.lsw := r4 */
			  LVXrx		(4,	 0, 5);		/* v4 := temp.quadWord */
			  VSPLTHrri	(4,	 4, 7);		/* v4 -.16 -> 16.16.16.16 */
			  STWrm		(3,	12, 5);		/* temp.lsw := r3 */
			  LVXrx		(3,	 0, 5);		/* v3 := temp.quad */
			  VUPKLSBrr	(3,	 3);		/* v3 8.8.8.8 -> 16.16.16.16 */
			  VMULOUBrrr	(3,	 3, 4);		/* v3 := source * mask.alpha */
			  VSPLTISHri	(5,	 0x01);		/* v5 := 0x0001000100010001 */
			  VSPLTISBri	(4,	 0x07);		/* v4 := 7 */
			  VSLHrrr	(4,	 5, 4);		/* v4 := 0x0080008000800080 */
			  VADDUHSrrr	(3,	 3, 4);		/* v3 == (source * mask.alpha) + 0x80808080 */
			  VSPLTISHri	(5,	 0x08);		/* v5 := 8 */
			  VSRHrrr	(4,	 3, 5);		/* v4 := ((source * mask.alpha) + 0x80808080) >> 8 */
			  VADDUHSrrr	(3,	 3, 4);		/* v3 += ((source * mask.alpha) + 0x80808080) >> 8 */
			  VSRHrrr	(3,	 3, 5);		/* v3 >>= 8 */
			  VPKUHUMrrr	(3,	 3, 3);		/* v3 16.16.16.16 -> 8.8.8.8 */
			  STVXrx	(3,	 0, 5);		/* temp.quad := v3 */
			  LWZrm		(3,	12, 5);		/* r3 := temp.lsw */
			  STWrm		(3,	LOC(0), 1); }

PixOver	emit: vpu	{ ADDIrri	(6,	 1, -32);	/* r6 := &temp */
			  LBZrm		(3,	LOC(0)+3, 1);	/* r3 := source alpha */
			  LWZrm		(4,	LOC(0)+0, 1);	/* r4 := source pixel */
			  LWZrm		(5,	LOC(1)+0, 1);	/* r5 := dest pixel */
			  XORIrri	(3,	 3, 255);	/* r3 := 255 - alpha */
			  STWrm		(3,	12, 6);		/* temp.lsw := dest */
			  LVXrx		(3,	 0, 6);		/* v3 := 1 - source alpha */
			  STWrm		(4,	12, 6);		/* temp.lsw := source pixel */
			  LVXrx		(4,	 0, 6);		/* v4 := source pixel */
			  STWrm		(5,	12, 6);		/* temp.lsw := dest pixel */
			  LVXrx		(5,	 0, 6);		/* v5 := dest pixel */
			  VSPLTHrri	(3,	 3, 7);		/* v3 := 1 - source alpha, 16 -> 16.16.16.16 */
			  VUPKLSBrr	(4,	 4);		/* v4 := source pixel, 8.8.8.8 -> 16.16.16.16 */
			  VSPLTISHri	(1,	 0x01);		/* v1 := 0x0001000100010001 */
			  VMULOUBrrr	(4,	 4, 1);		/* v4 := source pixel modulo 256 */
			  VUPKLSBrr	(5,	 5);		/* v5 := dest pixel, 8.8.8.8 -> 16.16.16.16 */
			  VMULOUBrrr	(5,	 5, 3);		/* v5 := dest pixel * (1 - source.alpha) */
			  VSPLTISHri	(8,	 0x08);		/* v8 := 0x0008000800080008 */
			  VSPLTISBri	(7,	 0x07);		/* v7 := 7 */
			  VSLHrrr	(7,	 7, 1);		/* v7 := 0x0080008000800080 */
			  VADDUHSrrr	(5,	 5, 7);		/* v5 += 0x0080008000800080 */
			  VSRHrrr	(6,	 5, 8);		/* v6 := v5 >> 8 */
			  VADDUHSrrr	(5,	 5, 6);		/* v5 += v5 >> 8 */
			  VSRHrrr	(5,	 5, 8);		/* v5 >>= 8 */
			  VADDUHSrrr	(5,	 5, 4);		/* v5 += source pixel */
			  VPKUHUSrrr	(5,	 5, 5);		/* v5 16.16.16.16 -> 8.8.8.8 */
			  STVXrx	(5,	 0, 6);		/* temp.quad := v3 */
			  LWZrm		(3,	12, 6);		/* r3 := temp.lsw */
			  STWrm		(3,	LOC(0), 1); }

"----------------------------------------------------------------"

"{ import: VPU-ppc-dsm.st }"

VPU disassemble_: _first to_: _last	[]
