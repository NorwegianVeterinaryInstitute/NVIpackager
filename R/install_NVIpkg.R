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
#'     The repository can be changed by giving more arguments that
#'     will be passed to \code{install_github}, see
#'     \code{\link[remotes:install_github]} for full description
#'     of the arguments \code{repo =}, \code{username =}, and
#'     \code{ref =}.
#'
#'     When \code{rsource = "local"}, it installs the package from a
#'     local copy of the package repository. It defaults to install
#'     the active branch. Use \code{rsource = "local"} to test new
#'     code during development.
#'
#'     For installing the latest released versions of NVIverse
#'     packages, use \code{\link[remotes:install_github]} or
#'     \code{\link[NVIbatch:use_NVIverse].
#'
#' @template pkg
#' @template pkg_path
#' @param lib character giving the library directory where to install
#'     the package. If missing, defaults to the first element of
#'     \code{.libPaths()}.
#' @param rsource, character with one of c("github", "local") .
#' @param username, the github username to install from. Defaults to
#'     "NorwegianVeterinaryInstitute".
#' @param \dots Other arguments to be passed to \code{remotes::install_github}
#'     or \code{devtools::install}.
#'
#' @return none. Installs a package.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Reading from standard directory at NVI's network
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
  checkmate::assert_character(x = rsource, add = checks)
  checkmate::assert_character(x = username, add = checks)
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
  if(rsource == "local") {
    withr::with_libpaths(paste0(lib,"/library"),
                         devtools::install(pkg_path,
                                           dependencies = c("Depends", "Imports", "LinkingTo"),
                                           upgrade=FALSE,
                                           build_vignettes = TRUE,
                                           ...)
    )
  }

  if(rsource == "github") {
    # Install from Github repository
    remotes::install_github(paste0(username, "/", pkg),
                            upgrade = FALSE,
                            build = TRUE,
                            build_manual = TRUE,
                            build_vignettes = TRUE,
                            ...)
  }
}
