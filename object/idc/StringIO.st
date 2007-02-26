" StringIO.st -- bogus input/output support 		-*- Smalltalk -*-

  Copyright (c) 2005 Ian Piumarta
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

  Last edited: 2006-02-07 20:02:27 by piumarta on cygwin.piumarta.com
"

"This file crowbars a bunch of bogus input/output methods into String."

{ import: String }
{ import: Smalltalk }

String _cString
{
  int len= (int)self->v_size >> 1;
  char *cString= (char *)_balloc(len + 1);
  memcpy(cString, self->v__bytes, len);
  cString[len]= '\0';
  return (oop)cString;
}

String directoryName
[
    "Answer the directory name component of the path name represented
    by the receiver."
    | dirName |
    (dirName := self tokenized: '/') removeLast.
    ^dirName isEmpty
	ifTrue: ['.']
	ifFalse: [(dirName delimited: '/') flattened]
]

String baseName
[
    "Answer the file name component of the path name represented by
    the receiver."
    ^(self tokenized: '/') last
]

String absolutePathName
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

String isReadableFile
[
    "Answer whether the file named by the receiver is regular and readable."
    | cPath |
    cPath := self _cString.
    {{
      char *path= (char *)v_cPath;
      struct stat sb;
      if (-1 == stat(path, &sb)) return 0;
      if (S_IFREG != (sb.st_mode & S_IFMT)) return 0;
      if (-1 == access(path, R_OK)) return 0;
    }}.
]

String findFileSearching: searchPaths withSuffixes: suffixes ifError: errorBlock
[
    "Answer an absolute path to a readable file as named by the
    receiver, prepending each directory in the searchPaths and
    appending each of the given suffxes.  If no file is found, answer
    the value of errorBlock."
    | dirs path |
    dirs := self first == $/ ifTrue: [#('')] ifFalse: [searchPaths].
    dirs do: [:dir |
	suffixes do: [:suffix |
	    (path := dir, '/', self, suffix) isReadableFile
		ifTrue: [^path absolutePathName]]].
    ^errorBlock value.
]

String findFileSearching: searchPaths withSuffixes: suffixes
[
    ^self findFileSearching: searchPaths
	  withSuffixes: suffixes
	  ifError: [self error: self, ': ', Smalltalk osErrorString]
]


String readFromFileNamed: path ifError: errorBlock
[
    "Answer a new String whose contents are those of the file named by
    the given path, as a String.  If the path does not name a
    readable, regular file then answer the value of errorBlock."
    | cPath |
    self := self _clone.
    cPath := path _cString.
    {{
      char *path= (char *)v_cPath;
      int fd= open(path, O_RDONLY | O_BINARY);
      if (fd >= 0)
        {
	  int position= 0;
	  int remaining= 0;
          struct stat sb;
          fstat(fd, &sb);
          remaining= sb.st_size;
	  self->v__bytes= _balloc(remaining);
          while (remaining)
            {
	      int count= read(fd, (char *)self->v__bytes + position, remaining);
              if (count < 1)
                break;
              position += count;
              remaining -= count;
	    }
          close(fd);
          if (!remaining)
            {
              self->v_size= (oop)(((long)position << 1) | 1);
              return v_self;
            }
        }
    }}.
    ^errorBlock value
]

String readFromFileNamed: path
[
    ^self readFromFileNamed: path ifError: [self error: path, ': ', Smalltalk osErrorString]
]

String fileContents
[
    "Answer the contents of the file named by the receiver."
    ^self readFromFileNamed: self
]

String writeToFileNamed: path ifError: errorBlock
[
    "Write the contents of the receiver into the file named by path.
    If the file cannot be writter, answer the value of errorBlock."
    | cPath |
    cPath := path _cString.
    {{
      char *path= (char *)v_cPath;
      int fd= open(path, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0666);
      if (fd >= 0)
        {
	  int position= 0;
	  int remaining= (int)self->v_size >> 1;
          while (remaining)
            {
	      int count= write(fd, (char *)self->v__bytes + position, remaining);
              if (count < 1)
                break;
              position += count;
              remaining -= count;
	    }
          close(fd);
          if (!remaining)
            return v_self;
        }
    }}.
    ^errorBlock value
]

String writeToFileNamed: path
[
    ^self writeToFileNamed: path ifError: [self error: path, ': ', Smalltalk osErrorString]
]

"This doesn't really belong here, but what the hey..."

String strftimeNow
[
    | _format _buf |
    _format := self _cString.
    {
      char buf[32];
      time_t clock= time(0);
      strftime(buf, sizeof(buf), (const char *)v__format, localtime(&clock));
      v__buf= (oop)buf;
    }.
    ^String value_: _buf.
]

String strftimeZulu
[
    | _format _buf |
    _format := self _cString.
    {
      char buf[32];
      time_t clock= time(0);
      strftime(buf, sizeof(buf), (const char *)v__format, gmtime(&clock));
      v__buf= (oop)buf;
    }.
    ^String value_: _buf.
]

String dateStamp		[ ^'%Y-%m-%d' strftimeNow ]
String timeStamp		[ ^'%H:%M:%S' strftimeNow ]
String dateAndTimeStamp		[ ^'%Y-%m-%d %H:%M:%S' strftimeNow ]
String dateAndTimeZoneStamp	[ ^'%Y-%m-%d %H:%M:%S %Z' strftimeNow ]
String dateAndTimeZuluStamp	[ ^'%Y-%m-%d %H:%M:%S Z' strftimeZulu ]
