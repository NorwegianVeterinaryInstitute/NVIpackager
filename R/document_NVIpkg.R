#' @title Update styling and documentation of a package
#' @description A wrapper around functions for styling, write the help files
#'     and update README and CONTRIBUTING.md.
#'
#' @details The help files for R-functions will always be generated. Whether
#'     styling should be performed and CONTRIBUTING.md and README
#'     should be updated are controlled by input arguments.
#'
#'     Default value for styling is \code{scope = "spaces"}. Input to
#'     \code{scope} can be any subset of c("spaces", "indention", "line_breaks", "tokens").
#'     For indention, rather use \code{Ctrl+I} than \code{scope = "indention"}.
#'     Be careful if using \code{scope = "tokens"} as code may be broken.
#'
#' @template pkg
#' @template pkg_path
#' @param style \[\code{logical}\]\cr
#'     Should the package be styled, defaults to \code{FALSE}.
#' @param manual \[\code{character}\]\cr
#'     Should a reference manual be included, updated or removed. Defaults to
#'     \code{manual = "update"} that will update the manual if exists and do
#'     nothing if it doesn't exist.
#' @param contributing \[\code{logical}\]\cr
#'     Should \code{CONTRIBUTING.md} and the vignette "Contribute to NVIpkg" be
#'     updated, defaults to \code{FALSE}.
#' @param readme \[\code{logical}\]\cr
#'     Should \code{README} be updated, defaults to \code{FALSE}.
#' @param \dots	Other arguments to be passed to \code{styler::style_pkg}.
#'
#' @return none. Updated help files for all functions and,
#'     depending on argument input, can updated style,
#'     \code{CONTRIBUTING.md}, and \code{README}
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#'
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
#' document_NVIpkg(pkg = "NVItest",
#'                 pkg_path = file.path(td, "NVItest"),
#'                 style = FALSE,
#'                 contributing = TRUE,
#'                 readme = TRUE)
#' }
#'
document_NVIpkg <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                            pkg_path = usethis::proj_path(),
                            style = FALSE,
                            manual = "update",
                            contributing = FALSE,
                            readme = FALSE,
                            ...) {
  # Argument checking
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # Perform checks
  assert_pkg_path(pkg = pkg, pkg_path = pkg_path)
  checkmate::assert_logical(x = style, add = checks)
  checkmate::assert_choice(x = manual, choices = c("include", "update", "remove"))
  checkmate::assert_logical(x = contributing, add = checks)
  checkmate::assert_logical(x = readme, add = checks)
  if (exists("scope")) {
    checkmate::assert_subset(x = scope,
                             choices = c("spaces", "indention", "line_breaks", "tokens"),
                             add = checks)
  }
  # Report assertions
  checkmate::reportAssertions(checks)

  if (isTRUE(style)) {
    if (!exists("scope")) {
      scope <- "spaces"
    }
    styler::style_pkg(pkg = pkg_path,
                      transformers = styler::tidyverse_style(scope = I(c(scope))),
                      ...)
  }

  devtools::document(pkg = pkg_path)

  update_reference_manual(pkg = pkg, pkg_path = pkg_path, manual = manual)

  if (isTRUE(contributing)) {
    update_contributing(pkg = pkg, pkg_path = pkg_path)
  }

  if (isTRUE(readme)) {
    update_readme(pkg = pkg, pkg_path = pkg_path)
  }
}
