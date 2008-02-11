;;; net-icmp.k -- the Internet Control Message Protocol

				         { structure-diagram }
+-------------------------+-------------------------+-------------------------------------------------+
| 00 01 02 03 04 05 06 07 | 08 09 10 11 12 13 14 15 | 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 |
+-------------------------+-------------------------+-------------------------------------------------+
|           type          |           code          |                   checksum                      |
+-------------------------+-------------------------+-------------------------------------------------+
		     icmp -- Internet Control Message Protocol packet header [RFC 792]

(define ICMP_ECHO_REPLY	0)
(define ICMP_ECHO	8)

(define icmp-print
  (lambda (icmp)
    (printf "type=%02x " (icmp-type icmp))
    (printf "code=%02x " (icmp-code icmp))
    (printf "sum=%04x\n" (icmp-checksum icmp))))

(define icmp-receive
  (lambda (if ip icmp icmplen)
    (printf "ICMP\tRECV ") (icmp-print icmp)
    (if (== ICMP_ECHO (icmp-type icmp))
	(let ()
	  (set (icmp-type     icmp) ICMP_ECHO_REPLY)
	  (set (icmp-checksum icmp) 0)
	  (set (icmp-checksum icmp) (^ 65535 (checksum icmp (+ icmp icmplen))))
	  (printf "ICMP\tSEND ") (icmp-print icmp)
	  (ip-send if ip (ip-destinationAddress ip) (ip-sourceAddress ip))))))

(ip-register-protocol IP_PROTO_ICMP icmp-receive)
