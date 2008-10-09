#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

int main()
{
  void *ptr1, *ptr2, *ptr3, *ptr4;
  char buf[1];
  int n;
  
  ptr1= malloc(1024);  printf("%p\n", ptr1);
  ptr2= malloc(1024);  printf("%p\n", ptr2);
  ptr3= malloc(1024);  printf("%p\n", ptr3);
  ptr4= malloc(1024);  printf("%p\n", ptr4);
  free(ptr1);
  ptr1= malloc(1024);  printf("%p\n", ptr1);
  free(ptr1);
  ptr1= malloc(1024);  printf("%p\n", ptr1);
  free(ptr1);
  ptr1= malloc(1024);  printf("%p\n", ptr1);

  printf("%ld %ld %ld\n", strtol("0x2a", 0, 0), strtol("   666   ", 0, 0), strtol("42abc", 0, 10));

  while ((n= read(0, buf, 1)) == 1)
    write(1, buf, 1);

  return 0;
}
