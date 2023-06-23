# assert_arguments
#
# assert collections developed for standardized assertion of input arguments within the package.
# - assert_pkg_path
#
#
#' @title Assertions for pkg and pkg_path in packager_functions
#' @description Assertions for pkg and pkg_path in packager_functions.
#'
#' @details The function does not set up and report the AssertCollection
#'   This need to be done separately, see example.
#'
#' @param pkg [\code{any}]\cr
#' Argument to the add-function to be asserted.
#' @param pkg_path [\code{any}]\cr
#' Argument to the add-function to be asserted.
#' @param add [\code{AssertCollection}]\cr
#' The AssertCollection for saving result of assertions.
#'
#' @return An AssertCollection that have been updated with the results
#'     of assertions for \code{pkg} and \code{pkg_path}.
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
#'   dir.create(file.path(td, "NVItest"))
#' }
#' # ARGUMENT CHECKING
#' # Object to store check-results
#' checks <- checkmate::makeAssertCollection()
#' # Perform checks
#' checks <- assert_pkg_path(pkg = "NVItest",
#'                 pkg_path = paste0(td, "/NVItest"),
#'                 add = checks)
#' # Report check-results
#' checkmate::reportAssertions(checks)
assert_pkg_path <- function(pkg,
                            pkg_path,
                            add) {

  # # ARGUMENT CHECKING ----
  # Perform checks
  # pkg_path
  checkmate::assert_directory_exists(x = pkg_path,
                                     add = add)
  # pkg
  checkmate::assert_choice(x = pkg,
                           choices = stringi::stri_extract_last_words(pkg_path),
                           add = add)

  return(add)
}
