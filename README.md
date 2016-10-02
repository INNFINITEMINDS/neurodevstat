# Curated (re)analysis of Neural RNA-seq data

[![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)

> Materials from a fully reproducible, curated (re)analysis of public RNA-seq
> data from a study examining the development of the human cortex.

---

## Summary

This is a fully curated, computationally reproducible, statistical re-analysis
of the RNA-Seq data set collected for and originally analyzed in the Jaffe _et
al._ paper cited below.

---

## References

1. [A.E. Jaffe _et al._. "Developmental regulation of human cortex transcription
    and its clinical relevance at base resolution." _Nature Neuroscience_,
    2014](http://www.nature.com/neuro/journal/v18/n1/abs/nn.3898.html).

2. [N.L. Bray, H. Pimentel, P. Melsted, and L. Pachter. "Near optimal
    probabilistic RNA-seq quantification." _Nature Biotechnology_, 34,
    2016.](http://www.nature.com/nbt/journal/v34/n5/full/nbt.3519.html)

3. [C.W. Law, Y. Chen, W. Shi, and G.K. Smyth. "voom: precision weights unlock
    linear model analysis tools for RNA-seq read counts." _Genome Biology_,
    15(2), 2014.](https://genomebiology.biomedcentral.com/articles/10.1186/gb-2014-15-2-r29)

4. [G.K. Smyth. "Linear models and empirical Bayes methods for assessing
    differential expression in microarray experiments." _Statistical
    Applications in Genetics and Molecular Biology_, 3(1),
    2004.](http://www.statsci.org/smyth/pubs/ebayes.pdf)

---

## Requirements

* `fastq-dump` - utility for converting SRA data to the FASTQ format

* `python3` - a working installation of Python v3.5+ as a glue language

* `kallisto` - probabilistic pseudo-aligner for quantifying RNA-seq reads

* `R` - a working installation of R v3.3+ is used for statistical analyses

---

## Notes

This work was produced as part of  my participation in the [Genomic Data
Science Capstone](https://www.coursera.org/learn/genomic-data-science-project),
a part of the [_Genomic Big Data Science
Specialization_](https://www.coursera.org/specializations/genomic-data-science)
offered by the Johns Hopkins University, on Coursera.

---

## License

&copy; 2016 [Nima Hejazi](http://nimahejazi.org)

This repository is licensed under the MIT license. See `LICENSE` for details.
