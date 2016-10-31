# visualize results from statistical analysis via Limma

library(NMF)
library(ggplot2)
no_topgenes <- 25


# MDS quality plot to examine whether subject specific weights are necessary
pdf(file = paste0(proj_dir, "/graphs/mds_samples.pdf"))
plotMDS(pseudocounts_filtered, pch = 19,
        col = ifelse(design_simple$type == 0, pal1[1], pal1[2]),
        labels = colnames(pseudocounts_filtered),
        main = "MDS Plot of Samples")
legend("topleft", legend = c("Adult", "Fetal"),
       col = c(pal1[1], pal1[2]), pch = 19)
dev.off()


# make heatmap of top genes from weighted Limma with intercept and exposure
tt_out_ranked <- tt_out1[order(tt_out1$fdrBH), ]
tt_topgenes <- tt_out_ranked[1:no_topgenes, ]
exprs <- as.matrix(v_simple$E[as.numeric(row.names(tt_topgenes)), ])
colnames(exprs) <- substr(colnames(exprs), 1, 10)
rownames(exprs) <- tt_topgenes$geneID

label <- data.frame(Type = ifelse(design_simple$type == 0, "Adult", "Fetal"))
rownames(label) <- substr(colnames(exprs), 1, 10)

# heatmap of top 25 genes across samples
nmf.options(grid.patch = TRUE)
pdf(file = paste0(getwd(), paste0("/graphs/heatmap_top", no_topgenes,
                                  "genes_simplemod.pdf")))
aheatmap(exprs, scale = "row", annCol = label, annColors = "Set2",
         main = paste("Heatmap of Top", no_topgenes,
                      "Genes \n (ranked by FDR)"))
dev.off()

# make heatmap of top genes from weighted Limma with full model
tt_out_ranked <- tt_out2[order(tt_out2$fdrBH), ]
tt_topgenes <- tt_out_ranked[1:no_topgenes, ]
exprs <- as.matrix(v_full$E[as.numeric(row.names(tt_topgenes)), ])
colnames(exprs) <- substr(colnames(exprs), 1, 10)
rownames(exprs) <- tt_topgenes$geneID

label <- data.frame(Type = ifelse(design_simple$type == 0, "Adult", "Fetal"))
rownames(label) <- substr(colnames(exprs), 1, 10)

# heatmap of top 25 genes across samples from full model
nmf.options(grid.patch = TRUE)
pdf(file = paste0(getwd(), paste0("/graphs/heatmap_top", no_topgenes,
                                  "genes_fullmod.pdf")))
aheatmap(exprs, scale = "row", annCol = label, annColors = "Set2",
         main = paste("Heatmap of Top", no_topgenes,
                      "Genes \n (ranked by FDR)"))
dev.off()


# volcano plot of fold change results by genes from simple model
tt_out1_gg <- tt_out1 %>%
  dplyr::mutate(
    geneID = I(geneID),
    logFC = log2(FoldChange),
    logPval = -log10(pvalue),
    color = ifelse((logFC > 2.0) & (logPval > 1.3), "1",
                   ifelse((logFC < -2.0) & (logPval > 1.3), "-1", "0"))
  ) %>%
  dplyr::select(which(colnames(.) %in% c("geneID", "logFC", "logPval",
                                         "color")))
pdf(file = paste0(getwd(), paste0("/graphs/volcano_simplemod_genes.pdf")))
p3 <- ggplot(tt_out1_gg, aes(x = logFC, y = logPval)) +
  geom_point(aes(colour = color)) +
  xlab("log2(Fold Change)") + ylab("-log10(raw p-value)") +
  ggtitle("Volcano Plot \n (from simple model)") +
  scale_colour_manual(values = pal2[1:3], guide = FALSE)
print(p3)
dev.off()

# volcano plot of fold change results by genes from full model
tt_out2_gg <- tt_out2 %>%
  dplyr::mutate(
    geneID = I(geneID),
    logFC = log2(FoldChange),
    logPval = -log10(pvalue),
    color = ifelse((logFC > 2.0) & (logPval > 1.3), "1",
                   ifelse((logFC < -2.0) & (logPval > 1.3), "-1", "0"))
  ) %>%
  dplyr::select(which(colnames(.) %in% c("geneID", "logFC", "logPval",
                                         "color")))
pdf(file = paste0(getwd(), paste0("/graphs/volcano_fullmod_genes.pdf")))
p4 <- ggplot(tt_out2_gg, aes(x = logFC, y = logPval)) +
  geom_point(aes(colour = color)) +
  xlab("log2(Fold Change)") + ylab("-log10(raw p-value)") +
  ggtitle("Volcano Plot \n (from full model)") +
  scale_colour_manual(values = pal2[1:3], guide = FALSE)
print(p4)
dev.off()
