#undef _send
#define _send(MSG, RCV, ARG...) ({				\
  oop _r= (RCV);						\
  struct __lookup _l= _libid->bind2((MSG), _r);			\
  (_l.closure->method)((oop)_l.closure, _l.state, _r, ##ARG);	\
})
