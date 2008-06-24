/* freedline.c -- user input with line editing and history
 * 
 * Copyright (c) 2008 Ian Piumarta
 * All rights reserved.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the 'Software'),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, provided that the above copyright notice(s) and this
 * permission notice appear in all copies of the Software and that both the
 * above copyright notice(s) and this permission notice appear in supporting
 * documentation.
 * 
 * THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.
 * 
 * Last edited: 2008-06-23 11:10:30 by piumarta on emilia
 */

#include "freedline.h"

#if defined(WIN32) && !defined(CYGWIN)
# include <windows.h>
#else
# include <termios.h>
# include <sys/ioctl.h>
#endif
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char *line= 0;			/* current input line */
static int   position= 0;		/* next insert position in line */
static int   size= 0;			/* number of chars in line */
static int   capacity= 0;		/* capacity of line */

static char	    *history[1024];	/* circular buffer of previous lines; must be power of two */
static unsigned int  now= 0;		/* position of current input line */
static unsigned int  then= 0;		/* position of most recently recopied history line */

#define arraySize(ARRAY)	(sizeof(ARRAY) / sizeof((ARRAY)[0]))
#define arrayMask(ARRAY)	(arraySize(ARRAY) - 1)

static int width= 0;			/* terminal width */
static int height= 0;			/* terminal height */
static int cursorPos= 0;		/* current terminal cursor position as number of chars from start of prompt */
static int offset= 0;			/* width of prompt */
static char *prompt= 0;			/* the prompt */

#if defined(WIN32) && !defined(CYGWIN)
  static HANDLE hConsoleIn;
  static HANDLE hConsoleOut;
#else
  static void (*oldWindowChanged)(int);	/* original SIGWINCH handler */
#endif

typedef int (*action)(int c);		/* action bound to a control key */

static action actions[256]= { 0 };	/* key bindings */

/* memory */

static inline void *memCheck(void *ptr, size_t lbs)
{
  if (!ptr)
    {
      fprintf(stderr, "\nfreedline: failed to allocate %ld bytes\n", (long)lbs);
      abort();
    }
  return ptr;
}

static void *xmalloc(size_t lbs)
{
  return memCheck(malloc(lbs), lbs);
}

static void *xrealloc(void *ptr, size_t lbs)
{
  return memCheck(realloc(ptr, lbs), lbs);
}

/* cursor and output control */

#if defined(WIN32) && !defined(CYGWIN)

  static void perr(char *who)
  {
    LPVOID lpMsgBuf;
    DWORD dw = GetLastError(); 
    FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM |	FORMAT_MESSAGE_IGNORE_INSERTS, NULL,
		  dw, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPTSTR)&lpMsgBuf, 0, NULL );
    printf("%s: %d: %s\n", who, (int)dw, (char *)lpMsgBuf);
  }

  static int move(int dx, int dy)
  {
    CONSOLE_SCREEN_BUFFER_INFO csbi;
#  define x csbi.dwCursorPosition.X
#  define y csbi.dwCursorPosition.Y
#  define w csbi.dwSize.X
#  define h csbi.dwSize.Y
    if (!GetConsoleScreenBufferInfo(hConsoleOut, &csbi)) return -1;
    x += dx;
    y += dy;
    if (x < 0) x= 0;  else if (x >= w) x= w - 1;
    if (y < 0) y= 0;  else if (y >= h) y= h - 1;
    if (!SetConsoleCursorPosition(hConsoleOut, csbi.dwCursorPosition)) return -1;
#  undef h
#  undef w
#  undef y
#  undef x
    return 0;
  }

  static int getWindowSize(int *xp, int *yp)
  {
    CONSOLE_SCREEN_BUFFER_INFO csbi;
    if (!GetConsoleScreenBufferInfo(hConsoleOut, &csbi)) return -1;
    *xp= csbi.dwSize.X;
    *yp= csbi.dwSize.Y;
    return 0;
  }

  static void cursorUp(int n)	 { move( 0, -n); }
  static void cursorDown(int n)	 { move( 0,  n); }
  static void cursorRight(int n) { move( n,  0); }
  static void cursorLeft(int n)	 { move(-n,  0); }

  char *fgetln(FILE *stream, size_t *len)
  {
    static size_t  capacity= 0;
    static char   *buffer= 0;
    size_t size= 0;
    int    c;
    while (EOF != (c= fgetc(stream)))
      {
        if (size == capacity)
	  buffer= buffer ? xrealloc(buffer, capacity *= 2) : xmalloc(capacity= 64);
        buffer[size++]= c;
	if ('\n' == c || '\r' == c)
	  break;
      }
    *len= size;
    printf("read %d\n", (int)size);
    return buffer;
  }

#else

# define perr(WHO) perror(WHO)

  static int getWindowSize(int *xp, int *yp)
  {
    struct winsize winsize;
    if (ioctl(0, TIOCGWINSZ, &winsize)) return -1;
    *xp= winsize.ws_col;
    *yp= winsize.ws_row;
    return 0;
  }

  static void cursorUp(int n)	 { printf("\033[%dA", n); }
  static void cursorDown(int n)	 { printf("\033[%dB", n); }
  static void cursorRight(int n) { printf("\033[%dC", n); }
  static void cursorLeft(int n)	 { printf("\033[%dD", n); }

  static void echo(int c);
  static void moveTo(int pos);

  static void windowChanged(int signo)
  {
    int curX= cursorPos % width;
    int curY= cursorPos / width;
    int nlines= 1 + (offset + size) / width;
    getWindowSize(&width, &height);
    if (curX >= width) curX= width - 1;
    cursorPos= width * curY + curX;
    moveTo(-offset);
    curY= nlines * width - 1;
    for (curX= 0;  curX < curY;  ++curX) echo(' ');
    moveTo(-offset);
    for (curX= 0;  curX < offset;  ++curX) echo(prompt[curX]);
    for (curX= 0;  curX < size;    ++curX) echo(line  [curX]);
    moveTo(position);
    fflush(stdout);
  }

#endif

static void echo(int c)
{
  if ((c < ' ') || (c > '~')) c= ' ';
  putchar(c);
  ++cursorPos;
  if (0 == cursorPos % width)
    printf("\n\r");
}

static void moveTo(int pos)
{
  pos += offset;
  int posX= pos % width;
  int posY= pos / width;
  int curX= cursorPos % width;
  int curY= cursorPos / width;
  if (posX < curX) cursorLeft(curX - posX); else if (posX > curX) cursorRight(posX - curX);
  if (posY < curY) cursorUp(curY - posY); else if (posY > curY) cursorDown(posY - curY);
  cursorPos= pos;
}

/* editing functions */

static void grow(void)
{
  line= capacity ? xrealloc(line, capacity *= 2) : xmalloc(capacity= 1024);
}

static int insert(int c)
{
  int i;
  if (size == capacity) grow();
  memmove(line + position + 1, line + position, size - position);
  ++size;
  line[position++]= c;
  echo(c);
  for (i= position;  i < size;  ++i) echo(line[i]);
  moveTo(position);
  return 0;
}

static int ignore(int c)
{
  return 0;
}

static int moveBackward(int c)
{
  if (position > 0)
    moveTo(--position);
  return 0;
}

static int moveBeginning(int c)
{
  if (position > 0)
    moveTo(position= 0);
  return 0;
}

static int moveForward(int c)
{
  if (position < size)
    moveTo(++position);
  return 0;
}

static int moveEnd(int c)
{
  moveTo(position= size);
  return 0;
}

static int enter(int c)
{
  line[size]= '\0';
  moveTo(size);
  if (size)
    {
      int prev= (now - 1) & arrayMask(history);
      int end= size;
      while (end > 0 && (('\n' == line[end-1]) || ('\r' == line[end-1]))) --end;
      if (end && ((!history[prev]) || strncmp(history[prev], line, end)))
	{
	  history[now]= strdup(line);
	  history[now][end]= '\0';
	  now= (now + 1) & arrayMask(history);
	}
    }
  return 1;
}

static int deleteToEnd(int c)
{
  int i;
  for (i= position;  i < size;  ++i) echo(' ');
  echo(' ');
  moveTo(size= position);
  return 0;
}

static int deleteLine(int c)
{
  int i;
  moveTo(0);
  for (i= 0;  i < size;  ++i) echo(' ');
  echo(' ');
  moveTo(position= size= 0);
  return 0;
}

static int deleteForward(int c)
{
  if (position < size)
    {
      int i;
      for (i= position + 1;  i < size;  ++i)
	echo(line[i-1]= line[i]);
      echo(' ');
      moveTo(position);
      --size;
    }
  return 0;
}

static int deleteBackward(int c)
{
  if (position > 0)
    {
      moveTo(--position);
      deleteForward(c);
    }
  return 0;
}

static int hangup(int c)
{
  if (size)
    return deleteForward(c);
  free(line);
  line= 0;
  position= size= capacity= 0;
  return 1;
}

static int redisplay(int c)
{
  int i;
  printf("\n\r");
  cursorPos= 0;
  for (i= 0;  i < offset;  ++i) echo(prompt[i]);
  for (i= 0;  i < size;    ++i) echo(line  [i]);
  moveTo(position);
  return 0;
}

static int remember(unsigned int when)
{
  when &= arrayMask(history);
  if (history[when])
    {
      int i, len= strlen(history[when]);
      deleteLine(0);
      for (i= 0;  i < len;  ++i)
	insert(history[when][i]);
      then= when;
    }
  return 0;
}

static int movePrior(int c)
{
  return remember(then - 1);
}

static int moveNext(int c)
{
  return remember(then + 1);
}

/* completion */

char *freedlineHistoryGenerator(char *text, int state)
{
  static int index, len;
  if (!state)
    {
      int prev;
      index= now;
      while (history[prev= (index - 1) & arrayMask(history)])
	index= prev;
      len= strlen(text);
    }
  while (index != now)
    {
      int prev= index;
      index= (index + 1) & arrayMask(history);
      if (!strncmp(text, history[prev], len))
	{
	  return strdup(history[prev]);
	}
    }
  return 0;
}

char **freedlineCompletionMatches(char *text, int start, int end, FreedlineCompletionGenerator generator)
{
  int    size= 0;
  int    capacity= 0;
  char **matches= 0;
  {
    char  *match;
    char  *word= strdup(text + start);
    word[end - start]= '\0';
    while ((match= generator(word, size)))
      {
	if (size >= (capacity - 1))
	  matches= capacity
	    ? xrealloc(matches, sizeof(char *) * (capacity *= 2))
	    : xmalloc(sizeof(char *) * (capacity= 16));
	matches[size++]= match;
      }
    free(word);
  }
  if (size)
    matches[size]= 0;
  return matches;
}

static char **defaultCompletionFunction(char *text, int start, int end)
{
  return freedlineCompletionMatches(text, start, end, freedlineHistoryGenerator);
}

FreedlineCompletionFunction freedlineCompletionFunction= defaultCompletionFunction;

static int complete(int c)
{
  if (freedlineCompletionFunction)
    {
      int start= position, end= position;
      char **matches;
      if (size == capacity) grow();
      line[size]= '\0';
      while (start && !strchr(" \t", line[start-1]))
	--start;
      matches= freedlineCompletionFunction(line, start, end);
      if (matches)
	{
	  if (matches[0])
	    {
	      char **matchp, *match, *prefix= strdup(matches[0]);
	      int i, len;
	      for (matchp= matches + 1;  prefix[0] && (match= *matchp);  ++matchp)
		{
		  for (i= 0;  prefix[i] && match[i];  ++i)
		    if (prefix[i] != match[i])
		      {
			prefix[i]= '\0';
			break;
		      }
		}
	      len= strlen(prefix);
	      if ((start < end) && len && (len > (end - start)) && (!strncmp(prefix, line + start, end - start)))
		{
		  for (i= end - start;  i < len;  ++i)
		    insert(prefix[i]);
		}
	      else if (matches[1])
		{
		  int count= height - 2;
		  int nwords, ncols= 0;
		  for (i= 0;  matches[i];  ++i)
		    {
		      int j= strlen(matches[i]);
		      if (j > ncols) ncols= j;
		    }
		  ncols += 2;
		  nwords= width / ncols;
		  if (ncols > width) ncols= width - 1;
		  if (nwords < 1) nwords= 1;
		  moveTo(size);
		  printf("\n\r");
		  for (i= 0;  matches[i];  ++i)
		    {
		      printf("%-*s", ncols, matches[i]);
		      if (nwords - 1 == i % nwords)
			{
			  printf("\n\r");
			  if (--count <= 0)
			    {
			      int c;
			      printf("--- more? ");
			      c= getchar();
			      printf("\r         \r");
			      if (('q' == c) || ('Q' == c))
				break;
			      if (('\n' != c) && ('\r' != c))
				count= height - 2;
			    }
			}
		    }
		  if (i % nwords) printf("\n\r");
		  cursorPos= 0;
		  for (i= 0;  i < offset;  ++i) echo(prompt[i]);
		  for (i= 0;  i < size;    ++i) echo(line  [i]);
		  moveTo(position);
		}
	      free(prefix);
	      for (i= 0;  matches[i];  ++i)
		free(matches[i]);
	    }
	  free(matches);
	}
    }
  return 0;
}

/* initialisation */

static void init(void)
{
  if (!actions[0])
    {
      int c;
      memset(history, 0, sizeof(history));
      for (c=  0;  c < arraySize(actions);  ++c)
	actions[c]= ignore;
      for (c= 32;  c < 128;  ++c)
	actions[c]= insert;
      actions['A'-'@']= moveBeginning;
      actions['B'-'@']= moveBackward;
      actions['D'-'@']= hangup;
      actions['E'-'@']= moveEnd;
      actions['F'-'@']= moveForward;
      actions['H'-'@']= deleteBackward;
      actions['I'-'@']= complete;
      actions['J'-'@']= enter;
      actions['K'-'@']= deleteToEnd;
      actions['L'-'@']= redisplay;
      actions['M'-'@']= enter;
      actions['N'-'@']= moveNext;
      actions['P'-'@']= movePrior;
      actions['U'-'@']= deleteLine;
      actions[127    ]= deleteBackward;
#    if defined(WIN32) && !defined(CYGWIN)
      setvbuf(stdout, 0, _IONBF, 0);
#    endif
    }
}

/* history */

void freedlineSaveHistory(char *fileName)
{
  FILE *file= fopen(fileName, "w");
  if (file)
    {
      int line, prev;
      init();
      if (history[now]) free(history[now]);
      history[now]= 0;
      line= (now - 1) & arrayMask(history);
      while (history[prev= (line - 1) & arrayMask(history)])
	line= prev;
      while (history[line])
	if ((1 == fwrite(history[line], strlen(history[line]), 1, file)) && ('\n' == fputc('\n', file)))
	  line= (line + 1) & arrayMask(history);
	else
	  break;
      fclose(file);
    }
}

void freedlineLoadHistory(char *fileName)
{
  FILE *file= fopen(fileName, "r");
  if (file)
    {
      char   *buf;
      size_t  len;
      init();
      while ((buf= fgetln(file, &len)) && len)
	{
	  char *line= xmalloc(len + 1);
	  memcpy(line, buf, len);
	  while (len && (('\n' == line[len-1]) || ('\r' == line[len-1]))) --len;
	  if (!len) continue;
	  line[len]= '\0';
	  if (history[now]) free(history[now]);
	  history[now++]= line;
	  now &= arrayMask(history);
	}
      fclose(file);
    }
}

/* command line editor */

char *freedline(char *promptOrNull)
{
  int c;
  enum { relax= 0, esc, escL } state= relax;
  char *what= 0;

  /* put the terminal into raw mode*/

#if defined(WIN32) && !defined(CYGWIN)

  DWORD consoleMode;
  hConsoleIn= GetStdHandle(STD_INPUT_HANDLE);
  hConsoleOut= GetStdHandle(STD_OUTPUT_HANDLE);

  if (   (hConsoleIn  == INVALID_HANDLE_VALUE)
      || (hConsoleOut == INVALID_HANDLE_VALUE))		{ what= "GetStdHandle";	   goto fail; }

  if (!GetConsoleMode(hConsoleIn, &consoleMode))	{ what= "GetConsoleMode";  goto fail; }
  if (!SetConsoleMode(hConsoleIn, 0))			{ what= "SetConsoleMode";  goto fail; }

#else

  struct termios termios, otermios;

  if (tcgetattr(0, &termios))
    {
      perr("tcgetattr");
      return fgets(line, sizeof(line), stdin);
    }

  otermios= termios;
  termios.c_iflag &= ~(IXON | ICANON | ISIG);
  termios.c_oflag &= ~(OPOST);
  termios.c_lflag &= ~(ECHO | ECHONL | ICANON | IEXTEN);
  termios.c_cflag &= ~(CSIZE | PARENB);
  termios.c_cflag |= CS8;

  if (tcsetattr(0, TCSADRAIN, &termios))		{ what= "tcsetattr";  goto fail; }

  oldWindowChanged= signal(SIGWINCH, windowChanged);

#endif

  init();

  getWindowSize(&width, &height);

  cursorPos= 0;
  offset= 0;

  prompt= promptOrNull ? promptOrNull : "";
  while (prompt[offset])
    echo(prompt[offset++]);

  /* initialise history for this line */

  if (history[now])
    {
      free(history[now]);
      history[now]= 0;
    }
  if (history[then= (now + 1) & arrayMask(history)])
    {
      free(history[then]);
      history[then]= 0;
    }
  then= now;

  /* edit the line */

  position= size= 0;

  while (EOF != (c= getchar()))
    {
      if (0 <= c && c < arraySize(actions))
	switch (state)
	  {
	  case relax:
	    if (27 == c)
	      state= esc;
	    else
	      if (actions[c](c))
		goto done;
	    break;

	  case esc:
	    if ('[' == c)
	      state= escL;
	    else
	      state= relax;
	    break;

	  case escL:
	    switch (c)
	      {
	      case 'A': movePrior(c);		break;
	      case 'B': moveNext(c);		break;
	      case 'C': moveForward(c);		break;
	      case 'D': moveBackward(c);	break;
	      }
	    state= relax;
	    break;
	  }
    }

 done:
  moveTo(size);

  /* restore the terminal */

#if defined(WIN32) && !defined(CYGWIN)

  if (!SetConsoleMode(hConsoleIn, consoleMode))		perr("SetConsoleMode");

#else

  signal(SIGWINCH, oldWindowChanged);
  if (tcsetattr(0, TCSADRAIN, &otermios))		perr("tcsetattr");

#endif

  printf("\n");
  return line;

 fail:
  perr(what);
  return fgets(line, sizeof(line), stdin);
}

#ifdef FREEDLINE_TEST

int main()
{
  char *line;
  freedlineLoadHistory("history");
  while ((line= freedline("yes? ")))
    puts(line);
  freedlineSaveHistory("history");
  puts("bye");
  return 0;
}

#endif
