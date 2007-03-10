#include <stdio.h>

int nfibs(int n)
{
  if (n < 2) return 1; else return nfibs(n - 1) + nfibs(n - 2) + 1;
}

int main()
{
  printf("%d\n", nfibs(38));
  return 0;
}
