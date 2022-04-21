#' @title Update reference manual
#' @description Update the PDF reference manual.
#'
#' @details If the package logo has been created, the logo is copied from
#'     \code{NVIrpackages} to the package directory "./man/figures/. If the logo
#'     already exists, the logo is overwritten.
#'
#' @template pkg
#' @template pkg_path
#' @param manual Can be c("include", "update", "remove")
#'
#' @return None. Creates or updates the PDF reference manual in directory "./vignettes/.
#'     The reference manual is given the name pkgname.pdf.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Update the reference manual if it already exists
#' library(NVIpackager)
#' update_reference_manual(manual = "update")
#' }
update_reference_manual <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                                    pkg_path = usethis::proj_path(),
                                    manual) {

  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # assertions
  assert_pkg_path(pkg = pkg, pkg_path = pkg_path)

  checkmate::assert_choice(manual, choices = c("include", "update", "remove"), add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)

  # RUN SCRIPT ----
  # update
  # Check if manual is included, update if included
  # install
  # install even if not included, if included, update
  # make pkg.pdf.asis
  # create manual
  # update description with
  # suggests: R.rsp (imports?)
  # VignetteBuilder: R.rsp


  devtools::build_manual(path = file.path(pkg_path, "vignettes"))

  file.rename(from = file.path(pkg_path, "vignettes", paste0(pkg, "_", desc::desc_get_field(key = "Version"), ".pdf")),
                              to = file.path(pkg_path, "vignettes", paste0(pkg, ".pdf")))

  asis <- rbind(paste0("%\\VignetteIndexEntry{", pkg, " reference manual}"),
                "%\\VignetteEngine{R.rsp::asis}",
                "%\\VignetteKeyword{PDF}")
  writeLines(asis, con = file.path(pkg_path, "vignettes", paste0(pkg, ".pdf.asis")))

  usethis::use_package(package = "R.rsp", type = "Imports")


  # library(desc)
  desc::desc_set_list(key = "VignetteBuilder", list_value = c("knitr", "R.rsp"))

  # MUST UPDATE GITIGNORE TO KEEP VIGNETTES/*.PDF


}
