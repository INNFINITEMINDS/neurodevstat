.PHONY : all

dataSRA :
	python preprocess/01_dumpData.py

dataFQ :
	sh preprocess/02_getDataFQ.py

pseudoalign :
	sh preprocess/03_refGenome.sh
	sh preprocess/04_pseudoAlign.py

analysis :
	R CMD BATCH src/01_setAnalysis.R
	R CMD BATCH src/02_fitAnalysis.R
	R CMD BATCH src/03_visAnalysis.R

report :
	Rscript -e "library(knitr); Rmarkdown::render('reports/analysis.Rmd')"

all : dataFQ pseudoalign analysis report
