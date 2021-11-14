# assert_arguments
#
# assert collections developed for standardized assertion of input arguments within the package.
# - assert_pkg_path
#
#
#' @title Assertions for pkg and pkg_path in packager_functions
#' @description Assertions for pkg and pkg_path in packager_functions.
#'
#' @details The function does not set up and report the assertCollection.
#'   This need to be done separately, see example.
#'
#' @param pkg Argument to the add-function to be asserted.
#' @param pkg_path Argument to the add-function to be asserted.
#' @param checks AssertCollection, defaults to checks.
#'
#' @return \code{TRUE } if none of the assertions failed. If any of the assertions
#'     failed, one or more error messages are returned.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @keywords internal
#' @export
#'
#' @examples
#' # Attach package and make temporary directory
#' library(NVIpackager)
#' td <- tempdir()
#' if (!dir.exists(file.path(td, "NVItest"))) {
#'    dir.create(file.path(td, "NVItest"))
#' }
#' # ARGUMENT CHECKING
#' # Object to store check-results
#' checks <- checkmate::makeAssertCollection()
#' # Perform checks
#' assert_pkg_path(pkg = "NVItest",
#'                 pkg_path = paste0(td, "/NVItest"))
#' # Report check-results
#' checkmate::reportAssertions(checks)
#'
#' @export

assert_pkg_path <- function(pkg,
                            pkg_path,
                            checks = checks) {

  # # ARGUMENT CHECKING ----
  # Perform checks
  # pkg_path
  checkmate::assert_directory_exists(x = pkg_path,
                                     add = checks)
  # pkg
  NVIcheckmate::assert_choice_character(x = pkg,
                                        choices = stringi::stri_extract_last_words(pkg_path),
                                        add = checks)
}
