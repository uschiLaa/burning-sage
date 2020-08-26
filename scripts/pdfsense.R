# pdfsense example
library(burningsage)
library(tourr)
library(dplyr)
library(here)
data(pdfsense)


pcs  <- prcomp(pdfsense[, 7:ncol(pdfsense)])

pdfsense <- bind_cols(
  pdfsense, 
  as.data.frame(pcs$x)
)
pdfsense$Type <- factor(pdfsense$Type)

pal <- c("dodgerblue", "darkorange", "darkred")
col <- pal[as.numeric(pdfsense$Type)]

set.seed(2020)
render_gif(
  select(pdfsense, PC1:PC6), 
  tour_path = grand_tour(),
  gif_file = here("gifs", "pdfsense_sage.gif"),
  display = display_sage(col=col, axes = "bottomleft"),
  frames = 100
)

set.seed(2020)
render_gif(
  select(pdfsense, PC1:PC6), 
  tour_path = grand_tour(),
  gif_file = here("gifs", "pdfsense_grand.gif"),
  display = display_xy(col=col, axes = "bottomleft"),
  frames = 100
)
