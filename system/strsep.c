#include <string.h>

char *strsep(char **stringp, const char *delim)
{
  char		*s;
  const char	*spanp;
  int		 c, sc;
  char		*tok;
  if (!(s= *stringp))
    return 0;
  tok= s;
  for (;;)
    {
      c= *s++;
      spanp= delim;
      do {
	if ((sc= *spanp++) == c)
	  {
	    if (!c)
	      s= 0;
	    else
	      s[-1]= '\0';
	    *stringp= s;
	    return tok;
	  }
      } while (sc != 0);
    }
}
