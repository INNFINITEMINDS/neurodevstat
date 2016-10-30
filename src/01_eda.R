# perform elementary EDA on pseudocounts produced by Kallisto pseudoaligner

library(ProjectTemplate)
ProjectTemplate::load.project()
library(ggbiplot)
library(wesanderson)
pal <- wes_palette("Chevalier", n = 2, type = "discrete")

# boxplot examining arrays before normalization
pdf(file = paste0(proj_dir, "/graphs/boxplot_counts_raw.pdf"))
boxplot(pseudocounts_filtered)
dev.off()

# boxplot examining arrays after normalization
pseudocounts_filtNorm <- normalizeBetweenArrays(pseudocounts_filtered,
                                                method = "scale")
pdf(file = paste0(proj_dir, "/graphs/boxplot_counts_norm.pdf"))
boxplot(pseudocounts_filtNorm)
dev.off()

# principal component decomposition of filtered + normalized counts
pseudocounts_pc <- prcomp(t(pseudocounts_filtNorm),
                          center = TRUE, scale. = TRUE)

# PCA biplots of filtered + normalized counts
pdf(file = paste0(proj_dir, "/graphs/pca_biplot_type.pdf"))
g1 <- ggbiplot(pseudocounts_pc, obs.scale = 1, var.scale = 1, 
               groups = ifelse(design_full$type == 1, "Adult", "Fetal"),
               var.axes = FALSE, ellipse = FALSE, circle = FALSE)
g1 <- g1 + scale_color_manual(values = pal, name = "type")
g1 <- g1 + ggtitle("PCA Biplot of Samples")
print(g1)
dev.off()

pdf(file = paste0(proj_dir, "/graphs/pca_biplot_sex.pdf"))
g2 <- ggbiplot(pseudocounts_pc, obs.scale = 1, var.scale = 1, 
               groups = ifelse(design_full$sex == 1, "Female", "Male"),
               var.axes = FALSE, ellipse = FALSE, circle = FALSE)
g2 <- g2 + scale_color_manual(values = pal, name = "sex")
g2 <- g2 + ggtitle("PCA Biplot of Samples")
print(g2)
dev.off()

pdf(file = paste0(proj_dir, "/graphs/pca_biplot_race.pdf"))
g3 <- ggbiplot(pseudocounts_pc, obs.scale = 1, var.scale = 1, 
               groups = ifelse(design_full$race == 1, "HISP", "AA"),
               var.axes = FALSE, ellipse = FALSE, circle = FALSE)
g3 <- g3 + scale_color_manual(values = pal, name = "race")
g3 <- g3 + ggtitle("PCA Biplot of Samples")
print(g3)
dev.off()
