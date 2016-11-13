# Gene Set Analysis (incomplete)

library("AnnotationHub")

# reduce list of differentially expressed genes from analysis
genes.sig <- tt_out_ranked %>%
  subset(fdrBH < 0.25)

# set up Annotation Hub for extracting metadata
ah <- AnnotationHub()
ah <- subset(ah, species == "Homo sapiens")
qhs <- query(ah, "H3K4me3")
roadmap <- subset(qhs, dataprovider == "BroadInstitute")

# get genes with H3K4me3 in Brain cells
brain <- query(roadmap, "Brain")
gr.brain <- subset(brain, title == brain$title[[11]])[[1]]

# get genes with H3K4me3 in Liver cells
liver <- query(roadmap, "Liver")
gr.liver <- subset(liver, title == liver$title[[2]])[[1]]

# get promoters of genes from RefSeq (conservative) annotation
qhs <- query(ah, "RefSeq")
refseq <- qhs[qhs$genome == "hg19" & qhs$title == "RefSeq Genes"]
refseq <- refseq[[1]]
promoters <- promoters(refseq)
prom.reds <- reduce(promoters, ignore.strand = TRUE)

# for peaks found in brain cell lines
ov.brain <- findOverlaps(promoters, gr.brain)
peaks.brain <- reduce(gr.brain)
int.brain <- intersect(prom.reds, peaks.brain)

# for peaks found in liver cell lines
ov.liver <- findOverlaps(promoters, gr.liver)
peaks.liver <- reduce(gr.liver)
int.liver <- intersect(prom.reds, peaks.liver)