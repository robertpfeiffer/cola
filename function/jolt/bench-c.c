#include <stdio.h>

int nfibs(int n)
{
  return n < 2 ? 1 : nfibs(n - 1) + nfibs(n - 2) + 1;
}

int main()
{
  printf("%d\n", nfibs(38));
  return 0;
}
