#include "SDL_prims.h"

#include <math.h>

#define SCREEN_WIDTH	800
#define SCREEN_HEIGHT	600
#define SCREEN_DEPTH	32

#define XSTEP		 1
#define YSTEP		20

#define COLOUR0		0xffff0000
#define COLOUR1		0xff00ff00
#define COLOUR2		0xff0000ff
#define COLOUR3		0xff00ffff
#define COLOUR4		0xffff00ff
#define COLOUR5		0xffffff00

static int x= 0;
static int y= 0;

static void step(SDL_Surface *sfc)
{
  SDL_Rect r= { 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT };
  SDL_FillRect(sfc, &r, 0);
  switch (y / YSTEP % 6)
    {
    case 0:
      {
	int ox= SCREEN_WIDTH / 2;
	int oy= SCREEN_HEIGHT / 2;
	int w= x - ox;
	int h= y - oy;
	if (w < 0) { ox += w;  w= -w; }
	if (h < 0) { oy += h;  h= -h; }
	SDL_Rect s= { ox, oy, w, h };
	SDL_DrawRect(sfc, &s, COLOUR0);
      }
      break;

    case 1:
      {
	SDL_DrawLine(sfc, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, x, y, COLOUR1);
      }
      break;

    case 2:
      {
	//SDL_Rect r= { 90, 90, 20, 20 };
	//SDL_DrawRect(sfc, &r, -1);
	//SDL_DrawCircle(sfc, 100, 100, 50, -1);
	SDL_DrawCircle(sfc, x, y, x / 2, COLOUR2);
      }
      break;

    case 3:
      {
	SDL_FillCircle(sfc, x, y, x / 2, COLOUR3);
      }
      break;

    case 4:
      {
	static double angle= 0.0;
	SDL_Point poly[10];
	int i;
	double a= angle, da= 2 * M_PI / 10;
	double od= SCREEN_HEIGHT / 2.1;
	double id= -od / 2;
	double ox= (double)x, oy= (double)y;
	for (i= 0;  i < 10;  i += 2)
	  {
	    poly[i  ].x= ox + od * sin(a);  poly[i  ].y= oy + od * cos(a);  a += da;
	    poly[i+1].x= ox + id * sin(a);  poly[i+1].y= oy + id * cos(a);  a += da;
	  }
	angle += 0.002;
	SDL_FillPolygon(sfc, poly, sizeof(poly)/sizeof(poly[0]), COLOUR4);
      }
      break;

    case 5:
      {
	SDL_FillLine(sfc, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, x, y, 25, COLOUR5);
      }
      break;
    }

  if ((x += XSTEP) >= SCREEN_WIDTH)
    {
      x= 0;
      if ((y += YSTEP) >= SCREEN_HEIGHT)
	y= 0;
    }
}


#undef main

int main(int argc, char *argv[])
{
  int i;
  SDL_Surface *screen;
  SDL_Init(SDL_INIT_VIDEO);
  screen= SDL_SetVideoMode(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_DEPTH, SDL_HWSURFACE | SDL_DOUBLEBUF);
  SDL_EnableUNICODE(1);
  SDL_EnableKeyRepeat(200, 10);
  SDL_Rect clip= { 10, 10, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 20 };
  SDL_SetClipRect(screen, &clip);
  for (i= 0;  1 || i < 5000;  ++i)
    {
      SDL_Event event;
      while (SDL_PollEvent(&event))
	{
	  switch (event.type)
	    {
	    case SDL_KEYDOWN:
	      if      (event.key.keysym.unicode == '=') x += 1;
	      else if (event.key.keysym.unicode == '-') x -= 1;
	      else if (event.key.keysym.unicode == 'q') goto quit;
	      break;

	    case SDL_QUIT:
	    quit:
	      SDL_Quit();
	      exit(0);
	    }
	}
      step(screen);
      SDL_Flip(screen);
    }
  return 0;
}
