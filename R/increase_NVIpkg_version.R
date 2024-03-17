#' @title Increase the package version
#' @description Increase the package version in the \code{DESCRIPTION}
#'     and \code{NEWS} files. As a default, the help and the reference
#'     manual will be styled and updated.
#'
#' @details When publishing a new release, use \code{type} one of
#'     c("major", "minor", "fix"), depending of which release type
#'     it is.
#'
#'     When \code{type = "first"}, the \code{NEWS} will be created with
#'     the template for the first release. If
#'     \code{\link{create_NVIpkg_skeleton}}
#'     has been used to create the package, the \code{DESCRIPTION}
#'     and \code{NEWS} files should already have been created with
#'     correct version number and \code{NEWS} template.
#'
#'     When \code{type = "develop"}, the \code{NEWS} will be created
#'     with the template for the next release if the previous version
#'     was a release. If not, it increased the development version.
#'
#' @template pkg
#' @template pkg_path
#' @param type [\code{character(1)}]\cr
#' The type of update to perform. Must be one of
#'     c("major", "minor" , "fix" , "develop" , "first").
#'     Defaults to "develop".
#' @param document [\code{logical(1)}]\cr
#' Should styling be performed and documentation be updated. Defaults to \code{FALSE}.
#' @param \dots Other arguments to be passed to \code{\link{document_NVIpkg}}.
#'
#' @return None. Modifies \code{NEWS} and \code{DESCRIPTION} and eventually
#'     updates help.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Modifies \code{NEWS} and \code{DESCRIPTION} with new version number.
#' # You need to be in a package directory at you PC for the code to work.
#' pkg <- stringi::stri_extract_last_words(usethis::proj_path())
#' pkg_path = usethis::proj_path()
#'
#' NVIpackager::increase_NVIpkg_version(pkg = pkg,
#'                                      pkg_path = pkg_path,
#'                                      type = "develop")
#'
#' # If you publish a new release, you want to ensure that documentation is up to date.
#' NVIpackager::increase_NVIpkg_version(pkg = pkg,
#'                                      pkg_path = pkg_path,
#'                                      type = "minor",
#'                                      document = TRUE)
#' }
#'
increase_NVIpkg_version <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                                    pkg_path = usethis::proj_path(),
                                    type = "develop",
                                    document = FALSE,
                                    ...) {

  # Argument checking ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # Perform checks
  checks <- assert_pkg_path(pkg = pkg, pkg_path = pkg_path, add = checks)
  checkmate::assert_choice(x = type, choices = c("major", "minor", "fix", "develop", "first"), add = checks)
  checkmate::assert_flag(x = document, add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)

  version <- desc::desc_get_field(key = "Version")
  version_split <- unlist(strsplit(version, ".", fixed = TRUE))

  template <- NULL
  date <- format(Sys.Date(), "%Y-%m-%d")

  if (type == "first") {
    date <- paste0(substr(date, 1, 4), "-##-##")
    version <- "0.0.0.9000"
    template <- "first"
  }

  if (type == "develop") {
    date <- paste0(substr(date, 1, 4), "-##-##")
    if (length(version_split) == 3) {
      version_split[4] <- "9000"
      template <- "develop"
    } else {
      version_split[4] <- as.character(as.numeric(version_split[4]) + 1)
    }
  }

  if (type == "fix") {
    version_split[3] <- as.character(as.numeric(version_split[3]) + 1)
    version_split <- version_split[c(1:3)]
  }

  if (type == "minor") {
    version_split[2] <- as.character(as.numeric(version_split[2]) + 1)
    version_split[3] <- 0
    version_split <- version_split[c(1:3)]
  }

  if (type == "major") {
    version_split[1] <- as.character(as.numeric(version_split[1]) + 1)
    version_split[2] <- 0
    version_split[3] <- 0
    version_split <- version_split[c(1:3)]
  }
  version <- paste(version_split, collapse = ".")

  # Increase Description version
  desc::desc_set("Date" = date)
  desc::desc_set("Version" = version)

  # Increase News version
  update_news(pkg = pkg,
              pkg_path = pkg_path,
              template = template)

  # Create manual. The file name includes version number.
  if (isTRUE(document)) {
    document_NVIpkg(pkg = pkg,
                    pkg_path = pkg_path,
                    style = TRUE,
                    manual = "update",
                    contributing = TRUE,
                    readme = TRUE, ...)
  }

}
