#' Display tour path with a fisheye scatterplot
#'
#' Animate a 2D tour path with a fisheye scatterplot.
#'
#' @param axes position of the axes: center, bottomleft or off
#' @param col color to be plotted.  Defaults to "black"
#' @param pch marker for points. Defaults to 20.
#' @param ...  other arguments passed on to \code{\link{animate}} and
#'   \code{\link{display_fisheye}}
#' @export
#' @examples
#' # Generate samples on a 3d and 5d hollow sphere using the geozoo package
#' sphere3 <- geozoo::sphere.hollow(3)$points
#' sphere5 <- geozoo::sphere.hollow(5)$points
#'
#' # Columns need to be named before launching the tour
#' colnames(sphere3) <- c("x1", "x2", "x3")
#' colnames(sphere5) <- c("x1", "x2", "x3", "x4", "x5")
#'



display_fisheye <- function(axes = "center",
                              col = "black", pch  = 20, ...) {
  
  labels <- NULL
  
  init <- function(data) {
    half_range <<- 1
    labels <<- abbreviate(colnames(data), 3)
  }
  
  
  render_frame <- function() {
    par(pty = "s", mar = rep(0.1, 4))
    tourr:::blank_plot(xlim = c(-1, 1), ylim = c(-1, 1))
  }
  render_transition <- function() {
    rect(-1, -1, 1, 1, col="#FFFFFFE6", border=NA)
  }
  
  render_data <- function(data, proj, geodesic) {
    tourr:::draw_tour_axes(proj, labels, 1, "bottomleft")
    
    
    # Projecte data and center
    x <- data %*% proj
    x <- center(x)
    # Calculate polar coordinates
    rad <- sqrt(x[,1]^2+x[,2]^2)
    ang <- atan2(x[,2], x[,1])
    # Calculate rescaled radius
    r_max <- max(rad) # adapt to maximum value of radius for each projection
    # transform with cumulative to get uniform distribution in radius
    rad <- cumulative_radial(rad, r_max, nrow(proj))
    # square-root is the inverse of the cumulative of a uniform disk (rescaling to maximum radius = 1)
    rad <- sqrt(rad)
    # transform back to x, y coordinates
    x[,1] <- rad * cos(ang)
    x[,2] <- rad * sin(ang)
    # scale down maximum radius from 1 to fit drawing range
    x <- 0.9 * x
    points(x, col = col, pch = pch)
    
  }
  
  
  list(
    init = init,
    render_frame = render_frame,
    render_transition = render_transition,
    render_data = render_data,
    render_target = tourr:::nul
  )
}

# cumulative distribution, fraction of points within radius r
# given 2D projection of hypersphere with radius R in p dimensions
cumulative_radial <- function(r, R, p){
  1 - (1 - (r/R)^2)^(p/2)
}