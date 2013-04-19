dissertation.pdf : dissertation.tex bibliography.bib abstract.tex mystyle.sty
	pdflatex dissertation
	bibtex dissertation
	pdflatex dissertation
	pdflatex dissertation

#dissertation.tex : dissertation.Rnw abstract.tex introduction.tex methods.tex results.tex conclusion.tex
#	R CMD Sweave dissertation.Rnw

dissertation.tex introduction.tex methods.tex results.tex conclusion.tex backgorund.tex: dissertation.Rnw introduction.Rnw methods.Rnw results.Rnw conclusion.Rnw background.Rnw
#	R CMD Sweave $<
	Rscript -e "library(knitr); knit('dissertation.Rnw')"

%.tex : %.Rnw
#	R CMD Sweave $<
	Rscript -e "library(knitr); knit('$<')"

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

wordcount :
	texcount -total *.tex

data : ./data/FBAtimings.csv ./data/geo_m_react.txt ./data/geo_s_react.txt ./data/iaf1260-ac.txt
	rm ./data/*.RData
  
./data/FBAtimings.csv : ./experiments/FBAtimings.csv
	rsync ./experiments/FBAtimings.csv ./data/

./data/geo_m_react.txt : ./experiments/geo_m_react.txt
	rsync ./experiments/geo_m_react.txt ./data/

./data/geo_s_react.txt : ./experiments/geo_s_react.txt
	rsync ./experiments/geo_s_react.txt ./data/

./data/iaf1260-ac.txt : ./experiments/iaf1260-ac.txt
	rsync ./experiments/geo_s_react.txt ./data/
