#' @title Update the vignette "Contribute to NVIpkg.Rmd" and CONTRIBUTING.md
#' @description Update the vignette "Contribute to NVIpkg.Rmd" and CONTRIBUTING.md
#'     from the template in NVI-package.
#'
#' @details The template for CONTRIBUTING.md is found in NVIpackager. Any change in the file must be done in the template.
#'
#' @param pkg The package name.
#' @param pkg_path The path for the package
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

update_contribute <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                              pkg_path = usethis::proj_path()) {

  # Set up vignettes
  if (!dir.exists(paste0(pkg_path, "/vignettes"))) {
    usethis::use_vignette(name = paste0("Contribute_to_", pkg), title = paste("Contribute to", pkg))
  }
  # read template
  contribute <- readLines(system.file('templates', "Contribute_to_NVIpkg.Rmd", package = "NVIpackager"))
  # contribute <- readLines('./inst/templates/Contribute_to_NVIpkg.Rmd')

  # give correct package name
  # check if need lapply
  contribute <- gsub("NVIpackage" , pkg, contribute)
  # save with name of package in filename
  writeLines(contribute, paste0 (pkg_path, "/vignettes/Contribute_to_", pkg, ".Rmd"))

  # For updating CONTRIBUTING.md after the vignette has been updated.
  rmarkdown::render(input = paste0(pkg_path, "/vignettes/Contribute_to_", pkg, ".Rmd"),
                    output_format = "md_document",
                    output_file = "CONTRIBUTING.md",
                    output_dir = pkg_path)
  header <- paste0("# Contribute to ", pkg, "\n")

  writeLines(c(header,readLines(paste0(pkg_path, "/CONTRIBUTING.md"))),
             paste0(pkg_path, "/CONTRIBUTING.md"))
}
