;;; net-ip.k -- the Internet Protocol

					   { structure-diagram }
+-------------+-------------+-------------------------+----------+----------------------------------------+
| 00 01 02 03 | 04 05 06 07 | 08 09 10 11 12 13 14 15 | 16 17 18 | 19 20 21 22 23 24 25 26 27 28 29 30 31 |
+-------------+-------------+-------------------------+----------+----------------------------------------+
|   version   |  headerSize |      typeOfService      |                     length                        |
+-------------+-------------+-------------------------+----------+----------------------------------------+
|                     identification                  |  flags   |                  offset                |
+---------------------------+-------------------------+----------+----------------------------------------+
|       timeToLive          |         protocol        |                    checksum                       |
+---------------------------+-------------------------+---------------------------------------------------+
|                                               sourceAddress                                             |
+---------------------------------------------------------------------------------------------------------+
|                                             destinationAddress                                          |
+---------------------------------------------------------------------------------------------------------+
			       ip -- Internet Protocol packet header [RFC 791]

(define IP_PROTO_ICMP	1)
(define IP_PROTO_TCP	6)

(define ip-print
  (lambda (ip)
    (printf "v=%x "       (ip-version ip))
    (printf "hl=%x "      (ip-headerSize ip))
    (printf "tos=%02x "   (ip-typeOfService ip))
    (printf "len=%04x "   (ip-length ip))
    (printf "id=%04x "    (ip-identification ip))
    (printf "flags=%x "   (ip-flags ip))
    (printf "off=%04x "   (ip-offset ip))
    (printf "ttl=%02x "   (ip-timeToLive ip))
    (printf "proto=%02x " (ip-protocol ip))
    (printf "sum=%04x "   (ip-checksum ip))
    (printf "src=%08x "   (ip-sourceAddress ip))
    (printf "dst=%08x\n"  (ip-destinationAddress ip))))

(define checksum
  (lambda (addr stop)
    (let ((sum 0) (limit (- stop 1)))
      (while (< addr limit)
	(set sum (+ sum (<< (& 255 (char@ addr)) 8) (& 255 (char@ addr 1))))
	(set addr (+ addr 2)))
      (if (< addr stop) (set sum (+ sum (<< (& 255 (char@ addr)) 8))))
      (while (> sum 65535) (set sum (+ (& sum 65535) (>> sum 16))))
      sum)))

(define compute-ip-checksum	(lambda (ip) (checksum ip (+ ip (* 4 (ip-headerSize ip))))))
(define ip-payload		(lambda (ip) (+ ip (* 4 (ip-headerSize ip)))))
(define ip-protocols		(calloc 256 4))
(define ip-register-protocol	(lambda (number protocol) (set (long@ ip-protocols number) protocol)))

(define ip-receive
  (lambda (if ip)
    (printf "IP\tRECV ") (ip-print ip)
    (if (and (or (== 4     (ip-version		ip))	(and (printf "bad ip version %d\n"	(ip-version ip))		0))
	     (or (== 5     (ip-headerSize	ip))	(and (printf "bad ip headerSize %d\n"	(ip-headerSize ip))		0))
	     (or (== 65535 (compute-ip-checksum	ip))	(and (printf "bad ip checksum %04x\n"	(compute-ip-checksum ip))	0)))
	(let ((protocol (long@ ip-protocols (ip-protocol ip)))
	      (payload  (ip-payload ip)))
	  (if protocol
	      (protocol if ip payload (- (ip-length ip) (- payload ip)))
	      (printf "bad ip protocol %d\n" (ip-protocol ip)))))))

(define ip-send
  (lambda (if ip src dst)
    (set (ip-sourceAddress      ip) src)
    (set (ip-destinationAddress ip) dst)
    (set (ip-checksum	      ip) 0)
    (set (ip-checksum	      ip) (^ 65535 (compute-ip-checksum ip)))
    (printf "IP\tSEND ") (ip-print ip)
    [if _write_: ip size_: (ip-length ip)]))
