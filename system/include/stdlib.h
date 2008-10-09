#ifndef _STDLIB_H_
#define _STDLIB_H_

#include <sys/types.h>
#include <alloca.h>

void  *malloc(size_t size);
void  *calloc(size_t count, size_t size);
void  *realloc(void *ptr, size_t size);
void   free(void *ptr);

void   exit(int status);
void   abort(void);

void   qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *));

int    abs(int n);
double strtod(const char *nptr, char **endptr);
long   strtol(const char *nptr, char **endptr, int base);

char  *getenv(const char *name);

#if defined(NO_GC)
# define GC_INIT()	GC_init()
  extern void GC_init(void);
#endif

#endif /* _STDLIB_H_ */
