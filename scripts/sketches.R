# sketches data
library(dplyr)
library(tourr)
library(here)
library(burningsage)
data("sketches_train")


sk_small <- filter(sketches, word %in% c("banana", "cactus", "crab")) %>%
  mutate(word = factor(word, levels = c("banana", "cactus", "crab")))
pal <- RColorBrewer::brewer.pal(3, "Dark2")
col <- pal[as.numeric(as.factor(sk_small$word))]
sk_pca <- prcomp(select(sk_small, -word, -id))
scale2 <- function(x, na.rm = FALSE) (x - mean(x, na.rm = na.rm)) / sd(x, na.rm)
sk_5 <- sk_pca$x[,1:5] %>%
  as_tibble() %>%
  mutate_all(scale2)

set.seed(1000)
render_gif(
  sk_5,
  tour_path = grand_tour(),
  gif_file = here::here("gifs", "sketches_grand.gif"),
  display = display_xy(col=col, axes = "bottomleft"),
  rescale = FALSE,
  frames = 100
)

set.seed(1000)
render_gif(
  sk_5,
  tour_path = grand_tour(),
  gif_file = here("gifs", "sketches_sage.gif"),
  display = display_sage(col=col, gam=2, axes = "bottomleft"),
  rescale = FALSE,
  frames = 100
)


# interactive use
animate(sk_5,
        display = display_sage(col=col, s=2), rescale = F)

animate(sk_5,
        display = display_sage(col=col, s=0.5, R=1, half_range = 0.5), 
        rescale = F)

animate_xy(sk_5, col=col)

