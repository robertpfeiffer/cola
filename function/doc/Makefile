EPS = $(wildcard *.eps)
PNG = $(EPS:.eps=.png)

all : parser.html $(PNG)

%.html : %.html.in
	awk -f ../../doc/number.awk $< > $@.num
	awk -f ../../doc/top.awk $@.num > $@.top
	cat $@.num | fgrep -v h1 | awk -f ../../doc/toc.awk > $@.toc
	awk -f ../../doc/bot.awk $@.num > $@.bot
	cat $@.top $@.toc $@.bot > $@

%.png : %.eps
	pstopnm -dpi=600 < $< | pnmtopng > $@

clean : .FORCE
	rm -f *.num *.top *.toc *.bot *~

spotless : clean .FORCE
	rm -f reader.html

.FORCE :
