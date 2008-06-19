#include <signal.h>
#include <readline/readline.h>

static void enterDebugger(void);

typedef struct breakpoint
{
  struct __methodinfo	*info;
  int			 number;
  struct breakpoint	*next;
} breakpoint;

typedef struct
{
  int  (*impl)(int, char *[]);
  char  *name, *args, *help;
} command;

static command commands[];

static int helpCommand(int argc, char *argv[])
{
  command *c;
  for (c= commands;  c->help;  ++c)
    if (argc < 2 || !strncasecmp(argv[1], c->name, strlen(argv[1])))
      {
	int n= printf("%s %s", c->name, c->args);
	if (n > 20)
	  {
	    n= 0;
	    printf("\n");
	  }
	printf("%*c", 22 - n, ' ');
	printf("- %s\n", c->help);
      }
  return 0;
}

static int yesCommand(int argc, char *argv[])
{
  printf("Good -- that'll be fun!  The 'debug?' prompt that you see above (and below) is\n");
  printf("me asking you what you'd like to do next.  If you are not sure what you'd like\n");
  printf("to do then type 'help' (without the quotes) and maybe I can suggest a few things.\n");
  return 0;
}

static int quitCommand(int argc, char *argv[])
{
  exit(0);
  return 0;
}

static int stackCommand(int argc, char *argv[])
{
  struct __methodinfo *info;
  int i;
  for (i= 0;  (info= _libid->methodAt(i));  ++i)
    printf("%4d %s.%s (%s:%d)\n", i, info->type, info->name, info->file, _libid->lineAt(i));
  return 0;
}

static breakpoint *breakpoints= 0;
static int breakpointNumber= 0;

static void *(*libidEnter)(struct __methodinfo *info);
static void  (*libidLine)(int line);
static void  (*libidLeave)(void *cookie);

static enum { OFF= 0, SEND, LINE } breakMode= OFF;

static void *debugEnter(struct __methodinfo *info)
{
  void *cookie= libidEnter(info);
  if (info->meta || breakMode)
    {
      printf("break %s.%s (%s:%d)\n", info->type, info->name, info->file, (int)info->sourceStart);
      enterDebugger();
    }
  return cookie;
}

static void debugLine(int line)
{
  if (LINE == breakMode)
    {
      struct __methodinfo *info= (struct __methodinfo *)_libid->methodAt(0);
      libidLine(line);
      printf("break %s.%s (%s:%d)\n", info->type, info->name, info->file, line);
      enterDebugger();
    }
}

static int printBreakMode(void)
{
  switch (breakMode)
    {
    case OFF:	printf("not single-stepping\n");			break;
    case SEND:	printf("single-stepping to next send/return\n");	break;
    case LINE:	printf("single-stepping to next source line\n");	break;
    }
  return 0;
}

static void printBreakpoint(breakpoint *bp)
{
  if (bp)
    {
      struct __methodinfo *info= bp->info;
      printBreakpoint(bp->next);
      printf("%4d %s.%s (%s:%d)\n", bp->number, info->type, info->name, info->file, (int)info->sourceStart);
    }
}

static int printBreakpoints(void)
{
  if (breakpoints)
    {
      printf("active breakpoints:\n");
      printBreakpoint(breakpoints);
    }
  else
    printf("no breakpoints set\n");
  return 0;
}

static struct __methodinfo *findBreakpointInfo(char *typeOrFile, char *nameOrLine)
{
  struct __methodinfo *info= _libid->infoList();
  char *end;
  int   line= strtol(nameOrLine, &end, 10);
  if (*end)
    {
      while (info)
	if ((!strcmp(info->type, typeOrFile)) && (!strcmp(info->name, nameOrLine)))
	  break;
	else
	  info= info->next;
      if (!info)
	{
	  printf("cannot find breakpoint for method %s.%s\n", typeOrFile, nameOrLine);
	  return 0;
	}
    }
  else
    {
      int flen= strlen(typeOrFile);
      while (info)
	if ((info->sourceStart == line) && !strncmp(info->file, typeOrFile, flen))
	  break;
	else
	  info= info->next;
      if (!info)
	{
	  printf("cannot find breakpoint for line %s:%d\n", typeOrFile, line);
	  return 0;
	}
    }
  return info;
}

static void clearBreakpoint(breakpoint *bp)
{
  breakpoint **bpp= &breakpoints;
  while (*bpp)
    if (bp != *bpp)
      bpp= &((*bpp)->next);
    else
      {
	breakpoint *next= (*bpp)->next;
	bp->info->meta= 0;
	free(*bpp);
	*bpp= next;
	break;
      }
}

static void enableStepping(void)
{
  _libid->enter= debugEnter;
  _libid->line= debugLine;
}

static void disableStepping(void)
{
  if (breakpoints || breakMode) return;
  _libid->enter= libidEnter;
  _libid->line= libidLine;
}

static int breakCommand(int argc, char *argv[])
{
  switch (argc)
    {
    case 1:
      printBreakMode();
      printBreakpoints();
      break;

    case 2:
      {
	int n= strlen(argv[1]);
	if (!strncasecmp(argv[1], "off", n))
	  {
	    breakMode= OFF;
	    disableStepping();
	    return printBreakMode();
	  }
	if (!strncasecmp(argv[1], "send", n))
	  {
	    enableStepping();
	    breakMode= SEND;
	    return printBreakMode();
	  }
	if (!strncasecmp(argv[1], "line", n))
	  {
	    enableStepping();
	    breakMode= LINE;
	    return printBreakMode();
	  }
	if (!strncasecmp(argv[1], "clear", n))
	  {
	    while (breakpoints)
	      clearBreakpoint(breakpoints);
	    disableStepping();
	    printf("all breakpoints cleared\n");
	    return 0;
	  }
	printf("%s?\n", argv[1]);
      }
      break;

    case 3:
      {
	if (!strncasecmp(argv[1], "clear", strlen(argv[1])))
	  {
	    char *end;
	    int num= strtol(argv[2], &end, 10);
	    if (num && !*end)
	      {
		breakpoint *bp;
		for (bp= breakpoints;  bp;  bp= bp->next)
		  if (num == bp->number)
		    {
		      clearBreakpoint(bp);
		      disableStepping();
		      return printBreakpoints();
		    }
	      }
	    else
	      printf("%s?\n", argv[2]);
	  }
	else
	  {
	    struct __methodinfo *info= findBreakpointInfo(argv[1], argv[2]);
	    if (info)
	      {
		if (info->meta)
		  {
		    printf("breakpoint already set?\n");
		    printBreakpoints();
		    return 0;
		  }
		info->meta= calloc(1, sizeof(breakpoint));
		((breakpoint *)info->meta)->info= info;
		((breakpoint *)info->meta)->number= ++breakpointNumber;
		((breakpoint *)info->meta)->next= breakpoints;
		breakpoints= info->meta;
		enableStepping();
		printBreakpoints();
	      }
	  }
      }
      break;
    }
  return 0;
}

static int contCommand(int argc, char *argv[])
{
  printf("continuing...\n");
  return -1;
}

static int noCommand(int argc, char *argv[])
{
  printf("Suit yourself.\n");
  return -1;
}

static command commands[]= {
  { breakCommand,  "break",    "[ off | line | send | [ clear ] <type> <name> | [ clear ] <file> <line> ]",  "control single-step and breakpoints; without args, show current status" },
  { contCommand,   "continue", "",		   "return from the debugger and continue (or single-step) the program" },
  { helpCommand,   "help",     "[ <command> ]",	   "print help; if <command> is given, print help for it only" },
  { quitCommand,   "quit",     "",		   "quit the entire program" },
  { stackCommand,  "where",    "",		   "print the execution stack" },
  { yesCommand,    "yes",      "",		   0 },
  { noCommand,     "no",       "",		   0 },
  { 0, 0, 0 }
};

static int first= 1;

static command *cmd= 0;

static void enterDebugger(void)
{
  for (;;)
    {
      char *line= readline("debug? ");
      if (!line)
	printf("\n");
      else if (*line)
	{
	  int   argc;
	  char *argv[32];
	  for (argc= 0;  (argv[argc]= strsep(&line, " \t"));)
	    if (*argv[argc])
	      if (++argc >= (sizeof(argv) / sizeof(argv[0]) - 1))
		break;
	  if (argc)
	    {
	      command *c= 0;
	      int n= strlen(argv[0]);
	      cmd= 0;
	      argv[argc]= 0;
	      for (c= commands;  c->impl;  ++c)
		if (!strncasecmp(argv[0], c->name, n))
		  {
		    if (cmd)
		      {
			printf("ambiguous\n");
			goto next;
		      }
		    cmd= c;
		  }
	      if ((!cmd) || ((!first) && (!cmd->help)))
		{
		  printf("%s?\n", argv[0]);
		  goto next;
		}
	      n= cmd->impl(argc, argv);
	      if (n < 0) return;
	    }
	}
      else if (cmd)	/* empty line */
	{
	  int n= cmd->impl(0, 0);
	  if (n < 0) return;
	}
    next:
      first= 0;
    }
  exit(1);
}

static void signalDebugger(int n)
{
  char *who= "UNKNOWN";
  switch (n)
    {
    case SIGHUP:	who= "hangup";				break;
    case SIGINT:	who= "interrupt";			break;
    case SIGQUIT:	who= "quit";				break;
    case SIGILL:	who= "illegal instruction";		break;
    case SIGTRAP:	who= "trace trap";			break;
    case SIGABRT:	who= "abort";				break;
  /*case SIGEMT:	who= "emulate instruction";		break;*/
    case SIGFPE:	who= "floating-point exception";	break;
    case SIGKILL:	who= "kill";				break;
    case SIGBUS:	who= "bus error";			break;
    case SIGSEGV:	who= "segmentation fault";		break;
    case SIGSYS:	who= "non-existent system call";	break;
    case SIGPIPE:	who= "pipe closed";			break;
    case SIGALRM:	who= "alarm";				break;
    case SIGTERM:	who= "termination";			break;
    case SIGURG:	who= "urgent condition";		break;
    case SIGSTOP:	who= "stop";				break;
    case SIGTSTP:	who= "keyboard stop";			break;
    case SIGCONT:	who= "continue";			break;
    case SIGCHLD:	who= "child status changed";		break;
    case SIGTTIN:	who= "terminal input";			break;
    case SIGTTOU:	who= "terminal output";			break;
    case SIGIO:		who= "I/O possible";			break;
    case SIGXCPU:	who= "cpu time limit exceeded";		break;
    case SIGXFSZ:	who= "file size limit exceeded";	break;
    case SIGVTALRM:	who= "virtual alarm";			break;
    case SIGPROF:	who= "profile";				break;
    case SIGWINCH:	who= "window size change";		break;
  /*case SIGINFO:	who= "status request";			break;*/
    case SIGUSR1:	who= "user-defined 1";			break;
    case SIGUSR2:	who= "user-defined 2";			break;
    }
  printf("\n\nsignal: %s\n", who);
  enterDebugger();
}

static char *commandGenerator(const char *text, int state)
{
  static command *cmd= 0;
  static int len;
  if (!state)
    {
      cmd= commands;
      len= strlen(text);
    }
  while (cmd->help)
    if (!strncasecmp(text, cmd->name, len))
      return strdup(cmd++->name);
    else
      ++cmd;
  return 0;
}

static const char **args;
static int argCap= 0;
static int argSize= 0;

static void addArgument(const char *arg)
{
  int i;
  if (argSize == argCap)
    {
      if (argCap)
	args= realloc(args, sizeof(char *) * (argCap *= 2));
      else
	args= malloc(sizeof(char *) * (argCap= 1024));
    }
  for (i= 0;  i < argSize;  ++i)
    {
      int n;
      if (arg == args[i]) return;
      n= strcmp(arg, args[i]);
      if (!n) return;
      if (n < 0)
	{
	  memmove(args + i + 1, args + i, sizeof(char *) * (argSize - i));
	  ++argSize;
	  args[i]= arg;
	  return;
	}
    }
  args[argSize++]= arg;
}

static char *argumentGenerator(const char *text, int state)
{
  static int init= 1;
  static int index= 0;
  static int len= 0;
  int n;
  if (init)
    {
      struct __methodinfo *info;
      for (info= _libid->infoList();  info;  info= info->next)
	if ('[' != info->name[0])
	  {
	    addArgument(info->type);
	    addArgument(info->name);
	    addArgument(info->file);
	  }
      init= 0;
    }
  if (!state)
    {
      index= 0;
      len= strlen(text);
    }
  while ((index < argSize) && ((n= strncmp(text, args[index], len)) >= 0))
    if (n == 0)
      return strdup(args[index++]);
    else
      ++index;
  return 0;
}

static char **debugCompletion(const char *text, int start, int end)
{
  return rl_completion_matches(text, start ? argumentGenerator : commandGenerator);
}

static void initDebugger(void)
{
  libidEnter= _libid->enter;
  libidLine=  _libid->line;
  libidLeave= _libid->leave;
  signal(SIGINT, signalDebugger);
  rl_readline_name= "Pepsi";
  rl_attempted_completion_function= debugCompletion;
}
