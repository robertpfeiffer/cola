PNGS = $(filter-out s-%, $(wildcard *.png))

FIGS = $(addprefix s-,$(PNGS))

all : pepsi.html coke.html prototypes.html canvas.html $(FIGS)

%.html : %.html.in
	awk -f number.awk $< > $@.num
	awk -f top.awk $@.num > $@.top
	cat $@.num | fgrep -v h1 | awk -f toc.awk > $@.toc
	awk -f bot.awk $@.num > $@.bot
	cat $@.top $@.toc $@.bot > $@

s-%.png : %.png
	pngtopnm $< | pamscale 0.75 | pnmtopng > $@

clean : .FORCE
	rm -f *.num *.top *.toc *.bot *~

spotless : clean .FORCE
	rm -f idst5.html coke.html

.FORCE :
