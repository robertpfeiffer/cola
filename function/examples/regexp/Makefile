JOLT = ../../jolt-burg/main

all : run

test : .FORCE
	$(MAKE) run

run : test1 test2 test3 test4 test5 test6 test7 test8 test9

GREP = $(JOLT) boot.k pgrep.k

test1 : .FORCE
	time egrep   'break|continue|for|while|switch|case|return|static|extern' < tests/test.c | tee out.e | wc -l
	time $(GREP) 'break|continue|for|while|switch|case|return|static|extern' < tests/test.c | tee out.p | wc -l
	diff out.e out.p
	rm out.e out.p

test2 : .FORCE
	time egrep   'd?e?l?t?a?' < tests/termcap | tee out.e | wc -l
	time $(GREP) 'd?e?l?t?a?' < tests/termcap | tee out.p | wc -l
	diff out.e out.p
	rm out.e out.p

test3 : .FORCE
	time egrep   'd?e+l*t?a+' < tests/termcap | tee out.e | wc -l
	time $(GREP) 'd?e+l*t?a+' < tests/termcap | tee out.p | wc -l
	diff out.e out.p
	rm out.e out.p

test4 : .FORCE
	time egrep   'd?e+l*t?a+' < tests/termcap | tee out.e | wc -l
	time $(GREP) 'd?e+l*t?a+' < tests/termcap | tee out.p | wc -l
	diff out.e out.p
	rm out.e out.p

test5 : .FORCE
	time egrep   'p[aeiou]t'  < tests/termcap | tee out.e | wc -l
	time $(GREP) 'p[aeiou]t'  < tests/termcap | tee out.p | wc -l
	diff out.e out.p
	rm out.e out.p

test6 : .FORCE
	time egrep   'p[^aeiou]t' < tests/termcap | tee out.e | wc -l
	time $(GREP) 'p[^aeiou]t' < tests/termcap | tee out.p | wc -l
	diff out.e out.p
	rm out.e out.p

test7 : .FORCE
	time egrep   '19[0-9]+'   < tests/termcap | tee out.e | wc -l
	time $(GREP) '19[0-9]+'   < tests/termcap | tee out.p | wc -l
	diff out.e out.p
	rm out.e out.p

test8 : .FORCE
	time egrep   '19[^0-9]+'  < tests/termcap | tee out.e | wc -l
	time $(GREP) '19[^0-9]+'  < tests/termcap | tee out.p | wc -l
	diff out.e out.p
	rm out.e out.p

test9 : .FORCE
	time egrep   '..a.....b'  < tests/termcap | tee out.e | wc -l
	time $(GREP) '..a.....b'  < tests/termcap | tee out.p | wc -l
	diff out.e out.p
	rm out.e out.p


clean : .FORCE
	rm -f *~ .*history

.FORCE :
