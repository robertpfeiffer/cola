/* Dynamic assembler for ARM
 *
 * Last edited: 2007-03-23 20:44:19 by piumarta on ubuntu
 */

#ifndef __ccg_asm_arm_h
#define __ccg_asm_arm_h

#ifndef __ASM_PC__
#define __ASM_PC__ asm_pc
typedef unsigned int insn;
#endif

#include "asm-common.h"

#define _UL(X)	((unsigned long)(X))

#define _ck_s(W,I) (_siP(W,I) ? (_UL(I) & _MASK(W)) : ASMFAIL(	"signed integer "#I" too large for "#W"-bit field"))
#define _ck_u(W,I) (_uiP(W,I) ? (_UL(I) & _MASK(W)) : ASMFAIL("unsigned integer "#I" too large for "#W"-bit field"))

#define _s24(I) _ck_s(24,I)

#define _u1(I)	_ck_u( 1,I)
#define _u2(I)	_ck_u( 2,I)
#define _u3(I)	_ck_u( 3,I)
#define _u4(I)	_ck_u( 4,I)
#define _u5(I)	_ck_u( 5,I)
#define _u6(I)	_ck_u( 6,I)
#define _u7(I)	_ck_u( 7,I)
#define _u8(I)	_ck_u( 8,I)
#define _u12(I) _ck_u(12,I)
#define _u16(I) _ck_u(16,I)
#define _u24(I) _ck_u(24,I)

#define _s24(I) _ck_s(24,I)

#define _d24(BD) ((_UL(BD) - _UL(__ASM_PC__))>>2)

#define _Q4(I) ((_UL(I) >> 24) & 0xff)
#define _Q3(I) ((_UL(I) >> 16) & 0xff)
#define _Q2(I) ((_UL(I) >> 8) & 0xff)
#define _Q1(I) (_UL(I) & 0xff)

#define _GEN(X) ((asm_pass ? (*__ASM_PC__ = (X)) : 0), ++__ASM_PC__)

/*
 * primitive insn formats [1, Table 3-1, page 3-3]       31 30 29 28	    27 26	     25		  24	       23	    22		 21	      20     19 18 17 16    15 14 13 12	     11 10 9 8			7	    6		5	     4	     3 2 1 0
 */

#define _dpi(CC, S, OP, RN, RD, ROT, IMM)		_GEN((_u4(CC)<<28)|(_u3(	      1)<<25)|(_u4(					 OP)<<21)|(_u1(S)<<20)|(_u4(  RN)<<16)|(_u4( RD)<<12)|(_u4(ROT)<<8)|(_u8(							 IMM)))
#define _dpis(CC, S, OP, RN, RD, SC, SH, RF, RM)	_GEN((_u4(CC)<<28)|(_u3(	      0)<<25)|(_u4(					 OP)<<21)|(_u1(S)<<20)|(_u4(  RN)<<16)|(_u4( RD)<<12)|(_u5((SC)==32?0:(SC))<<(RF?8:7))|(_u2(	       SH)<<5)|(_u1(RF)<<4)|(_u4( RM)))
#define _mul(CC, S, A, RD, RN, RS, RM)			_GEN((_u4(CC)<<28)|(_u6(						     0)<<22)|(_u1(A)<<21)|(_u1(S)<<20)|(_u4(  RD)<<16)|(_u4( RN)<<12)|(_u4( RS)<<8)|(_u4(					     9)<<4)|(_u4( RM)))
#define _lmul(CC, S, U, A, RDH, RDL, RS, RM)		_GEN((_u4(CC)<<28)|(_u5(					1)<<23)|(_u1(U)<<22)|(_u1(A)<<21)|(_u1(S)<<20)|(_u4( RDH)<<16)|(_u4(RDL)<<12)|(_u4( RS)<<8)|(_u4(					     9)<<4)|(_u4( RM)))
#define _mfsr(CC, R, RD)				_GEN((_u4(CC)<<28)|(_u5(					2)<<23)|(_u1(R)<<22)|(_u2(	       0)<<20)|(_u4( 0xf)<<16)|(_u4( RD)<<12)|(_u12(									   0)))
#define _mitsr(CC, R, MASK, ROT, IMM)			_GEN((_u4(CC)<<28)|(_u5(					6)<<23)|(_u1(R)<<22)|(_u2(	       2)<<20)|(_u4(MASK)<<16)|(_u4(0xf)<<12)|(_u4(ROT)<<8)|(_u8(							 IMM)))
#define _mrtsr(CC, R, MASK, RM)				_GEN((_u4(CC)<<28)|(_u5(					2)<<23)|(_u1(R)<<22)|(_u2(	       2)<<20)|(_u4(MASK)<<16)|(_u4(0xf)<<12)|(_u7(						0)<<5)|(_u1( 0)<<4)|(_u4( RM)))
#define _mwubl(CC, RO, P, U, B, W, L, RN, RD, OFF)	_GEN((_u4(CC)<<28)|(_u2(1)<<26)|(_u1(RO)<<25)|(_u1(P)<<24)|(_u1(U)<<23)|(_u1(B)<<22)|(_u1(W)<<21)|(_u1(L)<<20)|(_u4(  RN)<<16)|(_u4( RD)<<12)|(_u12(									 OFF)))
#define _mwubr(CC, P, U, B, W, L, RN, RD, SC, SH, RM)	_GEN((_u4(CC)<<28)|(_u3(	      3)<<25)|(_u1(P)<<24)|(_u1(U)<<23)|(_u1(B)<<22)|(_u1(W)<<21)|(_u1(L)<<20)|(_u4(  RN)<<16)|(_u4( RD)<<12)|(_u5(	  (SC)==32?0:(SC))<<7)|(_u2(	       SH)<<5)|(_u1( 0)<<4)|(_u4( RM)))
#define _mhs(CC, P, U, I, W, L, RN, RD, OP1, S, H, OP2)	_GEN((_u4(CC)<<28)|(_u3(	      0)<<25)|(_u1(P)<<24)|(_u1(U)<<23)|(_u1(I)<<22)|(_u1(W)<<21)|(_u1(L)<<20)|(_u4(  RN)<<16)|(_u4( RD)<<12)|(_u4(OP1)<<8)|(_u1(	1)<<7)|(_u1(S)<<6)|(_u1(H)<<5)|(_u1( 1)<<4)|(_u4(OP2)))
#define _swp(CC, B, RN, RD, RM)				_GEN((_u4(CC)<<28)|(_u5(					2)<<23)|(_u1(B)<<22)|(_u2(	       0)<<20)|(_u4(  RN)<<16)|(_u4( RD)<<12)|(_u4(  0)<<8)|(_u4(					     9)<<4)|(_u4( RM)))
#define _mm(CC, PU, S, W, L, RN, RL)			_GEN((_u4(CC)<<28)|(_u3(	      4)<<25)|(_u2(	       PU)<<23)|(_u1(S)<<22)|(_u1(W)<<21)|(_u1(L)<<20)|(_u4(  RN)<<16)|(_u16(											  RL)))
#define _b(CC, L, OFF)					_GEN((_u4(CC)<<28)|(_u3(	      5)<<25)|(_u1(L)<<24)|(_d24(																	   OFF-8) & _MASK(24)))
#define _blx(CC, RM)					_GEN((_u4(CC)<<28)|(_u8(	                                                                    0x12)<<20)|(_u4(  15)<<16)|(_u4( 15)<<12)|(_u4( 15)<<8)|(_u4(                                            3)<<4)|(_u4( RM)))
#define _swi(CC, N)					_GEN((_u4(CC)<<28)|(_u4(			 0xf)<<24)|(_u24(																			   N)))

/* +++ marker for instruction generator script. All macros below this line are assumed to be assembler instructions! */

/*
 * instructions	 [1, ARM Instruction Set, page 3-1]
 */

#define ADCrri(CC, S, RD, RN, ROT, IMM)			 _dpi (CC, S,  5, RN, RD, ROT,        IMM)
#define ADCrrr(CC, S, RD, RN, RM)			 _dpis(CC, S,  5, RN, RD,   0,  0,  0, RM)
#define ADCrrrs(CC, S, RD, RN, RM, SH, SC, RF)		 _dpis(CC, S,  5, RN, RD,  SC, SH, RF, RM)

#define ADDrri(CC, S, RD, RN, ROT, IMM)			 _dpi (CC, S,  4, RN, RD, ROT,        IMM)
#define ADDrrr(CC, S, RD, RN, RM)			 _dpis(CC, S,  4, RN, RD,   0,  0,  0, RM)
#define ADDrrrs(CC, S, RD, RN, RM, SH, SC, RF)		 _dpis(CC, S,  4, RN, RD,  SC, SH, RF, RM)

#define ANDrri(CC, S, RD, RN, ROT, IMM)			 _dpi (CC, S,  0, RN, RD, ROT,        IMM)
#define ANDrrr(CC, S, RD, RN, RM)			 _dpis(CC, S,  0, RN, RD,   0,  0,  0, RM)
#define ANDrrrs(CC, S, RD, RN, RM, SH, SC, RF)		 _dpis(CC, S,  0, RN, RD,  SC, SH, RF, RM)

#define Bi(CC, OFF)					 _b(CC, 0, OFF)

#define BICrri(CC, S, RD, RN, ROT, IMM)			 _dpi (CC, S, 14, RN, RD, ROT,        IMM)
#define BICrrr(CC, S, RD, RN, RM)			 _dpis(CC, S, 14, RN, RD,   0,  0,  0, RM)
#define BICrrrs(CC, S, RD, RN, RM, SH, SC, RF)		 _dpis(CC, S, 14, RN, RD,  SC, SH, RF, RM)

#define BLi(CC, OFF)					 _b(CC, 1, OFF)
#define BLXr(CC, RM)					 _blx(CC, RM)

#define CMNri(CC, RN, ROT, IMM)				 _dpi (CC, 1, 11, RN,  0, ROT,        IMM)
#define CMNrr(CC, RN, RM)				 _dpis(CC, 1, 11, RN,  0,   0,  0,  0, RM)
#define CMNrrs(CC, RN, RM, SH, SC, RF)			 _dpis(CC, 1, 11, RN,  0,  SC, SH, RF, RM)

#define CMPri(CC, RN, ROT, IMM)				 _dpi (CC, 1, 10, RN,  0, ROT,        IMM)
#define CMPrr(CC, RN, RM)				 _dpis(CC, 1, 10, RN,  0,   0,  0,  0, RM)
#define CMPrrs(CC, RN, RM, SH, SC, RF)			 _dpis(CC, 1, 10, RN,  0,  SC, SH, RF, RM)

#define EORrri(CC, S, RD, RN, ROT, IMM)			 _dpi (CC, S,  1, RN, RD, ROT,        IMM)
#define EORrrr(CC, S, RD, RN, RM)			 _dpis(CC, S,  1, RN, RD,   0,  0,  0, RM)
#define EORrrrs(CC, S, RD, RN, RM, SH, SC, RF)		 _dpis(CC, S,  1, RN, RD,  SC, SH, RF, RM)

#define LDMrl(CC, PU, RN, RL, S)			 _mm(CC, PU, S, 0, 1, RN, RL)
#define LDMri(CC, PU, RN, MT, RL)			 _mm(CC, PU, 0, 0, 1, RN, RL)
#define LDMwl(CC, PU, RN, RL, S)			 _mm(CC, PU, S, 1, 1, RN, RL)
#define LDMwi(CC, PU, RN, MT, RL)			 _mm(CC, PU, 0, 1, 1, RN, RL)

#define LDRhrm(CC, B, T, S, H, RD, RN, W)		 _mhs(CC, 1, 1, 1, W, 1, RN, RD,		   0, S, H,	      0)
#define LDRhrmf(CC, B, T, S, H, RD, RN, W, U, OFF)	 _mhs(CC, 0, U, 1, W, 1, RN, RD, ((OFF) >> 4) & 0xff, S, H, (OFF) & 0xf)
#define LDRhrmo(CC, B, T, S, H, RD, RN, W, U, RM)	 _mhs(CC, 0, U, 0, W, 1, RN, RD,		   0, S, H,	     RM)
#define LDRhrmpf(CC, B, T, S, H, RD, RN, U, OFF, W)	 _mhs(CC, 1, U, 1, W, 1, RN, RD, ((OFF) >> 4) & 0xff, S, H, (OFF) & 0xf)
#define LDRhrmpo(CC, B, T, S, H, RD, RN, U, RM, W)	 _mhs(CC, 1, U, 0, W, 1, RN, RD,		   0, S, H,	     RM)

#define LDRrm(CC, B, T, RD, RN, W)			 _mwubl(CC, 0, 1, 1, B, W, 1, RN, RD,          0)
#define LDRrmf(CC, B, T, RD, RN, W, U, OFF)		 _mwubl(CC, 0, 0, U, B, T, 1, RN, RD,        OFF)
#define LDRrmo(CC, B, T, RD, RN, W, U, RM)		 _mwubl(CC, 1, 0, U, B, T, 1, RN, RD,         RM)
#define LDRrmos(CC, B, T, RD, RN, W, U, RM, SH, SC, MT)	 _mwubr(CC, 0, U, B, T, 1,    RN, RD, SC, SH, RM)
#define LDRrmpf(CC, B, T, RD, RN, U, OFF, W)		 _mwubl(CC, 0, 1, U, B, W, 1, RN, RD,        OFF)
#define LDRrmpo(CC, B, T, RD, RN, U, RM, W)		 _mwubl(CC, 1, 1, U, B, W, 1, RN, RD,         RM)
#define LDRrmpos(CC, B, T, RD, RN, U, RM, SH, SC, MT, W) _mwubr(CC, 1, U, B, W, 1,    RN, RD, SC, SH, RM)

#define MLArrrr(CC, S, RD, RM, RS, RN)			 _mul(CC, S, 1, RD, RN, RS, RM)

#define MOVri(CC, S, RD, ROT, IMM)			 _dpi (CC, S, 13,  0, RD, ROT,        IMM)
#define MOVrr(CC, S, RD, RM)				 _dpis(CC, S, 13,  0, RD,   0,  0,  0, RM)
#define MOVrrs(CC, S, RD, RM, SH, SC, RF)		 _dpis(CC, S, 13,  0, RD,  SC, SH, RF, RM)

#define MRSri(CC, RD, R)				 _mfsr(CC, R, RD)

#define MSRir(CC, R, MASK, RD)				 _mrtsr(CC, R, MASK,       RD)
#define MSRii(CC, R, MASK, ROT, IMM)			 _mitsr(CC, R, MASK, ROT, IMM)

#define MULrrr(CC, S, RD, RM, RS)			 _mul(CC, S, 0, RD, 0, RS, RM)

#define MVNri(CC, S, RD, ROT, IMM)			 _dpi (CC, S, 15,  0, RD, ROT,        IMM)
#define MVNrr(CC, S, RD, RM)				 _dpis(CC, S, 15,  0, RD,   0,  0,  0, RM)
#define MVNrrs(CC, S, RD, RM, SH, SC, RF)		 _dpis(CC, S, 15,  0, RD,  SC, SH, RF, RM)

#define ORRrri(CC, S, RD, RN, ROT, IMM)			 _dpi (CC, S, 12, RN, RD, ROT,        IMM)
#define ORRrrr(CC, S, RD, RN, RM)			 _dpis(CC, S, 12, RN, RD,   0,  0,  0, RM)
#define ORRrrrs(CC, S, RD, RN, RM, SH, SC, RF)		 _dpis(CC, S, 12, RN, RD,  SC, SH, RF, RM)

#define RSBrri(CC, S, RD, RN, ROT, IMM)			 _dpi (CC, S,  3, RN, RD, ROT,        IMM)
#define RSBrrr(CC, S, RD, RN, RM)			 _dpis(CC, S,  3, RN, RD,   0,  0,  0, RM)
#define RSBrrrs(CC, S, RD, RN, RM, SH, SC, RF)		 _dpis(CC, S,  3, RN, RD,  SC, SH, RF, RM)

#define RSCrri(CC, S, RD, RN, ROT, IMM)			 _dpi (CC, S,  7, RN, RD, ROT,        IMM)
#define RSCrrr(CC, S, RD, RN, RM)			 _dpis(CC, S,  7, RN, RD,   0,  0,  0, RM)
#define RSCrrrs(CC, S, RD, RN, RM, SH, SC, RF)		 _dpis(CC, S,  7, RN, RD,  SC, SH, RF, RM)

#define SBCrri(CC, S, RD, RN, ROT, IMM)			 _dpi (CC, S,  6, RN, RD, ROT,        IMM)
#define SBCrrr(CC, S, RD, RN, RM)			 _dpis(CC, S,  6, RN, RD,   0,  0,  0, RM)
#define SBCrrrs(CC, S, RD, RN, RM, SH, SC, RF)		 _dpis(CC, S,  6, RN, RD,  SC, SH, RF, RM)

#define SMULLrrrr(CC, S, RL, RH, RM, RS)		 _lmul(CC, S, 1, 0, RH, RL, RS, RM)
#define SMLALrrrr(CC, S, RL, RH, RM, RS)		 _lmul(CC, S, 1, 1, RH, RL, RS, RM)

#define STMrl(CC, PU, RN, RL, S)			 _mm(CC, PU, S, 0, 0, RN, RL)
#define STMri(CC, PU, RN, MT, RL)			 _mm(CC, PU, 0, 0, 0, RN, RL)
#define STMwl(CC, PU, RN, RL, S)			 _mm(CC, PU, S, 1, 0, RN, RL)
#define STMwi(CC, PU, RN, MT, RL)			 _mm(CC, PU, 0, 1, 0, RN, RL)

#define STRhrm(CC, B, T, S, H, RD, RN, W)		 _mhs(CC, 1, 1, 1, W, 0, RN, RD,                   0, S, H,           0)
#define STRhrmf(CC, B, T, S, H, RD, RN, W, U, OFF)	 _mhs(CC, 0, U, 1, W, 0, RN, RD, ((OFF) >> 4) & 0xff, S, H, (OFF) & 0xf)
#define STRhrmo(CC, B, T, S, H, RD, RN, W, U, RM)	 _mhs(CC, 0, U, 0, W, 0, RN, RD,                   0, S, H,          RM)
#define STRhrmpf(CC, B, T, S, H, RD, RN, U, OFF, W)	 _mhs(CC, 1, U, 1, W, 0, RN, RD, ((OFF) >> 4) & 0xff, S, H, (OFF) & 0xf)
#define STRhrmpo(CC, B, T, S, H, RD, RN, U, RM, W)	 _mhs(CC, 1, U, 0, W, 0, RN, RD,                   0, S, H,          RM)

#define STRrm(CC, B, T, RD, RN, W)			 _mwubl(CC, 0, 1, 1, B, W, 0, RN, RD,          0)
#define STRrmf(CC, B, T, RD, RN, W, U, OFF)		 _mwubl(CC, 0, 0, U, B, T, 0, RN, RD,        OFF)
#define STRrmo(CC, B, T, RD, RN, W, U, RM)		 _mwubl(CC, 1, 0, U, B, T, 0, RN, RD,         RM)
#define STRrmos(CC, B, T, RD, RN, W, U, RM, SH, SC, MT)	 _mwubr(CC,    0, U, B, T, 0, RN, RD, SC, SH, RM)
#define STRrmpf(CC, B, T, RD, RN, U, OFF, W)		 _mwubl(CC, 0, 1, U, B, W, 0, RN, RD,        OFF)
#define STRrmpo(CC, B, T, RD, RN, U, RM, W)		 _mwubl(CC, 1, 1, U, B, W, 0, RN, RD,         RM)
#define STRrmpos(CC, B, T, RD, RN, U, RM, SH, SC, MT, W) _mwubr(CC,    1, U, B, W, 0, RN, RD, SC, SH, RM)

#define SUBrri(CC, S, RD, RN, ROT, IMM)			 _dpi (CC, S,  2, RN, RD, ROT,        IMM)
#define SUBrrr(CC, S, RD, RN, RM)			 _dpis(CC, S,  2, RN, RD,   0,  0,  0, RM)
#define SUBrrrs(CC, S, RD, RN, RM, SH, SC, RF)		 _dpis(CC, S,  2, RN, RD,  SC, SH, RF, RM)

#define SWIi(CC, N)					 _swi(CC, N)

#define SWPrrm(CC, B, T, RD, RM, RN, MT)		 _swp(CC, B, RN, RD, RM)

#define TEQri(CC, RN, ROT, IMM)				 _dpi (CC, 1,  9, RN,  0, ROT,        IMM)
#define TEQrr(CC, RN, RM)				 _dpis(CC, 1,  9, RN,  0,   0,  0,  0, RM)
#define TEQrrs(CC, RN, RM, SH, SC, RF)			 _dpis(CC, 1,  9, RN,  0,  SC, SH, RF, RM)

#define TSTri(CC, RN, ROT, IMM)				 _dpi (CC, 1,  8, RN,  0, ROT,        IMM)
#define TSTrr(CC, RN, RM)				 _dpis(CC, 1,  8, RN,  0,   0,  0,  0, RM)
#define TSTrrs(CC, RN, RM, SH, SC, RF)			 _dpis(CC, 1,  8, RN,  0,  SC, SH, RF, RM)

#define UMULLrrrr(CC, S, RL, RH, RM, RS)		 _lmul(CC, S, 0, 0, RH, RL, RS, RM)
#define UMLALrrrr(CC, S, RL, RH, RM, RS)		 _lmul(CC, S, 0, 1, RH, RL, RS, RM)

/*
 * pseudo instructions
 */

#define ADRri(CC, R, I)		(_uiP(8, I)																	\
				 ? MOVri(14, 0, R, 0, I)															\
				 : (_uiP(16, I)																	\
				    ? (MOVri(14, 0, R, 0, _Q1(I)), ORRrri(14, 0, R, R, 12, _Q2(I)))										\
				    : (_uiP(24, I)																\
				       ? (MOVri(14, 0, R, 0, _Q1(I)), ORRrri(14, 0, R, R, 12, _Q2(I)), ORRrri(14, 0, R, R, 8, _Q3(I)))						\
				       : (MOVri(14, 0, R, 0, _Q1(I)), ORRrri(14, 0, R, R, 12, _Q2(I)), ORRrri(14, 0, R, R, 8, _Q3(I)), ORRrri(14, 0, R, R, 4, _Q4(I))))))

#define NOP(CC)			MOVrr(14, 0, 0, 0)

/*
 * References: [1] "ARM Architecture Reference Manual", Prentice Hall, 1996
 */

#endif /* __ccg_asm_arm_h */
