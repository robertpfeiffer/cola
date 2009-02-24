#include <id/id.h>

#define _sendv(MSG, N, RCV, ARG...) ({					\
  struct __send _s= { (MSG), (N), (RCV) };				\
  ((_imp_t)(_libid->bindv(&_s)))(&_s, _s.receiver, _s.receiver, ##ARG);	\
})

extern struct __libid *_libid_init(int *, char ***, void *);

int main(int argc, char **argv)
{
  char **envp= { 0 };
  struct __libid *_libid= _libid_init(&argc, &argv, &envp);
  extern void __id__init__Test(struct __libid *);
  void *s_test= 0;
  void *result= 0;

  printf("initialising the library\n");
  __id__init__Test(_libid);
  printf("getting the selector\n");
  s_test= _libid->intern("test");
  printf("sending the message\n");
  result= _sendv(s_test, 0, 0);
  printf("result is %p\n", result);

  return 0;
}
