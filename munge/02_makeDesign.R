# build design matrices for "simple" and "full" linear modeling analysis

codebook <- data.table::fread(paste0(proj_dir, "/data/codebook.csv"))
phenodata <- data.table::fread(paste0(proj_dir, "/data/phenodata.tsv"),
                               sep = "\t")

n = nrow(codebook) #sample size
countsCutoff <- 10 # cutoff for mean of counts for dropping genes

# build simple design matrix for first pass analysis
subj_type <- codebook$Sample_Type[order(as.numeric(substr(codebook$run_ID_1,
                                                          4, 10)))]
design_simple <- data.frame(cbind(rep(1, n),
                                  (as.numeric(as.factor(subj_type)) - 1)))
colnames(design_simple) <- c("intercept", "type")


# build full design matrix for linear modeling analysis
pData <- merge(data.table(phenodata), data.table(codebook),
               by.x = "sample_ID", by.y = "Sample_ID")
design_full <- pData %>%
  dplyr::mutate(
    intercept = rep(1, nrow(.)),
    type = (as.numeric(as.factor(pData$Sample_Type)) - 1),
    age = I(age),
    sex = ifelse(sex == "male", 0, 1),
    race = (as.numeric(as.factor(race)) - 1),
    RIN = I(RIN)
  ) %>%
  dplyr::select(which(colnames(.) %in% c("intercept", "type", "age", "sex",
                                         "race", "RIN")))
design_full <- data.frame(design_full$intercept, design_full$type,
                          design_full$sex, design_full$age, design_full$race,
                          design_full$RIN)
colnames(design_full) <- c("intercept", "type", "sex", "age", "race", "RIN")
design_full <- as.data.frame(sapply(design_full, as.numeric))
