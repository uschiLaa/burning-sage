library(tourr)
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