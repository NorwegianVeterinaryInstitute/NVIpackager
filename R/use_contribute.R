#' @title Update the vignette "Contribute to NVIpkg.Rmd" and CONTRIBUTING.md
#' @description Update the vignette "Contribute to NVIpkg.Rmd" and CONTRIBUTING.md
#'     from the template in NVI-package. 
#'
#' @details The template for CONTRIBUTING.md is found in NVIpackager. Any change in the file must be done in the template. 
#'
#' @param pkg The package name.
#'
#' @return None. Writes the vignette and the file CONTRIBUTING.md.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Attach packages and set up with temporary directory
#' td <- tempdir()
#' library(NVIpackager)
#'
#' pkg <- 
#'  use_contribute(pkg = pkg) 
#' }

use_contribute <- function(pkg = stringi::stri_extract_last_words(usethis::path_proj())) {
# read template
contribute <- readLines(system.file('template', "Contribute_to_NVIpkg.Rmd", package = NVIpackager)) 

# give correct package name
# check if need lapply
contribute <- gsub("mypkg" , pkg, contribute) 
# save with name of package in filename 
writeLines(contribute), paste0 ("./vignettes/Contribute_to_", pkg, ".Rmd")) 

# For updating CONTRIBUTING.md after the vignette has been updated.
rmarkdown::render(input = paste0("./vignettes/Contribute_to_", pkg, ".Rmd"),
                  output_format = "md_document",
                  output_file = "CONTRIBUTING.md",
                  output_dir = "./")
header <- paste0("# Contribute to ", pkg, "\n",
                 "<!-- CONTRIBUTING.md is generated from ./vignettes/Contribute_to_", pkg, ".Rmd. Please edit that file -->", "\n")

writeLines(c(header,readLines("./CONTRIBUTING.md")),"./CONTRIBUTING.md")
} 
