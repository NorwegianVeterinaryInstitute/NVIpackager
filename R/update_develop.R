#' @title Update \code{develop.R}
#' @description Update \code{develop.R} from the template in \code{NVIpackager}.
#'     If the file already exist, it is overwritten.
#'
#' @details "develop.R" is a script comprising code for creating, documenting,
#'     testing and installing a package during development and maintainance. All
#'     code should be written without reference to a specific package, so that
#'     the script can be used without modification in development and maintainance
#'     of all NVIverse packages.
#'
#'     The template is found in \code{NVIpackager}. Any change in the script
#'     should be done in the template. Thereby, it is easier to keep the script
#'     updated in all packages.
#'
#' @template pkg
#' @template pkg_path
#'
#' @return None. Writes the R script "develop.R" to "./notes/".
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Updates the script develop.R
#' update_develop()
#' }
#'
update_develop <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                                pkg_path = usethis::proj_path()) {

  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # assertions
  checks <- assert_pkg_path(pkg = pkg, pkg_path = pkg_path, add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)

  # RUN SCRIPT ----
  # Create ./notes if it doesn't exist
  if (!dir.exists(file.path(pkg_path, "notes"))) {
    dir.create(path = file.path(pkg_path, "notes"))
  }
  # Copy develop.R from template to ./notes
  file.copy(from = system.file('templates', "develop.R", package = "NVIpackager"),
            to = file.path(pkg_path, "notes", "develop.R"),
            overwrite = TRUE)
}
