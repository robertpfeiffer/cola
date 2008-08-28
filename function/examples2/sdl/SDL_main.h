#include "SDL/SDL.h"

int __id__SDL_main(int argc, char *argv[], char **envp);

int main(int argc, char *argv[])
{
  return __id__SDL_main(argc, argv, 0);
}

#undef main
#define main __id__SDL_main
