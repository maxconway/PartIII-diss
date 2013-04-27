mainRfiles = background.R dissertation.R methods.R conclusion.R introduction.R results.R

otherRfiles = ./data/BindChromosomes.R ./data/hypervolumeMonteCarlo.R ./data/dominated.R ./data/import-GDMO.R ./data/eval_timings_GDMO.R ./data/NameLookup.R ./data/GDLS.R ./data/natural.R ./data/getChromosomes.R ./data/timing-prediction.R ./data/getNames.R 

datasets = ./data/FBAtimings.csv ./data/geo_m_react_plus.txt ./data/iaf1260-ac.txt ./data/geo_m_react.txt ./data/iJO1366_Ecoli_suc_aerobic.txt ./data/geo_s_react.txt

supplimentary = $(mainRfiles) $(otherRfiles) $(datasets) dissertation_nocode.pdf dissertation.pdf

knitrsource = dissertation.Rnw introduction.Rnw methods.Rnw results.Rnw conclusion.Rnw background.Rnw

dissertation.pdf : dissertation.tex bibliography.bib abstract.tex mystyle.sty
	pdflatex dissertation.tex
	bibtex dissertation.aux
	pdflatex dissertation.tex
	pdflatex dissertation.tex

dissertation_nocode.pdf : dissertation_nocode.tex bibliography.bib abstract.tex mystyle.sty
	pdflatex dissertation_nocode.tex
	bibtex dissertation_nocode.aux
	pdflatex dissertation_nocode.tex
	pdflatex dissertation_nocode.tex

#dissertation.tex : dissertation.Rnw abstract.tex introduction.tex methods.tex results.tex conclusion.tex
#	R CMD Sweave dissertation.Rnw

dissertation.tex introduction.tex methods.tex results.tex conclusion.tex background.tex: $(knitrsource)
	Rscript -e "require(knitr); knit('dissertation.Rnw')"

dissertation_nocode.tex introduction_nocode.tex methods_nocode.tex results_nocode.tex conclusion_nocode.tex background_nocode.tex: $(knitrsource)
	Rscript -e "require(knitr); opts_knit\$$set(echo=FALSE); knit('dissertation.Rnw','dissertation_nocode.tex')"

%.tex : %.Rnw
#	R CMD Sweave $<
	Rscript -e "require(knitr); knit('$<')"

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
	rm -f *.toc
	rm -f *.tdo
	rm -f *.lof
	rm -f *.lot
	rm -f *~

bibliography.bib : ../../Documents/bibtex/Part\ III\ project.bib
	cp ../../Documents/bibtex/Part\ III\ project.bib bibliography.bib

wordcount :
	texcount -total *.tex

$(mainRfiles) : $(knitrsource)
	Rscript -e "require(knitr); purl('$<',documentation=2)"



supplimentary.zip : $(supplimentary)
	zip $@ $?

supplimentary.tar : $(supplimentary)
	tar -uf supplimentary.tar $?

%.gz : %
	gzip $?

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
