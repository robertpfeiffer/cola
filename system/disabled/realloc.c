#include <string.h>	/* memcpy */
#include "malloc.h"
#define NULL 0

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  realloc				William L. Sebok
 * A  "smarter" malloc v1.0		Sept. 24, 1984 rev. Oct 17,1986
 *			Then modified by Arthur David Olsen
 *			MALLOCTRACE added by Mark Brader
 *
 *	realloc takes previously malloc-allocated area at mem, and tries
 *	 to change its size to nbytes bytes, moving it and copying its
 *	 contents if necessary.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifdef	MALLOCTRACE	/* See ./TRACE_README */
unsigned old_nbytes;
#endif

char *
realloc(mem,nbytes)
register char *mem; unsigned nbytes;	/* for 4.3 compat. */

#ifdef	MALLOCTRACE
	/*
	 * The (real) realloc function may call malloc or not; we want
	 * to generate a trace message from here if it doesn't.  And
	 * likewise for free.  Since the function is somewhat complicated,
	 * this goal is most easily achieved by wrapping a dummy realloc
	 * function -- this one -- around the real realloc.  The real
	 * realloc is imaginatively renamed real_realloc.
	 */
{

	char *real_realloc(), *newmem;
	Size new_nbytes;
	extern enum _malstate _malstate;

#define	BYTES(mem)	(((struct overhead *)(mem - sizeof(struct overhead))) \
		->ov_length)	/* How realloc finds the allocated length */

	old_nbytes = 0;		/* Normally changed in real_realloc */

	if (_malstate == S_INITIAL) _mal_init_trace();

	if (_malstate == S_TRACING)
		_malstate = S_IN_REALLOC;

	newmem = real_realloc (mem, nbytes);

	if (_malstate == S_IN_REALLOC) {
		_malstate = S_TRACING;

		if (newmem) new_nbytes = BYTES (newmem);
		_mal_write_trace ("realloc", (Size) old_nbytes,
						(Size) old_nbytes, mem);
		_mal_write_trace ("realloc-to", (Size) nbytes,
						(Size) new_nbytes, newmem);
	}

	return newmem;
}

	/*
	 * And now, the real realloc.  If MALLOCTRACE is not defined,
	 * this function will of course compile as realloc.
	 */

static char *
real_realloc(mem,nbytes)
register char *mem; unsigned nbytes;

#endif
{
	register char *newmem = NULL;
	register struct overhead *p;
	Size surplus, length;
	Size oldlength;

	if (mem == NULL)
		return(malloc(nbytes));

	/* if beyond current arena it has to be bad */
	if (mem > (char*)FROMADJ(adjhead.q_back) + sizeof(struct overhead))
		return(NULL);
	
	p = (struct overhead *)(mem - sizeof(struct overhead));

	if (p->ov_magic != MAGIC_BUSY && p->ov_magic != MAGIC_FREE)
		return(NULL);	/* already gone */

	oldlength = p->ov_length;

#ifdef	MALLOCTRACE
	old_nbytes = oldlength;
#endif

	nbytes = ((nbytes + (NALIGN-1)) & (~(NALIGN-1)))
		 + sizeof(struct overhead);

	if (p->ov_magic == MAGIC_BUSY) {
		void free();
		/* free may claim adjacent free memory, compacting storage */
		char oendfree = endfree;
		endfree = 0;
		free(mem);	/* free it but don't let it contract break */
		endfree = oendfree;
		if (p->ov_magic != MAGIC_FREE) {	/* check if moved */
			p = FROMADJ(p->ov_adj.q_back);
			newmem = (char *)p + sizeof(struct overhead);
		}
	}

	/* at this point p->ov_magic should be MAGIC_FREE */
	ASSERT(p->ov_magic == MAGIC_FREE, "\nrealloc: bad magic number.\n");

	/*
	** We wait to set length until after any possible compaction.
	*/
	length = p->ov_length;
	surplus = length - nbytes;
	if (surplus >= 0) {
		/* present location large enough */
		remque(TOBUK(p));
		p->ov_magic = MAGIC_BUSY;
	} else if ( ((char *)p + p->ov_length) == CURBRK) {
		/* if at break, grow in place */
		(void) BRK((char *)p + nbytes);
		p->ov_length = nbytes;
		remque(TOBUK(p));
		p->ov_magic = MAGIC_BUSY;
	} else {
		newmem = malloc(nbytes - sizeof(struct overhead));
		if (newmem == NULL)
			return(NULL);
		surplus = 0;
	}

	/* if returned address is different, move data */
	if (newmem != NULL) {
		/* note: it is assumed that bcopy does the right thing on
		 * overlapping extents (true on the vax)
		 */
		(void)memcpy(newmem, mem, ((oldlength < nbytes) ? oldlength : nbytes) - sizeof(struct overhead));
		mem = newmem;
	}

	/* if more memory than we need then return excess to buckets */
	if (surplus > (int) sizeof(struct overhead)) {
		register struct overhead *q;
		q = (struct overhead *)( (char *)p + nbytes);
		q->ov_length = surplus;
		q->ov_magic = MAGIC_FREE;
		insque(TOADJ(q),TOADJ(p));
		{
			Size mlindx();
			register struct qelem *	bp;

			bp = &buckets[mlindx(surplus)];
			if (bp > hifreebp)
				hifreebp = bp;
			insque(TOBUK(q),bp);
		}
		p->ov_length -= surplus;
	}

	if (endfree) {
		void mlfree_end();
		mlfree_end();
	}

	return(mem);
}
