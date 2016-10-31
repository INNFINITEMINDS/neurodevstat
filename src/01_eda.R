# perform elementary EDA on pseudocounts produced by Kallisto pseudoaligner

library(ProjectTemplate)
ProjectTemplate::load.project()
library(reshape2)
library(ggbiplot)
library(wesanderson)
pal1 <- wes_palette("Chevalier", n = 2, type = "discrete")
pal2 <- wes_palette("Darjeeling", type = "continuous")

# boxplot examining arrays before normalization
counts.raw <- reshape2::melt(pseudocounts_filtered)
pdf(file = paste0(proj_dir, "/graphs/boxplot_counts_raw.pdf"))
p1 <- ggplot(data = counts.raw, aes(x = variable, y = value)) +
  geom_boxplot() + xlab("") + ylab("Counts") +
  ggtitle("Boxplot of Raw (Pseudo)Counts") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(p1)
dev.off()

# boxplot examining arrays after normalization
pseudocounts_filtNorm <- normalizeBetweenArrays(pseudocounts_filtered,
                                                method = "scale")
counts.norm <- reshape2::melt(data.frame(pseudocounts_filtNorm))
pdf(file = paste0(proj_dir, "/graphs/boxplot_counts_norm.pdf"))
p2 <- ggplot(data = counts.norm, aes(x = variable, y = value)) +
  geom_boxplot() + xlab("") + ylab("Counts") +
  ggtitle(paste("Boxplot of Normalized (Pseudo)Counts",
                "\n (normalization method = median)")) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(p2)
dev.off()

# principal component decomposition of filtered + normalized counts
pseudocounts_pc <- prcomp(t(pseudocounts_filtNorm),
                          center = TRUE, scale. = TRUE)

# PCA biplots of filtered + normalized counts
pdf(file = paste0(proj_dir, "/graphs/pca_biplot_type.pdf"))
g1 <- ggbiplot(pseudocounts_pc, obs.scale = 1, var.scale = 1, 
               groups = ifelse(design_full$type == 1, "Adult", "Fetal"),
               var.axes = FALSE, ellipse = FALSE, circle = FALSE)
g1 <- g1 + scale_color_manual(values = pal1, name = "type")
g1 <- g1 + ggtitle("PCA Biplot of Samples")
print(g1)
dev.off()

pdf(file = paste0(proj_dir, "/graphs/pca_biplot_sex.pdf"))
g2 <- ggbiplot(pseudocounts_pc, obs.scale = 1, var.scale = 1, 
               groups = ifelse(design_full$sex == 1, "Female", "Male"),
               var.axes = FALSE, ellipse = FALSE, circle = FALSE)
g2 <- g2 + scale_color_manual(values = pal1, name = "sex")
g2 <- g2 + ggtitle("PCA Biplot of Samples")
print(g2)
dev.off()

pdf(file = paste0(proj_dir, "/graphs/pca_biplot_race.pdf"))
g3 <- ggbiplot(pseudocounts_pc, obs.scale = 1, var.scale = 1, 
               groups = ifelse(design_full$race == 1, "HISP", "AA"),
               var.axes = FALSE, ellipse = FALSE, circle = FALSE)
g3 <- g3 + scale_color_manual(values = pal1, name = "race")
g3 <- g3 + ggtitle("PCA Biplot of Samples")
print(g3)
dev.off()

pdf(file = paste0(proj_dir, "/graphs/pca_biplot_RIN.pdf"))
g4 <- ggbiplot(pseudocounts_pc, obs.scale = 1, var.scale = 1,
               groups = cut(design_full$RIN,
                            seq(min(design_full$RIN) - 0.5,
                                max(design_full$RIN) + 0.5, 1.25)),
               var.axes = FALSE, ellipse = FALSE, circle = FALSE)
g4 <- g4 + scale_color_manual(values = pal2, name = "RIN")
g4 <- g4 + ggtitle("PCA Biplot of Samples")
print(g4)
dev.off()