#include "malloc.h"
#include <string.h>	/* memset */
#define NULL 0


char *
calloc(n, s)
unsigned	n;
unsigned	s;
{
	unsigned	cnt;
	char *		cp;

	cnt = n * s;
	cp = malloc(cnt);
	if (cp != NULL)
	  memset(cp, 0, (size_t) cnt);
	return cp;
}
