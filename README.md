
# Research Compendium

>   Burning sage: Reversing the curse of dimensionality in the visualisation of high-dimensional data

In high-dimensional data analysis the curse of dimensionality reasons that points tend to be far away from the center of the distribution and on the edge of high-dimensional space. Contrary to this, is that projected data tends to clump at the center. This gives a sense that any structure near the center of the projection is obscured, whether this is true or not. A transformation to reverse the curse, is defined in this paper, which uses radial transformations on the projected data. It is integrated seamlessly into the grand tour algorithm, and we have called it a burning sage tour, to indicate that it reverses the curse. The work is implemented into the tourr package in R. Several case studies are included that show how the sage visualisations enhance exploratory clustering and classification problems.

## Install Dependencies

You can install the dependencies including the data to run the examples using
the `devtools` package from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("devtools")
devtools::install("uschilaa/burningsage")
library(burningsage)
```

If you want to run the analysis in `scripts/mouse.R` additional dependencies
from Bioconductor need to be installed with the `BiocManager` package.

```r
install.packages("BiocManager")
BiocManager::install(c("scran", "scater", "scRNAseq", "AnnotationHub", "ensembldb", "igraph"))
```

## Repo Structure

* `paper/` the Rmarkdown file and templates to reproduce the paper in pdf format
* `supp-materials/` the Rmarkdown files to view the gif files as a webpage
* `R/` the source code for the data used by the paper
* `scripts/` the source code for creating the examples in the paper
* `data/` the data sets used in the paper as ".rda" files
* `gifs/` tour animation artefacts produced by scripts
* `pngs/` tour frame artefacts produced by scripts
