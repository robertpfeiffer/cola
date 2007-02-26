{ import: Object }

{ include <sys/times.h> }

Date : Object ( _seconds _microseconds )

Date new
[
    ^super new initialize.
]

Date initialize
{
#if 1
    struct tms tms;
    times(&tms);
    self->v__seconds= (oop)(tms.tms_utime / CLOCKS_PER_SEC);
    self->v__microseconds= (oop)(tms.tms_utime % CLOCKS_PER_SEC * 1000000 / CLOCKS_PER_SEC);
#else
    struct timeval tv;
    gettimeofday(&tv, 0);
    self->v__seconds= (oop)tv.tv_sec;
    self->v__microseconds= (oop)tv.tv_usec;
#endif
}

Date seconds		[ ^SmallInteger value_: _seconds ]
Date microseconds	[ ^SmallInteger value_: _microseconds ]
Date milliseconds	[ ^self microseconds // 1000 ]
