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

  Last edited: 2007-03-05 13:16:08 by piumarta on emilia.local
"

{ import: Objects }
{ import: Expression }
{ import: Resource }
{ import: Instruction }
{ import: CompilerOptions }
{ import: CodeGenerator }

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

PowerPCCodeGenerator addi4    :d :s	[ self addR: d R: d R: s ]
PowerPCCodeGenerator addrfp4  :d	[ self mrR: d R: r1 ]
PowerPCCodeGenerator addrlp4  :d :v	[ self addiR: d R: v base I: v offset ]
PowerPCCodeGenerator andi4    :d :s	[ self andR: d R: d R: s ]
PowerPCCodeGenerator asgni1   :s :d	[ self stbR: s I: 0 R: d ]
PowerPCCodeGenerator asgni2   :s :d	[ self sthR: s I: 0 R: d ]
PowerPCCodeGenerator asgni4   :s :d	[ self stwR: s I: 0 R: d ]
PowerPCCodeGenerator bra      :l	[ self baL: l ]
PowerPCCodeGenerator brnz     :s :l	[ self cmpwiI: 7 R: s I: 0;  bneI: 7 L: l ]
PowerPCCodeGenerator brz      :s :l	[ self cmpwiI: 7 R: s I: 0;  beqI: 7 L: l ]
PowerPCCodeGenerator cnsti4   :d :v	[ self lisR: d I_: v;  oriR: d R: d I_: v ]
PowerPCCodeGenerator cnstp4   :d :v	[ self lisR: d I_: v;  oriR: d R: d I_: v ]
PowerPCCodeGenerator divi4    :d :s	[ self divwR: d R: d R: s ]
PowerPCCodeGenerator eqi4     :d :s	[ self xorR: d R: d R: s;  subficR: r0 R: r3 I: 0;  addeR: d R: r0 R: d ]
PowerPCCodeGenerator gei4     :d :s	[ self cmpwI: 7 R: d R: s;  crnorI: 30 I: 28 I: 28;  mfcrR: d;  rlwinmR: d R: d I: 31 I: 31 I: 31 ]
PowerPCCodeGenerator gti4     :d :s	[ self cmpwI: 7 R: d R: s;  mfcrR: d;  rlwinmR: d R: d I: 30 I: 31 I: 31 ]
PowerPCCodeGenerator indiri1  :d	[ self lbzR: d I: 0 R: d ]
PowerPCCodeGenerator indiri2  :d	[ self lhzR: d I: 0 R: d ]
PowerPCCodeGenerator indiri4  :d	[ self lwzR: d I: 0 R: d ]
PowerPCCodeGenerator label    :l	[ self define: l ]
PowerPCCodeGenerator lei4     :d :s	[ self cmpwI: 7 R: d R: s;  crnorI: 30 I: 29 I: 29;  mfcrR: d;  rlwinmR: d R: d I: 31 I: 31 I: 31 ]
PowerPCCodeGenerator lti4     :d :s	[ self cmpwI: 7 R: d R: s;  mfcrR: d;  rlwinmR: d R: d I: 29 I: 31 I: 31 ]
PowerPCCodeGenerator modi4    :d :s	[ self divwR: r0 R: d R: s;  mullwR: r0 R: r0 R: s;  subfR: d R: r0 R: d ]
PowerPCCodeGenerator muli4    :d :s	[ self mullwR: d R: d R: s ]
PowerPCCodeGenerator negi4    :d	[ self negR: d R: d ]
PowerPCCodeGenerator nei4     :d :s	[ self xorR: r12 R: d R: s;  addicR: r0 R: r12 I: -1;  subfeR: d R: r0 R: r12 ]
PowerPCCodeGenerator noti4    :d	[ self subficR: r0 R: d I: 0;  addeR: d R: r0 R: d ]
PowerPCCodeGenerator ori4     :d :s	[ self orR: d R: d R: s ]
PowerPCCodeGenerator reti4    :s	[ self mrR: r3 R: s; emitEpilogue ]
PowerPCCodeGenerator subi4    :d :s	[ self subR: d R: d R: s ]
PowerPCCodeGenerator shli4    :d :s	[ self slwR: d R: d R: s ]
PowerPCCodeGenerator shri4    :d :s	[ self srawR: d R: d R: s ]
PowerPCCodeGenerator xori4    :d :s	[ self xorR: d R: d R: s ]
PowerPCCodeGenerator spilli4  :r :t	[ self stwR: r I: t offset R: t base ]
PowerPCCodeGenerator reloadi4 :r :t	[ self lwzR: r I: t offset R: t base ]

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

PowerPCCodeGenerator calli4 :call
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

StaticPowerPCCodeGenerator : PowerPCCodeGenerator ()

StaticPowerPCCodeGenerator emit: tree
[
    self finaliseFrame.
    tree emit: self.
]

StaticPowerPCCodeGenerator addrgp4  :d :v	[ StdOut
						      nextPutAll: '	lis	'; print: d; nextPutAll: ',hi16('; print: v; nextPutAll: ')\n';
						      nextPutAll: '	ori	'; print: d; nextPut: $,; print: d; nextPutAll: ',lo16('; print: v; nextPutAll: ')\n' ]
StaticPowerPCCodeGenerator addrjp4  :d :l	[ StdOut nextPutAll: '	movl	$L'; print: l ordinal; nextPut: $,; print: d; cr ]

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
StaticPowerPCCodeGenerator beqI: c L: l		[ StdOut nextPutAll: '	bne	cr'; print: c; nextPutAll: ',.+20\n'.  self baL: l ]
StaticPowerPCCodeGenerator blr			[ StdOut nextPutAll: '	blr\n' ]
StaticPowerPCCodeGenerator blrl			[ StdOut nextPutAll: '	blrl\n' ]
StaticPowerPCCodeGenerator bneI: c L: l		[ StdOut nextPutAll: '	beq	cr'; print: c; nextPutAll: ',.+20\n'.  self baL: l ]
StaticPowerPCCodeGenerator cmpwI: d R: a R: b	[ StdOut nextPutAll: '	cmpw	cr'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator cmpwiI: d R: a I: i	[ StdOut nextPutAll: '	cmpwi	cr'; print: d; nextPut: $,; print: a; nextPut: $,; print: i; cr ]
StaticPowerPCCodeGenerator crnorI: d I: a I: b	[ StdOut nextPutAll: '	crnor	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator divwR: d R: a R: b	[ StdOut nextPutAll: '	divw	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator lbzR: d I: i R: s	[ StdOut nextPutAll: '	lbz	'; print: d; nextPut: $,; print: i; nextPut: $,; print: s; cr ]
StaticPowerPCCodeGenerator lhzR: d I: i R: s	[ StdOut nextPutAll: '	lhz	'; print: d; nextPut: $,; print: i; nextPut: $,; print: s; cr ]
StaticPowerPCCodeGenerator lisR: d I_: _i	[ StdOut nextPutAll: '	lis	'; print: d; nextPut: $,; print: (SmallInteger value_: _i) >> 16; cr ]
StaticPowerPCCodeGenerator lwzR: d I: i R: s	[ StdOut nextPutAll: '	lwz	'; print: d; nextPut: $,; print: i; nextPut: $(; print: s; nextPut: $); cr ]
StaticPowerPCCodeGenerator mfcrR: d		[ StdOut nextPutAll: '	mfcr	'; print: d; cr ]
StaticPowerPCCodeGenerator mflrR: d		[ StdOut nextPutAll: '	mflr	'; print: d; cr ]
StaticPowerPCCodeGenerator mrR: d R: s		[ d == s ifFalse: [StdOut nextPutAll: '	mr	'; print: d; nextPut: $,; print: s; cr ] ]
StaticPowerPCCodeGenerator mtlrR: d		[ StdOut nextPutAll: '	mtlr	'; print: d; cr ]
StaticPowerPCCodeGenerator mullwR: d R: a R: b	[ StdOut nextPutAll: '	mullw	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator negR: d R: s		[ StdOut nextPutAll: '	neg	'; print: d; nextPut: $,; print: s; cr ]
StaticPowerPCCodeGenerator orR: d R: a R: b	[ StdOut nextPutAll: '	or	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator oriR: d R: s I_: _i	[ StdOut nextPutAll: '	ori	'; print: d; nextPut: $,; print: s; nextPut: $,; print: (SmallInteger value_: _i) & 0xffff; cr ]
StaticPowerPCCodeGenerator rlwinmR: d R: s I: i I: j I: k	[ StdOut nextPutAll: '	rlwinm	'; print: d; nextPut: $,; print: s; nextPut: $,; print: i; nextPut: $,; print: j; nextPut: $,; print: k; cr ]
StaticPowerPCCodeGenerator slwR: d R: a R: b	[ StdOut nextPutAll: '	slw	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator srawR: d R: a R: b	[ StdOut nextPutAll: '	sraw	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator stbR: d I: i R: s	[ StdOut nextPutAll: '	stb	'; print: d; nextPut: $,; print: i; nextPut: $(; print: s; nextPut: $); cr ]
StaticPowerPCCodeGenerator sthR: d I: i R: s	[ StdOut nextPutAll: '	sth	'; print: d; nextPut: $,; print: i; nextPut: $(; print: s; nextPut: $); cr ]
StaticPowerPCCodeGenerator stwR: d I: i R: s	[ StdOut nextPutAll: '	stw	'; print: d; nextPut: $,; print: i; nextPut: $(; print: s; nextPut: $); cr ]
StaticPowerPCCodeGenerator stwuR: d I: i R: s	[ StdOut nextPutAll: '	stwu	'; print: d; nextPut: $,; print: i; nextPut: $(; print: s; nextPut: $); cr ]
StaticPowerPCCodeGenerator subR: d R: a R: b	[ StdOut nextPutAll: '	sub	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator subfR: d R: a R: b	[ StdOut nextPutAll: '	subf	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator subfeR: d R: a R: b	[ StdOut nextPutAll: '	subfe	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticPowerPCCodeGenerator subficR: d R: s I: i	[ StdOut nextPutAll: '	subfic	'; print: d; nextPut: $,; print: s; nextPut: $,; print: i; cr ]
StaticPowerPCCodeGenerator xorR: d R: a R: b	[ StdOut nextPutAll: '	xor	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]

"----------------------------------------------------------------"

DynamicPowerPCCodeGenerator : PowerPCCodeGenerator ()

DynamicPowerPCCodeGenerator emit: tree
[
    | _entry |
    { asm_pass= 0; }.
    { asm_pc= 0; }.
    self finaliseFrame.
    tree emit: self.
    CompilerOptions verboseExec ifTrue: [{ printf("code size %d bytes\n", (int)asm_pc); }].
    { asm_pc= (insn *)malloc((long)asm_pc); }.
    { asm_pass= 2; }.
    { v__entry= (oop)asm_pc; }.
    self relocateLabels_: self _asmPC.
    tree emit: self.
    CompilerOptions verboseExec ifTrue: [{ printf("code start %p\n", (void *)v__entry); }].
    { iflush((void *)v__entry, (void *)asm_pc); }.
]

DynamicPowerPCCodeGenerator asmPass	{ return (oop)(asm_pass << 1 | 1); }
DynamicPowerPCCodeGenerator _asmPC	{ return (oop)(asm_pc); }

SmallInteger _int	{ return (oop)((long)self >> 1); }

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
#   define _A(v)	((long)(((struct t_LABEL    *)(v_##v))->v__address))
}

DynamicPowerPCCodeGenerator addrgp4 :d :v	[ self lisR: d I_: v _address;  oriR: d R: d I_: v _address ]
DynamicPowerPCCodeGenerator addrjp4 :d :l	[ self lisR: d I_: l _address;  oriR: d R: d I_: l _address ]

DynamicPowerPCCodeGenerator addR: d R: a R: b	{ ADDrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator addeR: d R: a R: b	{ ADDErrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator addiR: d R: s I: i	{ ADDIrri	(_R(d), _R(s), _I(i)         	); }
DynamicPowerPCCodeGenerator addicR: d R: s I: i	{ ADDICrri	(_R(d), _R(s), _I(i)         	); }
DynamicPowerPCCodeGenerator andR: d R: a R: b	{ ANDrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator baL: l		{ LISri		(   0        ,(_A(l) >> 16)     );
						  ORIrri	(   0 ,    0 ,(_A(l) & 0xffff)  );
						  MTCTRr	(0				);
						  BCTR		(); }
DynamicPowerPCCodeGenerator beqI: c L: l	[{BNEii		(_I(c),        (long)asm_pc + 20);}.  self baL: l ]
DynamicPowerPCCodeGenerator blr			{ BLR		(); }
DynamicPowerPCCodeGenerator blrl		{ BLRL		(); }
DynamicPowerPCCodeGenerator bneI: c L: l	[{BEQii		(_I(c),        (long)asm_pc + 20);}.  self baL: l ]
DynamicPowerPCCodeGenerator cmpwI: d R: a R: b	{ CMPWirr	(_I(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator cmpwiI: d R: a I: i	{ CMPWIiri	(_I(d), _R(a), _I(i)         	); }
DynamicPowerPCCodeGenerator crnorI: d I: a I: b	{ CRNORiii	(_I(d), _I(a), _I(b)         	); }
DynamicPowerPCCodeGenerator divwR: d R: a R: b	{ DIVWrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator lbzR: d I: i R: s	{ LBZrm		(_R(d), _I(i), _R(s)		); }
DynamicPowerPCCodeGenerator lhzR: d I: i R: s	{ LHZrm		(_R(d), _I(i), _R(s)		); }
DynamicPowerPCCodeGenerator lisR: d I_: _i	{ LISri		(_R(d),        _P(i >> 16)   	); }
DynamicPowerPCCodeGenerator lwzR: d I: i R: s	{ LWZrm		(_R(d), _I(i), _R(s)		); }
DynamicPowerPCCodeGenerator mfcrR: d		{ MFCRr		(_R(d)			     	); }
DynamicPowerPCCodeGenerator mflrR: d		{ MFLRr		(_R(d)			     	); }
DynamicPowerPCCodeGenerator mtlrR: d		{ MTLRr		(_R(d)			     	); }
DynamicPowerPCCodeGenerator mullwR: d R: a R: b	{ MULLWrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator negR: d R: s	{ NEGrr		(_R(d), _R(s)		     	); }
DynamicPowerPCCodeGenerator orR: d R: a R: b	{ ORrrr		(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator oriR: d R: s I_: _i	{ ORIrri	(_R(d), _R(s), _P(i & 0xffff)	); }
DynamicPowerPCCodeGenerator rlwinmR: d R: s I: i I: j I:k	{ RLWINMrriii	(_R(d), _R(s), _I(i), _I(j), _I(k)); }
DynamicPowerPCCodeGenerator slwR: d R: a R: b	{ SLWrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator srawR: d R: a R: b	{ SRAWrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator stbR: d I: i R: s	{ STBrm		(_R(d), _I(i), _R(s)		); }
DynamicPowerPCCodeGenerator sthR: d I: i R: s	{ STHrm		(_R(d), _I(i), _R(s)		); }
DynamicPowerPCCodeGenerator stwR: d I: i R: s	{ STWrm		(_R(d), _I(i), _R(s)		); }
DynamicPowerPCCodeGenerator stwuR: d I: i R: s	{ STWUrm	(_R(d), _I(i), _R(s)		); }
DynamicPowerPCCodeGenerator subR: d R: a R: b	{ SUBrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator subfR: d R: a R: b	{ SUBFrrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator subfeR: d R: a R: b	{ SUBFErrr	(_R(d), _R(a), _R(b)         	); }
DynamicPowerPCCodeGenerator subficR: d R: s I: i{ SUBFICrri	(_R(d), _R(s), _I(i)         	); }
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
