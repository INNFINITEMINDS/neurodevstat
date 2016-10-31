.PHONY : analysis

dataSRA :
	python preprocess/01_dumpData.py

dataFQ :
	sh preprocess/02_getDataFQ.py

pseudoalign :
	sh preprocess/03_refGenome.sh
	python3 preprocess/04_pseudoAlign.py

analysis :
	R CMD BATCH src/01_eda.R
	R CMD BATCH src/02_modLimma.R
	R CMD BATCH src/03_visLimma.R

all : pseudoalign analysis
