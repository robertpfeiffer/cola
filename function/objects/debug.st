{ import: _object }
{ include "_debug.c" }

_object _debug
{
  enterDebugger();
  fprintf(stderr, "cannot continue\n");
  exit(0);
}

{
  initDebugger();
}
