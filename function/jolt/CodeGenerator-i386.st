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

Intel32CodeGenerator clobberEACDX: insn	[ self clobberRegister: eax; clobberRegister: ecx; clobberRegister: edx ]
Intel32CodeGenerator clobberEADX: insn	[ self clobberRegister: eax; clobberRegister: edx ]
Intel32CodeGenerator clobberECX:  insn	[ self clobberRegister: ecx ]

Intel32CodeGenerator allocateParam: insn
[
    ^(params add: (Temporary withBase: esp offset: params size * 4)) allocate
]

Intel32CodeGenerator allocateTemp: insn
[
    temps do: [:temp | temp live ifFalse: [^temp allocate]].
    ^(temps add: (Temporary withBase: esp offset: temps size * 4)) allocate
]

Intel32CodeGenerator addi4    :d :s	[ self addlR: s R: d ]
Intel32CodeGenerator addrfp4  :d	[ self movlR: ebp R: d ]
Intel32CodeGenerator addrlp4  :d :v	[ self lealMd: v offset b: v base R: d ]
Intel32CodeGenerator andi4    :d :s	[ self andlR: s R: d ]
Intel32CodeGenerator asgni1   :s :d	[ self movlR: s R: ecx;  movbR: cl Mb: d ]
Intel32CodeGenerator asgni2   :s :d	[ self movlR: s R: ecx;  movwR: cx Mb: d ]
Intel32CodeGenerator asgni4   :s :d	[ self movlR: s Mb: d ]
Intel32CodeGenerator bra      :l	[ self jmpL: l ]
Intel32CodeGenerator brnz     :s :l	[ self testlR: s R: s;  jneL: l ]
Intel32CodeGenerator brz      :s :l	[ self testlR: s R: s;  jeL: l ]
Intel32CodeGenerator cnsti4   :d :v	[ self movlI_: v R: d ]
Intel32CodeGenerator cnstp4   :d :v	[ self movlI_: v R: d ]
Intel32CodeGenerator divi4    :d :s	[ self movlR: d R: eax;  cltd;  idivlR: s;  movlR: eax R: d ]
Intel32CodeGenerator eqi4     :d :s	[ self xorlR: ecx R: ecx;  cmplR: s R: d;  seteR:  cl;  movlR: ecx R: d ]
Intel32CodeGenerator gei4     :d :s	[ self xorlR: ecx R: ecx;  cmplR: s R: d;  setgeR: cl;  movlR: ecx R: d ]
Intel32CodeGenerator gti4     :d :s	[ self xorlR: ecx R: ecx;  cmplR: s R: d;  setgR: cl;  movlR: ecx R: d ]
Intel32CodeGenerator indiri1  :d	[ self movsblMb: d R: d ]
Intel32CodeGenerator indiri2  :d	[ self movswlMb: d R: d ]
Intel32CodeGenerator indiri4  :d	[ self movlMb: d R: d ]
Intel32CodeGenerator label    :l	[ self define: l ]
Intel32CodeGenerator lei4     :d :s	[ self xorlR: ecx R: ecx;  cmplR: s R: d;  setleR: cl;  movlR: ecx R: d ]
Intel32CodeGenerator lti4     :d :s	[ self xorlR: ecx R: ecx;  cmplR: s R: d;  setlR: cl;  movlR: ecx R: d ]
Intel32CodeGenerator modi4    :d :s	[ self movlR: d R: eax;  cltd;  idivlR: s;  movlR: edx R: d ]
Intel32CodeGenerator muli4    :d :s	[ self imullR: s R: d ]
Intel32CodeGenerator negi4    :d	[ self neglR: d ]
Intel32CodeGenerator nei4     :d :s	[ self xorlR: ecx R: ecx;  cmplR: s R: d;  setneR: cl;  movlR: ecx R: d ]
Intel32CodeGenerator noti4    :d	[ self xorlR: ecx R: ecx;  cmplI: 0 R: d;  seteR: cl;  movlR: ecx R: d ]
Intel32CodeGenerator ori4     :d :s	[ self orlR: s R: d ]
Intel32CodeGenerator reti4    :s	[ self movlR: s R: eax; emitEpilogue ]
Intel32CodeGenerator subi4    :d :s	[ self sublR: s R: d ]
Intel32CodeGenerator shli4    :d :s	[ self movlR: s R: ecx;  shllR: cl R: d ]
Intel32CodeGenerator shri4    :d :s	[ self movlR: s R: ecx;  sarlR: cl R: d ]
Intel32CodeGenerator xori4    :d :s	[ self xorlR: s R: d ]
Intel32CodeGenerator spilli4  :r :t	[ self movlR: r Md: t offset b: esp ]
Intel32CodeGenerator reloadi4 :r :t	[ self movlMd: t offset b: esp R: r ]

Intel32CodeGenerator finaliseFrame
[
    | align |
    frameSize := 4.							"return address"
    tempsSize := 0.
    needsFrame ifTrue: [frameSize := frameSize + 4].			"saved frame pointer"
    csrs do: [:reg | reg used ifTrue: [frameSize := frameSize + 4]].	"callee-saved register"
    temps do: [:temp |
	tempsSize := tempsSize + 4.					"temporary variable"
	temp offset: temp offset + parametersSize].
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

Intel32CodeGenerator calli4 :call
[
    self emit: call rhs argument: 0.
    call lhs reload: self.
    self callMb: call lhs output.
    self movlR: eax R: call output.
]

Intel32CodeGenerator emit: insn argument: index
[
    insn isNOP ifTrue: [^self].
    self emit: insn rhs argument: index + 1.
    insn lhs reload: self.
    self movlR: insn output Md: index * 4 b: esp.
]


StaticIntel32CodeGenerator : Intel32CodeGenerator ()

StaticIntel32CodeGenerator emit: tree
[
    self finaliseFrame.
    tree emit: self.
]

StaticIntel32CodeGenerator addrgp4  :d :v	[ StdOut nextPutAll: '	movl	'; nextPut: $$; print: v; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator addrjp4  :d :l	[ StdOut nextPutAll: '	movl	$L'; print: l ordinal; nextPut: $,; print: d; cr ]

StaticIntel32CodeGenerator addlI: i R: d	[ StdOut nextPutAll: '	addl	'; nextPut: $$; print: i; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator addlR: s R: d	[ StdOut nextPutAll: '	addl	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator andlR: s R: d	[ StdOut nextPutAll: '	andl	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator callMb: b		[ StdOut nextPutAll: '	call	('; print: b; nextPutAll: ')\n' ]
StaticIntel32CodeGenerator cltd			[ StdOut nextPutAll: '	cltd\n' ]
StaticIntel32CodeGenerator cmplI: i R: d	[ StdOut nextPutAll: '	cmpl	'; nextPut: $$; print: i; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator cmplR: s R: d	[ StdOut nextPutAll: '	cmpl	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator define: l		[ StdOut nextPutAll: 'L'; print: l ordinal; nextPut: $:; cr ]
StaticIntel32CodeGenerator idivlR: s		[ StdOut nextPutAll: '	idivl	'; print: s; cr ]
StaticIntel32CodeGenerator imullR: s R: d	[ StdOut nextPutAll: '	imull	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator jeL: l		[ StdOut nextPutAll: '	je	L'; print: l ordinal; cr ]
StaticIntel32CodeGenerator jmpL: l		[ StdOut nextPutAll: '	jmp	L'; print: l ordinal; cr ]
StaticIntel32CodeGenerator jneL: l		[ StdOut nextPutAll: '	jne	L'; print: l ordinal; cr ]
StaticIntel32CodeGenerator lealMd: d b: b R: r	[ StdOut nextPutAll: '	leal	'; print: d; nextPut: $(; print: b; nextPutAll: '),'; print: r; cr]
StaticIntel32CodeGenerator movbR: r Mb: b	[ StdOut nextPutAll: '	movb	'; print: r; nextPutAll: ',('; print: b; nextPut: $); cr ]
StaticIntel32CodeGenerator movlI_: i R: d	[ StdOut nextPutAll: '	movl	'; nextPut: $$; print: (SmallInteger value_: i); nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator movlMb: b R: r	[ StdOut nextPutAll: '	movl	('; print: b; nextPutAll: '),'; print: r; cr]
StaticIntel32CodeGenerator movlMd: d b: b R: r	[ StdOut nextPutAll: '	movl	'; print: d; nextPut: $(; print: b; nextPutAll: '),'; print: r; cr]
StaticIntel32CodeGenerator movlR: r Mb: b	[ StdOut nextPutAll: '	movl	'; print: r; nextPutAll: ',('; print: b; nextPut: $); cr ]
StaticIntel32CodeGenerator movlR: s Md: d b: b	[ StdOut nextPutAll: '	movl	'; print: s; nextPut: $,; print: d; nextPut: $(; print: b; nextPut: $); cr]
StaticIntel32CodeGenerator movlR: s R: d	[ s == d ifFalse: [StdOut nextPutAll: '	movl	'; print: s; nextPut: $,; print: d; cr] ]
StaticIntel32CodeGenerator movsblMb: s R: d	[ StdOut nextPutAll: '	movsbl	('; print: s; nextPutAll: '),'; print: d; cr ]
StaticIntel32CodeGenerator movswlMb: s R: d	[ StdOut nextPutAll: '	movswl	('; print: s; nextPutAll: '),'; print: d; cr ]
StaticIntel32CodeGenerator movwR: r Mb: b	[ StdOut nextPutAll: '	movw	'; print: r; nextPutAll: ',('; print: b; nextPut: $); cr ]
StaticIntel32CodeGenerator neglR: d		[ StdOut nextPutAll: '	negl	'; print: d; cr ]
StaticIntel32CodeGenerator orlR: s R: d		[ StdOut nextPutAll: '	orl	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator poplR: d		[ StdOut nextPutAll: '	popl	'; print: d; cr ]
StaticIntel32CodeGenerator pushlR: s		[ StdOut nextPutAll: '	pushl	'; print: s; cr ]
StaticIntel32CodeGenerator ret			[ StdOut nextPutAll: '	ret\n' ]
StaticIntel32CodeGenerator sarlR: s R: d	[ StdOut nextPutAll: '	sarl	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator seteR: d		[ StdOut nextPutAll: '	sete	'; print: d; cr ]
StaticIntel32CodeGenerator setgR: d		[ StdOut nextPutAll: '	setg	'; print: d; cr ]
StaticIntel32CodeGenerator setgeR: d		[ StdOut nextPutAll: '	setge	'; print: d; cr ]
StaticIntel32CodeGenerator setlR: d		[ StdOut nextPutAll: '	setl	'; print: d; cr ]
StaticIntel32CodeGenerator setleR: d		[ StdOut nextPutAll: '	setle	'; print: d; cr ]
StaticIntel32CodeGenerator setneR: d		[ StdOut nextPutAll: '	setne	'; print: d; cr ]
StaticIntel32CodeGenerator shllR: s R: d	[ StdOut nextPutAll: '	shll	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator sublI: i R: d	[ StdOut nextPutAll: '	subl	'; nextPut: $$; print: i; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator sublR: s R: d	[ StdOut nextPutAll: '	subl	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator testlR: s R: d	[ StdOut nextPutAll: '	testl	'; print: s; nextPut: $,; print: d; cr ]
StaticIntel32CodeGenerator xorlR: s R: d	[ StdOut nextPutAll: '	xorl	'; print: s; nextPut: $,; print: d; cr ]

"----------------------------------------------------------------"

DynamicIntel32CodeGenerator : Intel32CodeGenerator ()

DynamicIntel32CodeGenerator emit: tree
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
]

DynamicIntel32CodeGenerator asmPass	{ return (oop)(asm_pass << 1 | 1); }
DynamicIntel32CodeGenerator _asmPC	{ return (oop)(asm_pc); }

SmallInteger _int	{ return (oop)((long)self >> 1); }

DynamicIntel32CodeGenerator define: l
[
    self asmPass == 0
	ifTrue:  [l address_: self _asmPC]
	ifFalse: [l phaseCheck_: self _asmPC]
]

DynamicIntel32CodeGenerator addrgp4 :d :v	[ self movlI_: v _address R: d ]

DynamicIntel32CodeGenerator addrjp4 :d :l	[ self movlI_: l _address R: d ]

DynamicIntel32CodeGenerator _
{
    (void)_W; (void)_D1; (void)_D4;
#   define _P(v)	((long)v__##v)
#   define _I(v)	((long)v_##v >> 1)
#   define _R(v)	((long)(((struct t_Register *)(v_##v))->v__encoding))
#   define _A(v)	((long)(((struct t_LABEL    *)(v_##v))->v__address))
}

DynamicIntel32CodeGenerator addlI: i R: d	{ ADDLir	(_I(i)          ,	_R(d)	 ); }
DynamicIntel32CodeGenerator addlR: s R: d	{ ADDLrr	(      _R(s)	, 	_R(d)    ); }
DynamicIntel32CodeGenerator andlR: s R: d	{ ANDLrr	(      _R(s)	, 	_R(d)    ); }
DynamicIntel32CodeGenerator cltd		{ CLTD		(				 ); }
DynamicIntel32CodeGenerator callMb: b		{ CALLm		(    0,_R(b),0,0		 ); }
DynamicIntel32CodeGenerator cmplI: i R: d	{ CMPLir	(_I(i)          ,	_R(d)	 ); }
DynamicIntel32CodeGenerator cmplR: s R: d	{ CMPLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator idivlR: s		{ IDIVLrr	(      _R(s)	,	_EAX	 ); }
DynamicIntel32CodeGenerator imullR: s R: d	{ IMULLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator jeL: l		{ JEm		(_A(l),    0,0,0		 ); }
DynamicIntel32CodeGenerator jmpL: l		{ JMPm		(_A(l),	   0,0,0		 ); }
DynamicIntel32CodeGenerator jneL: l		{ JNEm		(_A(l),	   0,0,0		 ); }
DynamicIntel32CodeGenerator lealMd: d b: b R: r	{ LEALmr	(_I(d),_R(b),0,0,	_R(r)	 ); }
DynamicIntel32CodeGenerator movbR: r Mb: b	{ MOVBrm	(      _R(r)	,     0,_R(b),0,0); }
DynamicIntel32CodeGenerator movlI_: _i R: d	{ MOVLir	(_P(i)		,	_R(d)	 ); }
DynamicIntel32CodeGenerator movlMb: b R: r	{ MOVLmr	(    0,_R(b),0,0,	_R(r)	 ); }
DynamicIntel32CodeGenerator movlMd: d b: b R: r	{ MOVLmr	(_I(d),_R(b),0,0,	_R(r)	 ); }
DynamicIntel32CodeGenerator movlR: r Mb: b	{ MOVLrm	(      _R(r)	,     0,_R(b),0,0); }
DynamicIntel32CodeGenerator movlR: s Md: d b: b	{ MOVLrm	(      _R(s)	, _I(d),_R(b),0,0); }
DynamicIntel32CodeGenerator movlR: s R: d	{ MOVLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator movsblMb: s R: d	{ MOVSBLmr	(    0,_R(s),0,0, 	_R(d)	 ); }
DynamicIntel32CodeGenerator movswlMb: s R: d	{ MOVSWLmr	(    0,_R(s),0,0, 	_R(d)	 ); }
DynamicIntel32CodeGenerator movwR: r Mb: b	{ MOVWrm	(      _R(r)	,     0,_R(b),0,0); }
DynamicIntel32CodeGenerator neglR: d		{ NEGLr		(      			_R(d)	 ); }
DynamicIntel32CodeGenerator orlR: s R: d	{ ORLrr		(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator poplR: d		{ POPLr		(      			_R(d)	 ); }
DynamicIntel32CodeGenerator pushlR: s		{ PUSHLr	(      _R(s)			 ); }
DynamicIntel32CodeGenerator ret			{ RET		(				 ); }
DynamicIntel32CodeGenerator sarlR: s R: d	{ SARLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator seteR: d		{ SETEr		(			_R(d)	 ); }
DynamicIntel32CodeGenerator setgR: d		{ SETGr		(			_R(d)	 ); }
DynamicIntel32CodeGenerator setgeR: d		{ SETGEr	(			_R(d)	 ); }
DynamicIntel32CodeGenerator setlR: d		{ SETLr		(			_R(d)	 ); }
DynamicIntel32CodeGenerator setleR: d		{ SETLEr	(			_R(d)	 ); }
DynamicIntel32CodeGenerator setneR: d		{ SETNEr	(			_R(d)	 ); }
DynamicIntel32CodeGenerator shllR: s R: d	{ SHLLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator sublI: i R: d	{ SUBLir	(_I(i)		,	_R(d)	 ); }
DynamicIntel32CodeGenerator sublR: s R: d	{ SUBLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator testlR: s R: d	{ TESTLrr	(      _R(s)	,	_R(d)	 ); }
DynamicIntel32CodeGenerator xorlR: s R: d	{ XORLrr	(      _R(s)	,	_R(d)	 ); }

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
