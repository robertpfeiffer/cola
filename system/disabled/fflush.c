#include "_file.h"
#include <stdio.h>
#include <unistd.h>
#include <errno.h>

int fflush(FILE *stream)
{
  if (!(stream->flags & _fileWRITE)) {
    errno= EBADF;
    return -1;
  }
  if (stream->size) {
    int offset= 0;
    while (offset < stream->size) {
      int n= write(stream->fileno, stream->buffer, stream->size - offset);
      if (n < 1) {
	stream->error= errno;
	stream->size= 0;
	return -1;
      }
      offset += n;
    }
    stream->size= 0;
  }
  return 0;
}
