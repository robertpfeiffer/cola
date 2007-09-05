#ifndef __dlsym_h
#define __dlsym_h

#if defined(WIN32)
# define RTLD_DEFAULT	0
# define RTLD_LAZY	0
# define RTLD_NOW	0
# define RTLD_GLOBAL	0
#else
# include <dlfcn.h>
#endif

#endif /* __dlsym_h */
