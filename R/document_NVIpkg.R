#' @title Update styling and documentation of a package
#' @description A wrapper around functions for styling,
#'     making the help files and updated vignettes and README.
#'
#' @details The help files for R-functions will always be generated.
#'     If styling and generation of CONTRIBUTING. md and README
#'     can be control led by input arguments.
#'
#' @template pkg
#' @template pkg_path
#' @param style {logical}, defaults to FALSE.
#' @param contributing {logical}, defaults to FALSE.
#' @param readme {logical}, defaults to FALSE.
#' @param \dots	Other arguments to be passed to \code{styler::style_pkg} .
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
document_NVIpkg <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                            pkg_path = usethis::proj_path(),
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

  if (isTRUE(style)) {
    styler::style_pkg(pkg = pkg_path,
                      transformers = styler::tidyverse_style(scope = I(c("spaces", "indention", "tokens" ))),
                      ...)
  }
  devtools::document()
  if (isTRUE(contributing)) {
    update_contributing(pkg = pkg, pkg_path = pkg_path)
  }
  if (isTRUE(readme)) {
    # update_readme(pkg = pkg, pkg_path = pkg_path)
  }
}
