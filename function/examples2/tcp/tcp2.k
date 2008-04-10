;;; tcp.k -- minimal TCP/IP services

;;; Copyright (c) 2006, 2007 Ian Piumarta
;;; All rights reserved.
;;; 
;;; Permission is hereby granted, free of charge, to any person obtaining a
;;; copy of this software and associated documentation files (the 'Software'),
;;; to deal in the Software without restriction, including without limitation
;;; the rights to use, copy, modify, merge, publish, distribute, and/or sell
;;; copies of the Software, and to permit persons to whom the Software is
;;; furnished to do so, provided that the above copyright notice(s) and this
;;; permission notice appear in all copies of the Software and that both the
;;; above copyright notice(s) and this permission notice appear in supporting
;;; documentation.
;;;
;;; THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.

;;; Last edited: 2008-04-10 12:25:23 by piumarta on emilia.local

(printf "temporarily out of order\n")
[OS exit]

(load "structure.k")

(load "net-if.k")
(load "net-ip.k")
(load "net-icmp.k")
(load "net-tcp.k")

;;; 
;;; daytime service
;;; 

(define daytime-receive
  (lambda (if ip tcp data len)
    (set (char@ data len) 0)
    (printf "DAYTIME client sent %d bytes:\n%s\n" len data)
    (strlen (strcpy data [[Time now] _formatted_: "%a %d %b %Y %T %Z\n"]))))

(tcp-register-service 13 daytime-receive)

;;; 
;;; http service
;;; 

(define http-receive
  (lambda (if ip tcp data len)
    (set (char@ data len) 0)
    (printf "HTTP client sent %d bytes:\n%s" len data)
    (strcpy data
"<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\"
<html><head>
<title>Colita HTTP Server</title>
</head><body>
<h1>Hello!</h1><p>This is the Colita HTTP nanoserver.  The current data and time are ")
    (strcat data [[Time now] _formatted_: "%a %d %b %Y %T %Z"])
    (strcat data
"</p>
<hr>
<address>Colita/0.0.1 (VPRI FoNC/COLA) server at 10.0.0.2 port 80</address>
</body></html>")
    (strlen data)))

(tcp-register-service 80 http-receive)

;;; 
;;; bring the network interface up
;;; 

(syntax with-tcp-ip
  (lambda (node)
    `(let ((ip ,[node second]))
       (with-ip ip
         (let ((tcp (ip-payload ip)))
           (with-tcp tcp (let ((datalen (- (ip-length ip) (* 4 (+ (ip-headerSize ip) (tcp-offset tcp))))))
			   ,@[node copyFrom: '2])))))))

(define fin-len (lambda (tcp) (if (& TCP_FIN (tcp-controlBits tcp)) 1 0)))

(syntax out
  (lambda (node)
    `(let ((dev [self source])) ;; [',[node second] println]
       (with-tcp-ip [[self next] _bytes]
	 (tcp-send dev ip destinationAddress sourceAddress tcp destinationPort sourcePort ,@[node copyFrom: '2])))))

(define up
  (lambda (port dev ip tcp data len)
    (let ((service  (tcp-service-at port)))
      (if service (service dev ip tcp data len) 0))))

(define tcp?  (lambda (p) (== 6 (ip-protocol p))))

(define svc?  (lambda (p) (let ((ip [p _bytes])) (and (tcp? ip) (tcp-service-at (tcp-destinationPort (ip-payload ip)))))))
(define syn?  (lambda (p) (let ((ip [p _bytes])) (and (tcp? ip) (& TCP_SYN (tcp-controlBits (ip-payload ip)))))))
(define req?  (lambda (p) (let ((qi [p _bytes])) (and (tcp? qi) (with-tcp-ip qi (and (== 0 acknowledgementNumber) datalen))))))
(define ack?  (lambda (p) (let ((ip [p _bytes])) (and (tcp? ip) (or (> (ip-length ip) (* 4 (+ (ip-headerSize ip) (tcp-offset (ip-payload ip)))))
								    (& TCP_FIN (tcp-controlBits (ip-payload ip))))))))

(printf "starting TCP/IP...\n")

['{ svc     = &->(svc? [self peek])
    syn     = &->(syn? [self peek])	<-(out ack-syn    -1 (+ sequenceNumber 1) (+ TCP_ACK TCP_SYN) 0)
    req     = &->(req? [self peek])	<-(out ack-psh-fin 0 (+ sequenceNumber datalen (fin-len tcp)) (+ TCP_ACK TCP_PSH TCP_FIN)
							     (up destinationPort dev ip tcp (tcp-payload tcp) datalen))
    ack     = &->(ack? [self peek])	<-(out ack	     acknowledgementNumber (+ sequenceNumber datalen (fin-len tcp)) TCP_ACK 0)
	    ;
    ( svc (syn | req | ack | .) | .	<-(out ack-rst 	     acknowledgementNumber (+ sequenceNumber 1) (+ TCP_ACK TCP_RST) 0)
    ) *
  } parse: [NetworkPseudoInterface tunnel: '"/dev/tun0" from: '"10.0.0.1" to: '"10.0.0.2"]]
