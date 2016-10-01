.PHONY : dataset preprocess analysis report
PROJ = neurodevstat

dataset :
  python3 preprocessing/01_dumpData.py

preprocess :
  sh preprocessing/02_data.sh
  python3 preprocessing/03_fasta.py

analysis :
  R CMD BATCH ./src/01_rna.R
  R CMD BATCH ./src/02_vis.R

report :
  Rscript -3 "library(knitr); Rmarkdown::render('./reports/analysis.Rmd')"

all : dataset preprocess analysis report
