#' @title Update copyright year in the license
#' @description Update copyright year in the LICENSE file. The
#'     copyright years are given as a range from the first year
#'     to the current year.
#' @details The copyright years will only be updated for the
#'     given copyright owner This to avoid that copyright for
#'     other copyright owners are updated if more than one.
#' @template pkg
#' @template pkg_path
#' @param copyright_owner [\code{character(1)}]\cr
#' The copyright owner in the copyright statement. Defaults
#'     to "Norwegian Veterinary Institute".
#' @return None. Writes the LICENSE file.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Used when are in the package directory
#' update_license()
#' }
#'
update_license <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                           pkg_path = usethis::proj_path(),
                           copyright_owner = "Norwegian Veterinary Institute") {
  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # assertions
  checks <- assert_pkg_path(pkg = pkg, pkg_path = pkg_path, add = checks)
  checkmate::assert_string(x = copyright_owner, add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)

  # RUN SCRIPT ----
  # read LICENSE
  license <- readLines(file.path(pkg_path, "LICENSE"))
  # updates copyright statement
  copyright <- license[grep(pattern = paste0("^Copyright[[:print:]]*", copyright_owner, "$"), license)]
  first_copyright_year <- substr(gsub(".*?([0-9]+).*", "\\1", copyright), 1, 4)
  copyright_year <- format(Sys.Date(), "%Y")
  if (first_copyright_year < copyright_year) {copyright_year <- paste(first_copyright_year, "-", copyright_year)}
  copyright <- paste("Copyright (c)", copyright_year, copyright_owner)
  license[grep(pattern = paste0("^Copyright[[:print:]]*", copyright_owner, "$"), license)] <- copyright

  # writes LICENSE
  writeLines(license, file.path(pkg_path, "LICENSE"))
}
