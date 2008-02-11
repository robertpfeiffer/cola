static oop sigalrmReceiver= 0;
static oop sigalrmSelector= 0;

static void sigalrm(int sig)
{
  _sendv(sigalrmSelector, 1, sigalrmReceiver);
}
