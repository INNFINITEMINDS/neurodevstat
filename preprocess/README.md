# preprocess

> Scripts and information for preparing RNA-seq data from the Jaffe _et al._
> study to use in this re-analysis project

---

## Directions

* `01_dumpData.py` - downloads RNA-seq data for each subject in `sra` format,
    then converts data to `fastq`.

* `02_getDataFQ.py` - downloads prepared RNA-seq data in the form of gzipped
    `fastq` files from Dropbox.

* `03_refGenome.sh` - downloads a public version of the _Homo sapiens_ reference
    genome and performs indexing for kallisto.

* `04_pseudoAlign.py` - uses the previously prepared genomic index to perform
    pseudo-alignment on all paired-end RNA-seq `fastq` files.
