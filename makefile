dissertation.pdf : dissertation.tex bibliography.bib
	cd ./data && make
	latex dissertation
	latex dissertation
	latex dissertation
	pdflatex dissertation

clean :
	rm -f dissertation.aux
	rm -f dissertation.log
	rm -f dissertation.pdf
	rm -f *~
	rm -f tex/dissertation.aux
	rm -f tex/dissertation.log
	rm -f tex/dissertation.pdf
	rm -f tex/*~


bibliography.bib : ../../Documents/bibtex/Part\ III\ project.bib
	cp ../../Documents/bibtex/Part\ III\ project.bib bibliography.bib
