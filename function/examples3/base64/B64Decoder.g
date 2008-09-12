%
% Base64 decoder by Derek Kulinski <takeda@takeda.tk>
%

B64Decoder : Parser ( s64 )

start = header base64text+ footer

header = space* 'begin-base64 ' perm ' ' filename nl
footer = space* nl space* '===='

base64text = b64 :p1 b64 :p2 b64 :p3 b64 :p4  -> {
               s64 := (p1 << 18) + (p2 << 12) + (p3 << 6) + p4.
               StdOut nextPut: ((s64 >> 16) & 255);
               nextPut: (s64 >> 8) & 255;
               nextPut: s64 & 0xff }

b64 = [A-Za-z0-9+/=] :c -> { c base64value }

perm = [0-7][0-7][0-7]

filename = [^\n]+

nl = '\n' | '\r' | '\n\r'
space = [\t ]
