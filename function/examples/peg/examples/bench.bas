100 let n=100000
110 let s=0
120 let m=0
125 let t=time
130 let m=m+1
140 let s=s+m
150 if m<n then goto 130
155 let t=time-t
160 print "interpreted ", n*3, " lines of code in ", t, " ms; answer is ", s
165 print "approx ", n*3/t*1000, " lines per second"
167 print "approx ", n*41/t*1000, " bytes per second"
170 end
