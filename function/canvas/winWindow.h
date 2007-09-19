#include "eventQueue.h"

static LRESULT CALLBACK wndproc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
  //printf("wndproc %d\n", msg);
  static int x= 0, y= 0;
  switch (msg)
    {
    case WM_LBUTTONDOWN:  enqueue(s_pointerDownEvent, 	wParam, 1, x= LOWORD(lParam), y= HIWORD(lParam));  break;
    case WM_MBUTTONDOWN:  enqueue(s_pointerDownEvent, 	wParam, 2, x= LOWORD(lParam), y= HIWORD(lParam));  break;
    case WM_RBUTTONDOWN:  enqueue(s_pointerDownEvent, 	wParam, 3, x= LOWORD(lParam), y= HIWORD(lParam));  break;
    case WM_LBUTTONUP:    enqueue(s_pointerUpEvent,   	wParam, 1, x= LOWORD(lParam), y= HIWORD(lParam));  break;
    case WM_MBUTTONUP:    enqueue(s_pointerUpEvent,   	wParam, 2, x= LOWORD(lParam), y= HIWORD(lParam));  break;
    case WM_RBUTTONUP:    enqueue(s_pointerUpEvent,   	wParam, 3, x= LOWORD(lParam), y= HIWORD(lParam));  break;
    case WM_MOUSEMOVE:    enqueue(s_pointerMotionEvent, wParam, 0, x= LOWORD(lParam), y= HIWORD(lParam));  break;
    case WM_KEYDOWN:	  enqueue(s_keyDownEvent, 	wParam, 0, x,		      y		       );  break;
    case WM_CHAR:	  enqueue(s_keyRepeatEvent, 	wParam, 0, x,		      y		       );  break;
    case WM_KEYUP:	  enqueue(s_keyUpEvent, 	wParam, 0, x,		      y		       );  break;
    case WM_CLOSE:	  DestroyWindow(hWnd);								   return 0;
    case WM_DESTROY:	  PostQuitMessage(0);								   return 0;
    case WM_PAINT:
      {
	RECT rect;
	GetUpdateRect(hWnd, &rect, FALSE);
	enqueue(s_damageEvent, rect.left, rect.top, rect.right, rect.bottom);
      }
      break;
    }
  return DefWindowProc(hWnd, msg, wParam, lParam);
}
