.PHONY : all

dataset :
	python preprocessing/01_dumpData.py

reference :
	sh preprocess/02_refGenome.sh

preprocessing :
	sh preprocess/02_bowtieAlign.sh
	sh preprocess/03_makeCounts.sh
	sh preprocess/04_wrapScripts.sh

analysis :
	ssh nhejazi@bluevelvet.biostat.berkeley.edu \
		'cd ~/$(PROJ); R CMD BATCH ./src/01_sgRNAlimma.R'
	ssh nhejazi@bluevelvet.biostat.berkeley.edu \
		'cd ~/$(PROJ); R CMD BATCH ./src/02_visLimma.R'

report :
	Rscript -e "library(knitr); Rmarkdown::render('reports/analysis.Rmd')"

all : dataset reference preprocessing analysis report
