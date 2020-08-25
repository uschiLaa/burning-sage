# pdfsense example
library(liminal)
library(tourr)
data(pdfsense)


pcs  <- prcomp(pdfsense[, 7:ncol(pdfsense)])


pdfsense <- dplyr::bind_cols(
  pdfsense, 
  as.data.frame(pcs$x)
)
pdfsense$Type <- factor(pdfsense$Type)

pal <- c("dodgerblue", "darkorange", "darkred")
col <- pal[as.numeric(pdfsense$Type)]

