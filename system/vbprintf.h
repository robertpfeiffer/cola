#include <sys/types.h>
#include <stdarg.h>

struct buffer
{
  char   *buffer;
  size_t  position;
  size_t  length;
};

struct buffer *buffer_init(struct buffer *b);
void buffer_release(struct buffer *b);

void vbprintf(struct buffer *b, const char *fmt, va_list ap);
