#' @title Update styling and documentation of a package
#' @description A wrapper around functions for styling,
#'     making the help files and updated vignettes and README.
#'
#' @details The help files for R-functions will always be generated.
#'     If styling and generation of CONTRIBUTING. md and README
#'     can be control led by input arguments.
#'
#' @param Rlibrary, defaults to FALSE.
#' @param type, defaults to FALSE.
#' @param repo, defaults to FALSE.
#' @param branch, defaults to FALSE.
#' @param dots, defaults to FALSE.
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
install_NVIpkg <- function(pkg,
                           pkg_path,
                           Rlibrary = R.home(),
                           type,
                           repo = "NorwegianVeterinaryInstitute",
                           branch,
                           ...) {

  # Argument checking
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # Perform checks
  assert_pkg_path()
  checkmate::assert_directory_exists(x = Rlibrary, add = checks)
  checkmate::assert_character(x = type, add = checks)
  checkmate::assert_character(x = repo, add = checks)
  checkmate::assert_character(x = branch, add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)


  # DETACH PACKAGE ----
  # The package must be detached to install it.
  if(pkg %in% (.packages())){
    pkgname <- paste0("package:", pkg)
    detach(pkgname, unload=TRUE, character.only = TRUE)
  }

  # INSTALL PACKAGE ----
  # Install from working directory
  if(type == "local") {
    withr::with_libpaths(paste0(Rlibrary,"/library"),
                         devtools::install(pkg_path,
                                           dependencies = c("Depends", "Imports", "LinkingTo"),
                                           upgrade=FALSE,
                                           build_vignettes = TRUE)
    )
  }

  if(type == "github") {
    # Install from Github repository
    remotes::install_github(paste0(repo, "/", pkg),
                            upgrade = FALSE,
                            build = TRUE,
                            build_manual = TRUE,
                            build_vignettes = TRUE,
                            ...)
  }
}
