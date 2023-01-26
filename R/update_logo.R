#' @title Update logo
#' @description Update the logo to be used in the README file.
#'
#' @details If the package logo has been created, the logo is copied from
#'     \code{NVIrpackages} to the package directory "./man/figures/". If the logo
#'     already exists, the logo is overwritten.
#'
#' @template pkg
#' @template pkg_path
#'
#' @return None. Copies the the logo file to the directory "./man/figures/".
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Attach packages and set up with temporary directory
#' library(NVIpackager)
#' update_logo()
#' }
update_logo <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                        pkg_path = usethis::proj_path()) {

  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # assertions
  checks <- assert_pkg_path(pkg = pkg, pkg_path = pkg_path, add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)

  # RUN SCRIPT ----
  # Copy logo to package if exists in NVIrpackages
  if (file.exists(system.file(paste0('logos/', pkg, "_logo.png"), package = "NVIrpackages"))) {
    if (!dir.exists(paths = file.path(pkg_path, "man"))) {
      dir.create(file.path(pkg_path, "man"))
    }
    if (!dir.exists(file.path(pkg_path, "man/figures"))) {
      dir.create(file.path(pkg_path, "man/figures"))
    }
    file.copy(from = system.file(paste0('logos/', pkg, "_logo.png"), package = "NVIrpackages"), to = file.path(pkg_path, "man/figures"), overwrite = TRUE)
  }
}
