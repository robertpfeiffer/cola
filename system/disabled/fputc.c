#include "_file.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

int fputc(int c, FILE *stream)
{
  if (stream->error || !(stream->flags & _fileWRITE)) return -1;
  if (c == '\n' && (stream == stdout || stream == stderr)) fputc('\r', stream);
  stream->buffer[stream->size++]= c;
  if ((stream->size == stream->capacity) && (stream->flags & _fileDYNAMIC))
    stream->buffer= realloc(stream->buffer, stream->capacity *= 2);
  else if ((stream->size == stream->capacity) || (stream->flags & _fileUNBUF) || (c == '\n' && (stream->flags & _fileLINEBUF)))
    if (fflush(stream) < 0)
      return -1;
  return c;
}
