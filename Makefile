.PHONY : all

dataset :
	python3 preprocessing/01_dumpData.py

preprocess :
	sh preprocessing/02_bowtieAlign.sh
	sh preprocessing/03_makeCounts.sh
	sh preprocessing/04_wrapScripts.sh

analysis :
	ssh nhejazi@bluevelvet.biostat.berkeley.edu \
		'cd ~/$(PROJ); R CMD BATCH ./src/01_sgRNAlimma.R'
	ssh nhejazi@bluevelvet.biostat.berkeley.edu \
		'cd ~/$(PROJ); R CMD BATCH ./src/02_visLimma.R'

report :
	Rscript -e "library(knitr); Rmarkdown::render('reports/analysis.Rmd')"

all : dataset preprocess analysis report
