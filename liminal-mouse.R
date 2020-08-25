## ----init-----------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install(c("scran", "scater", "scRNAseq", "AnnotationHub", "ensembldb"))
suppressPackageStartupMessages(library(scater))
suppressPackageStartupMessages(library(scran))
library(ggplot2)
library(tourr)
source(here::here("display-sage.R"))
source(here::here("helpers.R"))

sce <- scRNAseq::MacoskoRetinaData(ensembl = TRUE)
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
var_explained <- tidy_var_explained(sce)
ggplot(var_explained, aes(x = component, y = var_explained)) +
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


library(dplyr)
set.seed(119460)
tour_data <- pc_df %>% 
  group_by(cluster_membership) %>% 
  sample_frac(size = 0.1) %>% 
  ungroup()

pal <- liminal::limn_pal_tableau20()
col <- pal[as.integer(tour_data$cluster_membership)]
set.seed(1990)

render_gif(
  data = dplyr::select(tour_data, -cluster_membership),
  tour_path = grand_tour(),
  display = display_xy(col = col),
  frames = 100,
  gif_file = "mouse-grand.gif"
  
)

set.seed(1990)
render_gif(data = dplyr::select(tour_data, -cluster_membership),
           tour_path = grand_tour(),
           display = display_sage(col = col),
           frames = 100,
           gif_file = "mouse-sage.gif"
)
          

# guided tour

# ---

# markers <- findMarkers(sce, 
#                        groups = colData(sce)$cluster_membership,
#                        direction = "up",
#                        lfc = 1,
#                        pval.type = "some")
# 
# marker_genes <- markers[[2]]
# 
# sub_sce <- sce[rownames(sce) %in% rownames(marker_genes)[1:10]]
# 
# exprs <- t(logcounts(sub_sce))
# colnames(exprs) <- rowData(sub_sce)$SYMBOL
# 
# tour_marker <- dplyr::bind_cols(
#   dplyr::as_tibble(as.matrix(exprs)),
#   cluster_membership = colData(sub_sce)$cluster_membership
# ) %>% 
#   janitor::clean_names() %>% 
#   slice(tour_data$inx)
# 
# limn_tour(tour_marker, 1:10, color = cluster_membership)
