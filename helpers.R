# -- utility functions, mostly used for quickdraw example
# downsample the number of images to have 500 images in each category
slice_image_meta <- function(a, size = 500L) {
  res <- qd_read(a)
  nr <- nrow(res)
  slice <- sample.int(nr, size)
  slab <- res[slice, , drop = FALSE]
  slab[["row_number"]] <- slice
  slab
}

slice_bitmap <- function(a, row_number) {
  res <- qd_read_bitmap(a)
  colnames(res) <- paste0("px", seq_len(ncol(res)))
  dplyr::as_tibble(res[row_number, , drop = FALSE])
} 

tidy_tsne <- function(model, data) {
  enframe <- as.data.frame(model[["Y"]])
  colnames(enframe) <- c("tsneX", "tsneY", "tsneZ")[seq_len(ncol(enframe))]
  dplyr::bind_cols(enframe, data)
}

tidy_var_explained <- function(object) {
  if (methods::is(object, "SingleCellExperiment")) {
    pve <- attr(SingleCellExperiment::reducedDim(object), "percentVar")
    component <- seq_len(length(pve))
    c_pve <- cumsum(pve)
  }
  
  if (methods::is(object, "prcomp")) {
    component <- seq_len(length(object$sdev))
    var <- object$sdev^2
    pve <- (var / sum(var)) * 100
    c_pve <- cumsum(var) / sum(var)            
  }
  data.frame(
    component = component,
    var_explained = pve,
    cum_var_explained = c_pve
  )
}
