#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <assert.h>

union  object_t;	typedef union  object_t *oop;

struct symbol_t;	typedef struct symbol_t  symbol_t;
struct cons_t;		typedef struct cons_t    cons_t;
struct closure_t;	typedef struct closure_t closure_t;

typedef oop(*imp_t)();

//----------------------------------------------------------------

static oop symbol_vt= 0;

struct symbol_t
{
  oop	_field[0];
  char	*name;
};

static oop cons_vt= 0;

struct cons_t
{
  oop	_field[0];
  oop	head;
  oop	tail;
};

static oop closure_vt= 0;

struct closure_t
{
  oop	_field[0];
  imp_t	function;
  oop	data;
};

union object_t
{
  oop		_field[0];
  cons_t	cons;
  closure_t	closure;
  symbol_t	symbol;
};

typedef struct send_t
{
  oop	selector;
  long	nargs;
  oop	closure;
} send_t;

//----------------------------------------------------------------

static oop vt_alloc(send_t *send, oop self, size_t lbs)
{
  oop object= (oop)(calloc(1, sizeof(oop) + lbs) + sizeof(oop));
  object->_field[-1]= self;
  return object;
}

#define new(T)	vt_alloc(0, T##_vt, sizeof(T##_t))

static oop cons(send_t *send, oop self, oop head, oop tail)
{
  self= new(cons);
  self->cons.head= head;
  self->cons.tail= tail;
  return self;
}

static void dump(oop obj)
{
  if (!obj)
    {
      printf("NIL");
    }
  else if ((long)obj & 1)
    {
      printf("%ld", (long)obj >> 1);
    }
  else
    {
      oop vt= obj->_field[-1];
      if (vt == cons_vt)
	{
	  printf("(");
	  while (obj && (obj->_field[-1] == cons_vt))
	    {
	      dump(obj->cons.head);
	      obj= obj->cons.tail;
	      if (obj) printf(" ");
	    }
	  if (obj)
	    {
	      printf(". ");
	      dump(obj);
	    }
	  printf(")");
	}
      else if (vt == symbol_vt)
	{
	  printf("#%s", obj->symbol.name);
	}
      else if (vt == closure_vt)
	{
	  printf("{%p %p}", obj->closure.function, obj->closure.data);
	}
      else
	printf("?");
    }
}

static void dumpln(oop obj)
{
  dump(obj);
  printf("\n");
}

static oop assoc(oop list, oop key)
{
  while (list)
    {
      dumpln(list);
      if (list->cons.head->cons.head == key)
	return list->cons.head;
      else
	list= list->cons.tail;
    }
  return 0;
}

static oop append(oop pair, oop value)
{
  assert(pair);
  return pair->cons.tail= cons(0, 0, value, pair->cons.tail);
}

static oop get(oop list, oop key)
{
  oop pair= assoc(list, key);
  return pair ? pair->cons.tail : 0;
}

static oop put(oop *list, oop key, oop value)
{
  oop pair= assoc(*list, key);
  if (pair)
    pair->cons.tail= value;
  else
    pair= *list= cons(0, 0, cons(0, 0, key, value), *list);
  return pair;
}

//----------------------------------------------------------------

static oop symbols= 0;

oop symbol(send_t *send, oop self, char *name)
{
  oop obj;
  for (obj= symbols;  obj;  obj= obj->cons.tail)
    if (!strcmp(name, obj->cons.head->symbol.name))
      return obj->cons.head;
  obj= new(symbol);
  obj->symbol.name= strdup(name);
  symbols= cons(0, 0, obj, symbols);
  return obj;
}

//----------------------------------------------------------------

static oop closure(send_t *send, imp_t function, oop data)
{
  oop obj= new(closure);
  obj->closure.function= function;
  obj->closure.data= data;
  return obj;
}

//----------------------------------------------------------------

static oop dnu(send_t *send, oop self, ...)
{
  oop args, *argp= &args;
  va_list ap;
  size_t n;
  va_start(ap, self);
  for (n= send->nargs;  n-- > 1;)
    {
      *argp= cons(0, 0, va_arg(ap, oop), 0);
      argp= &(*argp)->cons.tail;
    }
  va_end(ap);
  fprintf(stderr, "%p does not understand '%s' + %ld\n", self, send->selector->symbol.name, send->nargs);
  dumpln(self);
  dumpln(args);
  exit(1);
}

static oop nil_vt= 0;
static oop tag_vt= 0;

static imp_t _bind(send_t *send, oop receiver)
{
  oop t= receiver ? (((long)receiver & 1) ? tag_vt : receiver->_field[-1]) : nil_vt;
  oop c= get(t, send->selector);
  return (send->closure= c) ? c->closure.function : (imp_t)dnu;
}

#define _send(selector, nargs, receiver, args...)	\
  ({							\
    oop _r= receiver;					\
    send_t send= { selector, nargs };			\
    _bind(&send, _r)(&send, _r, ##args);		\
  })

//----------------------------------------------------------------

oop symbol_println(send_t *send, oop self)
{
  printf("#%s\n", self->symbol.name);
  return self;
}

int main()
{
  cons_vt   = cons(0, 0, 0, 0);  cons_vt->_field[-1]= cons_vt;
  symbol_vt = cons(0, 0, 0, 0);
  closure_vt= cons(0, 0, 0, 0);

  cons_vt   ->cons.head= cons(0, 0, symbol(0, 0, "typeName"), symbol(0, 0, "cons"));
  symbol_vt ->cons.head= cons(0, 0, symbol(0, 0, "typeName"), symbol(0, 0, "symbol"));
  closure_vt->cons.head= cons(0, 0, symbol(0, 0, "typeName"), symbol(0, 0, "closure"));

  append(symbol_vt, cons(0, 0, symbol(0, 0, "intern_:"), closure(0, symbol, 0)));

  printf("%p %p\n", (void *)symbol, get(symbol_vt, symbol(0, 0, "intern_:")));
  printf("%p %p\n", (void *)symbol, get(symbol_vt, symbol(0, 0, "intern_:"))->closure.function);

  {
    oop s_println= 0;
    s_println= symbol(0, 0, "println");
    append(symbol_vt, cons(0, 0, s_println, closure(0, symbol_println, 0)));
    _send(s_println, 1, s_println);
    _send(s_println, 1, _send(symbol(0, 0, "intern_:"), 2, s_println, (oop)"hello!"));
    _send(symbol(0, 0, "foo:bar:"), 3, s_println, cons_vt, symbol_vt);
  }

  return 0;
}
