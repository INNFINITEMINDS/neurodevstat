# build modeling weights using Limma's voom method

library(limma)

# filter pseudocounts table before proceeding with analysis
pseudocounts_filtered <- pseudocounts_genes %>%
  dplyr::filter((rowMeans(.[, -ncol(.)]) > countsCutoff))
geneIDs <- pseudocounts_filtered$geneID
pseudocounts_filtered <- subset(pseudocounts_filtered,
                                select = -c(geneID))
                                  
pdf(file = paste0(proj_dir, "/graphs/voomTrend_simple.pdf"))
v_simple <- voomWithQualityWeights(pseudocounts_filtered, design_simple,
                                   normalization = "none", plot = TRUE,
                                   save.plot = TRUE)
dev.off()

pdf(file = paste0(proj_dir, "/graphs/voomTrend_full.pdf"))
v_full <- voomWithQualityWeights(pseudocounts_filtered, design_full,
                                 normalization = "none", plot = TRUE,
                                 save.plot = TRUE)
dev.off()

# clean up workspace before moving on...
rm(list = setdiff(ls(), c("proj_dir", "data_dir", "geneIDs", "design_simple",
                          "design_full", "txi", "txiTPM", "pseudocounts_genes",
                          "pseudocounts_TPM", "pseudocounts_filtered", "v_full",
                          "v_simple")))
