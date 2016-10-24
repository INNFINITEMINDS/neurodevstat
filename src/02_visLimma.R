# visualize results from statistical analysis via Limma

library(NMF)
library(ggplot2)
library(wesanderson)
pal <- wes_palette("Chevalier", 2, type = "discrete")
no_topgenes <- 25

# make ggplot of mean-variance trend from limma::voom structure
points <- data.frame(cbind(data.frame(v_simple$voom.xy)[, c(1, 2)],
                           tt$adj.P.Val))
pdf(file = paste0(proj_dir, "/graphs/meanVarVoom_trend.pdf"))
p_voom <- ggplot(points, aes(x, y)) + xlab(v_simple$voom.xy$xlab) +
  ylab(v_simple$voom.xy$ylab) + geom_point() + geom_smooth() +
  ggtitle(paste("Mean-Variance Trend (Fetal vs. Adult)",
                "\n (from Voom method of Limma)")) +
  theme_nima()
dev.off()


# make heatmap of top genes from weighted Limma with intercept and exposure
tt_out_ranked <- tt_out[order(tt_out$fdrBH), ]
tt_topgenes <- tt_out_ranked[1:no_topgenes, ]
exprs <- as.matrix(v_simple$E[as.numeric(row.names(tt_topgenes)), ])
colnames(exprs) <- substr(colnames(exprs), 1, 10)
row.names(exprs) <- tt_topgenes$ID

label <- data.frame(Type = ifelse(design_simple$type == 0, "Adult", "Fetal"))
rownames(label) <- substr(colnames(exprs), 1, 10)

nmf.options(grid.patch = TRUE)
pdf(file = paste0(getwd(), "/graphs/heatmap_top25genes.pdf"))
aheatmap(exprs, scale = "row", annCol = label, annColors = "Set2",
         main = "Heatmap of Top 25 Genes (by FDR)")
dev.off()
