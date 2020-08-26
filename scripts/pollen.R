library(tourr)
library(animation)
library(magrittr)
source("display-sage.R")

data(pollen)
pollen <- as.matrix(pollen) %>% scale()

s <- 26082020

set.seed(s)
render_gif(data = pollen,
           tour_path = grand_tour(),
           display = display_xy(axes="bottomleft"),
           frames = 100,
           rescale = F,
           gif_file = "pollen_xy.gif"
)
set.seed(s)
render_gif(data = pollen,
           tour_path = grand_tour(),
           display = display_sage(axes="bottomleft"),
           frames = 100,
           rescale = F,
           gif_file = "pollen_sage.gif"
)
set.seed(s)
render_gif(data = pollen,
           tour_path = grand_tour(),
           display = display_sage(axes="bottomleft", gam = 5),
           frames = 100,
           rescale = F,
           gif_file = "pollen_sage_gam5.gif"
)
set.seed(s)
render_gif(data = pollen,
           tour_path = grand_tour(),
           display = display_sage(axes="bottomleft", gam = 20),
           frames = 100,
           rescale = F,
           gif_file = "pollen_sage_gam20.gif"
)
set.seed(s)
render_gif(data = pollen,
           tour_path = grand_tour(),
           display = display_sage(axes="bottomleft", R = 3, half_range = 3),
           frames = 100,
           rescale = F,
           gif_file = "pollen_sage_R3.gif"
)
set.seed(s)
render_gif(data = pollen,
           tour_path = grand_tour(),
           display = display_sage(axes="bottomleft", R = 1, half_range = 1),
           frames = 100,
           rescale = F,
           gif_file = "pollen_sage_R1.gif"
)
set.seed(s)
render_gif(data = pollen,
           tour_path = grand_tour(),
           display = display_sage(axes="bottomleft", gam = 5, R = 3, half_range = 3),
           frames = 100,
           rescale = F,
           gif_file = "pollen_sage_gam5_R3.gif"
)


#### code below is for trying things out live

quartz()
animate_sage(pollen, grand_tour(), pch=".",  axes="bottomleft")
animate_sage(pollen, grand_tour(),  axes="bottomleft", gam=20)
animate_sage(pollen, grand_tour(),  axes="bottomleft", R = 0.2, half_range = 0.2)

# seems tour is "slower" with zooming, maybe need concept of "torque"?

# are effects from gam and R really different? maybe R is faster to push more points towards outer circle?
animate_sage(pollen, grand_tour(),  axes="bottomleft", gam=100)
animate_sage(pollen, grand_tour(),  axes="bottomleft", gam=150)
animate_sage(pollen, grand_tour(),  axes="bottomleft", R = 0.1, half_range = 0.1)
animate_sage(pollen, grand_tour(),  axes="bottomleft", R = 0.075, half_range = 0.075)

