#include <sys/syscall.h>
#include <unistd.h>
#include <stdio.h>

int main()
{
#define sys(S)	printf("#define SYS_"#S" %d\n", SYS_##S)
  sys(exit);
  sys(read);
  sys(write);
  sys(open);
  sys(close);
  sys(unlink);
  sys(access);
  sys(brk);
  printf("extern long syscall(long, ...);\n");
  return 0;
}
