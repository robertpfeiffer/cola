/* asm-common.h -- dynamic assembler support
 *
 * Copyright (C) 1999, 2000 Ian Piumarta <ian.piumarta@inria.fr>
 *
 * This file is part of CCG.
 *
 * CCG is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * CCG is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the file COPYING for more details.
 *
 * Last edited: 2003-01-20 13:05:50 by piumarta on emilia.local.
 */

#ifndef __ccg_asm_common_h
#define __ccg_asm_common_h_

#ifdef EMBEDDED
# include "osdep/stdio.h"
# include "osdep/stdlib.h"
#else
# include <stdio.h>
# define sys_fprintf fprintf
# define sys_abort   abort
#endif

#include "asm-cache.h"

#ifndef _ASM_LOCALPC
  static int   asm_pass;	/* 0 (single pass) or 1/2 (two pass) */
  static insn *asm_pc;
#endif

#define ASMFAIL(MSG) asmFail(MSG, __FILE__, __LINE__, __FUNCTION__)

#ifndef  _ASM_APP_1
# define _ASM_APP_1	{ asm_pass= 0; {
#endif
#ifndef  _ASM_NOAPP_1
# define _ASM_NOAPP_1	}}
#endif
#ifndef  _ASM_APP_2
# define _ASM_APP_2	{ insn *asm_lwm= asm_pc; for (asm_pass= 1; ((asm_pass < 3) && ((asm_pc= asm_lwm), 1)); ++asm_pass) {
#endif
#ifndef  _ASM_NOAPP_2
# define _ASM_NOAPP_2	}}
#endif

#ifndef  _ASM_ORG
# define _ASM_ORG(O)	(asm_pc= (insn *)(O))
#endif
#ifndef  _ASM_LBL
# define _ASM_LBL(V)	static insn *V= 0
#endif
#ifndef  _ASM_DEF
# define _ASM_DEF(V)	(V= (((asm_pass==2)&&(asm_pc!=(V))) ? (insn *)ASMFAIL("phase error") : asm_pc))
#endif

static int asmFail(const char *msg, const char *file, int line, const char *function)
{
  sys_fprintf(stderr, "%s: In function `%s':\n", file, function);
  sys_fprintf(stderr, "%s:%d: %s\n", file, line, msg);
  sys_abort();
  return 0;
}

/* integer predicates */

#define _MASK(N)	((u_int32_t)((1<<(N)))-1)
#define _siP(N,I)	((((int)(I)) >= (-1<<((N)-1))) && (((int)(I)) < (1<<((N)-1))))
#define _uiP(N,I)	(((unsigned int)(I)) < (1U<<(N)))

#endif /* __ccg_asm_common_h */

#ifndef EMBEDDED
# undef sys_fprintf
# undef sys_abort
#endif
