## ----init-----------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install(c("scran", "scater", "scRNAseq", "AnnotationHub", "ensembldb"))
suppressPackageStartupMessages(library(scater))
suppressPackageStartupMessages(library(scran))
library(ggplot2)
library(tourr)
library(burningsage)

sce <- scRNAseq::MacoskoRetinaData(ensembl = FALSE)
# annotation ensembl database
anno_db <- AnnotationHub::AnnotationHub()[["AH73905"]] 
anno <- AnnotationDbi::select(anno_db, 
               keys=rownames(sce), 
               keytype="GENEID", columns=c("SYMBOL", "SEQNAME", "GENEBIOTYPE"))
rowData(sce) <- anno[match(rownames(sce), anno$GENEID), ]


## ----qc-------------------------------------------------------------
is.mito <- grepl("^mt-", rowData(sce)$SYMBOL)
qcstats <- perCellQCMetrics(sce, subsets=list(Mito=is.mito))
filtered <- quickPerCellQC(qcstats, percent_subsets="subsets_Mito_percent")
sce <- sce[, !filtered$discard]

## ----normalise-counts-----------------------------------------------
sce <- logNormCounts(sce)

## ----gene-selection-------------------------------------------------
dec <- modelGeneVar(sce) # fits mean-variance trend using `nls`.
hvg <- getTopHVGs(dec, prop=0.1) # selects ~10% of nrow(sce) that are HVGs



## ----pca------------------------------------------------------------
sce <- runPCA(sce, ncomponents = 25, subset_row = hvg)
# looking at elbow-plot looks like we get the first five PCs explain most of the 
# variation
var_explained <- data.frame(
  var_explained  = attr(reducedDim(object), "percentVar"),
  component = 1:25
)

ggplot(var_explained, 
       aes(x = component, y = var_explained)) +
  geom_point()

## ----cluster--------------------------------------------------------
# the recommended workflow is to use graph based clustering on the principal 
# components
g <- buildSNNGraph(sce, use.dimred = 'PCA')
colData(sce)$cluster_membership <- factor(igraph::cluster_louvain(g)$membership)

# extract PCs to tour and perform tSNE on, keep cluster labels too
pc_df <- reducedDim(sce, "PCA")
pc_df <- dplyr::as_tibble(pc_df)
pc_df$cluster_membership <- colData(sce)$cluster_membership
pc_df$inx <- seq_len(nrow(pc_df))

table(colData(sce)$cluster_membership)



# --- tour a subset of the data
library(dplyr)
set.seed(119460)
tour_data <- pc_df %>% 
  group_by(cluster_membership) %>% 
  sample_frac(size = 0.1) %>% 
  ungroup()

pal <- c("#4c78a8", "#9ecae9", "#f58518", "#ffbf79", "#54a24b",
           "#88d27a", "#b79a20", "#f2cf5b", "#439894", "#83bcb6",
           "#e45756", "#ff9d98", "#79706e", "#bab0ac", "#d67195",
           "#fcbfd2", "#b279a2", "#d6a5c9", "#9e765f", "#d8b5a5")

col <- pal[as.integer(tour_data$cluster_membership)]

set.seed(1990)
render_gif(
  data = dplyr::select(tour_data, -cluster_membership),
  tour_path = grand_tour(),
  display = display_xy(col = col, axes = "bottomleft"),
  frames = 100,
  gif_file = "mouse-grand.gif"
  
)

set.seed(1990)
render_gif(data = dplyr::select(tour_data, -cluster_membership),
           tour_path = grand_tour(),
           display = display_sage(axes = "bottomleft", col = col),
           frames = 100,
           gif_file = "mouse-sage.gif"
)