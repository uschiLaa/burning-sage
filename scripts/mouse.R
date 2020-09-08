## ----init-----------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install(c("scran", "scater", "scRNAseq", "AnnotationHub", "ensembldb", "igraph"))
suppressPackageStartupMessages(library(scater))
suppressPackageStartupMessages(library(scran))
library(ggplot2)
library(tourr)
library(here)
library(burningsage)

sce <- scRNAseq::MacoskoRetinaData(ensembl = FALSE)
# annotation ensembl database
ah <-  AnnotationHub::AnnotationHub()
anno_db <- ah[["AH73905"]] 
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
  var_explained  = attr(reducedDim(sce), "percentVar"),
  component = 1:25
)

ggplot(var_explained, 
       aes(x = component, y = var_explained)) +
  geom_point()

## ----cluster--------------------------------------------------------
# the recommended workflow is to use graph based clustering on the principal 
# components
g <- buildSNNGraph(sce, use.dimred = 'PCA')
labels <- igraph::cluster_louvain(g)
colData(sce)$cluster_membership <- factor(labels$membership)

# extract PCs to tour and perform tSNE on, keep cluster labels too
pc_df <- reducedDim(sce, "PCA")
pc_df <- dplyr::as_tibble(pc_df)
pc_df$cluster_membership <- colData(sce)$cluster_membership
pc_df$inx <- seq_len(nrow(pc_df))

# look at groups
table(colData(sce)$cluster_membership)

pal <- c("#4c78a8", "#9ecae9", "#f58518", "#ffbf79", "#54a24b",
         "#88d27a", "#b79a20", "#f2cf5b", "#439894", "#83bcb6",
         "#e45756", "#ff9d98", "#79706e", "#bab0ac", "#d67195",
         "#fcbfd2", "#b279a2", "#d6a5c9", "#9e765f", "#d8b5a5")

ggplot(pc_df, aes(x = PC1, y = PC2, color = cluster_membership)) + 
  geom_point() + 
  scale_color_manual(values = pal) +
  theme_bw() 
                                                                                                                             "#88d27a", "#b79a20", "#f2cf5b", "#439894", "#83bcb6",
                                                                                                                             "#e45756", "#ff9d98", "#79706e", "#bab0ac", "#d67195",
                                                                                                                             "#fcbfd2", "#b279a2", "#d6a5c9", "#9e765f", "#d8b5a5")) 

# --- tour a subset of the data, focus on two clusters that are concentrated towards the center, 
# which is kind of obscured by everything else
library(dplyr)
set.seed(119460)
tour_data <- pc_df %>% 
  group_by(cluster_membership) %>% 
  sample_frac(size = 0.1) %>% 
  ungroup()

col <- ifelse(as.integer(tour_data$cluster_membership) == 9, 
              pal[9], 
              "grey90")

set.seed(1990)
render_gif(
  data = dplyr::select(tour_data, PC1:PC5, -cluster_membership),
  tour_path = grand_tour(),
  display = display_xy(col = col, axes = "bottomleft"),
  frames = 100,
  gif_file = here("gifs", "mouse_grand.gif")
  
)

# default
set.seed(1990)
render_gif(data = dplyr::select(tour_data, PC1:PC5, -cluster_membership),
           tour_path = grand_tour(),
           display = display_sage(axes = "bottomleft", col = col),
           frames = 100,
           gif_file = here("gifs", "mouse_sage_default.gif")
)


set.seed(1990)
render_gif(data = dplyr::select(tour_data, PC1:PC5, -cluster_membership),
           tour_path = grand_tour(),
           display = display_sage(axes = "bottomleft", col = col, gam = 3),
           frames = 100,
           gif_file = here("gifs", "mouse_sage_gam3.gif")
)
