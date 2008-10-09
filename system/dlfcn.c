#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct dlent
{
  char *name;
  void *addr;
};

extern struct dlent dlsym_tab[];	// -S option to idc

typedef struct dll *dlhandle_t;

typedef struct dli
{
  char		*dli_fname;
  void		*dli_fbase;
  const char	*dli_sname;
  void		*dli_saddr;
  struct dli	*next;
} Dl_info;

struct dll
{
  char		*name;
  dlhandle_t	 handle;
  struct dll	*next;
  struct dli	*infos;
};

static struct dll *dlls= 0;

static const char *dlreason= 0;

static int dlinitialised= 0;

static void dlinit(void);

void *dlopen(const char *path, int mode)
{
  if (!dlinitialised) dlinit();
  if (path)
    {
      dlreason= "no such file or directory";
      return 0;
    }
  return dlls;
}

static void dlinit(void)
{
  dlls= (struct dll *)calloc(1, sizeof(struct dll));
  dlinitialised= 1;
}

static struct dli *dlfind(dlhandle_t dll, const char *symbol)
{
  struct dli *info;
  for (info= dll->infos;  info;  info= info->next)
    if (!strcmp(symbol, info->dli_sname))
      return info;
  return 0;
}

void *dlsym(void *handle, const char *symbol)
{
  if (!dlinitialised) dlinit();
  if (handle) return dlfind(handle, symbol);
  for (handle= dlls;  handle;  handle= ((dlhandle_t)handle)->next)
    {
      struct dli *dli= dlfind(handle, symbol);
      if (dli)
	return dli->dli_saddr;
    }
  {
    struct dlent *ent;
    for (ent=  dlsym_tab;  ent->name;  ++ent)
      if (!strcmp(symbol, ent->name))
	{
	  struct dli *dli= (struct dli *)calloc(1, sizeof(struct dli));
	  dli->dli_sname= ent->name;
	  dli->dli_saddr= ent->addr;
	  return ent->addr;
	}
  }
  return 0;
}

int dlclose(void *handle)
{
  if (!dlinitialised) dlinit();
  if (handle != dlls)
    {
      dlreason= "invalid handle";
      return -1;
    }
  return 0;
}

const char *dlerror(void)
{
  return dlreason;
}
