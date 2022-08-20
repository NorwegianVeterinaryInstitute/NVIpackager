#' @title Install an NVIverse Package during the Development Phase
#' @description Installation of an NVIverse package from github or
#'     from local directory. Mainly intended for installation of a
#'     package during development to test new code in the package
#'     scripts .
#'
#' @details When \code{rsource = "github"}, the default is to install
#'     the latest version in the main branch at the NorwegianVeterinaryInstitute
#'     package repository. During package development one will usually
#'     change the username to your own.
#'
#' The repository can be changed by giving more arguments that
#'     will be passed to \code{install_github}, see
#'     \link[remotes]{install_github} for full description
#'     of the arguments \code{repo = }, \code{username = }, and
#'     \code{ref = }.
#'
#' When \code{rsource = "local"}, it installs the package from a
#'     local copy of the package repository. It defaults to install
#'     the active branch. Use \code{rsource = "local"} to test new
#'     code during development.
#'
#' For installing the latest released versions of NVIverse
#'     packages, use \link[remotes]{install_github} or
#'     \link[NVIbatch]{use_NVIverse}.
#'
#' @template pkg
#' @template pkg_path
#' @param lib [\code{character}]\cr
#'   The library directory where to install, defaults to \code{R.home()}.
#' @param rsource [\code{character}]\cr
#'    One of c("github", "local").
#' @param username [\code{character}]\cr
#'    The github username where the repository is found, defaults to
#'     "NorwegianVeterinaryInstitute".
#' @param \dots Other arguments to be passed to \code{remotes::install_github}
#'     or \code{devtools::install}.
#'
#' @return None. Installs a package.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Installs a package from local PC
#' # You need to be in a package directory at you PC for the code to work.
#' pkg <- stringi::stri_extract_last_words(usethis::proj_path())
#' pkg_path = usethis::proj_path()
#'
#' NVIpackager::install_NVIpkg(pkg = pkg, pkg_path = pkg_path, rsource = "local")
#' }
#'
install_NVIpkg <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                           pkg_path = usethis::proj_path(),
                           lib = R.home(),
                           rsource,
                           username = "NorwegianVeterinaryInstitute",
                           ...) {

  # Argument checking
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # Perform checks
  assert_pkg_path(pkg = pkg, pkg_path = pkg_path)
  checkmate::assert_directory_exists(x = lib, add = checks)
  checkmate::assert_choice(x = rsource, choices = c("github", "local"), add = checks)
  checkmate::assert_character(x = username, add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)


  # DETACH PACKAGE ----
  # The package must be detached to install it.
  if (pkg %in% (.packages())) {
    pkgname <- paste0("package:", pkg)
    detach(pkgname, unload = TRUE, character.only = TRUE)
  }

  # INSTALL PACKAGE ----
  # Install from working directory
  if (rsource == "local") {
    withr::with_libpaths(paste0(lib, "/library"),
                         devtools::install(pkg_path,
                                           dependencies = c("Depends", "Imports", "LinkingTo"),
                                           upgrade = FALSE,
                                           build_vignettes = TRUE,
                                           ...)
    )
  }

  if (rsource == "github") {
    # Install from Github repository
    remotes::install_github(paste0(username, "/", pkg),
                            upgrade = FALSE,
                            build = TRUE,
                            build_vignettes = TRUE,
                            ...)
  }
}
