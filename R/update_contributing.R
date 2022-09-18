#' @title Update \code{CONTRIBUTING.md}
#' @description Update \code{CONTRIBUTING.md} and the vignette "Contribute_to_NVIpkg.Rmd"
#'     from the template in \code{NVIpackager}. If the files don't exist, they are created.
#'
#' @details The template is found in \code{NVIpackager}. Any change in the text
#'     must be done in the template.
#'
#' @template pkg
#' @template pkg_path
#'
#' @return None. Writes the vignette "Contribute_to_NVIpkg.Rmd" and the file \code{CONTRIBUTING.md}.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Attach packages and set up with temporary directory
#' library(NVIpackager)
#' td <- tempdir()
#' if (!dir.exists(file.path(td, "NVItest"))) {
#'   dir.create(file.path(td, "NVItest"))
#' }
#' if (!dir.exists(file.path(td, "NVItest", "vignettes"))) {
#'   dir.create(file.path(td, "NVItest", "vignettes"))
#' }
#'
#' use_contributing(pkg = "NVItest",
#'                  pkg_path = file.path(td, "NVItest"))
#' }
#'
update_contributing <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                                pkg_path = usethis::proj_path()) {

  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # assertions
  checks <- assert_pkg_path(pkg = pkg, pkg_path = pkg_path, add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)

  # RUN SCRIPT ----
  # Set up vignettes
  if (!dir.exists(paste0(pkg_path, "/vignettes"))) {
    usethis::use_vignette(name = paste0("Contribute_to_", pkg), title = paste("Contribute to", pkg))
  }
  # read template
  contribute <- readLines(system.file('templates', "Contribute_to_NVIpkg.Rmd", package = "NVIpackager"))
  # contribute <- readLines('./inst/templates/Contribute_to_NVIpkg.Rmd')

  # give correct package name
  contribute <- gsub("_package_name_", pkg, contribute)
  # save with name of package in filename
  writeLines(contribute, paste0(pkg_path, "/vignettes/Contribute_to_", pkg, ".Rmd"))

  # For updating CONTRIBUTING.md after the vignette has been updated.
  rmarkdown::render(input = paste0(pkg_path, "/vignettes/Contribute_to_", pkg, ".Rmd"),
                    output_format = "md_document",
                    output_file = "CONTRIBUTING.md",
                    output_dir = pkg_path)
  header <- paste0("# Contribute to ", pkg, "\n")

  writeLines(c(header, readLines(paste0(pkg_path, "/CONTRIBUTING.md"))),
             paste0(pkg_path, "/CONTRIBUTING.md"))
}
