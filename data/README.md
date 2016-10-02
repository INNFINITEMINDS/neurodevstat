# data

> The publicly available data from the _Jaffe et al._ study, used in this
> re-analysis study

---

## Notes

* Scripts in this directory can be used to download the appropriate files from
    the NCBI database in `sra` format.

* The `sra` files must then be converted to `fastq` format so that alignment can
    be performed.

* Since downloading the data via `http` takes significantly longer than, the
    Cyberduck tool was used to directly download the data from the NCBI `ftp`
    site. Directions for obtaining the `ftp` addresses are [available
    here](https://www.biostars.org/p/93494/).
