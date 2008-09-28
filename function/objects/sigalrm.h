#if !defined(WIN32)
# include <signal.h>
#endif

static oop sigalrmReceiver= 0;
static oop sigalrmSelector= 0;
static int statisticalSampler= 0;

static void *(*enter)(struct __methodinfo *info);
static void  (*leave)(void *cookie);

static void  enableStatisticalProfile(void);
static void  disableStatisticalProfile(void);
static void *statisticalProfileEnter(struct __methodinfo *info);
static void  statisticalProfileLeave(void *cookie);

static void *statisticalProfileEnter(struct __methodinfo *info)
{
  if (statisticalSampler)
    {
      statisticalSampler= 0;
      _sendv(sigalrmSelector, 1, sigalrmReceiver);
    }
  return enter(info);
  (void)statisticalProfileEnter;
}

static void  statisticalProfileLeave(void *cookie)
{
  leave(cookie);
  (void)statisticalProfileLeave;
}

static void enableStatisticalProfile(void)
{
  if (enter != statisticalProfileEnter)
    {
      enter= _libid->enter;  _libid->enter= statisticalProfileEnter;
      leave= _libid->leave;  _libid->leave= statisticalProfileLeave;
    }
  (void)enableStatisticalProfile;
}

static void disableStatisticalProfile(void)
{
  if (enter == statisticalProfileEnter)
    {
      _libid->enter= enter;  enter= 0;
      _libid->leave= leave;  leave= 0;
    }
  (void)disableStatisticalProfile;
}

static void sigalrm(int sig)
{
  ++statisticalSampler;
}
