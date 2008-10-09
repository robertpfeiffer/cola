#ifndef _TIME_H_
#define _TIME_H_

#include <sys/time.h>

struct tm
{
  int	 tm_sec;
  int	 tm_min;
  int	 tm_hour;
  int	 tm_mday;
  int	 tm_mon;
  int	 tm_year;
  int	 tm_wday;
  int	 tm_yday;
  int	 tm_isdst;
  long	 tm_gmtoff;
  char	*tm_zone;
};

struct tm *localtime(const time_t *clock);

size_t	   strftime(char *buf, size_t maxsize, const char *format, const struct tm *timeptr);

struct timespec
{
  time_t tv_sec;
  long	 tv_nsec;
};

int nanosleep(const struct timespec *rqtp, struct timespec *rmtp);

#endif /* _TIME_H_ */
