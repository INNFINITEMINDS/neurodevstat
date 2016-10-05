# download and index human genome (GRCH38) for use in pseudo-alignment procedure

wget http://bio.math.berkeley.edu/kallisto/transcriptomes/Homo_sapiens.GRCh38.rel79.cdna.all.fa.gz \
  -P ./data/

kallisto index -i ./data/Homo_sapiens.GRCh38.rel79.idx \
  ./data/Homo_sapiens.GRCh38.rel79.cdna.all.fa.gz
