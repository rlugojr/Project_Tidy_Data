


source(file = "run_analysis.R", verbose = TRUE, keep.source = TRUE)

source(file = "build_codebook.R", verbose = TRUE, keep.source = TRUE)


library(rmarkdown)
library(knitr)

render("README.Rmd")
#render("run_analysis.Rmd")
#render("codebook.Rmd")
