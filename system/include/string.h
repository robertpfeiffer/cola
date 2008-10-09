#ifndef _STRING_H_
#define _STRING_H_

#include <sys/types.h>

void   *memset(void *dst, int c, size_t len);
void   *memcpy(void *dst, const void *src, size_t len);
void   *memmove(void *dst, const void *src, size_t len);
size_t  strlen(const char *s);
int     strcmp(const char *s1, const char *s2);
int     strncmp(const char *s1, const char *s2, size_t len);
int     strncasecmp(const char *s1, const char *s2, size_t len);
char   *strcpy(char *dst, const char *src);
char   *strncpy(char *dst, const char *src, size_t len);
char   *strdup(const char *src);
char   *strchr(const char *s, int c);
char   *strrchr(const char *s, int c);
char   *strsep(char **stringp, const char *delim);
char   *strerror(int errnum);

#endif /* _STRING_H_ */
