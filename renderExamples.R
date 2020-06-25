library(tourr)
library(tidyverse)
library(animation)
library(geozoo)

sp6 <- sphere.solid.random(6, 1000)$points
colnames(sp6) <- c("a","b","c","d","e","f")

set.seed(2020)
saveGIF(
  animate(sp6,
          display = display_fisheye(),
          max_frames = 100),
  movie.name = "sphere6_fe.gif", interval=0.2)

set.seed(2020)
saveGIF(
  animate(sp6,
          display = display_xy( axes="bottomleft"),
          max_frames = 100),
  movie.name = "sphere6_xy.gif", interval=0.2)

sp6h <- sphere.hollow(6, 1000)$points
colnames(sp6h) <- c("a","b","c","d","e","f")

set.seed(2020)
saveGIF(
  animate(sp6h,
          display = display_fisheye(),
          max_frames = 100),
  movie.name = "sphere6h_fe.gif", interval=0.2)

set.seed(2020)
saveGIF(
  animate(sp6h,
          display = display_xy( axes="bottomleft"),
          max_frames = 100),
  movie.name = "sphere6h_xy.gif", interval=0.2)

data(pollen)
pollen <- as.matrix(pollen) %>% scale()

set.seed(2020)
saveGIF(
  animate(pollen,
          display = display_fisheye(pch="."),
          max_frames = 100),
  movie.name = "pollen_fe.gif", interval=0.2)

set.seed(2020)
saveGIF(
  animate(pollen,
          display = display_xy(pch=".", axes="bottomleft"),
          max_frames = 100),
  movie.name = "pollen_xy.gif", interval=0.2)

# this is PDFSense data
projCenter <- readRDS("projCenter.rds")
pal <- c("dodgerblue", "darkorange", "darkred")
col <- pal[as.numeric(factor(projCenter$type))]

set.seed(2020)
saveGIF(
  animate(select(projCenter,-type),
          display = display_fisheye(col=col),
          max_frames = 100),
  movie.name = "pdfsense_fe.gif", interval=0.2)

set.seed(2020)
saveGIF(
  animate(select(projCenter,-type),
          display = display_xy(col=col, axes="bottomleft"),
          max_frames = 100),
  movie.name = "pdfsense_xy.gif", interval=0.2)

#sketches data

load("sketches_train.rda")
sk_small <- dplyr::filter(sketches, word %in% c("banana", "cactus", "crab")) %>%
  mutate(word = factor(word, levels = c("banana", "cactus", "crab")))
pal <- RColorBrewer::brewer.pal(3, "Dark2")
col <- pal[as.numeric(as.factor(sk_small$word))]
sk_pca <- prcomp(select(sk_small, -word, -id))
scale2 <- function(x, na.rm = FALSE) (x - mean(x, na.rm = na.rm)) / sd(x, na.rm)
sk_5 <- sk_pca$x[,1:5] %>%
  as_tibble() %>%
  mutate_all(scale2)
animate(sk_5,
        display = display_fisheye(col=col, s=2), rescale = F)
animate_xy(sk_5,
        col=col)

# with t-SNE
# can only get up to 3 ouput dimensions
# new display is not useful here!
library(Rtsne)
tsne <- Rtsne(select(sketches, -word, -id), dims=3)
tsne_data <- tsne$Y
colnames(tsne_data) <- c("tsne1", "tsne2", "tsne3")
animate(tsne_data,
        display = display_fisheye(col=col, s=3))
animate_xy(tsne_data, col=col)
