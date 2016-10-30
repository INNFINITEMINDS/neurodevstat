# build modeling weights using Limma's voom method

library(limma)
countsCutoff <- 10 # cutoff for mean of counts for dropping genes

# filter pseudocounts table before proceeding with analysis
pseudocounts_filtered <- pseudocounts_genes %>%
  dplyr::filter((rowMeans(.[, -ncol(.)]) > countsCutoff))

# remove outstanding genes with extremely high values
geneMaxInd <- unlist(unique(lapply(pseudocounts_filtered[, -13],
                                   FUN = which.max)))
pseudocounts_filtered <- pseudocounts_filtered[-geneMaxInd, ]

# get gene IDs for those remaining in the data set
geneIDs <- pseudocounts_filtered$geneID
pseudocounts_filtered <- subset(pseudocounts_filtered,
                                select = -c(geneID))

# apply Voom transform to filtered RNA-seq data with minimal design matrix
pdf(file = paste0(proj_dir, "/graphs/voomTrend_simple.pdf"))
v_simple <- voomWithQualityWeights(pseudocounts_filtered, design_simple,
                                   normalization = "scale", plot = TRUE,
                                   save.plot = TRUE)
dev.off()

# apply Voom transform to filtered RNA-seq data with full design matrix
pdf(file = paste0(proj_dir, "/graphs/voomTrend_full.pdf"))
v_full <- voomWithQualityWeights(pseudocounts_filtered, design_full,
                                 normalization = "scale", plot = TRUE,
                                 save.plot = TRUE)
dev.off()

# clean up workspace before moving on...
rm(list = setdiff(ls(), c("proj_dir", "data_dir", "geneIDs", "design_simple",
                          "design_full", "txi", "txiTPM", "pseudocounts_genes",
                          "pseudocounts_TPM", "pseudocounts_filtered", "v_full",
                          "v_simple")))
