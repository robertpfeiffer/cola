#include <stdio.h>
#include <stdarg.h>
#include <sys/types.h>

struct _file;

#define unsupported()	printf("unsupported function: %s\n", __PRETTY_FUNCTION__)

typedef long time_t;

/**
 **	STDLIB
 **/

double strtod(const char *string, char **endPtr)						{ unsupported();  return 0.0; }
void   qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))	{ unsupported(); }

/**
 **	UNISTD
 **/

void   *sbrk(int incr)						{ unsupported();  return 0; }
int	access(const char *path, int amoge)			{ unsupported();  return 0; }
int	open(const char *path, int oflag, ...)			{ unsupported();  return 0; }
int	close(int fildes)					{ unsupported();  return 0; }

int isatty(int fd)
{
  return 1;
}

#if 1

ssize_t read(int fildes, void *buf, size_t nbyte)
{
  if (fildes == 0)
    {
      size_t i= nbyte;
      char *ptr= (char *)buf;
      while (i--)
	*ptr++= fgetc(stdin);
      return nbyte;
    }
  unsupported();
  return -1;
}

ssize_t write(int fildes, const void *buf, size_t nbyte)
{
  if ((fildes == 1) || (fildes == 2))
    {
      size_t i= nbyte;
      const char *ptr= buf;
      while (i--)
	fputc(*ptr++, stdout);
      return nbyte;
    }
  unsupported();
  return -1;
}

#endif

/**
 **	STRING
 **/

size_t fread(void *ptr, size_t size, size_t nmemb, FILE *stream)		{ unsupported();  return 0; }
FILE  *fdopen(int fildes, const char *mode)					{ unsupported();  return 0; }
int    setvbuf(FILE *stream, char *buf, int mode, size_t size)			{ unsupported();  return 0; }

/**
 **	TIME
 **/

struct itimerval;
struct timespec;
struct timeval;
struct tm;

int	   setitimer(int which, const struct itimerval *value, struct itimerval *ovalue)	{ unsupported();  return 0; }
int	   nanosleep(const struct timespec *rqtp, struct timespec *rmtp)			{ unsupported();  return 0; }
int	   gettimeofday(struct timeval *tp, void *tzp)						{ unsupported();  return 0; }
struct tm *localtime(const time_t *clock)							{ unsupported();  return 0; }
size_t	   strftime(char *buf, size_t maxsize, const char *format, const struct tm *timeptr)	{ unsupported();  return 0; }

/**
 **	SIGNAL
 **/

void (*signal(int sig, void (*func)(int)))(int)		{ unsupported();  return 0; }

/**
 **	IOCTL
 **/

int ioctl(int fildes, unsigned long request, ...)	{ unsupported();  return 0; }

/**
 **	TERMIOS
 **/

struct termios;

int tcgetattr(int fd, struct termios *t)			{ unsupported();  return 0; }

int tcsetattr(int fd, int action, const struct termios *t)	{ unsupported();  return 0; }

/**
 **	GC
 **/

void GC_INIT(void) {}
void GC_init(void) {}

#if 0

/**
 ** CRT0
 **/

void _start(void)
{
  extern int main();
  char *argv[]= { "cola", 0 };
  main(1, argv, 0);
  fatal("terminated\n");

}
#endif
