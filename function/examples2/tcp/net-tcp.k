;;; net-tcp.k -- the Transmission Control Protocol (over IP)

					   { structure-diagram }
+-------------+----------+----------+-------------------+-------------------------------------------------+
| 00 01 02 03 | 04 05 06 | 07 08 09 | 10 11 12 13 14 15 | 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 |
+-------------+----------+----------+-------------------+-------------------------------------------------+
|                       sourcePort                      |                 destinationPort                 |
+-------------------------------------------------------+-------------------------------------------------+
|                                                 sequenceNumber                                          |
+---------------------------------------------------------------------------------------------------------+
|                                              acknowledgementNumber                                      |
+-------------+----------+----------+-------------------+-------------------------------------------------+
|    offset   | reserved |   ecn    |    controlBits    |                    window                       |
+-------------+----------+----------+-------------------+-------------------------------------------------+
|                       checksum                        |                 urgentPointer                   |
+-------------------------------------------------------+-------------------------------------------------+
			tcp -- Transmission Control Protocol packet header [RFC 793]

(define TCP_FIN  1)
(define TCP_SYN  2)
(define TCP_RST  4)
(define TCP_PSH  8)
(define TCP_ACK 16)

(define tcp-print
  (lambda (tcp)
    (printf "sport=%04x " (tcp-sourcePort tcp))
    (printf "dport=%04x " (tcp-destinationPort tcp))
    (printf "seq=%u "     (tcp-sequenceNumber tcp))
    (printf "ack=%u "     (tcp-acknowledgementNumber tcp))
    (printf "off=%d "     (tcp-offset tcp))
    (printf "flags=%02x " (tcp-controlBits tcp))
    (printf "win=%04x "   (tcp-window tcp))
    (printf "urg=%04x\n"  (tcp-urgentPointer tcp))))

(define tcp-payload	(lambda (tcp) (+ tcp (* 4 (tcp-offset tcp)))))

(define compute-tcp-checksum
  (lambda (tcp ip)
    (let ((src (ip-sourceAddress	ip))
	  (dst (ip-destinationAddress	ip))
	  (sum (+ (& src 65535) (>> src 16) (& dst 65535) (>> dst 16) IP_PROTO_TCP (- (ip-length ip) (- tcp ip))	; pseudo header
		  (checksum tcp (+ ip (ip-length ip))))))
      (while (> sum 65535) (set sum (+ (& sum 65535) (>> sum 16))))
      sum)))

(define tcp-services		(calloc 1024 4))
(define tcp-register-service	(lambda (number service) (set (long@ tcp-services number) service)))

(define tcp-service-at
  (lambda (port)
    (if (and (< 0 port) (< port 1024))
	(long@ tcp-services port)
	0)))

(define tcp-send
  (lambda (if ip src dst tcp srcPort dstPort seq ack flags len)
    (set (tcp-sourcePort		tcp) srcPort)
    (set (tcp-destinationPort		tcp) dstPort)
    (set (tcp-sequenceNumber		tcp) seq)
    (set (tcp-acknowledgementNumber	tcp) ack)
    (set (tcp-controlBits		tcp) flags)
    (set (tcp-offset			tcp) 5)
    (set (tcp-checksum			tcp) 0)
    (set (ip-length			ip)  (+ (- (tcp-payload tcp) ip) len))
    (set (tcp-checksum			tcp) (^ 65535 (compute-tcp-checksum tcp ip)))
    (printf "TCP\tSEND ") (tcp-print tcp)
    (ip-send if ip src dst)))

(define tcp-receive
  (lambda (if ip tcp tcplen)
    (printf "TCP\tRECV ") (tcp-print tcp)
    (let ((flags  (tcp-controlBits tcp)))
      (if (== 0 (& flags TCP_RST))
	  (let ((saddr   (ip-sourceAddress		ip))
		(daddr   (ip-destinationAddress		ip))
		(dport   (tcp-destinationPort		tcp))
		(seqno   (tcp-sequenceNumber		tcp))
		(ackno   (tcp-acknowledgementNumber	tcp))
		(payload (tcp-payload tcp))
		(datalen (- tcplen (* 4 (tcp-offset tcp))))
		(service (tcp-service-at dport)))
	    (printf "TCP service %d tcplen %d datalen %d\n" dport tcplen datalen)
	    (if (& flags TCP_FIN) (set datalen (+ datalen 1)))
	    (if service
		(if (& flags TCP_SYN)
		    (tcp-send				if ip daddr saddr tcp dport (tcp-sourcePort tcp) -1    (+ seqno 1)       (+ TCP_ACK TCP_SYN)	     0)
		    (if (and (== 0 ackno) (> datalen 0))
			(let ((replylen (service if ip tcp (tcp-payload tcp) datalen)))
			  (tcp-send			if ip daddr saddr tcp dport (tcp-sourcePort tcp) 0     (+ seqno datalen) (+ TCP_ACK TCP_PSH TCP_FIN) replylen))
			(if datalen (tcp-send		if ip daddr saddr tcp dport (tcp-sourcePort tcp) ackno (+ seqno datalen)    TCP_ACK		     0))))
		(tcp-send				if ip daddr saddr tcp dport (tcp-sourcePort tcp) ackno (+ seqno 1)       (+ TCP_ACK TCP_RST)         0)))))))

(ip-register-protocol IP_PROTO_TCP tcp-receive)
