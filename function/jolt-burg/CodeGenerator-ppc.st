" CodeGenerator-ppc.st -- translate abstract Instructions to PowerPC machine instructions

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

  Last edited: 2007-05-17 10:40:08 by piumarta on margaux.piumarta.com
"

{ import: Objects }
{ import: Expression }
{ import: Resource }
{ import: Instruction }
{ import: CompilerOptions }
{ import: CodeGenerator }

SmallInteger lo16_: _i	{ short i= (long)v__i;  return (oop)(((long)i) << 1 | 1); }
SmallInteger hi16_: _i	{ unsigned long  i= (unsigned long)v__i;  return (oop)(((i >> 16)                                   ) << 1 | 1); }
SmallInteger ha16_: _i	{ unsigned long  i= (unsigned long)v__i;  return (oop)(((i >> 16) + (((i & 0xffff) > 32767) ? 1 : 0)) << 1 | 1); }

{ include "asm-ppc.h" }

PowerPCRegister : Register ( location )

PowerPCRegister location: loc	[ ^location := loc ]
PowerPCRegister location	[ ^location ]


PowerPCCodeGenerator : CodeGenerator ( r0 r1 r2 r3 r11 r12 )

PowerPCCodeGenerator new
[
    self := super new.
    r0           := PowerPCRegister withClass: I4 name: 'r0'  encoding:  0.
    r1           := PowerPCRegister withClass: I4 name: 'r1'  encoding:  1.
    r2           := PowerPCRegister withClass: I4 name: 'r2'  encoding:  2.
    ccrs
	add: (r3 := PowerPCRegister withClass: I4 name: 'r3'  encoding:  3);
	add: (      PowerPCRegister withClass: I4 name: 'r4'  encoding:  4);
	add: (      PowerPCRegister withClass: I4 name: 'r5'  encoding:  5);
	add: (      PowerPCRegister withClass: I4 name: 'r6'  encoding:  6);
	add: (      PowerPCRegister withClass: I4 name: 'r7'  encoding:  7);
	add: (      PowerPCRegister withClass: I4 name: 'r8'  encoding:  8);
	add: (      PowerPCRegister withClass: I4 name: 'r9'  encoding:  9);
	add: (      PowerPCRegister withClass: I4 name: 'r10' encoding: 10).
    r11          := PowerPCRegister withClass: I4 name: 'r11' encoding: 11.
    r12          := PowerPCRegister withClass: I4 name: 'r12' encoding: 12.
    csrs
	add: (	    PowerPCRegister withClass: I4 name: 'r13' encoding: 13);
	add: (	    PowerPCRegister withClass: I4 name: 'r14' encoding: 14);
	add: (	    PowerPCRegister withClass: I4 name: 'r15' encoding: 15);
	add: (	    PowerPCRegister withClass: I4 name: 'r16' encoding: 16);
	add: (	    PowerPCRegister withClass: I4 name: 'r17' encoding: 17);
	add: (	    PowerPCRegister withClass: I4 name: 'r18' encoding: 18);
	add: (	    PowerPCRegister withClass: I4 name: 'r19' encoding: 19);
	add: (	    PowerPCRegister withClass: I4 name: 'r20' encoding: 20);
	add: (	    PowerPCRegister withClass: I4 name: 'r21' encoding: 21);
	add: (	    PowerPCRegister withClass: I4 name: 'r22' encoding: 22);
	add: (	    PowerPCRegister withClass: I4 name: 'r23' encoding: 23);
	add: (	    PowerPCRegister withClass: I4 name: 'r24' encoding: 24);
	add: (	    PowerPCRegister withClass: I4 name: 'r25' encoding: 25);
	add: (	    PowerPCRegister withClass: I4 name: 'r26' encoding: 26);
	add: (	    PowerPCRegister withClass: I4 name: 'r27' encoding: 27);
	add: (	    PowerPCRegister withClass: I4 name: 'r28' encoding: 28);
	add: (	    PowerPCRegister withClass: I4 name: 'r29' encoding: 29);
	add: (	    PowerPCRegister withClass: I4 name: 'r30' encoding: 30);
	add: (	    PowerPCRegister withClass: I4 name: 'r31' encoding: 31).
]

PowerPCCodeGenerator clobberRegisters: insn	[ insn clobberPowerPC: self ]

Instruction clobberPowerPC: gen	[]

ADDRFP4 clobberPowerPC: gen [ gen requireFrame ]
Call	clobberPowerPC: gen [ gen clobberCall: self; requireFrame ]

PowerPCCodeGenerator clobberCall: insn
[
    ccrs do: [:ccr | self clobberRegister: ccr]
]

PowerPCCodeGenerator allocateParam: insn
[
    ^(params add: (Temporary withBase: r1 offset: params size * 4)) allocate
]

PowerPCCodeGenerator allocateSpill: insn
[
    spills do: [:temp | temp live ifFalse: [^temp allocate]].
    ^(spills add: (Temporary withBase: r1 offset: 0)) allocate
]

PowerPCCodeGenerator allocateTemp: insn
[
    temps do: [:temp | temp live ifFalse: [^temp allocate]].
    ^(temps add: (Temporary withBase: r1 offset: 0)) allocate
]

PowerPCCodeGenerator finaliseFrame
[
    | linkage align tempOffset |
    linkage := 24.
"
    StdOut
	nextPutAll: 'linkage '; print: linkage;
	nextPutAll: ' needsFrame '; print: needsFrame;
	nextPutAll: ' parametersSize '; print: parametersSize;
	cr.
"
    needsFrame ifTrue: [parametersSize := parametersSize max: 32].	"always leave space for 8 outgoing arg registers"
    frameSize := linkage + parametersSize.
    csrs do: [:reg | reg used ifTrue: [reg location: (temps add: (Temporary withBase: r1 offset: temps size * 4)) allocate]].
    tempOffset := linkage + parametersSize.
    temps do: [:temp |
	temp offset: tempOffset.
	frameSize := frameSize + 4.					"temporary space"
	tempOffset := tempOffset + 4.					"temporary space"
	needsFrame := true].
    spills do: [:temp |
	temp offset: tempOffset.
	frameSize := frameSize + 4.					"temporary space"
	tempOffset := tempOffset + 4.					"temporary space"
	needsFrame := true].
    needsFrame
	ifTrue:
	   [align := (frameSize + 15 bitAnd: -16) - frameSize.
	    frameSize := frameSize + align].
    needsFrame
	ifTrue:  [params do: [:param | param offset: frameSize + linkage + param offset]]
	ifFalse: [params do: [:param | param offset:             linkage + param offset]].
"
    StdOut
	nextPutAll: 'linkage '; print: linkage;
	nextPutAll: ' needsFrame '; print: needsFrame;
	nextPutAll: ' parametersSize '; print: parametersSize;
	cr.
"
]

PowerPCCodeGenerator emitPrologue
[
    needsFrame ifTrue: [self mflrR: r0;  stwR: r0 I: 8 R: r1;  stwuR: r1 I: frameSize negated R: r1].
    params doWithIndex: [:param :index | index < 8 ifTrue: [self stwR: (ccrs at: index) I: param offset R: param base]].
    csrs do: [:reg | reg used ifTrue: [self stwR: reg I: reg location offset R: reg location base]].
]

PowerPCCodeGenerator emitEpilogue
[
    csrs do: [:reg | reg used ifTrue: [self lwzR: reg I: reg location offset R: reg location base]].
    needsFrame ifTrue: [self addiR: r1 R: r1 I: frameSize;  lwzR: r0 I: 8 R: r1;  mtlrR: r0].
    self blr.
]

PowerPCCodeGenerator noteCall: call
[
    parametersSize := parametersSize max: call arity * 4.
]

PowerPCCodeGenerator calli4: call
[
    | func |
    call arity - 1 downTo: 0 do: [:index | self emit: call argumentAt: index].
    (func := call function) reload: self.
    self mtlrR: func output.
    self blrl.
    self mrR: call output R: r3.
]

PowerPCCodeGenerator emit: call argumentAt: index
[
    | insn |
    (insn := call argumentAt: index) reload: self.
    index < 8
	ifTrue:  [self mrR: (ccrs at: index) R: insn output]
	ifFalse: [self stwR: insn output I: index * 4 + 24 R: r1]
]

PowerPCCodeGenerator spilli4:  reg to:   tmp	[ self stwR: reg I: tmp offset R: tmp base ]
PowerPCCodeGenerator reloadi4: reg from: tmp	[ self lwzR: reg I: tmp offset R: tmp base ]

StaticPowerPCCodeGenerator : PowerPCCodeGenerator ()

StaticPowerPCCodeGenerator define: l		[ StdOut nextPutAll: 'L'; print: l ordinal; nextPut: $:; cr ]

StaticPowerPCCodeGenerator addR: d R: a R: b	[ StdOut nextPutAll: '	add	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator addeR: d R: a R: b	[ StdOut nextPutAll: '	adde	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator addiR: d R: s I: i	[ StdOut nextPutAll: '	addi	'; print: d; nextPut: $,; print: s; nextPut: $,; print: i; cr ]
StaticPowerPCCodeGenerator addicR: d R: s I: i	[ StdOut nextPutAll: '	addic	'; print: d; nextPut: $,; print: s; nextPut: $,; print: i; cr ]
StaticPowerPCCodeGenerator andR: d R: a R: b	[ StdOut nextPutAll: '	and	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator baL: l		[ StdOut
						      nextPutAll: '	lis	r0,hi16(L';    print: l ordinal; nextPutAll: ')\n';
						      nextPutAll: '	ori	r0,r0,lo16(L'; print: l ordinal; nextPutAll: ')\n';
						      nextPutAll: '	mtctr	r0\n';
						      nextPutAll: '	bctr\n']
StaticPowerPCCodeGenerator baR: r		[ StdOut
						      nextPutAll: '	mtctr	'; print: r; cr;
						      nextPutAll: '	bctr\n']
StaticPowerPCCodeGenerator beqI: c L: l		[ StdOut nextPutAll: '	bne	cr'; print: c; nextPutAll: ',.+20\n'.  self baL: l ]
StaticPowerPCCodeGenerator bgeI: c L: l		[ StdOut nextPutAll: '	blt	cr'; print: c; nextPutAll: ',.+20\n'.  self baL: l ]
StaticPowerPCCodeGenerator blr			[ StdOut nextPutAll: '	blr\n' ]
StaticPowerPCCodeGenerator blrl			[ StdOut nextPutAll: '	blrl\n' ]
StaticPowerPCCodeGenerator bneI: c L: l		[ StdOut nextPutAll: '	beq	cr'; print: c; nextPutAll: ',.+20\n'.  self baL: l ]
StaticPowerPCCodeGenerator cmpwI: d R: a R: b	[ StdOut nextPutAll: '	cmpw	cr'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator cmpwiI: d R: a I: i	[ StdOut nextPutAll: '	cmpwi	cr'; print: d; nextPut: $,; print: a; nextPut: $,; print: i; cr ]
StaticPowerPCCodeGenerator crnorI: d I: a I: b	[ StdOut nextPutAll: '	crnor	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator divwR: d R: a R: b	[ StdOut nextPutAll: '	divw	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator lbzR: d I: i R: s	[ StdOut nextPutAll: '	lbz	'; print: d; nextPut: $,; print: i; nextPut: $,; print: s; cr ]
StaticPowerPCCodeGenerator lhaR: d I: i R: s	[ StdOut nextPutAll: '	lha	'; print: d; nextPut: $,; print: i; nextPut: $,; print: s; cr ]
StaticPowerPCCodeGenerator lisR: d I_: _i	[ StdOut nextPutAll: '	lis	'; print: d; nextPut: $,; print: (SmallInteger hi16_: _i); cr ]
StaticPowerPCCodeGenerator lisR: d Iha_: _i	[ StdOut nextPutAll: '	lis	'; print: d; nextPut: $,; print: (SmallInteger ha16_: _i); cr ]
StaticPowerPCCodeGenerator lwzR: d I: i R: s	[ StdOut nextPutAll: '	lwz	'; print: d; nextPut: $,; print: i; nextPut: $(; print: s; nextPut: $); cr ]
StaticPowerPCCodeGenerator mfcrR: d		[ StdOut nextPutAll: '	mfcr	'; print: d; cr ]
StaticPowerPCCodeGenerator mflrR: d		[ StdOut nextPutAll: '	mflr	'; print: d; cr ]
StaticPowerPCCodeGenerator mrR: d R: s		[ d == s ifFalse: [StdOut nextPutAll: '	mr	'; print: d; nextPut: $,; print: s; cr ] ]
StaticPowerPCCodeGenerator mtlrR: d		[ StdOut nextPutAll: '	mtlr	'; print: d; cr ]
StaticPowerPCCodeGenerator mullwR: d R: a R: b	[ StdOut nextPutAll: '	mullw	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator negR: d R: s		[ StdOut nextPutAll: '	neg	'; print: d; nextPut: $,; print: s; cr ]
StaticPowerPCCodeGenerator notR: d R: s		[ StdOut nextPutAll: '	not	'; print: d; nextPut: $,; print: s; cr ]
StaticPowerPCCodeGenerator orR: d R: a R: b	[ StdOut nextPutAll: '	or	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator oriR: d R: s I_: _i	[ StdOut nextPutAll: '	ori	'; print: d; nextPut: $,; print: s; nextPut: $,; print: (SmallInteger value_: _i) & 0xffff; cr ]
StaticPowerPCCodeGenerator rlwinmR: d R: s I: i I: j I: k	[ StdOut nextPutAll: '	rlwinm	'; print: d; nextPut: $,; print: s; nextPut: $,; print: i; nextPut: $,; print: j; nextPut: $,; print: k; cr ]
StaticPowerPCCodeGenerator slwR: d R: a R: b	[ StdOut nextPutAll: '	slw	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator srawR: d R: a R: b	[ StdOut nextPutAll: '	sraw	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator srwR: d R: a R: b	[ StdOut nextPutAll: '	srw	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator stbR: d I: i R: s	[ StdOut nextPutAll: '	stb	'; print: d; nextPut: $,; print: i; nextPut: $(; print: s; nextPut: $); cr ]
StaticPowerPCCodeGenerator sthR: d I: i R: s	[ StdOut nextPutAll: '	sth	'; print: d; nextPut: $,; print: i; nextPut: $(; print: s; nextPut: $); cr ]
StaticPowerPCCodeGenerator stwR: d I: i R: s	[ StdOut nextPutAll: '	stw	'; print: d; nextPut: $,; print: i; nextPut: $(; print: s; nextPut: $); cr ]
StaticPowerPCCodeGenerator stwuR: d I: i R: s	[ StdOut nextPutAll: '	stwu	'; print: d; nextPut: $,; print: i; nextPut: $(; print: s; nextPut: $); cr ]
StaticPowerPCCodeGenerator subR: d R: a R: b	[ StdOut nextPutAll: '	sub	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator subfR: d R: a R: b	[ StdOut nextPutAll: '	subf	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator subfeR: d R: a R: b	[ StdOut nextPutAll: '	subfe	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator subficR: d R: s I: i	[ StdOut nextPutAll: '	subfic	'; print: d; nextPut: $,; print: s; nextPut: $,; print: i; cr ]
StaticPowerPCCodeGenerator subiR: d R: a I: i	[ StdOut nextPutAll: '	subi	'; print: d; nextPut: $,; print: a; nextPut: $,; print: i; cr ]
StaticPowerPCCodeGenerator xorR: d R: a R: b	[ StdOut nextPutAll: '	xor	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]

"----------------------------------------------------------------"

DynamicPowerPCCodeGenerator : PowerPCCodeGenerator ()

DynamicPowerPCCodeGenerator asmPass	{ return (oop)(asm_pass << 1 | 1); }
DynamicPowerPCCodeGenerator _asmPC	{ return (oop)(asm_pc); }

DynamicPowerPCCodeGenerator define: l
[
    self asmPass == 0
	ifTrue:  [l address_: self _asmPC]
	ifFalse: [l phaseCheck_: self _asmPC]
]

DynamicPowerPCCodeGenerator _
{
    (void)asmFail;
#   define _P(v)	((long)v__##v)
#   undef  _I
#   define _I(v)	((long)v_##v >> 1)
#   define _R(v)	((long)(((struct t_Register *)(v_##v))->v__encoding))
#   define _A(v)	((long)(((struct t_Label    *)(v_##v))->v__address))
#   define _ha16(v)	(((unsigned long)v_##v >> 16) + ((((unsigned long)v_##v & 0xffff) > 32767) ? 1 : 0))
}

DynamicPowerPCCodeGenerator addR: d R: a R: b	{ ADDrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator addeR: d R: a R: b	{ ADDErrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator addiR: d R: s I: i	{ ADDIrri	(_R(d), _R(s), _I(i)         	); }
DynamicPowerPCCodeGenerator addicR: d R: s I: i	{ ADDICrri	(_R(d), _R(s), _I(i)         	); }
DynamicPowerPCCodeGenerator andR: d R: a R: b	{ ANDrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator baL: l		{ LISri		(   0        ,(_A(l) >> 16)     );
						  ORIrri	(   0 ,    0 ,(_A(l) & 0xffff)  );
						  MTCTRr	(0				);
						  BCTR		(); }
DynamicPowerPCCodeGenerator baR: r		{ MTCTRr	(_R(r)				);
						  BCTR		(); }
DynamicPowerPCCodeGenerator beqI: c L: l	[{BNEii		(_I(c),        (long)asm_pc + 20);}.  self baL: l ]
DynamicPowerPCCodeGenerator bgeI: c L: l	[{BLTii		(_I(c),        (long)asm_pc + 20);}.  self baL: l ]
DynamicPowerPCCodeGenerator blr			{ BLR		(); }
DynamicPowerPCCodeGenerator blrl		{ BLRL		(); }
DynamicPowerPCCodeGenerator bneI: c L: l	[{BEQii		(_I(c),        (long)asm_pc + 20);}.  self baL: l ]
DynamicPowerPCCodeGenerator cmpwI: d R: a R: b	{ CMPWirr	(_I(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator cmpwiI: d R: a I: i	{ CMPWIiri	(_I(d), _R(a), _I(i)         	); }
DynamicPowerPCCodeGenerator crnorI: d I: a I: b	{ CRNORiii	(_I(d), _I(a), _I(b)         	); }
DynamicPowerPCCodeGenerator divwR: d R: a R: b	{ DIVWrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator lbzR: d I: i R: s	{ LBZrm		(_R(d), _I(i), _R(s)		); }
DynamicPowerPCCodeGenerator lhaR: d I: i R: s	{ LHArm		(_R(d), _I(i), _R(s)		); }
DynamicPowerPCCodeGenerator lisR: d I_: _i	{ LISri		(_R(d),        _P(i >> 16)   	); }
DynamicPowerPCCodeGenerator lisR: d Iha_: _i	{ LISri		(_R(d),        _ha16(_i)   	); }
DynamicPowerPCCodeGenerator lwzR: d I: i R: s	{ LWZrm		(_R(d), _I(i), _R(s)		); }
DynamicPowerPCCodeGenerator mfcrR: d		{ MFCRr		(_R(d)			     	); }
DynamicPowerPCCodeGenerator mflrR: d		{ MFLRr		(_R(d)			     	); }
DynamicPowerPCCodeGenerator mtlrR: d		{ MTLRr		(_R(d)			     	); }
DynamicPowerPCCodeGenerator mullwR: d R: a R: b	{ MULLWrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator negR: d R: s	{ NEGrr		(_R(d), _R(s)		     	); }
DynamicPowerPCCodeGenerator notR: d R: s	{ NOTrr		(_R(d), _R(s)		     	); }
DynamicPowerPCCodeGenerator orR: d R: a R: b	{ ORrrr		(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator oriR: d R: s I_: _i	{ ORIrri	(_R(d), _R(s), _P(i & 0xffff)	); }
DynamicPowerPCCodeGenerator rlwinmR: d R: s I: i I: j I:k	{ RLWINMrriii	(_R(d), _R(s), _I(i), _I(j), _I(k)); }
DynamicPowerPCCodeGenerator slwR: d R: a R: b	{ SLWrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator srawR: d R: a R: b	{ SRAWrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator srwR: d R: a R: b	{ SRWrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator stbR: d I: i R: s	{ STBrm		(_R(d), _I(i), _R(s)		); }
DynamicPowerPCCodeGenerator sthR: d I: i R: s	{ STHrm		(_R(d), _I(i), _R(s)		); }
DynamicPowerPCCodeGenerator stwR: d I: i R: s	{ STWrm		(_R(d), _I(i), _R(s)		); }
DynamicPowerPCCodeGenerator stwuR: d I: i R: s	{ STWUrm	(_R(d), _I(i), _R(s)		); }
DynamicPowerPCCodeGenerator subR: d R: a R: b	{ SUBrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator subfR: d R: a R: b	{ SUBFrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator subfeR: d R: a R: b	{ SUBFErrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator subficR: d R: s I: i{ SUBFICrri	(_R(d), _R(s), _I(i)         	); }
DynamicPowerPCCodeGenerator subiR: d R: a I: i	{ SUBIrri	(_R(d), _R(a), _I(i)         	); }
DynamicPowerPCCodeGenerator xorR: d R: a R: b	{ XORrrr	(_R(d), _R(a), _R(b)         	); }

DynamicPowerPCCodeGenerator mrR: d R: s		{ if (_R(d) != _R(s))   MRrr(_R(d), _R(s)); }

"----------------------------------------------------------------"

CodeGenerator versionString	[ ^self default versionString ]

CodeGenerator default		[ ^PowerPCCodeGenerator ]

PowerPCCodeGenerator static	[ ^StaticPowerPCCodeGenerator ]
PowerPCCodeGenerator dynamic	[ ^DynamicPowerPCCodeGenerator ]

PowerPCCodeGenerator versionString
[
    ^'PowerPC 1.0'
]

"----------------------------------------------------------------"

CodeGenerator		   isStatic	[ ^false ]
StaticPowerPCCodeGenerator isStatic	[ ^true ]

CodeGenerator		    isDynamic	[ ^false ]
DynamicPowerPCCodeGenerator isDynamic	[ ^true ]

StaticPowerPCCodeGenerator defineVariable: name
[
    StdOut nextPutAll: '	.data\n'.
    StdOut nextPutAll: name; nextPutAll: ':	.long	_'; nextPutAll: name; cr.
    StdOut nextPutAll: '	.text\n'.
]

DynamicPowerPCCodeGenerator defineVariable: name
[
]

"----------------------------------------------------------------"

{ import: Grammar }

PowerPCCodeGenerator r0		[ ^r0 ]
PowerPCCodeGenerator r1		[ ^r1 ]
PowerPCCodeGenerator r3		[ ^r3 ]
PowerPCCodeGenerator r12	[ ^r12 ]

PowerPCGrammar := [
    ReductionGrammar new
	"-------------------------------- baseline --------------------------------"

	at: #VOID add: #REG			"discard";
	at: #VOID add: #(label		)	do: [:op :gen | gen define: op ];
	at: #VOID add: #(enter		)	do: [:op :gen | gen emitPrologue ];
	at: #VOID add: #(retv		)	do: [:op :gen | gen emitEpilogue ];
	at: #VOID add: #(reti4 	 REG	)	do: [:op :gen | gen mrR: gen r3 R: op lhs output;  emitEpilogue ];
	at: #VOID add: #(drop  	 REG	)	do: [:op :gen | ];
	at: #VOID add: #(brz   	 REG	)	do: [:op :gen | gen cmpwiI:  7 R: op lhs output I: 0;
								    beqI:    7 L: op destination ];
	at: #VOID add: #(brnz  	 REG	)	do: [:op :gen | gen cmpwiI:  7 R: op lhs output I: 0;
								    bneI:    7 L: op destination ];
	at: #VOID add: #(bri 	 REG	)	do: [:op :gen | gen baR:     op lhs output ];
	at: #VOID add: #(bra		)	do: [:op :gen | gen baL:     op destination ];
	at: #REG  add: #(cnsti4	 	)	do: [:op :gen | gen lisR:    op output		   I_: op arg;
								    oriR:    op output R: op output I_: op arg ];
	at: #REG  add: #(cnstp4	 	)	do: [:op :gen | gen lisR:    op output		   I_: op arg;
								    oriR:    op output R: op output I_: op arg ];
	at: #REG  add: #(parami4 	)	do: [:op :gen | ];
	at: #REG  add: #(addrfp4 	)	do: [:op :gen | gen mrR:     op output R: gen r1 ];
	at: #REG  add: #(addrgp4 	)	do: [:op :gen | gen lisR:    op output		   I_: op arg _address;
								    oriR:    op output R: op output I_: op arg _address ];
	at: #REG  add: #(addrjp4 	)	do: [:op :gen | gen lisR:    op output		   I_: op arg _address;
								    oriR:    op output R: op output I_: op arg _address ];
	at: #REG  add: #(addrlp4 	)	do: [:op :gen | gen addiR:   op output R: op arg base I: op arg offset ];
	at: #REG  add: #(indiri1 REG	)	do: [:op :gen | gen lbzR:    op output I: 0 R: op lhs output ];
	at: #REG  add: #(indiri2 REG	)	do: [:op :gen | gen lhaR:    op output I: 0 R: op lhs output ];
	at: #REG  add: #(indiri4 REG	)	do: [:op :gen | gen lwzR:    op output I: 0		R: op output ];
	at: #REG  add: #(noti4 	 REG	)	do: [:op :gen | gen subficR: gen r0    R: op lhs output I: 0;
								    addeR:   op output R: gen r0	R: op lhs output ];
	at: #REG  add: #(comi4 	 REG	)	do: [:op :gen | gen notR:    op output R: op lhs output ];
	at: #REG  add: #(negi4 	 REG	)	do: [:op :gen | gen negR:    op output R: op lhs output ];
	at: #REG  add: #(calli4	 REG	)	do: [:op :gen | gen calli4:  op ];
	at: #REG  add: #(asgni1  REG REG)	do: [:op :gen | gen stbR:    op lhs output I: 0 R: op rhs output ];
	at: #REG  add: #(asgni2  REG REG)	do: [:op :gen | gen sthR:    op lhs output I: 0 R: op rhs output ];
	at: #REG  add: #(asgni4  REG REG)	do: [:op :gen | gen stwR:    op lhs output I: 0 R: op rhs output ];
	at: #REG  add: #(andi4   REG REG)	do: [:op :gen | gen andR:    op output R: op lhs output R: op rhs output ];
	at: #REG  add: #(ori4    REG REG)	do: [:op :gen | gen orR:     op output R: op lhs output R: op rhs output ];
	at: #REG  add: #(xori4 	 REG REG)	do: [:op :gen | gen xorR:    op output R: op lhs output R: op rhs output ];
	at: #REG  add: #(addi4 	 REG REG)	do: [:op :gen | gen addR:    op output R: op lhs output R: op rhs output ];
	at: #REG  add: #(subi4 	 REG REG)	do: [:op :gen | gen subR:    op output R: op lhs output R: op rhs output ];
	at: #REG  add: #(muli4 	 REG REG)	do: [:op :gen | gen mullwR:  op output R: op lhs output R: op rhs output ];
	at: #REG  add: #(divi4 	 REG REG)	do: [:op :gen | gen divwR:   op output R: op lhs output R: op rhs output ];
	at: #REG  add: #(modi4 	 REG REG)	do: [:op :gen | gen divwR:   gen r0    R: op lhs output R: op rhs output;
								    mullwR:  gen r0    R: gen r0	R: op rhs output;
								    subfR:   op output R: gen r0	R: op lhs output ];
	at: #REG  add: #(shli4 	 REG REG)	do: [:op :gen | gen slwR:    op output R: op lhs output R: op rhs output ];
	at: #REG  add: #(shlu4 	 REG REG)	do: [:op :gen | gen slwR:    op output R: op lhs output R: op rhs output ];
	at: #REG  add: #(shri4 	 REG REG)	do: [:op :gen | gen srawR:   op output R: op lhs output R: op rhs output ];
	at: #REG  add: #(shru4 	 REG REG)	do: [:op :gen | gen srwR:    op output R: op lhs output R: op rhs output ];
	at: #REG  add: #(lti4 	 REG REG)	do: [:op :gen | gen cmpwI:   7		R: op lhs output R: op rhs output;
								    mfcrR:   op output;
								    rlwinmR: op output	R: op output	 I: 29 I: 31 I: 31 ];
	at: #REG  add: #(lei4 	 REG REG)	do: [:op :gen | gen cmpwI:   7		R: op lhs output R: op rhs output;
								    crnorI:  30 I: 29 I: 29;
								    mfcrR:   op output;
								    rlwinmR: op output R: op output	I: 31 I: 31 I: 31 ];
	at: #REG  add: #(eqi4 	 REG REG)	do: [:op :gen | gen xorR:    op output R: op lhs output R: op rhs output;
								    subficR: gen r0    R: op output	I: 0;
								    addeR:   op output R: gen r0	R: op output ];
	at: #REG  add: #(nei4 	 REG REG)	do: [:op :gen | gen xorR:    gen r12   R: op lhs output R: op rhs output;
								    addicR:  gen r0    R: gen r12	I: -1;
								    subfeR:  op output R: gen r0	R: gen r12 ];
	at: #REG  add: #(gei4 	 REG REG)	do: [:op :gen | gen cmpwI:   7	       R: op lhs output R: op rhs output;
								    crnorI:  30 I: 28 I: 28;
								    mfcrR:   op output;
								    rlwinmR: op output R: op output	I: 31 I: 31 I: 31 ];
	at: #REG  add: #(gti4 	 REG REG)	do: [:op :gen | gen cmpwI:   7	       R: op lhs output R: op rhs output;
								    mfcrR:   op output;
								    rlwinmR: op output R: op output	I: 30 I: 31 I: 31 ];

	"-------------------------------- optimisations --------------------------------"

	at: #I16 add: #(cnsti4)			if: [:op | false "(SmallInteger value_: op arg) between: -32768 and: 32767"];

	at: #VOID add: #(brz (lti4 (indiri4 (addrlp4))
			           I16))	do: [:op :gen | gen lwzR:   gen r0 I: op lhs lhs lhs arg offset R: op lhs lhs lhs arg base;
								    cmpwiI: 7	   R: gen r0			I: (SmallInteger lo16_: op lhs rhs arg);
								    bgeI:   7	   L: op destination ];

	at: #REG  add: #(indiri4 (addrgp4))	do: [:op :gen | gen lisR:  op output Iha_: op lhs arg _address;
								    lwzR:  op output I: (SmallInteger lo16_: op lhs arg _address) R: op output ];

	at: #REG  add: #(indiri4 (addrlp4))	do: [:op :gen | gen lwzR:  op output I: op lhs arg offset R: op lhs arg base ];

	at: #REG  add: #(addi4 I16 REG)		do: [:op :gen | gen addiR: op output R: op rhs output I: (SmallInteger value_: op lhs arg) ];
	at: #REG  add: #(addi4 REG I16)		do: [:op :gen | gen addiR: op output R: op lhs output I: (SmallInteger value_: op rhs arg) ];
	at: #REG  add: #(subi4 I16 REG)		do: [:op :gen | gen addiR: op output R: op rhs output I: (SmallInteger value_: op lhs arg) negated ];
	at: #REG  add: #(subi4 REG I16)		do: [:op :gen | gen subiR: op output R: op lhs output I: (SmallInteger value_: op rhs arg) ];
	yourself
]

"----------------------------------------------------------------"

PowerPCRegisterFilter    : RegisterAllocator ()
PowerPCRegisterAllocator : RegisterAllocator ()

PowerPCRegisterFilter	 REG  :insn	[ ^true ]
PowerPCRegisterAllocator REG  :insn	[ ^codeGenerator allocateRegister: insn ]

PowerPCRegisterFilter	 I16  :insn	[ ^false ]
PowerPCRegisterAllocator I16  :insn	[ ^nil ]

PowerPCCodeGenerator grammar		[ ^PowerPCGrammar ]
PowerPCCodeGenerator registerFilter	[ ^PowerPCRegisterFilter   "on: self"]
PowerPCCodeGenerator registerAllocator	[ ^PowerPCRegisterAllocator on: self ]

"----------------------------------------------------------------"

StaticPowerPCCodeGenerator generate: tree
[
    self finaliseFrame.
    tree printOn: StdOut indent: 0.  StdOut cr.
    tree generate: self.
]

"{ include ""dis-ppc.c"" }"

DynamicPowerPCCodeGenerator generate: tree
[
    | _entry |
    { asm_pass= 0; }.
    { asm_pc= 0; }.
    self finaliseFrame.
    tree generate: self.
    CompilerOptions verboseExec ifTrue: [{ printf("code size %d bytes\n", (int)asm_pc); }].
    { asm_pc= (insn *)malloc((long)asm_pc); }.
    { asm_pass= 2; }.
    { v__entry= (oop)asm_pc; }.
    self relocateLabels_: self _asmPC.
    tree generate: self.
    CompilerOptions verboseExec ifTrue: [{ printf("code start %p\n", (void *)v__entry); }].
    { iflush((void *)v__entry, (void *)asm_pc); }.
"    CompilerOptions verboseExec ifTrue: [{ disassemble((void *)v__entry, (void *)asm_pc); }]."
]
