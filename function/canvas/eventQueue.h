struct Event
{
  oop	name;
  int	detail[4];
  struct Event *next;
};

static struct Event *events= 0;

static void enqueue(oop name, int a, int b, int c, int d)
{
  struct Event *msg= malloc(sizeof(struct Event));
  msg->name= name;
  msg->detail[0]= a;
  msg->detail[1]= b;
  msg->detail[2]= c;
  msg->detail[3]= d;
  msg->next= events;
  events= msg;
}

