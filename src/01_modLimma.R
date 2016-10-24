# setting up necessary preliminaries for statistical analysis

library(ProjectTemplate)
load.project()

# fit linear models to each gene using voom with simple design matrix
vfit_simple <- limma::lmFit(v_simple)
vfit_simple <- limma::eBayes(vfit_simple)
tt <- limma::topTable(vfit_simple,
                      coef = which(colnames(design_simple) == "type"),
                      adjust.method = "BH", number = Inf,
                      sort.by = "none", confint = TRUE)

# clean up topTable output to generate results tables
tt_out <- tt %>%
  dplyr::mutate(
    ID = pseudocounts_filtered$target_id,
    lowerCI = exp(CI.L),
    FoldChange = exp(logFC),
    upperCI = exp(CI.R),
    pvalue = I(P.Value),
    fdrBH = I(adj.P.Val)
  ) %>%
  dplyr::select(which(colnames(.) %ni% colnames(tt)))

data.table::fwrite(data.table(data.frame(tt_out)),
                   file.path = paste0(proj_dir, "/results/ttLimma_simple.csv"))
