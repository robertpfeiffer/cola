#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>

#include <sys/types.h>

enum {
  RedButtonBit		= 4,
  YellowButtonBit	= 2,
  BlueButtonBit		= 1
};

enum {
  ShiftKeyBit		= 1,
  ControlKeyBit		= 2,
  OptionKeyBit		= 4,
  CommandKeyBit		= 8
};

typedef struct
{
  int		*contents;
  size_t	 size;
  size_t	 in;
  size_t	 out;
} Buffer;

static int	 mouseX= 0;
static int	 mouseY= 0;
static unsigned	 buttonState= 0;
static unsigned	 modifierState= 0;

static Buffer	*keyboardBuffer= 0;

Buffer *Buffer_new(size_t nItems)
{
  Buffer *self= (Buffer *)malloc(sizeof(Buffer));
  self->size= nItems;
  self->contents= (int *)malloc(sizeof(int) * nItems);
  self->in= self->out= 0;
  return self;
}

static int Buffer_isEmpty(Buffer *self)
{
  return self->in == self->out;
}

static int Buffer_nextPut(Buffer *self, int item)
{
  self->contents[self->in]= item;
  self->in= (self->in + 1) % self->size;
  if (self->in == self->out) // overflow
    self->out= (self->out + 1) % self->size;	// discard
  return item;
}

static int Buffer_next(Buffer *self, int remove)
{
  int item= -1;
  if (!Buffer_isEmpty(self))
    {
      item= self->contents[self->out];
      if (remove) self->out= (self->out + 1) % self->size;
    }
  return item;
}

static void error(const char *reason)
{
  fprintf(stderr, "%s\n", reason);
  exit(1);
}

#if defined(__unix__) || defined(__MACH__)
# include "io-x11.c"
# include "io-posix.c"
#else
# error platform not supported
#endif

void ioInitialise(void)
{
  keyboardBuffer= Buffer_new(32);
}

unsigned int ioMousePoint(void)
{
  ioProcessEvents(0);
  return (mouseX << 16) | (mouseY & 0xffff);
}

unsigned int ioGetButtonState(void)
{
  ioProcessEvents(0);
  return buttonState | (modifierState << 3);
}

int ioGetKeystroke(int remove)
{
  ioProcessEvents(0);
  return Buffer_next(keyboardBuffer, remove);
}

int ioRelinquishProcessor(int microSecs)
{
  return ioProcessEvents(microSecs);
}
