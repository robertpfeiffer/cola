#include "_file.h"
#include <stdio.h>

static char _buf0[128];
static char _buf1[128];
static char _buf2[128];

static FILE _std0 = { 0, _fileREAD,			0, _buf0, 0, sizeof(_buf0) };
static FILE _std1 = { 1, _fileWRITE | _fileLINEBUF,	0, _buf1, 0, sizeof(_buf1) };
static FILE _std2 = { 2, _fileWRITE | _fileLINEBUF,	0, _buf2, 0, sizeof(_buf2) };

FILE *stdin  = &_std0;
FILE *stdout = &_std1;
FILE *stderr = &_std2;
