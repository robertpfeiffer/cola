#ifndef _SYS_TIME_H_
#define _SYS_TIME_H_

typedef long time_t;
typedef int  suseconds_t;

struct timeval
{
  time_t	 tv_sec;
  suseconds_t	 tv_usec;
};

int gettimeofday(struct timeval *tp, void *tzp);

struct itimerval
{
  struct  timeval it_interval;
  struct  timeval it_value;
};

#define ITIMER_REAL	0

int setitimer(int which, const struct itimerval *value, struct itimerval *ovalue);

#endif /* _SYS_TIME_H_ */
