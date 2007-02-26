{ import: Objects }

Time : Magnitude ( _seconds _nanoseconds )

Time seconds		[ ^SmallInteger value_: _seconds ]
Time nanoseconds	[ ^SmallInteger value_: _nanoseconds ]

Time millisecondClockValue
{
    struct timeval tv;
    gettimeofday(&tv, 0);
    return (oop)(((tv.tv_sec * 1000 + tv.tv_usec / 1000) &0x3fffffff) << 1 | 1);
}

Time now
[
    self := self new.
    {
      struct timeval tv;
      gettimeofday(&tv, 0);
      self->v__seconds=     (oop)(tv.tv_sec        );
      self->v__nanoseconds= (oop)(tv.tv_usec * 1000);
    }
]

Time hash		[ ^self seconds hash * 10333 bitXor: self nanoseconds hash ]

Time = aTime		[ ^self seconds = aTime seconds and: [self nanoseconds = aTime nanoseconds] ]
Time < aTime		[ ^self seconds < aTime seconds or: [self seconds = aTime seconds and: [self nanoseconds < aTime nanoseconds]] ]

Time _formatted_: _format
{
  time_t time= (time_t)(unsigned long)self->v__seconds;
  struct tm *tm= localtime((time_t *)&time);
  static char buf[64];
  strftime(buf, sizeof(buf), (char *)v__format, tm);
  return (oop)buf;
}

Time formatted: format
[
    ^String value_: (self _formatted_: format _stringValue)
]

Time printOn: aStream		[ self printShortOn: aStream ]
Time printLongOn: aStream	[ aStream nextPutAll: (self formatted: '%a %b %e %H:%M:%S %Z %Y') ]
Time printShortOn: aStream	[ aStream nextPutAll: (self formatted: '%Y-%m-%d %H:%M:%S') ]

SmallInteger uprint: width	{ fprintf(stdout, "%0*d", (int)v_width >> 1, (unsigned)self >> 1); }

Time print
[
    self seconds uprint: 0.
    $. put.
    self nanoseconds uprint: 9
]
