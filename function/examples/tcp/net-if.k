;;; net-if.k -- network pseudo interface

(define NetworkPseudoInterface (import "NetworkPseudoInterface"))

(define ntohl (dlsym "ntohl"))
(define htonl (dlsym "htonl"))

(define ifconfig
  (lambda (deviceNode localAddress remoteAddress protocol)
    (let ((if [NetworkPseudoInterface tunnel: deviceNode from: localAddress to: remoteAddress])
	  (bytes 0))
      [StdOut nextPutAll: '"; "]
      [StdOut nextPutAll: deviceNode]
      [StdOut nextPutAll: '" inet "]
      [StdOut nextPutAll: localAddress]
      [StdOut nextPutAll: '" --> "]
      [StdOut nextPutAll: remoteAddress]
      [StdOut nextPutAll: '" running\n"]
      (while (set bytes [if next])
	(protocol if [bytes _bytes]))
      [if close])))
