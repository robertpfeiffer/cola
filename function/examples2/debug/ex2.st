{ import: Object }
{ import: debug }

Object sleep
{
#ifdef WIN32
  Sleep(100);
#else
  usleep(100000);
#endif
}

[
    [Object sleep] whileTrue: ['boo!' putln]
]
