#include "libjolt.h"

typedef unsigned int pixel_t;
typedef pixel_t (*pixop_t   )(pixel_t, pixel_t);
typedef pixop_t (*compiler_t)(const char *);

#define PIXEL(A,R,G,B)				\
  (   ((unsigned int)(A)  << 24)		\
   | (((unsigned int)(R)) << 16)		\
   | (((unsigned int)(G)) <<  8)		\
   | (((unsigned int)(B)) <<  0))

int main(int argc, char **argv, char **envp)
{
  compiler_t eval= (compiler_t)libjolt_init(&argc, &argv, &envp);
  pixop_t pixop= eval("\n\
	(lambda (srcPix dstPix)\n\
	  (let ((srcA (& 255 (>> srcPix 24)))\n\
		(srcR (& 255 (>> srcPix 16)))\n\
		(srcG (& 255 (>> srcPix  8)))\n\
		(srcB (& 255     srcPix    ))\n\
		(dstA (& 255 (>> dstPix 24)))\n\
		(dstR (& 255 (>> dstPix 16)))\n\
		(dstG (& 255 (>> dstPix  8)))\n\
		(dstB (& 255     dstPix    ))\n\
		(outA (+ dstA (>> (* srcA (- srcA dstA)) 8)))\n\
		(outR (+ dstR (>> (* srcA (- srcR dstR)) 8)))\n\
		(outG (+ dstG (>> (* srcA (- srcG dstG)) 8)))\n\
		(outB (+ dstB (>> (* srcA (- srcB dstB)) 8))))\n\
	    (| (<<         outA  24)\n\
	       (<< (& 255 outR) 16)\n\
	       (<< (& 255 outG)  8)\n\
	           (& 255 outB)   )))");
  pixel_t result= pixop(PIXEL(5,0,0,100), PIXEL(100,0,0,5));
  printf("%08x\n", result);
  eval("(printf \"success!\\n\")");
  return 0;
}
