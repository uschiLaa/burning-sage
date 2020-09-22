library(tourr)
library(animation)
library(here)

data(pollen)
pollen <- scale(as.matrix(pollen)) 

s <- 26082020

set.seed(s)
render_gif(data = pollen,
           tour_path = grand_tour(),
           display = display_xy(axes="bottomleft"),
           frames = 100,
           rescale = F,
           gif_file = here("gifs", "pollen_xy.gif")
)
set.seed(s)
render_gif(data = pollen,
           tour_path = grand_tour(),
           display = display_sage(axes="bottomleft"),
           frames = 100,
           rescale = F,
           gif_file = here("gifs", "pollen_sage.gif")
)

set.seed(s)
render(
  pollen,
  tour_path = grand_tour(),
  dev = "png",
  display = display_sage(axes = "bottomleft"),
  rescale = FALSE,
  frames = 100,
  here::here("pngs", "pollen_sage-%03d.png")
)

set.seed(s)
render_gif(data = pollen,
           tour_path = grand_tour(),
           display = display_sage(axes="bottomleft", gam = 5),
           frames = 100,
           rescale = F,
           gif_file = here("gifs", "pollen_sage_gam5.gif")
)

set.seed(s)
render(
  pollen,
  tour_path = grand_tour(),
  dev = "png",
  display = display_sage(axes="bottomleft", gam = 5),
  rescale = FALSE,
  frames = 100,
  here::here("pngs", "pollen_sage_gam5-%03d.png")
)

set.seed(s)
render_gif(data = pollen,
           tour_path = grand_tour(),
           display = display_sage(axes="bottomleft", gam = 20),
           frames = 100,
           rescale = F,
           gif_file = here("gifs", "pollen_sage_gam20.gif")
)

set.seed(s)
render(
  pollen,
  tour_path = grand_tour(),
  dev = "png",
  display = display_sage(axes="bottomleft", gam = 20),
  rescale = FALSE,
  frames = 100,
  here::here("pngs", "pollen_sage_gam20-%03d.png")
)

set.seed(s)
render_gif(data = pollen,
           tour_path = grand_tour(),
           display = display_sage(axes="bottomleft", R = 3, half_range = 3),
           frames = 100,
           rescale = F,
           gif_file = here("gifs", "pollen_sage_R3.gif")
)

set.seed(s)
render(
  pollen,
  tour_path = grand_tour(),
  dev = "png",
  display = display_sage(axes="bottomleft", R = 3, half_range = 3),
  rescale = FALSE,
  frames = 100,
  here::here("pngs", "pollen_sage_R3-%03d.png")
)

set.seed(s)
render_gif(data = pollen,
           tour_path = grand_tour(),
           display = display_sage(axes="bottomleft", R = 1, half_range = 1),
           frames = 100,
           rescale = F,
           gif_file = here("gifs", "pollen_sage_R1.gif")
)

set.seed(s)
render(
  pollen,
  tour_path = grand_tour(),
  dev = "png",
  display = display_sage(axes="bottomleft", R = 1, half_range = 1),
  rescale = FALSE,
  frames = 100,
  here::here("pngs", "pollen_sage_R1-%03d.png")
)

set.seed(s)
render_gif(data = pollen,
           tour_path = grand_tour(),
           display = display_sage(axes="bottomleft", gam = 5, R = 3, half_range = 3),
           frames = 100,
           rescale = F,
           gif_file = here("gifs", "pollen_sage_gam5_R3.gif")
)

set.seed(s)
render(
  pollen,
  tour_path = grand_tour(),
  dev = "png",
  display = display_sage(axes="bottomleft", gam = 5, R = 3, half_range = 3),
  rescale = FALSE,
  frames = 100,
  here::here("pngs", "pollen_sage_gam5_R1-%03d.png")
)

