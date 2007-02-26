struct __lookup { struct __closure *closure;  oop fragment; };
extern struct __lookup _libid_bind2(oop selector, oop receiver);

#undef _send
#define _send(MSG, RCV, ARG...) ({				\
  oop _r= (RCV);						\
  struct __lookup _l= _libid_bind2((MSG), _r);			\
  (_l.closure->method)((oop)_l.closure, _l.fragment, _r, ##ARG);	\
})
