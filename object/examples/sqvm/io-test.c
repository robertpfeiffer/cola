#include "io-common.c"

#include <unistd.h>
#include <math.h>

#define W	256
#define H	256
#define D	 32
#define WW	(W*2)
#define HH	(H*2)

uint32_t bits[H][W];
uint32_t background[H][W];

#define PI	3.1415926535897932384626433832795

double hyp(double a, double b)	{ return sqrt(a*a + b*b); }

int main()
{
  unsigned x, y, s, n;

  ioInitialise();

  unsigned char plasma1[HH][WW];
  unsigned char plasma2[HH][WW];
  unsigned char sinTable[256];
  unsigned char cosTable[256];
  uint32_t	palette[256];

  {
    int i, j;

    for (i= 0;  i < 256;  ++i)
      {
	sinTable[i]= (unsigned)(128 + 127 * sin(i * 2 * PI / 255));
	cosTable[i]= (unsigned)(128 + 127 * cos(i * 2 * PI / 255));
      }

    for (i= 0;  i < 256;  ++i)
      {
	unsigned r= sinTable[cosTable[(i+32) % 256]];
	unsigned g= sinTable[cosTable[(i+11) % 256]];
	unsigned b= cosTable[sinTable[(i+55) % 256]];
	palette[i]= ((r << 16) | (g << 8) | b);
      }

    for (j= 0;  j < HH;  ++j)
      for (i= 0;  i < WW;  ++i)
	{
	  plasma1[j][i]= (unsigned)sinTable[(unsigned)hyp((HH/2) - j, (WW/2) - i) % 256] >> 2;
	  plasma2[j][i]= (unsigned)sinTable[(cosTable[(i + 76) % 256] + sinTable[(j + 42) % 256]) >> 1 ] >> 2;
	}
  }

  for (y= 0;  y < H;  ++y)
    for (x= 0;  x < W;  ++x)
      background[y][x]= bits[y][x]= 0;

  ioShowDisplayBits((uint32_t *)bits, W, H, D, 0, 0, W, H);

  for (y= H * 1/8;  y < H * 5/8;  ++y)
    for (x= W * 1/8;  x < W * 5/8;  ++x)
      background[y][x] ^= 0x808080;

  for (y= H * 3/8;  y < H * 7/8;  ++y)
    for (x= W * 3/8;  x < W * 7/8;  ++x)
      background[y][x] ^= 0x404040;

  n= 0;
  s= ioMilliSecs();
  for (;;)
    {
      unsigned t= ioMilliSecs();
      int x1 = (int)((120) + (120 - 1) * sin(t / 452.0));
      int x2 = (int)((120) + (120 - 1) * cos(t / 744.0));
      int x3 = (int)((120) + (120 - 1) * cos(t / 421.0));
      int y1 = (int)((120) + (120 - 1) * cos(t / 381.0));
      int y2 = (int)((120) + (120 - 1) * sin(t / 827.0));
      int y3 = (int)((120) + (120 - 1) * sin(t / 634.0));

      for (y= 0;  y < H;  ++y)
	{
	  for (x= 0;  x < W;  ++x)
	    {
	      unsigned char colour= plasma1[y+y1][x1+x];
	      colour += plasma2[y+y2][x2+x];
	      colour += plasma2[y+y3][x3+x];
	      colour += (background[y][x] >> 2);
	      bits[y][x] = palette[colour];
	    }
	}

      ioShowDisplayBits((uint32_t *)bits, W, H, D, 0, 0, W, H);

      if (27 == ioGetKeystroke(1)) break;

      ++n;
      if (t - s >= 2000)
	{
	  s= t;
	  printf("%d fps\n", n * 2);
	  n= 0;
	}
    }

  ioCloseDisplay();

  return 0;
}
