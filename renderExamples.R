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
