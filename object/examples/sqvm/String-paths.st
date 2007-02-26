{ import: st80 }

String _cString
{
  int len= (int)self->v_size >> 1;
  char *cString= (char *)_balloc(len + 1);
  memcpy(cString, self->v__bytes, len);
  cString[len]= '\0';
  return (oop)cString;
}

String getcwd
[
    self := self _clone.
    {
      char buf[PATH_MAX];
      getcwd(buf, sizeof(buf));
      size_t len= strlen(buf);
      self->v_size= (oop)((len << 1) | 1);
      self->v__bytes= _balloc(len);
      memcpy(self->v__bytes, buf, len);
    }.
]

{ include <libgen.h> }

String dirname		[ ^self value_: self _dirname ]
String _dirname		{ return (oop)dirname((char *)self->v__bytes); }

String basename		[ ^self value_: self _basename ]
String _basename	{ return (oop)basename((char *)self->v__bytes); }

String realpath
[
    "Answer the absolute path name to the file named by the receiver.
    The result starts with '/' and contains no '..' or '.'
    components."
    | cPath |
    cPath := self _cString.
    {{
      char *path= (char *)v_cPath;
      char buf[PATH_MAX];
#    if defined(WIN32)
      if (!_fullpath(buf, path, PATH_MAX)) return 0;
#    else
      if (!realpath(path, buf)) return 0;
#    endif
      v_cPath= (oop)buf;
    }}.
    ^String value_: cPath.
]
