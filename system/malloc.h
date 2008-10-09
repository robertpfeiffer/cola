/*LINTLIBRARY*/

#ifndef lint
#ifndef NOID
#endif /* !NOID */
#endif /* !lint */

#ifdef vax

struct qelem *	_p;
struct qelem *	_q;

#define remque(p)	{ _p = (p); asm("remque	*__p,r0"); }
#define insque(p, q)	{ _p = (p); _q = (q) ; asm("insque	*__p,*__q"); }

#endif /* vax */

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * A  "smarter" malloc				William L. Sebok
 *			Then modified by Arthur David Olsen
 *			MALLOCTRACE added by Mark Brader
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *	Algorithm:
 *	 Assign to each area an index "n". This is currently proportional to
 *	the log 2 of size of the area rounded down to the nearest integer.
 *	Then all free areas of storage whose length have the same index n are
 *	organized into a chain with other free areas of index n (the "bucket"
 *	chain). A request for allocation of storage first searches the list of
 *	free memory.  The search starts at the bucket chain of index equal to
 *	that of the storage request, continuing to higher index bucket chains
 *	if the first attempt fails.
 *	If the search fails then new memory is allocated.  Only the amount of
 *	new memory needed is allocated.  Any old free memory left after an
 *	allocation is returned to the free list.
 *
 *	  All memory areas (free or busy) handled by malloc are also chained
 *	sequentially by increasing address (the adjacency chain).  When memory
 *	is freed it is merged with adjacent free areas, if any.  If a free area
 *	of memory ends at the end of memory (i.e. at the break), and if the
 *	variable "endfree" is non-zero, then the break is contracted, freeing
 *	the memory back to the system.
 *
 *	Notes:
 *		ov_length field includes sizeof(struct overhead)
 *		adjacency chain includes all memory, allocated plus free.
 */

/* the following items may need to be configured for a particular machine */

/* alignment requirement for machine (in bytes) */
#define NALIGN	4

/* size of an integer large enough to hold a character pointer */
typedef	long	Size;

/*
 * CURBRK returns the value of the current system break, i.e., the system's
 * idea of the highest legal address in the data area.  It is defined as
 * a macro for the benefit of systems that have provided an easier way to
 * obtain this number (such as in an external variable)
 */

#ifndef CURBRK
#define CURBRK	sbrk(0)
extern void *sbrk();
#else /* CURBRK */
#	if	CURBRK == curbrk
extern Size curbrk;
#	endif
#endif /* CURBRK */

/*
 * note that it is assumed that CURBRK remembers the last requested break to
 * the nearest byte (or at least the nearest word) rather than the nearest page
 * boundary.  If this is not true then the following BRK macro should be
 * replaced with one that remembers the break to within word-size accuracy.
 */

#ifndef BRK
#define BRK(x)	brk(x)
extern void *brk();
#endif /* !BRK */

/* END of machine dependent portion */

#ifdef	MALLOCTRACE
/* Tracing of all calls to malloc, free, realloc... see ./TRACE_README */

enum _malstate {S_INITIAL, S_IN_STDIO, S_IN_REALLOC, S_TRACING};

#define	TRACEFILE	"malloc.out"	/* default output filename */

#undef	MALLOCTRACE		/* so the next line means what it says! */
#define	TRACEENVVAR	"MALLOCTRACE"	/* where to read nondefault name */
#define	MALLOCTRACE		/* cancel #undef! */

#define	TRACEBUFVAR	"MALLOCTRACEBUF"	/* No-flush request */
#endif

#define	MAGIC_FREE	0x548a934c
#define	MAGIC_BUSY	0xc139569a

#define NBUCKETS	18

struct qelem {
	struct qelem *q_forw;
	struct qelem *q_back;
};

struct overhead {
	struct qelem	ov_adj;		/* adjacency chain pointers */ 
	struct qelem	ov_buk;		/* bucket chain pointers */
	long		ov_magic;
	Size		ov_length;
};

/*
 * The following macros depend on the order of the elements in struct overhead
 */
#define TOADJ(p)	((struct qelem *)(p))
#define FROMADJ(p)	((struct overhead *)(p))
#define FROMBUK(p)	((struct overhead *)( (char *)p - sizeof(struct qelem)))
#define TOBUK(p)	((struct qelem *)( (char *)p + sizeof(struct qelem)))

/*
 * return to the system memory freed adjacent to the break 
 * default is Off
 */
extern char endfree;

/* head of adjacency chain */
extern struct qelem adjhead;

/* head of bucket chains */
extern struct qelem buckets[NBUCKETS];
extern struct qelem *	hifreebp;

extern void (*mlabort)();

#ifndef vax
extern void insque(), remque();
#endif
extern void mllcerr();
extern char *malloc(), *realloc();

#ifdef debug
# define ASSERT(p,q)	if (!(p)) mllcerr(q)
#else
# define ASSERT(p,q)	((void)(p),(void)(q))
#endif
