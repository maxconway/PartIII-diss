dissertation.pdf : dissertation.tex
	latex dissertation
	latex dissertation
	latex dissertation
	pdflatex dissertation

clean :
	rm dissertation.aux
	rm dissertation.log
