void printf(char *, ...); 

#include "malloc.h"
#include <unistd.h>	/* write(2) */
#define NULL 0

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * A  "smarter" malloc v1.0			William L. Sebok
 *					Sept. 24, 1984 rev. June 30,1986
 *			Then modified by Arthur David Olsen
 *			MALLOCTRACE added by Mark Brader
 *			Modernised for 21st century compilers by Ian Piumarta
 *
 *	malloc allocates and returns a pointer to a piece of memory nbytes
 *	in size.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifdef	MALLOCTRACE	/* See ./TRACE_README */

#include <stdio.h>
FILE *_malfp;
int _malbuff;

enum _malstate _malstate = S_INITIAL;

#endif

/* sizes of buckets currently proportional to log 2() */
static Size mlsizes[] = {0, 64, 128, 256, 512, 1024, 2048,
	4096, 8192, 16384, 32768, 65536, 131072,
	262144, 524288, 1048576, 2097152, 4194304};

/* head of adjacency chain */
struct qelem adjhead = { &adjhead, &adjhead };

/* head of bucket chains */
struct qelem buckets[NBUCKETS] = {
  { &buckets[ 0], &buckets[ 0] }, { &buckets[ 1], &buckets[ 1] },
  { &buckets[ 2], &buckets[ 2] }, { &buckets[ 3], &buckets[ 3] },
  { &buckets[ 4], &buckets[ 4] }, { &buckets[ 5], &buckets[ 5] },
  { &buckets[ 6], &buckets[ 6] }, { &buckets[ 7], &buckets[ 7] },
  { &buckets[ 8], &buckets[ 8] }, { &buckets[ 9], &buckets[ 9] },
  { &buckets[10], &buckets[10] }, { &buckets[11], &buckets[11] },
  { &buckets[12], &buckets[12] }, { &buckets[13], &buckets[13] },
  { &buckets[14], &buckets[14] }, { &buckets[15], &buckets[15] },
  { &buckets[16], &buckets[16] }, { &buckets[17], &buckets[17] }
};

struct qelem *	hifreebp = &buckets[0];

char endfree = 0;
void (*mlabort)() = {0};
void	mlfree_end();

char *
malloc(nbytes)
	unsigned nbytes;	/* for 4.3 compat. */
{
	register struct overhead *p, *q;
	register struct qelem *bucket;
	register Size surplus;
	Size mlindx();

#ifdef	MALLOCTRACE
	unsigned old_nbytes;

	old_nbytes = nbytes;
	if (_malstate == S_INITIAL) _mal_init_trace();
#endif

	nbytes = ((nbytes + (NALIGN-1)) & ~(NALIGN-1))
		+ sizeof(struct overhead);

	for (
	    bucket = &buckets[mlindx((Size) nbytes)];
	    bucket <= hifreebp;
	    bucket++
	) { 
		register struct qelem *b;
		for(b = bucket->q_forw; b != bucket; b = b->q_forw) {
			p = FROMBUK(b);
			ASSERT(p->ov_magic == MAGIC_FREE, "\nmalloc: Entry not marked FREE found on Free List!\n");
			if (p->ov_length >= nbytes) {
				remque(b);
				surplus = p->ov_length - nbytes;
				goto foundit;
			}
		}
	}

	/* obtain additional memory from system */
	{
		register Size i;
		p = (struct overhead *)CURBRK;

		i = ((Size)p)&(NALIGN-1);
		if (i != 0)
			p = (struct overhead *)((char *)p + NALIGN - i);

		if (-1 == (long)BRK((char *)p + nbytes)) {
#ifdef	MALLOCTRACE
			if (_malstate == S_TRACING)
				_mal_write_trace ("malloc", (Size) old_nbytes, (Size) 0, (char*) 0);
#endif
			return(NULL);
		}

		p->ov_length = nbytes;
		surplus = 0;

		/* add to end of adjacency chain */
		ASSERT((FROMADJ(adjhead.q_back)) < p, "\nmalloc: Entry in adjacency chain found with address lower than Chain head!\n"
			);
		insque(TOADJ(p),adjhead.q_back);
	}

foundit:
	/* mark surplus memory free */
	if (surplus > (int) sizeof(struct overhead)) {
		/* if big enough, split it up */
		q = (struct overhead *)((char *)p + nbytes);

		q->ov_length = surplus;
		p->ov_length = nbytes;
		q->ov_magic = MAGIC_FREE;

		/* add surplus into adjacency chain */
		insque(TOADJ(q),TOADJ(p));

		/* add surplus into bucket chain */
		{
			register struct qelem *	bp;

			bp = &buckets[mlindx(surplus)];
			if (bp > hifreebp)
				hifreebp = bp;
			insque(TOBUK(q),bp);
		}
	}
#ifdef	MALLOCTRACE
	else
		nbytes += surplus;

	if (_malstate == S_TRACING)
		_mal_write_trace ("malloc", (Size) old_nbytes, (Size) nbytes,
					(char *) p + sizeof (struct overhead));
#endif

	p->ov_magic = MAGIC_BUSY;
	return((char*)p + sizeof(struct overhead));
}

/*
 * select the proper size bucket
 */
Size
mlindx(n)
register Size n;
{
	register Size *p;

	p = mlsizes;
	p[NBUCKETS - 1] = n;
	/* Linear search. */
	while (n > *p++)
		;
	return (p - 1) - mlsizes;
}

void
mllcerr(p)
char *p;
{
	register char *q;
	q = p;
	while (*q++);	/* find end of string */
	(void)write(2,p,q-p-1);
#ifndef	MALLOCTRACE
	if (mlabort)
		(*mlabort)();
#ifdef debug
	else
		abort();
#endif /* debug */
#endif /* MALLOCTRACE */
}

#ifndef vax
/*
 * The vax has wondrous instructions for inserting and removing items into
 * doubly linked queues.  On the vax the assembler output of the C compiler is
 * massaged by an sed script to turn these function calls into invocations of
 * the insque and remque machine instructions.
 */

void
insque(item,queu)
register struct qelem *item, *queu;
/* insert "item" after "queu" */
{
	register struct qelem *pueu;
	pueu = queu->q_forw;
	item->q_forw = pueu;
	item->q_back = queu;
	queu->q_forw = item;
	pueu->q_back = item;
}

void
remque(item)
register struct qelem *item;
/* remove "item" */
{
	register struct qelem *queu, *pueu;
	pueu = item->q_forw;
	queu = item->q_back;
	queu->q_forw = pueu;
	pueu->q_back = queu;
}
#endif
