" If you don't have /dev/tun0 and can't 'ifconfig create' one then you probably don't stand a chance.
  Mac users see <http://www-user.rhrk.uni-kl.de/~nissler/tuntap/> for tun/tap device kexts. "

{ import: Object }

{ include <errno.h> }
{ include <netdb.h> }
{ include <sys/socket.h> }
{ include <sys/ioctl.h> }
{ include <sys/sockio.h> }
{ include <net/if.h> }

NetworkPseudoInterface : File ()

NetworkPseudoInterface tunnel: dev from: src to: dst
[
    | _dev _src _dst |
    self := super open: dev.
    _dev := dev _stringValue.
    _src := src _stringValue.
    _dst := dst _stringValue.
    {
      struct addrinfo *src, *dst;
      int sock;
      sock= socket(AF_INET, SOCK_DGRAM, 0);
      if (getaddrinfo((char *)v__src, 0, 0, &src))
	perror((char *)v__src);
      else
	{
	  if (getaddrinfo((char *)v__dst, 0, 0, &dst))
	    perror((char *)v__dst);
	  else
	    {
	      struct ifaliasreq ifra;
	      memset(&ifra, 0, sizeof(ifra));
	      strcpy(ifra.ifra_name, (char *)v__dev + 5);	/* xxx ASSUMES /dev/ PREFIX xxx */
	      if (ioctl(sock, SIOCDIFADDR, &ifra) < 0) perror("SIOCDIFADDR");
	      memcpy(&ifra.ifra_addr,	   src->ai_addr, src->ai_addrlen);
	      memcpy(&ifra.ifra_broadaddr, dst->ai_addr, dst->ai_addrlen);
	      if (ioctl(sock, SIOCAIFADDR, &ifra) < 0) perror("SIOCAIFADDR");
	      v__dst= (oop)ntohl(((struct sockaddr_in *)dst->ai_addr)->sin_addr.s_addr);
	      freeaddrinfo(dst);
	    }
	  freeaddrinfo(src);
	}
      close(sock);
    }.
]

NetworkPseudoInterface open_: _path	{ _return (oop)(((long)open((char *)v__path, O_RDWR, 0)) << 1 | 1); }	"parent uses O_RDONLY"

NetworkPseudoInterface _read_: _bytes at_: _offset size_: _size		"ignore input/output errors during tunnel setup"
{
  int n, tries= 100;
  while (((n= read((int)self->v__fd, (void *)v__bytes + (long)v__offset, (size_t)v__size)) < 0) && (EIO == errno) && tries--)
    usleep(10000);
  fprintf(stderr, "errno %d\n", errno);
  _return((oop)(long)n);
}

NetworkPseudoInterface next
[
    | data n |
    data := ByteArray new: 8192.	"xxx could be as much as 65536 per datagram xxx"
    ^(n := self read: data) > 0	ifTrue:  [data "copyFrom: 0 to: n"]
]

NetworkPseudoInterface nextPut: packet
[
    StdErr nextPutAll: '>\t'; println: packet.
    ^self write: packet data size: packet iplen
]




NetworkProtocol : Object ()

NetworkPacket : Object ( data )

NetworkPacket withData: aByteArray
[
    self := super new.
    data := aByteArray.
]

NetworkPacket data	[ ^data ]
NetworkPacket size	[ ^data size ]

NetworkPacket at: index			[ ^data at: index ]
NetworkPacket at: index put: aByte	[ ^data at: index put: aByte ]

{ include <netinet/ip.h> }

IPPacket : NetworkPacket ( _ip )

IPPacket withData: aByteArray
[
    self := super withData: aByteArray.
    _ip := data _bytes.
]

IPPacket headerSize	[ ^self iphl * 4 ]

IPPacket printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPutAll: '(v=';	print: self ipv;
	nextPutAll: ' hl=';	print: self iphl;
	nextPutAll: ' tos=';	print: self iptos;
	nextPutAll: ' len=';	print: self iplen;
	nextPutAll: ' id=';	print: self ipid;
	nextPutAll: ' flags=';	print: self ipflags base: 16 width: 4;
	nextPutAll: ' off=';	print: self ipoff;
	nextPutAll: ' ttl=';	print: self ipttl;
	nextPutAll: ' p=';	print: self ipp;
	nextPutAll: ' sum=';	print: self ipsum base: 16 width: 4;
	nextPutAll: ' src=';	print: self ipsrc base: 16 width: 8;
	nextPutAll: ' dst=';	print: self ipdst base: 16 width: 8;
	nextPutAll: ')'
]

IPPacket ipv	 { _return((oop)((long)(     (((struct ip *)self->v__ip)->ip_v)			) << 1 | 1)); }
IPPacket iphl	 { _return((oop)((long)(     (((struct ip *)self->v__ip)->ip_hl)		) << 1 | 1)); }
IPPacket iptos	 { _return((oop)((long)(     (((struct ip *)self->v__ip)->ip_tos)		) << 1 | 1)); }
IPPacket iplen	 { _return((oop)((long)(ntohs(((struct ip *)self->v__ip)->ip_len)		) << 1 | 1)); }
IPPacket ipid	 { _return((oop)((long)(ntohs(((struct ip *)self->v__ip)->ip_id)		) << 1 | 1)); }
IPPacket ipflags { _return((oop)((long)(ntohs(((struct ip *)self->v__ip)->ip_off) & ~IP_OFFMASK	) << 1 | 1)); }
IPPacket ipoff	 { _return((oop)((long)(     (((struct ip *)self->v__ip)->ip_off) &  IP_OFFMASK	) << 1 | 1)); }
IPPacket ipttl	 { _return((oop)((long)(     (((struct ip *)self->v__ip)->ip_ttl)		) << 1 | 1)); }
IPPacket ipp	 { _return((oop)((long)(     (((struct ip *)self->v__ip)->ip_p)			) << 1 | 1)); }
IPPacket ipsum	 { _return((oop)((long)(ntohs(((struct ip *)self->v__ip)->ip_sum)		) << 1 | 1)); }

IPPacket ipsrc	 [ ^Integer unsignedValue_: self _ipsrc ]	IPPacket _ipsrc	{ _return((oop)((long)(ntohl(((struct ip *)self->v__ip)->ip_src.s_addr)	))); }
IPPacket ipdst	 [ ^Integer unsignedValue_: self _ipdst ]	IPPacket _ipdst	{ _return((oop)((long)(ntohl(((struct ip *)self->v__ip)->ip_dst.s_addr)	))); }

IPPacket iplen: len	{ ((struct ip *)self->v__ip)->ip_len	    = htons((long)v_len >> 1); }
IPPacket ipsum: sum	{ ((struct ip *)self->v__ip)->ip_sum	    = htons((long)v_sum >> 1); }
IPPacket ipsrc: src	[ self ipsrc_: src _integerValue ]	IPPacket ipsrc_: _src	{ ((struct ip *)self->v__ip)->ip_src.s_addr = htonl((long)v__src); }
IPPacket ipdst: dst	[ self ipdst_: dst _integerValue ]	IPPacket ipdst_: _dst	{ ((struct ip *)self->v__ip)->ip_dst.s_addr = htonl((long)v__dst); }
