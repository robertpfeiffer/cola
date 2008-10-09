#include "malloc.h"
#define NULL 0

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  free					William L. Sebok
 * A "smarter" malloc v1.0		Sept. 24, 1984 rev. June 30,1986
 *			Then modified by Arthur David Olsen
 *			MALLOCTRACE added by Mark Brader
 *
 * 	free takes a previously malloc-allocated area at mem and frees it.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

void free(mem)
register char *mem;
{
	register struct overhead *p, *q;
	void mlfree_end();

#ifdef	MALLOCTRACE	/* See ./TRACE_README */
	extern enum _malstate _malstate;

	if (_malstate == S_INITIAL) _mal_init_trace();
#endif

	if (mem == NULL)
		return;

	p = (struct overhead *)(mem - sizeof(struct overhead));

#ifdef	MALLOCTRACE
	if (_malstate == S_TRACING)
		_mal_write_trace ("free", p->ov_length, p->ov_length, mem);
#endif

	/* not advised but allowed */
	if (p->ov_magic == MAGIC_FREE)
		return;

	if (p->ov_magic != MAGIC_BUSY) {
		mllcerr("attempt to free memory not allocated with malloc!\n");
#ifdef	MALLOCTRACE
		return;		/* mllcerr() normally doesn't return */
#endif
	}

	/* try to merge with previous free area */
	q = FROMADJ((TOADJ(p))->q_back);

	if (q != FROMADJ(&adjhead)) {
		ASSERT(q < p, "\nfree: While trying to merge a free area with a lower adjacent free area, addresses were found out of order!\n");
		/* If lower segment can be merged */
		if (   q->ov_magic == MAGIC_FREE
		   && (char *)q + q->ov_length == (char *)p
		) {
			/* remove lower address area from bucket chain */
			remque(TOBUK(q));

			/* remove upper address area from adjacency chain */
			remque(TOADJ(p));

			q->ov_length += p->ov_length;
			p->ov_magic = NULL;	/* decommission */
			p = q;
		}
	}

	/* try to merge with next higher free area */
	q = FROMADJ((TOADJ(p))->q_forw);

	if (q != FROMADJ(&adjhead)) {
		/* upper segment can be merged */
		ASSERT(q > p, "\nfree: While trying to merge a free area with a higher adjacent free area, addresses were found out of order!\n");
		if ( 	q->ov_magic == MAGIC_FREE
		   &&	(char *)p + p->ov_length == (char *)q
		) {
			/* remove upper from bucket chain */
			remque(TOBUK(q));

			/* remove upper from adjacency chain */
			remque(TOADJ(q));

			p->ov_length += q->ov_length;
			q->ov_magic = NULL;	/* decommission */
		}
	}

	p->ov_magic = MAGIC_FREE;

	/* place in bucket chain */
	{
		Size mlindx();
		register struct qelem *	bp;

		bp = &buckets[mlindx(p->ov_length)];
		if (bp > hifreebp)
			hifreebp = bp;
		insque(TOBUK(p),bp);
	}

	if (endfree)
		mlfree_end();

	return;
}

void
mlfree_end()
{
	register struct overhead *p;

	p = FROMADJ(adjhead.q_back);
	if (	/* area is free and at end of memory */
	        p->ov_magic == MAGIC_FREE
	    &&	(char*)p + p->ov_length == (char *)CURBRK
	) {
		p->ov_magic = NULL;	/* decommission (just in case) */

		/* remove from end of adjacency chain */
		remque(TOADJ(p));

		/* remove from bucket chain */
		remque(TOBUK(p));

		/* release memory to system */
		(void)BRK((char *)p);
	}
	return;
}
