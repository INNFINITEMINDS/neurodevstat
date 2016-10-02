# data

> The publicly available data from the _Jaffe et al._ study, used in this
> re-analysis study

---

## Notes

* Scripts in this directory can be used to download the appropriate data files
    from the NCBI database in `sra` format.

* The `sra` files must then be converted via
    ([fastq-dump](https://www.ncbi.nlm.nih.gov/books/NBK158900/)) to `fastq`
    format so that alignment can be performed.

* While scripts are provided here for downloading the data in `sra` format,
    Cyberduck or similar utilities can be used to directly download from the
    NCBI `ftp` site. Directions for obtaining the `ftp` addresses are [available
    here](https://www.biostars.org/p/93494/).

---

## Tips

* Largely because the `sra` binary format is a pain in the ass to deal with, it
    is recommended that other resources be used to acquire the reads in `fastq`
    format; in particular, consider consulting these resources:
    * [__Japan SRA mirror__](http://trace.ddbj.nig.ac.jp/dra/index_e.html) - has
        not completely adopted the `sra` format, with many data files still
        being available in `fastq` format.
    * [__European Nucleotide Archive__](http://www.ebi.ac.uk/ena) - provides a
        large collection of data sets in `fastq` format.
    * [Biostars thread on `fastq-dump` speed
        issues](https://www.biostars.org/p/91885/)
