" See <http://www.tinc-vpn.org> or <http://openvpn.net> for TAP-Win32 tun/tap driver.
  Follow the instructions included in either of the above to install and activate the driver.
  You MUST rename the driver interface to 'tunnel' in the Network Connections control panel and
  then set the ip address to 10.0.2.1 in the TCP/IP properties or using netsh from a dos prompt:
	netsh interface ip set address tunnel static 10.0.2.1 255.255.255.0 10.0.2.2 1
  The demo will configure the device for you. "

{ import: Object }

{ include "win32.h" }

NetworkPseudoInterface : File ()

NetworkPseudoInterface tunnel: dev from: src to: dst
[
    | _dev _src _dst |
    self := super new.
    name := dev.
    _dev := dev _stringValue.
    _src := src _stringValue.
    _dst := dst _stringValue.
    {
#     define NETWORK_CONNECTIONS_KEY	"SYSTEM\\CurrentControlSet\\Control\\Network\\{4D36E972-E325-11CE-BFC1-08002BE10318}"
#     define USERMODEDEVICEDIR		"\\\\.\\Global\\"
#     define TAPSUFFIX			".tap"
#     define TAP_CONTROL_CODE(request, method)	CTL_CODE(FILE_DEVICE_UNKNOWN, request, method, FILE_ANY_ACCESS)
#     define TAP_IOCTL_CONFIG_POINT_TO_POINT	TAP_CONTROL_CODE( 5, METHOD_BUFFERED)
#     define TAP_IOCTL_SET_MEDIA_STATUS		TAP_CONTROL_CODE( 6, METHOD_BUFFERED)
#     define TAP_IOCTL_CONFIG_TUN		TAP_CONTROL_CODE(10, METHOD_BUFFERED)
      char devname[1024];
      char *reason;
      struct addrinfo *src, *dst;
      setvbuf(stdout, 0, _IONBF, 0);
      setvbuf(stderr, 0, _IONBF, 0);
      {
	struct WSAData wsa_state;
	if (WSAStartup(MAKEWORD(2, 2), &wsa_state))
	  {
	    reason= "winsock";
	    goto winError;
	  }
      }
      if (getaddrinfo((char *)v__src, 0, 0, &src))
	perror((char *)v__src);
      else
	{
	  if (getaddrinfo((char *)v__dst, 0, 0, &dst))
	    perror((char *)v__dst);
	  else
	    {
	      int i;
	      char device[1024];
	      long len;
	      int found= 0;
	      HANDLE device_handle;
	      {
		HKEY key;
		if (RegOpenKeyEx(HKEY_LOCAL_MACHINE, NETWORK_CONNECTIONS_KEY, 0, KEY_READ, &key))
		  {
		    reason= "registry";
		    goto winError;
		  }
		for (i= 0;  !found;  ++i)
		  {
		    HKEY key2;
		    char regent[1024];
		    int err;
		    len= sizeof(device);
		    if (RegEnumKeyEx(key, i, device, &len, 0, 0, 0, 0))
		      break;
		    snprintf(regent, sizeof(regent), "%s\\%s\\Connection", NETWORK_CONNECTIONS_KEY, device);
		    if (RegOpenKeyEx(HKEY_LOCAL_MACHINE, regent, 0, KEY_READ, &key2))
		      continue;
		    len= sizeof(devname);
		    err= RegQueryValueEx(key2, "Name", 0, 0, devname, &len);
		    RegCloseKey(key2);
		    if (err)
		      continue;
		    if (!strcmp((char *)v__dev, devname))
		      found= 1;
		  }
		RegCloseKey(key);
	      }
	      if (!found)
		{
		  fprintf(stderr, ("No tunnel device found\n"));
		  exit(1);
		}
	      {
		snprintf(devname, sizeof(devname), USERMODEDEVICEDIR "%s" TAPSUFFIX, device);
		device_handle= CreateFile(devname, GENERIC_WRITE | GENERIC_READ, 0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM, 0);
		if (device_handle == INVALID_HANDLE_VALUE)
		  {
		    reason= devname;
		    goto winError;
		  }
	      }
	      {
		DWORD len;
		long addrs[3]= { ((struct sockaddr_in *)src->ai_addr)->sin_addr.s_addr,
				 ((struct sockaddr_in *)src->ai_addr)->sin_addr.s_addr & htonl(0xffffff00),
				 htonl(0xffffff00) };
//		if (!DeviceIoControl(device_handle, TAP_IOCTL_CONFIG_POINT_TO_POINT, addrs, sizeof(addrs), addrs, sizeof(addrs), &len, 0))
		if (!DeviceIoControl(device_handle, TAP_IOCTL_CONFIG_TUN, addrs, sizeof(addrs), addrs, sizeof(addrs), &len, 0))
		  {
		    fprintf(stderr, "%s: point-to-point configuration refused\n", (char *)v__dev);
		    exit(1);
		  }
	      }
	      {
		unsigned long status= 1;
		DeviceIoControl(device_handle, TAP_IOCTL_SET_MEDIA_STATUS, &status, sizeof(status), &status, sizeof(status), &len, 0);
	      }
	      self->v__fd= (oop)device_handle;
	      freeaddrinfo(dst);
	    }
	  freeaddrinfo(src);
	}
      _return(v_self);

     winError:
      {
	static char buf[1024], *newline;
	if (!FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
			   0, GetLastError(), MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), buf, sizeof(buf), 0))
	  strncpy(buf, "unknown error", sizeof(buf));
	if ((newline= strchr(buf, '\r')))
	  *newline= '\0';
	fprintf(stderr, "%s: %s\n", reason, buf);
	exit(1);
      }
    }.
]

NetworkPseudoInterface _read_: _bytes at_: _offset size_: _size		"ignore input/output errors during tunnel setup"
{
  HANDLE device_handle= (HANDLE)self->v__fd;
  long len, tries= 100, status;
  while ((status= ReadFile(device_handle, (void *)v__bytes + (long)v__offset, (size_t)v__size, &len, 0)) && (len == 0) && --tries)
    {
      fprintf(stderr, "ignore %ld bytes status %ld\n", len, status);
      fprintf(stderr, "errno %d\n", errno);
      Sleep(10);
    }
  _return((oop)len);
}

NetworkPseudoInterface next
[
    | data n |
    data := ByteArray new: 8192.	"xxx could be as much as 65536 per datagram xxx"
    ^(n := self read: data) println > 0	ifTrue:  [data "copyFrom: 0 to: n"]
]

NetworkPseudoInterface nextPut: packet
[
    StdErr nextPutAll: '>\t'; println: packet.
    ^self write: packet data size: packet iplen
]

NetworkPseudoInterface _write_: _bytes size_: _size
{
  HANDLE device_handle= (HANDLE)self->v__fd;
  long len, tries= 100, status;
  while ((status= WriteFile(device_handle, (void *)v__bytes, (size_t)v__size, &len, 0)) && (len == 0) && --tries)
    {
      fprintf(stderr, "ignore %ld bytes status %ld\n", len, status);
      fprintf(stderr, "errno %d\n", errno);
      Sleep(10);
    }
  _return((oop)len);
}
