# pdfsense example
library(burningsage)
library(tourr)
library(dplyr)
library(here)
data(pdfsense)

# play around with the gamma parameter
pcs  <- prcomp(pdfsense[, 7:ncol(pdfsense)])

pdfsense <- bind_cols(
  pdfsense, 
  as.data.frame(pcs$x)
)
pdfsense$Type <- factor(pdfsense$Type)

pal <- c("dodgerblue", "darkorange", "darkred")
col <- pal[as.numeric(pdfsense$Type)]

pdfsense_rs <- select(pdfsense, PC1:PC6) %>% 
  mutate_all(.funs = function(x) (x - mean(x)) / sd(x))

set.seed(2020)
render_gif(
  pdfsense_rs, 
  tour_path = grand_tour(),
  gif_file = here("gifs", "pdfsense_grand.gif"),
  display = display_xy(col=col, axes = "bottomleft"),
  frames = 100,
  rescale = FALSE
)

set.seed(2020)
render_gif(
  pdfsense_rs, 
  tour_path = grand_tour(),
  gif_file = here("gifs", "pdfsense_sage.gif"),
  display = display_sage(col=col, axes = "bottomleft"),
  frames = 100,
  rescale = FALSE
)

set.seed(2020)
render_gif(
  pdfsense_rs, 
  tour_path = grand_tour(),
  gif_file = here("gifs", "pdfsense_sage_r10.gif"),
  display = display_sage(col=col, axes = "bottomleft", R = 10),
  frames = 100,
  rescale = FALSE
)


