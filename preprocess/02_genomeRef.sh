# downloading the human genome (build 19) for use in alignment procedure

# extracting genome data
if [ -e ~/genomeRef/ensembl-hsapiens/GRCh37-hg19 ]; then
  rm -rf ~/genomeRef/ensembl-hsapiens/GRCh37-hg19;
fi


wget ftp://ftp.ensembl.org/pub/release-75/fasta/homo_sapiens/dna/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa.gz

gunzip Homo_sapiens.GRCh37.75.dna.primary_assembly.fa.gz
