struct _file
{
  short	 fileno;
  short	 flags;
  int	 error;
  char	*buffer;
  int	 position;
  int	 size;
  int	 capacity;
};

#define _fileLINEBUF	0x0001	/* line buffered */
#define _fileUNBUF	0x0002	/* unbuffered */
#define _fileREAD	0x0004	/* OK to read */
#define _fileWRITE	0x0008	/* OK to write */
#define _fileEOF	0x0020	/* found EOF */
#define _fileMALLOC	0x0080	/* buffer is from malloc */
#define _fileDYNAMIC	0x4000	/* allocate string space dynamically */
