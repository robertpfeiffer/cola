" CodeGenerator-ppc.st -- translate abstract Instructions to x86 machine instructions

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

  Last edited: 2007-07-24 18:08:51 by piumarta on emilia.lax04.mtt
"

{ import: Objects }
{ import: Expression }
{ import: Resource }
{ import: Instruction }
{ import: CompilerOptions }
{ import: CodeGenerator }

{ include "asm-arm.h" }

ARMCodeGenerator : CodeGenerator ( tempsSize registerList r0 r1 ip sp lr pc )

ARMCodeGenerator new
[
    self := super new.
    tempsSize := 0.
    ccrs
	add: (r0 := Register withClass: I4 name:  'r0' encoding:  0);
	add: (r1 := Register withClass: I4 name:  'r1' encoding:  1);
	add: (      Register withClass: I4 name:  'r2' encoding:  2);
	add: (      Register withClass: I4 name:  'r3' encoding:  3).
    csrs
	add: (      Register withClass: I4 name:  'r4' encoding:  4);
	add: (      Register withClass: I4 name:  'r5' encoding:  5);
	add: (      Register withClass: I4 name:  'r6' encoding:  6);
	add: (      Register withClass: I4 name:  'r7' encoding:  7);
	add: (      Register withClass: I4 name:  'r8' encoding:  8);
	add: (      Register withClass: I4 name:  'r9' encoding:  9);
	add: (      Register withClass: I4 name: 'r10' encoding: 10);
	add: (      Register withClass: I4 name: 'r11' encoding: 11).
    	      ip := Register withClass: P4 name:  'ip' encoding: 12.
    	      sp := Register withClass: P4 name:  'sp' encoding: 13.
    	      lr := Register withClass: P4 name:  'lr' encoding: 14.
    	      pc := Register withClass: P4 name:  'pc' encoding: 15.
]

ARMCodeGenerator clobberRegisters: insn	[ insn clobberARM: self ]

Instruction clobberARM: gen	[]

Call	clobberARM: gen [ gen clobberCall: self; requireFrame ]
DIVI4	clobberARM: gen [ gen clobberCall: self; requireFrame ]
MODI4	clobberARM: gen [ gen clobberCall: self; requireFrame ]

ARMCodeGenerator clobberCall: insn	[ ccrs do: [:ccr | self clobberRegister: ccr] ]
ARMCodeGenerator clobberR0: insn	[ self clobberRegister: r0 ]
ARMCodeGenerator clobberR1: insn	[ self clobberRegister: r1 ]

ARMCodeGenerator allocateParam: insn
[
    ^(params add: (Temporary withBase: sp offset: params size * 4)) allocate
]

ARMCodeGenerator allocateSpill: insn
[
    spills do: [:temp | temp live ifFalse: [^temp allocate]].
    ^(spills add: (Temporary withBase: sp offset: 0)) allocate
]

ARMCodeGenerator allocateTemp: insn
[
    temps do: [:temp | temp live ifFalse: [^temp allocate]].
    ^(temps add: (Temporary withBase: sp offset: 0)) allocate
]

" |           	  |
  | in arg N-1 	  |
  | in arg 4  	  | <-- SP
  | in arg 3  	  | <= r3 [spilled iff varargs]
  | in arg 2  	  | <= r2 [spilled iff varargs]
  | in arg 1  	  | <= r1 [spilled iff varargs]
  | in arg 0  	  | <= r0 [spilled iff varargs]
  |-------------  |
  | saved LR   	  |
  | ...temps...	  |
  | out params... | <-- SP'
"

ARMCodeGenerator finaliseFrame
[
    | align |
    frameSize := parametersSize - 16 max: 0.				"outgoing parameters (first four words passed in registers)"
    spills do: [:temp |
	temp offset: frameSize.
	frameSize := frameSize + 4].					"temporary variable"
    temps do: [:temp |
	temp offset: frameSize.
	frameSize := frameSize + 4].					"temporary variable"
    tempsSize := frameSize.						"offset to first first four words of incoming arguments"
    registerList := 0.
    csrs do: [:reg | reg used
	ifTrue:
	   [frameSize := frameSize + 4.					"callee-saved register"
	    registerList := registerList bitOr: 1 << reg encoding]].
    needsFrame
	ifTrue:
	   [frameSize := frameSize + 4.					"saved LR[,SP]"
	    align := (frameSize + 15 bitAnd: -16) - frameSize.
	    tempsSize := tempsSize + align.
	    frameSize := frameSize + align].
    params do: [:param | param offset: param offset + frameSize].
]

ARMCodeGenerator emitPrologue
[
    | mask |
    params isEmpty ifFalse:	[self stmfdW: sp L: 0x000f].			"push up to four incoming args"
    mask := registerList.
    needsFrame ifTrue: [mask := mask bitOr: 0x4000].				"lr[+sp]"
    mask == 0 ifFalse:		[self stmfdW: sp L: mask].			"push lr"
    tempsSize == 0 ifFalse:	[self subR: sp R: sp r: 30 I: tempsSize >> 2].	"push temp space"
]

ARMCodeGenerator emitEpilogue
[
    | mask |
    tempsSize == 0 ifFalse:	[self addR: sp R: sp r: 30 I: tempsSize >> 2].	"pop temp space"
    mask := registerList.
    needsFrame ifTrue: [mask := mask bitOr: 0x4000].				"lr[+sp]"
    mask == 0 ifFalse:		[self ldmfdW: sp L: mask].			"pop lr"
    params isEmpty ifFalse:	[self addR: sp R: sp r: 0 I: 16].		"pop up to four incoming args"
    self movR: pc R: lr.
]

ARMCodeGenerator noteCall: call
[
    parametersSize := parametersSize max: call arity * 4.
]

ARMCodeGenerator calli4: call
[
    | func |
    call arity - 1 downTo: 0 do: [:index | self emit: call argumentAt: index].
    (func := call function) reload: self.
    self blxR: func output.
    self movR: call output R: r0.
]

ARMCodeGenerator emit: call argumentAt: index
[
    | insn |
    (insn := call argumentAt: index) reload: self.
    index < 4
	ifTrue:  [self movR: (ccrs at: index) R: insn output]
	ifFalse: [self strR: insn output Mb: sp d: index - 4 * 4]
]

ARMCodeGenerator spilli4:  reg to:   tmp	[ self strR: reg Mb: tmp base d: tmp offset ]
ARMCodeGenerator reloadi4: reg from: tmp	[ self ldrR: reg Mb: tmp base d: tmp offset ]

"----------------------------------------------------------------"

SmallInteger value_: _int shr: shift and: mask
{
    _return (oop)((((long)v__int >> ((long)v_shift >> 1)) & ((long)v_mask >> 1)) << 1 | 1);
}

StaticARMCodeGenerator : ARMCodeGenerator ()

StaticARMCodeGenerator define: l			[ StdOut nextPutAll: 'L'; print: l ordinal; nextPut: $:; cr ]

StaticARMCodeGenerator addR: d R: a	 R: b		[ StdOut nextPutAll: '	add	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticARMCodeGenerator addR: d R: s r: r I: i		[ StdOut nextPutAll: '	add	'; print: d; nextPut: $,; print: s; nextPutAll: ',#'; print: i; nextPutAll: ' ROR #'; print: r; cr ]
StaticARMCodeGenerator andR: d R: a	 R: b		[ StdOut nextPutAll: '	and	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticARMCodeGenerator bL: l				[ StdOut nextPutAll: '	b	L'; print: l ordinal; cr ]
StaticARMCodeGenerator beqL: l				[ StdOut nextPutAll: '	beq	L'; print: l ordinal; cr ]
StaticARMCodeGenerator blxR: r				[ StdOut nextPutAll: '	blx	'; print: r; cr ]
StaticARMCodeGenerator bneL: l				[ StdOut nextPutAll: '	bne	L'; print: l ordinal; cr ]
StaticARMCodeGenerator cmpR: d		 I: i		[ StdOut nextPutAll: '	cmp	'; print: d; nextPutAll: ',#'; print: i; cr ]
StaticARMCodeGenerator cmpR: d	    r: r I: i		[ StdOut nextPutAll: '	cmp	'; print: d; nextPutAll: ',#'; print: i; nextPutAll: ' ROR #'; print: r; cr ]
StaticARMCodeGenerator cmpR: d		 R: s		[ StdOut nextPutAll: '	cmp	'; print: d; nextPut: $,; print: s; cr ]
StaticARMCodeGenerator eorR: d R: a	 R: b		[ StdOut nextPutAll: '	eor	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]

StaticARMCodeGenerator ldmfdW: d	 L: l
[
    | first |
    StdOut nextPutAll: '	ldmfd	'; print: d; nextPutAll: '!,{'.
    first := true.
    0 to: 15 do: [:r |
	(l bitAnd: (1 << r)) == 0
	    ifFalse:
	       [first ifTrue: [first := false] ifFalse: [StdOut nextPut: $,].
		StdOut nextPut: $r; print: r]].
    StdOut nextPutAll: '}\n'
]

StaticARMCodeGenerator ldrR: r	   Mb: b		[ StdOut nextPutAll: '	ldr	'; print: r; nextPutAll: ',['; print: b; nextPutAll: ']\n' ]
StaticARMCodeGenerator ldrR: r	   Mb: b d: d		[ StdOut nextPutAll: '	ldr	'; print: r; nextPutAll: ',['; print: b; nextPutAll: ',#'; print: d; nextPutAll: ']\n' ]
StaticARMCodeGenerator ldrbR: r	   Mb: b		[ StdOut nextPutAll: '	ldrb	'; print: r; nextPutAll: ',['; print: b; nextPutAll: ']\n' ]
StaticARMCodeGenerator ldrhR: r	   Mb: b		[ StdOut nextPutAll: '	ldrh	'; print: r; nextPutAll: ',['; print: b; nextPutAll: ']\n' ]
StaticARMCodeGenerator movR: d		 R: s		[ d == s ifFalse: [StdOut nextPutAll: '	mov	'; print: d; nextPut: $,; print: s; cr] ]
StaticARMCodeGenerator movR: d		 R: s asrR: t	[ StdOut nextPutAll: '	mov	'; print: d; nextPut: $,; print: s; nextPutAll: ',ASR '; print: t; cr]
StaticARMCodeGenerator movR: d		 R: s lslR: t	[ StdOut nextPutAll: '	mov	'; print: d; nextPut: $,; print: s; nextPutAll: ',LSL '; print: t; cr]
StaticARMCodeGenerator movR: d	    r: r I: i		[ StdOut nextPutAll: '	mov	'; print: d; nextPutAll: ',#'; print: i; nextPutAll: ' ROR #'; print: r; cr ]
StaticARMCodeGenerator moveqR: d	 I: i		[ StdOut nextPutAll: '	moveq	'; print: d; nextPutAll: ',#'; print: i; cr ]
StaticARMCodeGenerator movgeR: d	 I: i		[ StdOut nextPutAll: '	movge	'; print: d; nextPutAll: ',#'; print: i; cr ]
StaticARMCodeGenerator movgtR: d	 I: i		[ StdOut nextPutAll: '	movgt	'; print: d; nextPutAll: ',#'; print: i; cr ]
StaticARMCodeGenerator movleR: d	 I: i		[ StdOut nextPutAll: '	movle	'; print: d; nextPutAll: ',#'; print: i; cr ]
StaticARMCodeGenerator movltR: d	 I: i		[ StdOut nextPutAll: '	movlt	'; print: d; nextPutAll: ',#'; print: i; cr ]
StaticARMCodeGenerator movneR: d	 I: i		[ StdOut nextPutAll: '	movne	'; print: d; nextPutAll: ',#'; print: i; cr ]
StaticARMCodeGenerator mvnR: d		 R: s		[ StdOut nextPutAll: '	mvn	'; print: d; nextPut: $,; print: s; cr ]
StaticARMCodeGenerator mulR: d R: a	 R: b		[ StdOut nextPutAll: '	mul	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticARMCodeGenerator orrR: d R: s r: r I: i		[ StdOut nextPutAll: '	orr	'; print: d; nextPut: $,; print: s; nextPutAll: ',#'; print: i; nextPutAll: ' ROR #'; print: r; cr ]
StaticARMCodeGenerator orrR: d R: a	 R: b		[ StdOut nextPutAll: '	orr	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]
StaticARMCodeGenerator rsbR: d R: s	 I: i		[ StdOut nextPutAll: '	rsb	'; print: d; nextPut: $,; print: s; nextPutAll: ',#'; print: i; cr ]

StaticARMCodeGenerator stmfdW: d L: l
[
    | first |
    StdOut nextPutAll: '	stmfd	'; print: d; nextPutAll: '!,{'.
    first := true.
    0 to: 15 do: [:r |
	(l bitAnd: (1 << r)) == 0
	    ifFalse:
	       [first ifTrue: [first := false] ifFalse: [StdOut nextPut: $,].
		StdOut nextPut: $r; print: r.]].
    StdOut nextPutAll: '}\n'
]

StaticARMCodeGenerator strR: r     Mb: b		[ StdOut nextPutAll: '	str	'; print: r; nextPutAll: ',['; print: b; nextPutAll: ']\n' ]
StaticARMCodeGenerator strR: r     Mb: b d: d		[ StdOut nextPutAll: '	str	'; print: r; nextPutAll: ',['; print: b; nextPutAll: ',#'; print: d; nextPutAll: ']\n' ]
StaticARMCodeGenerator strbR: r	   Mb: b		[ StdOut nextPutAll: '	strb	'; print: r; nextPutAll: ',['; print: b; nextPutAll: ']\n' ]
StaticARMCodeGenerator strhR: r	   Mb: b		[ StdOut nextPutAll: '	strh	'; print: r; nextPutAll: ',['; print: b; nextPutAll: ']\n' ]
StaticARMCodeGenerator subR: d R: s r: r I: i		[ StdOut nextPutAll: '	sub	'; print: d; nextPut: $,; print: s; nextPutAll: ',#'; print: i; nextPutAll: ' ROR #'; print: r; cr ]
StaticARMCodeGenerator subR: d R: a	 R: b		[ StdOut nextPutAll: '	sub	'; print: d; nextPut: $,; print: a; nextPut: $,; print: b; cr ]

"----------------------------------------------------------------"

DynamicARMCodeGenerator : ARMCodeGenerator ()

DynamicARMCodeGenerator asmPass	{ _return (oop)(asm_pass << 1 | 1); }
DynamicARMCodeGenerator _asmPC	{ _return (oop)(asm_pc); }

SmallInteger _int	{ _return (oop)((long)self >> 1); }

DynamicARMCodeGenerator define: l
[
    self asmPass == 0
	ifTrue:  [l address_: self _asmPC]
	ifFalse: [l phaseCheck_: self _asmPC]
]

DynamicARMCodeGenerator _
{
    (void)asmFail;
#   undef _P
#   undef _I
#   undef _R
#   undef _A
#   define _P(v)	((long)v__##v)
#   define _I(v)	((long)v_##v >> 1)
#   define _R(v)	((long)(((struct t_Register *)(v_##v))->v__encoding))
#   define _A(v)	((long)(((struct t_Label    *)(v_##v))->v__address))
}

DynamicARMCodeGenerator addR: d R: a	   R: b		{ ADDrrr(14, 0, _R(d), _R(a),	       _R(b)); }
DynamicARMCodeGenerator addR: d R: s r: r  I: i		{ ADDrri(14, 0, _R(d), _R(s), _I(r)/2, _I(i)); }
DynamicARMCodeGenerator andR: d R: a	   R: b		{ ANDrrr(14, 0, _R(d), _R(a),	       _R(b)); }
DynamicARMCodeGenerator cmpR: d		   I: i		{ CMPri	(14,    _R(d),	            0, _I(i)); }
DynamicARMCodeGenerator cmpR: d	     r: r  I: i		{ CMPri	(14,    _R(d),	      _I(r)/2, _I(i)); }
DynamicARMCodeGenerator cmpR: d		   R: s		{ CMPrr	(14,    _R(d),		       _R(s)); }
DynamicARMCodeGenerator bL: l				{ Bi	(14,			       _A(l)); }
DynamicARMCodeGenerator beqL: l				{ Bi	(00,			       _A(l)); }
DynamicARMCodeGenerator blxR: r				{ BLXr	(14,			       _R(r)); }
DynamicARMCodeGenerator bneL: l				{ Bi	(01,			       _A(l)); }
DynamicARMCodeGenerator eorR: d R: a	   R: b		{ EORrrr(14, 0, _R(d), _R(a),	       _R(b)); }
DynamicARMCodeGenerator ldmfdW: d	   L: l		{ LDMwl	(14, 1, _R(d), _I(l), 0); }
DynamicARMCodeGenerator ldrR: r	    Mb: b		{ LDRrm	(14, 0, 0, _R(r), _R(b), 0); }
DynamicARMCodeGenerator ldrR: r	    Mb: b  d: d		{ LDRrmpf(14, 0, 0, _R(r), _R(b), 1, _I(d), 0); }
DynamicARMCodeGenerator ldrbR: r    Mb: b		{ LDRrm	(14, 1, 0, _R(r), _R(b), 0); }
DynamicARMCodeGenerator ldrhR: r    Mb: b		{ LDRHrm(14, 0, 0, 1, 1, _R(r), _R(b), 0); }
DynamicARMCodeGenerator movR: d		   R: s		{ if (_R(d) != _R(s)) MOVrr(14, 0, _R(d), _R(s)); }
DynamicARMCodeGenerator movR: d		   R: m asrR: s	{ MOVrrs(14, 0, _R(d), _R(m), 2, _R(s), 1); }
DynamicARMCodeGenerator movR: d		   R: m lslR: s	{ MOVrrs(14, 0, _R(d), _R(m), 0, _R(s), 1); }
DynamicARMCodeGenerator movR: d	     r: r  I: i		{ MOVri	(14, 0, _R(d),	      _I(r)/2, _I(i)); }
DynamicARMCodeGenerator moveqR: d	   I: i		{ MOVri	(00, 0, _R(d),		    0, _I(i)); }
DynamicARMCodeGenerator movgeR: d	   I: i		{ MOVri	(10, 0, _R(d),		    0, _I(i)); }
DynamicARMCodeGenerator movgtR: d	   I: i		{ MOVri	(12, 0, _R(d),		    0, _I(i)); }
DynamicARMCodeGenerator movleR: d	   I: i		{ MOVri	(13, 0, _R(d),		    0, _I(i)); }
DynamicARMCodeGenerator movltR: d	   I: i		{ MOVri	(11, 0, _R(d),		    0, _I(i)); }
DynamicARMCodeGenerator movneR: d	   I: i		{ MOVri	(01, 0, _R(d),		    0, _I(i)); }
DynamicARMCodeGenerator mulR: d R: a	   R: b		{ MULrrr(14, 0, _R(d), _R(a),	       _R(b)); }
DynamicARMCodeGenerator mvnR: d		   R: s		{ MVNrr	(14, 0, _R(d), _R(s)); }
DynamicARMCodeGenerator orrR: d R: s r: r  I: i		{ ORRrri(14, 0, _R(d), _R(s), _I(r)/2, _I(i)); }
DynamicARMCodeGenerator orrR: d R: a	   R: b		{ ORRrrr(14, 0, _R(d), _R(a),	       _R(b)); }
DynamicARMCodeGenerator rsbR: d R: s	   I: i		{ RSBrri(14, 0, _R(d), _R(s),       0, _I(i)); }
DynamicARMCodeGenerator stmfdW: d	   L: l		{ STMwl	(14, 2, _R(d), _I(l), 0); }
DynamicARMCodeGenerator strR: r	    Mb: b		{ STRrm	(14, 0, 0, _R(r), _R(b), 0); }
DynamicARMCodeGenerator strR: r	    Mb: b  d: d		{ STRrmpf(14, 0, 0, _R(r), _R(b), 1, _I(d), 0); }
DynamicARMCodeGenerator strbR: r    Mb: b		{ STRrm	(14, 1, 0, _R(r), _R(b), 0); }
DynamicARMCodeGenerator strhR: r    Mb: b		{ STRHrm(14, 0, 0, 0, 1, _R(r), _R(b), 0); }
DynamicARMCodeGenerator subR: d R: s r: r  I: i		{ SUBrri(14, 0, _R(d), _R(s), _I(r)/2, _I(i)); }
DynamicARMCodeGenerator subR: d R: a	   R: b		{ SUBrrr(14, 0, _R(d), _R(a),	       _R(b)); }

"----------------------------------------------------------------"

CodeGenerator versionString	[ ^self default versionString ]

CodeGenerator default		[ ^ARMCodeGenerator ]

ARMCodeGenerator static	[ ^StaticARMCodeGenerator ]
ARMCodeGenerator dynamic	[ ^DynamicARMCodeGenerator ]

ARMCodeGenerator versionString
[
    ^'ARM 1.0'
]

"----------------------------------------------------------------"

CodeGenerator		   isStatic	[ ^false ]
StaticARMCodeGenerator isStatic	[ ^true ]

CodeGenerator		    isDynamic	[ ^false ]
DynamicARMCodeGenerator isDynamic	[ ^true ]

StaticARMCodeGenerator defineVariable: name
[
    StdOut nextPutAll: '	.data\n'.
    StdOut nextPutAll: name; nextPutAll: ':	.long	_'; nextPutAll: name; cr.
    StdOut nextPutAll: '	.text\n'.
]

DynamicARMCodeGenerator defineVariable: name
[
]

"----------------------------------------------------------------"

{ import: Grammar }

ARMCodeGenerator r0		[ ^r0 ]
ARMCodeGenerator r1		[ ^r1 ]
ARMCodeGenerator ip		[ ^ip ]
ARMCodeGenerator sp		[ ^sp ]
ARMCodeGenerator lr		[ ^lr ]
ARMCodeGenerator frameSize	[ ^frameSize ]

ARMCodeGenerator movR: r P32_: _i
[
    self
	movR: r	     r:  0 I: (SmallInteger value_: _i shr:  0 and: 255);
	orrR: r R: r r: 24 I: (SmallInteger value_: _i shr:  8 and: 255);
	orrR: r R: r r: 16 I: (SmallInteger value_: _i shr: 16 and: 255);
	orrR: r R: r r:  8 I: (SmallInteger value_: _i shr: 24 and: 255)
]

ARMCodeGenerator movR: r I32_: _i
[
    | i |
    self movR: r r:  0 I: (SmallInteger value_: _i shr:  0 and: 255).
    (i := SmallInteger value_: _i shr:  8 and: 255) == 0 ifFalse: [self orrR: r R: r r: 24 I: i].
    (i := SmallInteger value_: _i shr: 16 and: 255) == 0 ifFalse: [self	orrR: r R: r r: 16 I: i].
    (i := SmallInteger value_: _i shr: 24 and: 255) == 0 ifFalse: [self	orrR: r R: r r:  8 I: i].
]

ARMCodeGenerator __aeabi_idiv		{ extern int __aeabi_idiv   (int, int);  _return (oop)__aeabi_idiv;	}
ARMCodeGenerator __aeabi_idivmod	{ extern int __aeabi_idivmod(int, int);  _return (oop)__aeabi_idivmod;	}

ARMGrammar := [
    ReductionGrammar new
	"-------------------------------- baseline --------------------------------"

	at: #VOID add: #REG			"discard";
	at: #VOID add: #(label		)	do: [:op :gen | gen define: op];
	at: #VOID add: #(enter		)	do: [:op :gen | gen emitPrologue];
	at: #VOID add: #(retv		)	do: [:op :gen | gen emitEpilogue];
	at: #VOID add: #(reti4 	 REG	)	do: [:op :gen | gen movR:   gen r0			       R: op lhs output;  emitEpilogue];
	at: #VOID add: #(drop  	 REG	)	do: [:op :gen | ];
	at: #VOID add: #(brz   	 REG	)	do: [:op :gen | gen cmpR:   op lhs output		  r: 0 I: 0;  beqL: op destination];
	at: #VOID add: #(brnz  	 REG	)	do: [:op :gen | gen cmpR:   op lhs output		  r: 0 I: 0;  bneL: op destination];
	at: #VOID add: #(bra		)	do: [:op :gen | gen bL:     op destination];
	at: #REG  add: #(cnsti4	 	)	do: [:op :gen | gen movR:   op output   I32_: op arg];
	at: #REG  add: #(cnstp4	 	)	do: [:op :gen | gen movR:   op output   I32_: op arg];
	at: #REG  add: #(parami4 	)	do: [:op :gen | ];
	at: #REG  add: #(addrfp4 	)	do: [:op :gen | gen addR:   op output	   R: gen sp	 r: 30 I: gen frameSize / 4];
	at: #REG  add: #(addrgp4 	)	do: [:op :gen | gen movR:   op output   I32_: op arg _address];
	at: #REG  add: #(addrjp4 	)	do: [:op :gen | gen movR:   op output   P32_: op arg _address];
	at: #REG  add: #(addrlp4 	)	do: [:op :gen | gen addR:   op output	   R: gen sp	 r: 30 I: op arg offset >> 2];
	at: #REG  add: #(indiri1 REG	)	do: [:op :gen | gen ldrbR:  op output     Mb: op lhs output];
	at: #REG  add: #(indiri2 REG	)	do: [:op :gen | gen ldrhR:  op output     Mb: op lhs output];
	at: #REG  add: #(indiri4 REG	)	do: [:op :gen | gen ldrR:   op output     Mb: op lhs output];
	at: #REG  add: #(noti4 	 REG	)	do: [:op :gen | gen cmpR:   op lhs output  I: 0;
								    movneR: op output	   I: 0;
								    moveqR: op output	   I: 1];
	at: #REG  add: #(comi4 	 REG	)	do: [:op :gen | gen mvnR:   op output	   R: op lhs output];
	at: #REG  add: #(negi4 	 REG	)	do: [:op :gen | gen rsbR:   op output	   R: op lhs output    I: 0];
	at: #REG  add: #(calli4	 REG	)	do: [:op :gen | gen calli4: op];
	at: #REG  add: #(asgni1  REG REG)	do: [:op :gen | gen strbR:  op lhs output Mb: op rhs output];
	at: #REG  add: #(asgni2  REG REG)	do: [:op :gen | gen strhR:  op lhs output Mb: op rhs output];
	at: #REG  add: #(asgni4  REG REG)	do: [:op :gen | gen strR:   op lhs output Mb: op rhs output];
	at: #REG  add: #(andi4   REG REG)	do: [:op :gen | gen andR:   op output 	   R: op lhs output    R: op rhs output];
	at: #REG  add: #(ori4    REG REG)	do: [:op :gen | gen orrR:   op output 	   R: op lhs output    R: op rhs output];
	at: #REG  add: #(xori4 	 REG REG)	do: [:op :gen | gen eorR:   op output 	   R: op lhs output    R: op rhs output];
	at: #REG  add: #(addi4 	 REG REG)	do: [:op :gen | gen addR:   op output 	   R: op lhs output    R: op rhs output];
	at: #REG  add: #(subi4 	 REG REG)	do: [:op :gen | gen subR:   op output 	   R: op lhs output    R: op rhs output];
	at: #REG  add: #(muli4 	 REG REG)	do: [:op :gen | gen mulR:   op output      R: op lhs output    R: op rhs output];
	at: #REG  add: #(divi4 	 REG REG)	do: [:op :gen | gen movR:   gen r0 	   R: op lhs output;
								    movR:   gen r1 	   R: op rhs output;
								    movR:   gen ip      I32_: gen __aeabi_idiv;
								    blxR:   gen ip;
								    movR:   op output	   R: gen r0];
	at: #REG  add: #(modi4 	 REG REG)	do: [:op :gen | gen movR:   gen r0 	   R: op lhs output;
								    movR:   gen r1 	   R: op rhs output;
								    movR:   gen ip      I32_: gen __aeabi_idivmod;
								    blxR:   gen ip;
								    movR:   op output 	   R: gen r1];
	at: #REG  add: #(shli4 	 REG REG)	do: [:op :gen | gen movR:   op output 	   R: op lhs output lslR: op rhs output];
	at: #REG  add: #(shri4 	 REG REG)	do: [:op :gen | gen movR:   op output 	   R: op lhs output asrR: op rhs output];
	at: #REG  add: #(lti4 	 REG REG)	do: [:op :gen | gen cmpR:   op lhs output  R: op rhs output;  movgeR: op output I: 0;  movltR: op output I: 1];
	at: #REG  add: #(lei4 	 REG REG)	do: [:op :gen | gen cmpR:   op lhs output  R: op rhs output;  movgtR: op output I: 0;  movleR: op output I: 1];
	at: #REG  add: #(eqi4 	 REG REG)	do: [:op :gen | gen cmpR:   op lhs output  R: op rhs output;  movneR: op output I: 0;  moveqR: op output I: 1];
	at: #REG  add: #(nei4 	 REG REG)	do: [:op :gen | gen cmpR:   op lhs output  R: op rhs output;  moveqR: op output I: 0;  movneR: op output I: 1];
	at: #REG  add: #(gei4 	 REG REG)	do: [:op :gen | gen cmpR:   op lhs output  R: op rhs output;  movltR: op output I: 0;  movgeR: op output I: 1];
	at: #REG  add: #(gti4 	 REG REG)	do: [:op :gen | gen cmpR:   op lhs output  R: op rhs output;  movleR: op output I: 0;  movgtR: op output I: 1];

	"-------------------------------- optimisations --------------------------------"
"
	at: #VOID add: #(brz (lti4 (indiri4 (addrlp4))
			           (cnsti4)))		do: [:op :gen | gen cmplI_:  op lhs rhs arg Md: op lhs lhs lhs arg offset b: op lhs lhs lhs arg base;
									    jgeL:    op destination ];

	at: #REG  add: #(indiri4 (addrlp4))		do: [:op :gen | gen movlMd:  op lhs arg offset b: op lhs arg base R: op output ];
	at: #REG  add: #(indiri4 (addrgp4))		do: [:op :gen | gen movlMd_: op lhs arg _address R: op output ];
	at: #REG  add: #(subi4 REG (cnsti4))		do: [:op :gen | gen sublI_:  op rhs arg R: op lhs output ];
	at: #REG  add: #(addi4 REG (cnsti4))		do: [:op :gen | gen addlI_:  op rhs arg R: op lhs output ];
	at: #REG  add: #(addi4 (cnsti4) REG)		do: [:op :gen | gen lealMd_: op lhs arg b: op rhs output R: op output ];
""
	at: #REG  add: #(indiri4 (addrgp4))	do: [:op :gen | gen lisR:  op output Iha_: op lhs arg _address;
								    lwzR:  op output I: (SmallInteger lo16_: op lhs arg _address) R: op output ];

	at: #REG  add: #(indiri4 (addrlp4))	do: [:op :gen | gen lwzR:  op output I: op lhs arg offset R: op lhs arg base ];
"
	yourself
]

"----------------------------------------------------------------"

ARMRegisterFilter    : RegisterAllocator ()
ARMRegisterAllocator : RegisterAllocator ()

ARMRegisterFilter    REG  :insn	[ ^true ]
ARMRegisterAllocator REG  :insn	[ ^codeGenerator allocateRegister: insn ]

ARMCodeGenerator grammar		[ ^ARMGrammar ]
ARMCodeGenerator registerFilter		[ ^ARMRegisterFilter   "on: self"]
ARMCodeGenerator registerAllocator	[ ^ARMRegisterAllocator on: self ]

"----------------------------------------------------------------"

StaticARMCodeGenerator generate: tree
[
    self finaliseFrame.
    tree printOn: StdOut indent: 0.  StdOut cr.
    tree generate: self.
    ^Array with: 0 with: 0
]

"
{ include ""dis-arm.c"" }
"

DynamicARMCodeGenerator generate: tree
[
    | _entry _size |
    { asm_pass= 0; }.
    { asm_pc= 0; }.
    self finaliseFrame.
    tree generate: self.
    CompilerOptions verboseExec ifTrue: [{ printf("code size %d bytes\n", (int)asm_pc); }].
    { v__size= (oop)asm_pc; }.
    { asm_pc= (insn *)malloc((long)asm_pc); }.
    { asm_pass= 2; }.
    { v__entry= (oop)asm_pc; }.
    self relocateLabels_: self _asmPC.
    tree generate: self.
    CompilerOptions verboseExec ifTrue: [{ printf("code start %p\n", (void *)v__entry); }].
    { iflush((void *)v__entry, (void *)asm_pc); }.
"
    CompilerOptions verboseExec ifTrue: [{ disassemble((void *)v__entry, (void *)asm_pc); }].
"
    ^Array with: _entry with: _size.
]
