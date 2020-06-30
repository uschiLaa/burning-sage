#' Display tour path with a sage scatterplot
#'
#' Animate a 2D tour path with a sage scatterplot that
#' uses a radial transformation on the projected points to re-allocate
#' the volume projected across the 2D plane.
#'
#' @param axes position of the axes: center, bottomleft or off
#' @param half_range half range to use when calculating limits of projected.
#'   If not set, defaults to maximum distance from origin to each row of data.
#' @param col color to be plotted.  Defaults to "black"
#' @param pch marker for points. Defaults to 20.
#' @param s scaling of the effective dimensionality for rescaling. Defaults to 1.
#' @param R scale for the radial transformation.
#'   If not set, defaults to maximum distance from origin to each row of data.
#' @param ...  other arguments passed on to \code{\link{animate}} and
#'   \code{\link{display_sage}}
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



display_sage <- function(axes = "center", half_range = NULL,
                              col = "black", pch  = 20, s = 1, R = NULL, ...) {
  
  labels <- NULL
  peff <- NULL
  
  init <- function(data) {
    half_range <<- tourr:::compute_half_range(half_range, data, TRUE)
    R <<- tourr:::compute_half_range(R, data, TRUE)
    labels <<- abbreviate(colnames(data), 3)
    peff <<- s * ncol(data)
  }
  
  
  render_frame <- function() {
    par(pty = "s", mar = rep(0.1, 4))
    tourr:::blank_plot(xlim = c(-1, 1), ylim = c(-1, 1))
  }
  render_transition <- function() {
    rect(-1, -1, 1, 1, col="#FFFFFFE6", border=NA)
  }
  
  render_data <- function(data, proj, geodesic) {
    tourr:::draw_tour_axes(proj, labels, 1, axes)
    
    # Projecte data and center
    x <- data %*% proj
    x <- center(x)
    # Calculate polar coordinates
    rad <- sqrt(x[,1]^2+x[,2]^2)
    ang <- atan2(x[,2], x[,1])
    # transform with cumulative to get uniform distribution in radius
    rad <- cumulative_radial(rad, half_range, peff)
    # square-root is the inverse of the cumulative of a uniform disk (rescaling to maximum radius = 1)
    rad <- sqrt(rad)
    # transform back to x, y coordinates
    x[,1] <- rad * cos(ang)
    x[,2] <- rad * sin(ang)
    # scale down maximum radius from 1 to fit drawing range
    # also allow to change drawing range with half_range
    x <- 0.9 * (half_range / R) * x
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

animate_sage <- function(data, tour_path = grand_tour(), ...) {
  animate(data, tour_path, display_sage(...), ...)
}