dissertation.pdf : dissertation.tex bibliography.bib
	latex dissertation
	latex dissertation
	latex dissertation
	pdflatex dissertation

clean :
	rm -f dissertation.aux
	rm -f dissertation.log
	rm -f dissertation.pdf
	rm -f *~

bibliography.bib : cp ../../Documents/bibtex/Part\ III\ project.bib
	cp ../../Documents/bibtex/Part\ III\ project.bib bibliography.bib
