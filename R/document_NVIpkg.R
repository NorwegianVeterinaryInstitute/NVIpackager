#' @title Update styling and documentation of a package
#' @description A wrapper around functions for styling,
#'     making the help files and updated vignettes and README.
#'
#' @details The help files for R-functions will always be generated.
#'     If styling and generation of CONTRIBUTING. md and README
#'     can be control led by input arguments.
#'
#' @param style {logical}, defaults to FALSE.
#' @param contributing {logical}, defaults to FALSE.
#' @param readme {logical}, defaults to FALSE.
#'
#' @return none. Updated help files for all functions and,
#'     depending on argument input, can updated style,
#'     \code{CONTRIBUTING}, and \code{README}
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Reading from standard directory at NVI's network
#' }
#'
document_NVIpkg <- function(pkg,
                            pkg_path,
                            style = FALSE,
                            contributing = FALSE,
                            readme = FALSE,
                            ...) {
  # Argument checking
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # Perform checks
  assert_pkg_path()
  checkmate::assert_logical(x = style, add = checks)
  checkmate::assert_logical(x = contributing, add = checks)
  checkmate::assert_logical(x = readme, add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)

  if (isTrue(style)) {
    styler::style()
  }
  devtools::document()
  if (isTrue(contributing)) {
    use_contributing(pkg = pkg, pkg_path = pkg_path)
  }
  if (isTrue(readme)) {
    update_readme(pkg = pkg, pkg_path = pkg_path)
  }
}

