dissertation.pdf : dissertation.tex bibliography.bib abstract.tex introduction.tex methods.tex results.tex conclusion.tex mystyle.sty
	pdflatex dissertation
	bibtex dissertation
	pdflatex dissertation
	pdflatex dissertation

#dissertation.tex : dissertation.Rnw abstract.tex introduction.tex methods.tex results.tex conclusion.tex
#	R CMD Sweave dissertation.Rnw

%.tex : %.Rnw
	R CMD Sweave $<
#	Rscript -e "library(knitr); knit('$<')"

clean :
	rm -f dissertation.aux
	rm -f dissertation.log
	rm -f *.pdf
	rm -f dissertation.tex
	rm -f dissertation-concordance.tex
	rm -f *.aux
	rm -f *.log
	rm -f introduction.tex 
	rm -f background.tex
	rm -f methods.tex 
	rm -f results.tex 
	rm -f conclusion.tex
	rm -f *.blg
	rm -f *.bbl
	rm -f *~

bibliography.bib : ../../Documents/bibtex/Part\ III\ project.bib
	cp ../../Documents/bibtex/Part\ III\ project.bib bibliography.bib
