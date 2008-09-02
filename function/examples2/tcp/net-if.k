;;; net-if.k -- network pseudo interface

(send '_import: Object "NetworkPseudoInterface" "__id__init__NetworkPseudoInterface")

(define NetworkPseudoInterface (import "NetworkPseudoInterface"))

;(define ntohl (dlsym "ntohl"))
;(define htonl (dlsym "htonl"))

(define swap32
  (lambda (x)
    (+ (<< (& 255 (>> x 24))  0)
       (<< (& 255 (>> x 16))  8)
       (<< (& 255 (>> x  8)) 16)
       (<< (& 255 (>> x  0)) 24))))

(define identity (lambda (x) x))

(define ntohl identity)
(define htonl identity)

(and (== 1684234849 (long@ "abcd"))
     (define ntohl swap32)
     (define htonl swap32))

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
