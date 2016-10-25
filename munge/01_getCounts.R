# load and clean quantified transcript outputfrom Kallisto pseudoalignment

rm(list = ls())
proj_dir <- paste0(path.expand("~"), "/git_repos/neurodevstat")
data_dir <- paste0(proj_dir, "/data/data_Jaffe2015/quantKallisto")

set.seed(6401^2)

library(dplyr)
library(data.table)
library(dtplyr)
library(readr)
library(tximport)
library(EnsDb.Hsapiens.v79)

# find data files, load, and combine via list manipulations
filenames <- list.files(path = data_dir, pattern = "abundance.tsv",
                        full.names = TRUE, recursive = TRUE)

data_list <- lapply( filenames, function(x) { read.csv(file = x, sep = "\t",
                                                       header = TRUE) } )

names(data_list) <- sapply(strsplit(filenames, "/"), function(x) {
  grep("SRR", x, value = TRUE) })

data_reduced <- lapply( data_list, function(x) {
  subset(x, select = c("target_id", "est_counts")) })

for (i in 1:length(data_reduced)) {
  colnames(data_reduced[[i]])[2] <- paste(names(data_reduced)[i],
                                          colnames(data_reduced[[i]])[2],
                                          sep = "_")
}

# build table of pseudocounts
pseudocounts <- Reduce(function(...) merge(..., by = "target_id"), data_reduced)

# save raw pseudocounts at the transcript level
data.table::fwrite(pseudocounts, paste0(proj_dir,
                                        "/data/pseudocounts_transcripts.csv"))


# summarize data from transcript to genes for modeling and inference
txdf <- transcripts(EnsDb.Hsapiens.v79, columns = c("tx_id", "gene_name"),
                    return.type = "DataFrame")
tx2gene <- as.data.frame(txdf)
txi <- tximport(filenames, type = "kallisto", tx2gene = tx2gene,
                reader = read_tsv)
pseudocounts_genes <- as.data.frame(txi$counts)
colnames(pseudocounts_genes) <- sapply(strsplit(filenames, split = "/"),
                                       function(x) x[9])
pseudocounts_genes$geneID <- rownames(pseudocounts_genes)
rownames(pseudocounts_genes) <- NULL

# save raw pseudocounts at the transcript level
data.table::fwrite(pseudocounts_genes, paste0(proj_dir,
                                              "/data/pseudocounts_genes.csv"))


# obtain pseudocount results scaled as transcripts per million (TpM)
txiTPM <- tximport(filenames, type = "kallisto", tx2gene = tx2gene,
                   reader = read_tsv, countsFromAbundance = "scaledTPM")
pseudocounts_TPM <- as.data.frame(txiTPM$counts)
colnames(pseudocounts_TPM) <- sapply(strsplit(filenames, split = "/"),
                                     function(x) x[9])
pseudocounts_TPM$geneID <- rownames(pseudocounts_TPM)
rownames(pseudocounts_TPM) <- NULL
