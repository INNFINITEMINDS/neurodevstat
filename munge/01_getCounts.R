# load and clean quantified transcript outputfrom Kallisto pseudoalignment

rm(list = ls())
proj_dir <- paste0(path.expand("~"), "/git_repos/neurodevstat")
data_dir <- paste0(proj_dir, "/data/data_Jaffe2015/quantKallisto")

library(data.table); library(dplyr); library(dtplyr)
set.seed(6401^2)

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

# save raw data set
data.table::fwrite(pseudocounts, paste0(getwd(), "/data/pseudocounts_raw.csv"))
