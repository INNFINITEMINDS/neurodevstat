# set up design matrix and build modeling weights using Limma's voom method

# first import supporting data files needed for analysis
codebook <- data.table::fread(paste0(proj_dir, "/data/codebook.csv"))
phenodata <- data.table::fread(paste0(proj_dir, "/data/phenodata.tsv"),
                               sep = "\t")

n = nrow(codebook) #sample size
countsCutoff <- 10 # cutoff for mean of counts for dropping genes

# build simple design matrix for first pass analysis
subj_type <- codebook$Sample_Type[order(as.numeric(substr(codebook$run_ID_1,
                                                          4, 10)))]
design_simple <- data.frame(cbind(rep(1, n),
                                  (as.numeric(as.factor(subj_type)) - 1)))
colnames(design_simple) <- c("intercept", "type")


# filter pseudocounts table before proceeding with analysis
library(limma)
pseudocounts_filtered <- pseudocounts %>%
  dplyr::filter((rowMeans(.[, -1]) > countsCutoff))

v_simple <- voomWithQualityWeights(pseudocounts_filtered[, -1], design_simple,
                 normalization = "none", plot = TRUE, save.plot = TRUE)


# clean up workspace before moving on...
rm(list = setdiff(ls(), c("v_simple", "proj_dir", "data_dir", "design_simple",
                          "codebook", "phenodata", "pseudocounts_filtered")))
