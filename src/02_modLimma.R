# fit linear models to each gene using voom with simple design matrix
vfit_simple <- limma::lmFit(v_simple)
vfit_simple <- limma::eBayes(vfit_simple)
tt1 <- limma::topTable(vfit_simple,
                       coef = which(colnames(design_simple) == "type"),
                       adjust.method = "BH", number = Inf,
                       sort.by = "none", confint = TRUE)

# clean up topTable output to generate results tables
tt_out1 <- tt1 %>%
  dplyr::mutate(
    geneID = geneIDs,
    lowerCI = exp(CI.L),
    FoldChange = exp(logFC),
    upperCI = exp(CI.R),
    pvalue = I(P.Value),
    fdrBH = I(adj.P.Val)
  ) %>%
  dplyr::select(which(colnames(.) %ni% colnames(tt)))

data.table::fwrite(data.table(data.frame(tt_out1)),
                   file = paste0(proj_dir, "/results/ttLimma_simplemod.csv"))


# fit linear models to each gene using voom with the full design matrix
vfit_full <- limma::lmFit(v_full)
vfit_full <- limma::eBayes(vfit_full)
tt2 <- limma::topTable(vfit_full,
                       coef = which(colnames(design_full) == "type"),
                       adjust.method = "BH", number = Inf,
                       sort.by = "none", confint = TRUE)

# clean up topTable output to generate results tables
tt_out2 <- tt2 %>%
  dplyr::mutate(
    geneID = geneIDs,
    lowerCI = exp(CI.L),
    FoldChange = exp(logFC),
    upperCI = exp(CI.R),
    pvalue = I(P.Value),
    fdrBH = I(adj.P.Val)
  ) %>%
  dplyr::select(which(colnames(.) %ni% colnames(tt2)))

data.table::fwrite(data.table(data.frame(tt_out2)),
                   file = paste0(proj_dir, "/results/ttLimma_fullmod.csv"))


#test <- fread(paste0(proj_dir, "/results/ttLimma_fullmod.csv"))
#test_clean <- test %>%
#  dplyr::arrange(., fdrBH) %>%
#  dplyr::mutate(
#    geneID = geneID,
#    FoldChange = I(FoldChange),
#    pvalueRaw = I(pvalue),
#    pvalueAdj = I(fdrBH)
#  ) %>%
#  dplyr::select(which(colnames(.) %in% c("geneID", "FoldChange", "pvalueRaw",
#                                         "pvalueAdj")))
#data.table::fwrite(test_clean, file = paste0(proj_dir, "/resultSubmit.tsv"),
#                   sep = "\t")