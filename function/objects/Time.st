" Time.st -- time of day

  Copyright (c) 2006, 2007 Ian Piumarta
  All rights reserved.

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the 'Software'),
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, provided that the above copyright notice(s) and this
  permission notice appear in all copies of the Software and that both the
  above copyright notice(s) and this permission notice appear in supporting
  documentation.

  THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.

  Last edited: 2007-02-28 14:23:50 by piumarta on emilia
"

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
