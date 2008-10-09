#include <stdlib.h>
#include <errno.h>

#ifndef  ULONG_MAX
# define ULONG_MAX	((unsigned long)(~0L))		/* 0xFFFFFFFF */
#endif

#ifndef  LONG_MAX
# define LONG_MAX	((long)(ULONG_MAX >> 1))	/* 0x7FFFFFFF */
#endif

#ifndef  LONG_MIN
# define LONG_MIN	((long)(~LONG_MAX))		/* 0x80000000 */
#endif 

#define ISDIGIT(C)	(('0' <= (C)) && ((C) <= '9'))
#define ISUPPER(C)	(('A' <= (C)) && ((C) <= 'Z'))
#define ISLOWER(C)	(('a' <= (C)) && ((C) <= 'z'))
#define ISALPHA(C)	(ISUPPER(C) || ISLOWER(C))
#define ISSPACE(C)	((' ' == (C)) || ('\n' == (C)) || ('\t' == (C)) || ('\r' == (C)) || ('\v' == (C)) || ('\f' == (C)))

long strtol(const char *nptr, char **endptr, register int base)
{
  register const char *s= nptr;
  register unsigned long acc;
  register int c;
  register unsigned long cutoff;
  register int neg= 0, any, cutlim;

  do { c= *s++; } while (ISSPACE(c));

  if	  (c == '-') { neg= 1;  c= *s++; }
  else if (c == '+') {          c= *s++; }

  if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    {
      c= s[1];
      s += 2;
      base= 16;
    }
  if (base == 0)
    base= c == '0' ? 8 : 10;

  cutoff= neg ? -(unsigned long)LONG_MIN : LONG_MAX;
  cutlim= cutoff % (unsigned long)base;
  cutoff /= (unsigned long)base;
  for (acc= 0, any= 0;;  c= *s++)
    {
      if	(ISDIGIT(c))	c -= '0';
      else if	(ISALPHA(c))	c -= (ISUPPER(c) ? ('A' - 10) : ('a' - 10));
      else			break;
      if (c >= base)
	break;
      if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
	any= -1;
      else
	{
	  any= 1;
	  acc *= base;
	  acc += c;
	}
    }
  if (any < 0)
    {
      acc= neg ? LONG_MIN : LONG_MAX;
      errno= ERANGE;
    }
  else if (neg)
    acc= -acc;
  if (endptr != 0)
    *endptr= (char *) (any ? s - 1 : nptr);
  return (acc);
}
