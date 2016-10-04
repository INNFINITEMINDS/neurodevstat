.PHONY : all

dataSRA :
	python preprocess/01_dumpData.py

dataFQ :
	sh preprocess/02_getDataFQ.py

reference :
	sh preprocess/03_refGenome.sh

pseudoalign :
	sh preprocess/04_pseudoAlign.sh

analysis :
	R CMD BATCH src/01_setAnalysis.R
	R CMD BATCH src/02_fitAnalysis.R
	R CMD BATCH src/03_visAnalysis.R

report :
	Rscript -e "library(knitr); Rmarkdown::render('reports/analysis.Rmd')"

all : dataFQ reference pseudoalign analysis report
