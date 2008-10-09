#ifndef _DLFCN_H
#define _DLFCN_H

#define RTLD_DEFAULT	0
#define RTLD_LAZY	0
#define RTLD_GLOBAL	0
#define RTLD_NOW	0

void	   *dlopen(const char* path, int mode);
void	   *dlsym(void* handle, const char* symbol);
int	    dlclose(void* handle);
const char *dlerror(void);

#endif /* _DLFCN_H */
