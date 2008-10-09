#ifndef _ASSERT_H_
#define _ASSERT_H_

#include <stdio.h>
#include <stdlib.h>

#if defined(NDEBUG)
# define assert(e)			((void)0)
#else
# define assert(e)			((void)((e) ? 0 : __assert(#e, __FILE__, __LINE__)))
# define __assert(e, file, line)	((void)printf("%s:%u: failed assertion `%s'\n", file, line, e), abort())
#endif

#endif /* _ASSERT_H_ */
