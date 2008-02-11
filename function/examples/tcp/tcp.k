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

;;; Last edited: 2008-02-11 11:54:05 by piumarta on emilia

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

(ifconfig '"/dev/tun0" '"10.0.0.1" '"10.0.0.2" ip-receive)
