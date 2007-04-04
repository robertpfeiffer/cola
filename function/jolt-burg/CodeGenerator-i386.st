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

  Last edited: 2007-04-04 07:28:45 by piumarta on alan-kays-computer.local
"

{ import: Objects }
{ import: Expression }
{ import: Resource }
{ import: Instruction }
{ import: CompilerOptions }
{ import: CodeGenerator }

{ include "asm-i386.h" }

Intel32CodeGenerator : CodeGenerator ( tempsSize eax ecx edx ebx esp ebp esi edi cx cl )

Intel32CodeGenerator new
[
    self := super new.
    tempsSize := 0.
    ccrs
	add: (eax := Register withClass: I4 name: '%eax' encoding: 0x40);
	add: (ecx := Register withClass: I4 name: '%ecx' encoding: 0x41);
	add: (edx := Register withClass: I4 name: '%edx' encoding: 0x42).
    csrs
	add: (ebx := Register withClass: I4 name: '%ebx' encoding: 0x43);
	add: (esi := Register withClass: I4 name: '%esi' encoding: 0x46);
	add: (edi := Register withClass: I4 name: '%edi' encoding: 0x47).
    	      esp := Register withClass: P4 name: '%esp' encoding: 0x44.
    	      ebp := Register withClass: P4 name: '%ebp' encoding: 0x45.
    	      cx  := Register withClass: I2 name: '%cx'  encoding: 0x21.
    	      cl  := Register withClass: I1 name: '%cl'  encoding: 0x11.
]

Intel32CodeGenerator clobberRegisters: insn	[ insn clobberIntel32: self ]

Instruction clobberIntel32: gen	[]

ADDRFP4 clobberIntel32: gen [ gen requireFrame ]
ASGNI1	clobberIntel32: gen [ gen clobberECX:   self ]
ASGNI2	clobberIntel32: gen [ gen clobberECX:   self ]
Call	clobberIntel32: gen [ gen clobberEACDX: self; requireFrame ]
DIVI4	clobberIntel32: gen [ gen clobberEADX: 	self; requireFrame ]
MODI4	clobberIntel32: gen [ gen clobberEADX: 	self; requireFrame ]
EQI4	clobberIntel32: gen [ gen clobberECX:  	self ]
LEI4	clobberIntel32: gen [ gen clobberECX:  	self ]
LTI4	clobberIntel32: gen [ gen clobberECX:  	self ]
GEI4	clobberIntel32: gen [ gen clobberECX:  	self ]
GTI4	clobberIntel32: gen [ gen clobberECX:  	self ]
NEI4	clobberIntel32: gen [ gen clobberECX:  	self ]
NOTI4	clobberIntel32: gen [ gen clobberECX:  	self ]
SHLI4	clobberIntel32: gen [ gen clobberECX:  	self ]
SHRI4	clobberIntel32: gen [ gen clobberECX:  	self ]
SHLU4	clobberIntel32: gen [ gen clobberECX:  	self ]
SHRU4	clobberIntel32: gen [ gen clobberECX:  	self ]

Intel32CodeGenerator clobberEACDX: insn	[ self clobberRegister: eax; clobberRegister: ecx; clobberRegister: edx ]
Intel32CodeGenerator clobberEADX: insn	[ self clobberRegister: eax; clobberRegister: edx ]
Intel32CodeGenerator clobberECX:  insn	[ self clobberRegister: ecx ]

Intel32CodeGenerator allocateParam: insn
[
    ^(params add: (Temporary withBase: esp offset: params size * 4)) allocate
]

Intel32CodeGenerator allocateSpill: insn
[
    spills do: [:temp | temp live ifFalse: [^temp allocate]].
    ^(spills add: (Temporary withBase: esp offset: 0)) allocate
]

Intel32CodeGenerator allocateTemp: insn
[
    temps do: [:temp | temp live ifFalse: [^temp allocate]].
    ^(temps add: (Temporary withBase: esp offset: 0)) allocate
]

Intel32CodeGenerator finaliseFrame
[
    | align |
    frameSize := 4.							"return address"
    tempsSize := 0.
    needsFrame ifTrue: [frameSize := frameSize + 4].			"saved frame pointer"
    csrs do: [:reg | reg used ifTrue: [frameSize := frameSize + 4]].	"callee-saved register"
    temps do: [:temp |
	temp offset: tempsSize + parametersSize.
	tempsSize := tempsSize + 4].					"temporary variable"
    spills do: [:temp |
	temp offset: tempsSize + parametersSize.
	tempsSize := tempsSize + 4].					"temporary variable"
    tempsSize := tempsSize + parametersSize.				"outgoing parameters"
    frameSize := frameSize + tempsSize.
    needsFrame
	ifTrue:
	   [align := (frameSize + 15 bitAnd: -16) - frameSize.
	    tempsSize := tempsSize + align.
	    frameSize := frameSize + align].
    needsFrame
	ifTrue:  [params do: [:param | param base: ebp; offset: param offset + 8]]
	ifFalse: [params do: [:param | param offset: param offset + frameSize]].
]

Intel32CodeGenerator emitPrologue
[
    needsFrame ifTrue: [self pushlR: ebp;  movlR: esp R: ebp].
    csrs do: [:reg | reg used ifTrue: [self pushlR: reg]].
    tempsSize > 0 ifTrue: [self sublI: tempsSize R: esp].
]

Intel32CodeGenerator emitEpilogue
[
    tempsSize > 0 ifTrue: [self addlI: tempsSize R: esp].
    csrs reverseDo: [:reg | reg used ifTrue: [self poplR: reg]].
    needsFrame ifTrue: [self poplR: ebp].
    self ret.
]

Intel32CodeGenerator noteCall: call
[
    parametersSize := parametersSize max: call arity * 4.
]

Intel32CodeGenerator calli4: call
[
    | func |
    call arity - 1 downTo: 0 do: [:index | self emit: call argumentAt: index].
    (func := call function) reload: self.
    self callMb: func output.
    self movlR: eax R: call output.
]

Intel32CodeGenerator emit: call argumentAt: index
[
    | insn |
    (insn := call argumentAt: index) reload: self.
    self movlR: insn output Md: index * 4 b: esp.
]

"----------------------------------------------------------------"

StaticIntel32CodeGenerator : Intel32CodeGenerator ()

StaticIntel32CodeGenerator addrgp4  :d :v	[ StdOut nextPutAll: '	movl	'; nextPut: $$; print: v; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator addrjp4  :d :l	[ StdOut nextPutAll: '	movl	$L'; print: l ordinal; nextPut: $,; print: d; cr ]

StaticIntel32CodeGenerator addlI: i R: d	[ StdOut nextPutAll: '	addl	'; nextPut: $$; print: i; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator addlI_: i R: d	[ StdOut nextPutAll: '	addl	'; nextPut: $$; print: (SmallInteger value_: i); nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator addlR: s R: d	[ StdOut nextPutAll: '	addl	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator andlR: s R: d	[ StdOut nextPutAll: '	andl	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator callMb: b		[ StdOut nextPutAll: '	call	('; print: b; nextPutAll: ')\n' ]
StaticIntel32CodeGenerator cltd			[ StdOut nextPutAll: '	cltd\n' ]
StaticIntel32CodeGenerator cmplI: i R: d	[ StdOut nextPutAll: '	cmpl	'; nextPut: $$; print: i; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator cmplI_: i Md: d b: b	[ StdOut nextPutAll: '	cmpl	'; nextPut: $$; print: (SmallInteger value_: i); nextPut: $,; print: d; nextPut: $(; print: b; nextPut: $); cr]
StaticIntel32CodeGenerator cmplR: s R: d	[ StdOut nextPutAll: '	cmpl	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator define: l		[ StdOut nextPutAll: 'L'; print: l ordinal; nextPut: $:; cr ]
StaticIntel32CodeGenerator idivlR: s		[ StdOut nextPutAll: '	idivl	'; print: s; cr ]
StaticIntel32CodeGenerator imullR: s R: d	[ StdOut nextPutAll: '	imull	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator jeL: l		[ StdOut nextPutAll: '	je	L'; print: l ordinal; cr ]
StaticIntel32CodeGenerator jgeL: l		[ StdOut nextPutAll: '	jge	L'; print: l ordinal; cr ]
StaticIntel32CodeGenerator jmpL: l		[ StdOut nextPutAll: '	jmp	L'; print: l ordinal; cr ]
StaticIntel32CodeGenerator jneL: l		[ StdOut nextPutAll: '	jne	L'; print: l ordinal; cr ]
StaticIntel32CodeGenerator lealMd: d b: b R: r	[ StdOut nextPutAll: '	leal	'; print: d; nextPut: $(; print: b; nextPutAll: '),'; print: r; cr]
StaticIntel32CodeGenerator lealMd_: d b: b R: r	[ StdOut nextPutAll: '	leal	'; print: (SmallInteger value_: d); nextPut: $(; print: b; nextPutAll: '),'; print: r; cr]
StaticIntel32CodeGenerator movbR: r Mb: b	[ StdOut nextPutAll: '	movb	'; print: r; nextPutAll: ',('; print: b; nextPut: $); cr ]
StaticIntel32CodeGenerator movlI_: i R: d	[ StdOut nextPutAll: '	movl	'; nextPut: $$; print: (SmallInteger value_: i); nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator movlMb: b R: r	[ StdOut nextPutAll: '	movl	('; print: b; nextPutAll: '),'; print: r; cr]
StaticIntel32CodeGenerator movlMd: d b: b R: r	[ StdOut nextPutAll: '	movl	'; print: d; nextPut: $(; print: b; nextPutAll: '),'; print: r; cr]
StaticIntel32CodeGenerator movlMd_: d R: r	[ StdOut nextPutAll: '	movl	'; print: (SmallInteger value_: d); nextPut: $,; print: r; cr ]
StaticIntel32CodeGenerator movlR: r Mb: b	[ StdOut nextPutAll: '	movl	'; print: r; nextPutAll: ',('; print: b; nextPut: $); cr ]
StaticIntel32CodeGenerator movlR: s Md: d b: b	[ StdOut nextPutAll: '	movl	'; print: s; nextPut: $,; print: d; nextPut: $(; print: b; nextPut: $); cr]
StaticIntel32CodeGenerator movlR: s R: d	[ s == d ifFalse: [StdOut nextPutAll: '	movl	'; print: s; nextPut: $,; print: d; cr] ]
StaticIntel32CodeGenerator movsblMb: s R: d	[ StdOut nextPutAll: '	movsbl	('; print: s; nextPutAll: '),'; print: d; cr ]
StaticIntel32CodeGenerator movswlMb: s R: d	[ StdOut nextPutAll: '	movswl	('; print: s; nextPutAll: '),'; print: d; cr ]
StaticIntel32CodeGenerator movwR: r Mb: b	[ StdOut nextPutAll: '	movw	'; print: r; nextPutAll: ',('; print: b; nextPut: $); cr ]
StaticIntel32CodeGenerator neglR: d		[ StdOut nextPutAll: '	negl	'; print: d; cr ]
StaticIntel32CodeGenerator notlR: d		[ StdOut nextPutAll: '	notl	'; print: d; cr ]
StaticIntel32CodeGenerator orlR: s R: d		[ StdOut nextPutAll: '	orl	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator poplR: d		[ StdOut nextPutAll: '	popl	'; print: d; cr ]
StaticIntel32CodeGenerator pushlR: s		[ StdOut nextPutAll: '	pushl	'; print: s; cr ]
StaticIntel32CodeGenerator ret			[ StdOut nextPutAll: '	ret\n' ]
StaticIntel32CodeGenerator sallR: s R: d	[ StdOut nextPutAll: '	sall	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator sarlR: s R: d	[ StdOut nextPutAll: '	sarl	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator seteR: d		[ StdOut nextPutAll: '	sete	'; print: d; cr ]
StaticIntel32CodeGenerator setgR: d		[ StdOut nextPutAll: '	setg	'; print: d; cr ]
StaticIntel32CodeGenerator setgeR: d		[ StdOut nextPutAll: '	setge	'; print: d; cr ]
StaticIntel32CodeGenerator setlR: d		[ StdOut nextPutAll: '	setl	'; print: d; cr ]
StaticIntel32CodeGenerator setleR: d		[ StdOut nextPutAll: '	setle	'; print: d; cr ]
StaticIntel32CodeGenerator setneR: d		[ StdOut nextPutAll: '	setne	'; print: d; cr ]
StaticIntel32CodeGenerator shllR: s R: d	[ StdOut nextPutAll: '	shll	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator shrlR: s R: d	[ StdOut nextPutAll: '	shrl	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator sublI: i R: d	[ StdOut nextPutAll: '	subl	'; nextPut: $$; print: i; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator sublI_: i R: d	[ StdOut nextPutAll: '	subl	'; nextPut: $$; print: (SmallInteger value_: i); nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator sublR: s R: d	[ StdOut nextPutAll: '	subl	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator testlR: s R: d	[ StdOut nextPutAll: '	testl	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator xorlR: s R: d	[ StdOut nextPutAll: '	xorl	'; print: s; nextPut: $,; print: d; cr ]

Intel32CodeGenerator spilli4:  reg to:   tmp	[ self movlR:  reg        Md: tmp offset b: esp ]
Intel32CodeGenerator reloadi4: reg from: tmp	[ self movlMd: tmp offset  b: esp        R: reg ]

"----------------------------------------------------------------"

DynamicIntel32CodeGenerator : Intel32CodeGenerator ()

DynamicIntel32CodeGenerator asmPass	{ return (oop)(asm_pass << 1 | 1); }
DynamicIntel32CodeGenerator _asmPC	{ return (oop)(asm_pc); }

SmallInteger _int	{ return (oop)((long)self >> 1); }

DynamicIntel32CodeGenerator define: l
[
    self asmPass == 0
	ifTrue:  [l address_: self _asmPC]
	ifFalse: [l phaseCheck_: self _asmPC]
]

DynamicIntel32CodeGenerator _
{
    (void)_W; (void)_D1; (void)_D4;
#   undef _P
#   undef _I
#   undef _R
#   undef _A
#   define _P(v)	((long)v__##v)
#   define _I(v)	((long)v_##v >> 1)
#   define _R(v)	((long)(((struct t_Register *)(v_##v))->v__encoding))
#   define _A(v)	((long)(((struct t_Label    *)(v_##v))->v__address))
}

DynamicIntel32CodeGenerator addlI: i R: d	  { ADDLir	(_I(i)          ,	_R(d)	 ); }
DynamicIntel32CodeGenerator addlI_: _i R: d	  { ADDLir	(_P(i)		,	_R(d)	 ); }
DynamicIntel32CodeGenerator addlR: s R: d	  { ADDLrr	(      _R(s)	, 	_R(d)    ); }
DynamicIntel32CodeGenerator andlR: s R: d	  { ANDLrr	(      _R(s)	, 	_R(d)    ); }
DynamicIntel32CodeGenerator cltd		  { CLTD	(				 ); }
DynamicIntel32CodeGenerator callMb: b		  { CALLm	(    0,_R(b),0,0		 ); }
DynamicIntel32CodeGenerator cmplI: i R: d	  { CMPLir	(_I(i)          ,	_R(d)	 ); }
DynamicIntel32CodeGenerator cmplI_: _i Md: d b: b { CMPLim	(_P(i)		, _I(d),_R(b),0,0); }
DynamicIntel32CodeGenerator cmplR: s R: d	  { CMPLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator idivlR: s		  { IDIVLrr	(      _R(s)	,	_EAX	 ); }
DynamicIntel32CodeGenerator imullR: s R: d	  { IMULLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator jeL: l		  { JEm		(_A(l),    0,0,0		 ); }
DynamicIntel32CodeGenerator jgeL: l		  { JGEm	(_A(l),	   0,0,0		 ); }
DynamicIntel32CodeGenerator jmpL: l		  { JMPm	(_A(l),	   0,0,0		 ); }
DynamicIntel32CodeGenerator jneL: l		  { JNEm	(_A(l),	   0,0,0		 ); }
DynamicIntel32CodeGenerator lealMd: d b: b R: r	  { LEALmr	(_I(d),_R(b),0,0,	_R(r)	 ); }
DynamicIntel32CodeGenerator lealMd_: _d b: b R: r { LEALmr	(_P(d),_R(b),0,0,	_R(r)	 ); }
DynamicIntel32CodeGenerator movbR: r Mb: b	  { MOVBrm	(      _R(r)	,     0,_R(b),0,0); }
DynamicIntel32CodeGenerator movlI_: _i R: d	  { MOVLir	(_P(i)		,	_R(d)	 ); }
DynamicIntel32CodeGenerator movlMb: b R: r	  { MOVLmr	(    0,_R(b),0,0,	_R(r)	 ); }
DynamicIntel32CodeGenerator movlMd: d b: b R: r	  { MOVLmr	(_I(d),_R(b),0,0,	_R(r)	 ); }
DynamicIntel32CodeGenerator movlMd_: _d R: r	  { MOVLmr	(_P(d),    0,0,0,	_R(r)	 ); }
DynamicIntel32CodeGenerator movlR: r Mb: b	  { MOVLrm	(      _R(r)	,     0,_R(b),0,0); }
DynamicIntel32CodeGenerator movlR: s Md: d b: b	  { MOVLrm	(      _R(s)	, _I(d),_R(b),0,0); }
DynamicIntel32CodeGenerator movlR: s R: d	  { MOVLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator movsblMb: s R: d	  { MOVSBLmr	(    0,_R(s),0,0, 	_R(d)	 ); }
DynamicIntel32CodeGenerator movswlMb: s R: d	  { MOVSWLmr	(    0,_R(s),0,0, 	_R(d)	 ); }
DynamicIntel32CodeGenerator movwR: r Mb: b	  { MOVWrm	(      _R(r)	,     0,_R(b),0,0); }
DynamicIntel32CodeGenerator neglR: d		  { NEGLr	(      			_R(d)	 ); }
DynamicIntel32CodeGenerator notlR: d		  { NOTLr	(      			_R(d)	 ); }
DynamicIntel32CodeGenerator orlR: s R: d	  { ORLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator poplR: d		  { POPLr	(      			_R(d)	 ); }
DynamicIntel32CodeGenerator pushlR: s		  { PUSHLr	(      _R(s)			 ); }
DynamicIntel32CodeGenerator ret			  { RET		(				 ); }
DynamicIntel32CodeGenerator sallR: s R: d	  { SALLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator sarlR: s R: d	  { SARLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator seteR: d		  { SETEr	(			_R(d)	 ); }
DynamicIntel32CodeGenerator setgR: d		  { SETGr	(			_R(d)	 ); }
DynamicIntel32CodeGenerator setgeR: d		  { SETGEr	(			_R(d)	 ); }
DynamicIntel32CodeGenerator setlR: d		  { SETLr	(			_R(d)	 ); }
DynamicIntel32CodeGenerator setleR: d		  { SETLEr	(			_R(d)	 ); }
DynamicIntel32CodeGenerator setneR: d		  { SETNEr	(			_R(d)	 ); }
DynamicIntel32CodeGenerator shllR: s R: d	  { SHLLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator shrlR: s R: d	  { SHRLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator sublI: i R: d	  { SUBLir	(_I(i)		,	_R(d)	 ); }
DynamicIntel32CodeGenerator sublI_: _i R: d	  { SUBLir	(_P(i)		,	_R(d)	 ); }
DynamicIntel32CodeGenerator sublR: s R: d	  { SUBLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator testlR: s R: d	  { TESTLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator xorlR: s R: d	  { XORLrr	(      _R(s)	,	_R(d)	 ); }

"----------------------------------------------------------------"

CodeGenerator versionString	[ ^self default versionString ]

CodeGenerator default		[ ^Intel32CodeGenerator ]

Intel32CodeGenerator static	[ ^StaticIntel32CodeGenerator ]
Intel32CodeGenerator dynamic	[ ^DynamicIntel32CodeGenerator ]

Intel32CodeGenerator versionString
[
    ^'x86 1.0 generic'
]

"----------------------------------------------------------------"

CodeGenerator		   isStatic	[ ^false ]
StaticIntel32CodeGenerator isStatic	[ ^true ]

CodeGenerator		    isDynamic	[ ^false ]
DynamicIntel32CodeGenerator isDynamic	[ ^true ]

StaticIntel32CodeGenerator defineVariable: name
[
    StdOut nextPutAll: '	.data\n'.
    StdOut nextPutAll: name; nextPutAll: ':	.long	_'; nextPutAll: name; cr.
    StdOut nextPutAll: '	.text\n'.
]

DynamicIntel32CodeGenerator defineVariable: name
[
]

"----------------------------------------------------------------"

{ import: Grammar }

Intel32CodeGenerator cl		[ ^cl  ]
Intel32CodeGenerator cx		[ ^cx  ]
Intel32CodeGenerator eax	[ ^eax ]
Intel32CodeGenerator ecx	[ ^ecx ]
Intel32CodeGenerator edx	[ ^edx ]
Intel32CodeGenerator ebp	[ ^ebp ]

Intel32Grammar := [
    ReductionGrammar new
	"-------------------------------- baseline --------------------------------"

	at: #VOID add: #REG			"discard";
	at: #VOID add: #(label		)	do: [:op :gen | gen define: op ];
	at: #VOID add: #(enter		)	do: [:op :gen | gen emitPrologue ];
	at: #VOID add: #(retv		)	do: [:op :gen | gen emitEpilogue ];
	at: #VOID add: #(reti4 	 REG	)	do: [:op :gen | gen movlR:    op lhs output   R: gen eax; emitEpilogue ];
	at: #VOID add: #(drop  	 REG	)	do: [:op :gen | ];
	at: #VOID add: #(brz   	 REG	)	do: [:op :gen | gen testlR:   op lhs output   R: op lhs output;  jeL: op destination ];
	at: #VOID add: #(brnz  	 REG	)	do: [:op :gen | gen testlR:   op lhs output   R: op lhs output;  jneL: op destination ];
	at: #VOID add: #(bra		)	do: [:op :gen | gen jmpL:     op destination ];
	at: #REG  add: #(cnsti4	 	)	do: [:op :gen | gen movlI_:   op arg	      R: op output ];
	at: #REG  add: #(cnstp4	 	)	do: [:op :gen | gen movlI_:   op arg	      R: op output ];
	at: #REG  add: #(parami4 	)	do: [:op :gen | ];
	at: #REG  add: #(addrfp4 	)	do: [:op :gen | gen movlR:    gen ebp	      R: op output ];
	at: #REG  add: #(addrgp4 	)	do: [:op :gen | gen movlI_:   op arg _address R: op output ];
	at: #REG  add: #(addrjp4 	)	do: [:op :gen | gen movlI_:   op arg _address R: op output ];
	at: #REG  add: #(addrlp4 	)	do: [:op :gen | gen lealMd:   op arg offset   b: op arg base R: op output ];
	at: #REG  add: #(indiri1 REG	)	do: [:op :gen | gen movsblMb: op lhs output   R: op output ];
	at: #REG  add: #(indiri2 REG	)	do: [:op :gen | gen movswlMb: op lhs output   R: op output ];
	at: #REG  add: #(indiri4 REG	)	do: [:op :gen | gen movlMb:   op lhs output   R: op output ];
	at: #REG  add: #(noti4 	 REG	)	do: [:op :gen | gen xorlR:    gen ecx	      R: gen ecx;
								    cmplI:    0		      R: op output;
								    seteR:    gen cl;
								    movlR:    gen ecx	      R: op output ];
	at: #REG  add: #(comi4 	 REG	)	do: [:op :gen | gen notlR:    op output ];
	at: #REG  add: #(negi4 	 REG	)	do: [:op :gen | gen neglR:    op output ];
	at: #REG  add: #(calli4	 REG	)	do: [:op :gen | gen calli4: op ];
	at: #REG  add: #(asgni1  REG REG)	do: [:op :gen | gen movlR:    op lhs output   R: gen ecx;
								    movbR:    gen cl	     Mb: op rhs output ];
	at: #REG  add: #(asgni2  REG REG)	do: [:op :gen | gen movlR:    op lhs output   R: gen ecx;
								    movwR:    gen cx	     Mb: op rhs output ];
	at: #REG  add: #(asgni4  REG REG)	do: [:op :gen | gen movlR:    op lhs output  Mb: op rhs output ];
	at: #REG  add: #(andi4   REG REG)	do: [:op :gen | gen andlR:    op rhs output   R: op output ];
	at: #REG  add: #(ori4    REG REG)	do: [:op :gen | gen orlR:     op rhs output   R: op output ];
	at: #REG  add: #(xori4 	 REG REG)	do: [:op :gen | gen xorlR:    op rhs output   R: op output ];
	at: #REG  add: #(addi4 	 REG REG)	do: [:op :gen | gen addlR:    op rhs output   R: op output ];
	at: #REG  add: #(subi4 	 REG REG)	do: [:op :gen | gen sublR:    op rhs output   R: op output ];
	at: #REG  add: #(muli4 	 REG REG)	do: [:op :gen | gen imullR:   op rhs output   R: op output ];
	at: #REG  add: #(divi4 	 REG REG)	do: [:op :gen | gen movlR:    op lhs output   R: gen eax;
								    cltd;
								    idivlR: op rhs output;
								    movlR:  gen eax	      R: op output ];
	at: #REG  add: #(modi4 	 REG REG)	do: [:op :gen | gen movlR:  op lhs output     R: gen eax;
								    cltd;
								    idivlR: op rhs output;
								    movlR:  gen edx	  R: op output ];
	at: #REG  add: #(shli4 	 REG REG)	do: [:op :gen | gen movlR:  op rhs output R: gen ecx;
								    sallR:  gen cl	  R: op output ];
	at: #REG  add: #(shlu4 	 REG REG)	do: [:op :gen | gen movlR:  op rhs output R: gen ecx;
								    shllR:  gen cl	  R: op output ];
	at: #REG  add: #(shri4 	 REG REG)	do: [:op :gen | gen movlR:  op rhs output R: gen ecx;
								    sarlR:  gen cl	  R: op output ];
	at: #REG  add: #(shru4 	 REG REG)	do: [:op :gen | gen movlR:  op rhs output R: gen ecx;
								    shrlR:  gen cl	  R: op output ];
	at: #REG  add: #(lti4 	 REG REG)	do: [:op :gen | gen xorlR:  gen ecx	  R: gen ecx;
								    cmplR:  op rhs output R: op lhs output;
								    setlR:  gen cl;
								    movlR:  gen ecx	  R: op output ];
	at: #REG  add: #(lei4 	 REG REG)	do: [:op :gen | gen xorlR:  gen ecx	  R: gen ecx;
								    cmplR:  op rhs output R: op lhs output;
								    setleR: gen cl;
								    movlR:  gen ecx	  R: op output ];
	at: #REG  add: #(eqi4 	 REG REG)	do: [:op :gen | gen xorlR:  gen ecx	  R: gen ecx;
								    cmplR:  op rhs output R: op lhs output;
								    seteR:  gen cl;
								    movlR:  gen ecx	  R: op output ];
	at: #REG  add: #(nei4 	 REG REG)	do: [:op :gen | gen xorlR:  gen ecx	  R: gen ecx;
								    cmplR:  op rhs output R: op lhs output;
								    setneR: gen cl;
								    movlR:  gen ecx	  R: op output ];
	at: #REG  add: #(gei4 	 REG REG)	do: [:op :gen | gen xorlR:  gen ecx	  R: gen ecx;
								    cmplR:  op rhs output R: op lhs output;
								    setgeR: gen cl;
								    movlR:  gen ecx	  R: op output ];
	at: #REG  add: #(gti4 	 REG REG)	do: [:op :gen | gen xorlR:  gen ecx	  R: gen ecx;
								    cmplR:  op rhs output R: op lhs output;
								    setgR:  gen cl;
								    movlR:  gen ecx	  R: op output ];

	"-------------------------------- optimisations --------------------------------"

	at: #VOID add: #(brz (lti4 (indiri4 (addrlp4))
			           (cnsti4)))		do: [:op :gen | gen cmplI_:  op lhs rhs arg Md: op lhs lhs lhs arg offset b: op lhs lhs lhs arg base;
									    jgeL:    op destination ];

	at: #REG  add: #(indiri4 (addrlp4))		do: [:op :gen | gen movlMd:  op lhs arg offset b: op lhs arg base R: op output ];
	at: #REG  add: #(indiri4 (addrgp4))		do: [:op :gen | gen movlMd_: op lhs arg _address R: op output ];
	at: #REG  add: #(subi4 REG (cnsti4))		do: [:op :gen | gen sublI_:  op rhs arg R: op lhs output ];
	at: #REG  add: #(addi4 REG (cnsti4))		do: [:op :gen | gen addlI_:  op rhs arg R: op lhs output ];
	at: #REG  add: #(addi4 (cnsti4) REG)		do: [:op :gen | gen lealMd_: op lhs arg b: op rhs output R: op output ];

	yourself
]

"----------------------------------------------------------------"

Intel32RegisterFilter    : RegisterAllocator ()
Intel32RegisterAllocator : RegisterAllocator ()

Intel32RegisterFilter	 REG  :insn	[ ^true ]
Intel32RegisterAllocator REG  :insn	[ ^codeGenerator allocateRegister: insn ]

Intel32CodeGenerator grammar		[ ^Intel32Grammar ]
Intel32CodeGenerator registerFilter	[ ^Intel32RegisterFilter   "on: self"]
Intel32CodeGenerator registerAllocator	[ ^Intel32RegisterAllocator on: self ]

"----------------------------------------------------------------"

StaticIntel32CodeGenerator generate: tree
[
    self finaliseFrame.
    tree printOn: StdOut indent: 0.  StdOut cr.
    tree generate: self.
]

DynamicIntel32CodeGenerator generate: tree
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
]
