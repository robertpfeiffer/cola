" WinWindow.st -- Windoze host window support

  Copyright (c) 2007 Ian Piumarta
  All rights reserved.

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the 'Software'),
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, provided that the above copyright notice(s) and this
  permission notice appear in all copies of the Software and that both the
  above copyright notice(s) and this permission notice appear in supporting
  documentation.

  THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.

  Last edited: 2007-09-18 20:21:58 by piumarta on emilia
"

{ import: HostWindow }
{ import: Geometry }
{ import: Cairo }

{ include "winWindow.h" }

WinWindow : HostWindow ( _hwnd _hbdc _hbuf dpix dpiy )

HostWindow withExtent: extent	[ ^WinWindow withExtent: extent ]

WinWindow withExtent: extent
[
    self	 := super new.
    windowWidth  := extent x rounded.
    windowHeight := extent y rounded.
    StdErr println: 'withExtent'.
    {
	static int registered= 0;
	if (!registered)
	  {
	    static const char szClassName[]= "CanvasWindowClass";

	    WNDCLASSEX wc;
	    HWND       hwnd;

	    int width=  (long)self->v_windowWidth  >> 1;
	    int height= (long)self->v_windowHeight >> 1;

	    HINSTANCE hInstance= GetModuleHandle(0);

	    registered= 1;

	    wc.cbSize        = sizeof(WNDCLASSEX);
	    wc.style         = CS_VREDRAW | CS_HREDRAW;
	    wc.lpfnWndProc   = wndproc;
	    wc.cbClsExtra    = 0;
	    wc.cbWndExtra    = 0;
	    wc.hInstance     = hInstance;
	    wc.hIcon         = LoadIcon(NULL, IDI_APPLICATION);
	    wc.hCursor       = LoadCursor(NULL, IDC_ARROW);
	    wc.hbrBackground = NULL; // (HBRUSH)(COLOR_WINDOW + 1);
	    wc.lpszMenuName  = NULL;
	    wc.lpszClassName = szClassName;
	    wc.hIconSm       = LoadIcon(NULL, IDI_APPLICATION);

	    if (!RegisterClassEx(&wc))
	      {
	        MessageBox(NULL, "Window Registration Failed!", "Error!", MB_ICONEXCLAMATION | MB_OK);
	        return 0;
	      }

	    hwnd= CreateWindowEx(0 /*WS_EX_CLIENTEDGE*/,
	  		       szClassName,
	  		       "Canvas",
	  		       WS_OVERLAPPEDWINDOW,
	  		       CW_USEDEFAULT, CW_USEDEFAULT, width, height,
	  		       NULL, NULL, hInstance, NULL);
	    if (hwnd == NULL)
	      {
	        MessageBox(NULL, "Window Creation Failed!", "Error!", MB_ICONEXCLAMATION | MB_OK);
	        exit(0);
	      }

	    ShowWindow(hwnd, SW_SHOW);
	    {
	      HDC hdc= GetDC(hwnd);
	      RECT rect= { 0, 0, width, height };
	      self->v__hwnd = (oop)hwnd;
	      self->v_dpix  = (oop)((long)72 << 1 | 1);
	      self->v_dpiy  = (oop)((long)72 << 1 | 1);
	      self->v__hbdc = (oop)CreateCompatibleDC(hdc);
	      self->v__hbuf = (oop)CreateCompatibleBitmap(hdc, width, height);
	      SelectObject((HDC)self->v__hbdc, (HBITMAP)self->v__hbuf);
	      FillRect((HDC)self->v__hbdc, &rect, GetStockObject(WHITE_BRUSH));
	      ReleaseDC(hwnd, hdc);
	      InvalidateRect(hwnd, &rect, FALSE);
	      UpdateWindow(hwnd);
	    }
	  }
    }.
]

WinWindow swapBuffers: rectangle
[
    self damageEvent
	:rectangle left
	:windowHeight - rectangle top
	:rectangle right
	:windowHeight - rectangle bottom
]

WinWindow flush	[]
WinWindow sync	[]
WinWindow purge	[]

WinWindow damageEvent :l :t :r :b
{
  long l=  (long)v_l >> 1, t=  (long)v_t >> 1, r=  (long)v_r >> 1, b=  (long)v_b >> 1;
  long w= r - l, h= b - t;
  if (w > 0 && h > 0)
    {
      HDC hdc= GetDC((HWND)self->v__hwnd);
      BitBlt(hdc, l, t, w, h, (HDC)self->v__hbdc, l, t, SRCCOPY);
      ReleaseDC((HWND)self->v__hwnd, hdc);
    }
  return 0;
}

WinWindow nextEvent
[
    | name a b c d |
    {
      struct Event *e;
      while (!(e= events))
	{
	  MSG msg;
	  if (!PeekMessage(&msg, NULL, 0, 0, PM_REMOVE)) return 0;
	  if (WM_QUIT == msg.message) exit(msg.wParam);
      	  TranslateMessage(&msg);
      	  DispatchMessage(&msg);
      	}
      v_name = e->name;
      v_a    = (oop)((long)e->detail[0] << 1 | 1);
      v_b    = (oop)((long)e->detail[1] << 1 | 1);
      v_c    = (oop)((long)e->detail[2] << 1 | 1);
      v_d    = (oop)((long)e->detail[3] << 1 | 1);
      events= e->next;
      free(e);
    }.
    ^self perform: name with: a with: b with: c with: d
]

WinWindow pollEvent
[
    | event |
    (event := self nextEvent)
	ifTrue:
	   [| position |
	    position := event position.
	    position y: windowHeight - position y.
	    event position: position; localPosition: position].
    ^event
]

WinWindow waitEvent
[
    | event |
    [ { WaitMessage(); }.
      event := self pollEvent] whileFalse.
    ^event
]

{ include <cairo-win32.h> }

WinWindow newCairoContext
[
    ^(Cairo withWinWindow: self)
	translate:	 (0".5") , (windowHeight" - 0.5");
	scale:		 1 , -1
]

WinWindow newPainter
[
    ^(Cairo withWinWindow: self)
	translate:	 (0".5") , (windowHeight" - 0.5");
	scale:		 1 , -1
]

WinWindow newCPainter
[
    ^(Cairo withWinWindow: self)
	translate:	 (0".5") , (windowHeight" - 0.5");
	scale:		 1 , -1
]

Cairo withWinWindow: winWindow	[ ^self withSurface_: winWindow _cairoSurface ]

WinWindow _cairoSurface	[ ^libcairo _cairo_win32_surface_create :_hbdc ]

libcairo _cairo_win32_surface_create :_hdc {
  cairo_surface_t * _;
  _=(cairo_surface_t *)cairo_win32_surface_create((HDC)v__hdc);
  _return (oop)(long)_;
}

WinWindow dummy
[
    "ensure symbol definitions"
    self
	pointerDownEvent; pointerUpEvent; pointerMotionEvent;
	keyDownEvent; keyRepeatEvent; keyUpEvent;
	damageEvent
]
