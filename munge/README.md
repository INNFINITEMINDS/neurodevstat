# munge

> statistical preprocessing of cleaned RNA-seq read count data

All scripts intended for performing statistical preprocessing on tables of read
counts produced by the bioinformatical preprocessing scripts (housed in the
`preprocess` subdirectory). Scripts here do not need to be called directly, as a
simple call to `load.project()` (by scripts in the `src` directory) will
automatically run these preprocessing scripts.
