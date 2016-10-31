# visualize results from statistical analysis via Limma

library(NMF)
library(ggplot2)
no_topgenes <- 25

# examine whether subject specific weights might be necessary
pdf(file = paste0(proj_dir, "/graphs/samples_MDS.pdf"))
plotMDS(pseudocounts_filtered, pch = 19,
        col = ifelse(design_simple$type == 0, pal1[1], pal1[2]),
        labels = colnames(pseudocounts_filtered),
        main = "MDS Plot of Samples")
legend("topleft", legend = c("Adult", "Fetal"),
       col = c(pal1[1], pal1[2]), pch = 19)
dev.off()


# make heatmap of top genes from weighted Limma with intercept and exposure
tt_out_ranked <- tt_out[order(tt_out$fdrBH), ]
tt_topgenes <- tt_out_ranked[1:no_topgenes, ]
exprs <- as.matrix(v_simple$E[as.numeric(row.names(tt_topgenes)), ])
colnames(exprs) <- substr(colnames(exprs), 1, 10)
rownames(exprs) <- tt_topgenes$geneID

label <- data.frame(Type = ifelse(design_simple$type == 0, "Adult", "Fetal"))
rownames(label) <- substr(colnames(exprs), 1, 10)

nmf.options(grid.patch = TRUE)
pdf(file = paste0(getwd(), paste0("/graphs/heatmap_top", no_topgenes,
                                  "genes.pdf")))
aheatmap(exprs, scale = "row", annCol = label, annColors = "Set2",
         main = paste("Heatmap of Top", no_topgenes,
                      "Genes \n (ranked by FDR)"))
dev.off()
