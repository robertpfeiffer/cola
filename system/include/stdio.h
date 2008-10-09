#ifndef _STDIO_H_
#define _STDIO_H_

#include <sys/types.h>
#include <stdarg.h>

#define	EOF	(-1)
#define	NULL	(0)

struct _file;

typedef struct _file FILE;

extern FILE *stdin;
extern FILE *stdout;
extern FILE *stderr;

FILE   *fopen(const char *path, const char *mode);
int	fclose(FILE *stream);
size_t	fread(void *ptr, size_t size, size_t nmemb, FILE *stream);
size_t	fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream);
int	fflush(FILE *stream);
int	fputc(int c, FILE *stream);
int	fputs(const char *s, FILE *stream);
int	fprintf(FILE *stream, const char *fmt, ...);
int	vfprintf(FILE *stream, const char *format, va_list ap);
int	sprintf(char *str, const char *format, ...);
int	vsnprintf(char *str, size_t size, const char *format, va_list ap);
int	vsprintf(char *string, const char *fmt, va_list ap);
int	snprintf(char *str, size_t size, const char *format, ...);
int	printf(const char *fmt, ...);
int	puts(const char *s);
int	fgetc(FILE *stream);
char   *fgets(char *str, int size, FILE *stream);
int	getchar(void);
int	putchar(int c);
void    perror(const char *string);

#define	_IOFBF	0
#define	_IOLBF	1
#define	_IONBF	2

int     setvbuf(FILE *stream, char *buf, int mode, size_t size);

#endif /* _STDIO_H_ */
