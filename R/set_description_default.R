#' @title Set default Values for the \code{DESCRIPTION} file
#' @description Set default Values for the \code{DESCRIPTION} file. The values are saved
#'     as the option \code{usethis.description}.
#'
#' @details These options are used when creating the package skeleton in the script
#'     \code{create_NVIpackage_skeleton.R}. The following standard values are given:
#'
#' \itemize{
#'   \item "Petter Hopp" with role c("aut", "cre")
#'   \item "Norwegian Veterinary Institute" with role = cph"
#'   \item registertype (categories for locations and addresses)
#'   \item URL: "https://github.com/NorwegianVeterinaryInstitute/NVIpkg"
#'   \item BugReports: "https://github.com/NorwegianVeterinaryInstitute/NVIpkg/issues"
#'   \item License: license_keyword "+ file LICENSE",
#'   \item Language: "en-GB",
#'   \item Depends:= "R (>= 4.0.0)"
#' }
#'     The function accepts a short list of the listed license keywords accepted
#'     at Cran in "./share/license/license.db" in R home. If you need any  other
#'     license than in the short list, submit an issue.
#'
#' @template pkg
#' @param license_keyword  \[\code{character}\]\cr
#'     The keyword for the package's license in accord with list of license keywords,
#'     defaults to "BSD_3_clause".
#'
#' @return None. Writes the options to the option \code{usethis.description}.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' library(NVIpackager)
#' set_description_default()
#' }
#'
#'
#' # set up standards for DESCRIPTION file ----
set_description_default <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                                    license_keyword = "BSD_3_clause") {
  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()

  # Perform checks
  # pkg
  checkmate::assert_character(x = pkg, min.chars = 2, len = 1, add = checks)
  # license_keyword
  checkmate::assert_choice(x = license_keyword,
                           choices = c("BSD_2_clause", "BSD_3_clause",
                                       "CC BY 4.0", "CC BY-SA 4.0",
                                       "GPL-2", "GPL-3", "LGPL-2.1", "LGPL-3",
                                       "MIT"),
                           add = checks)

  # Report check-results
  checkmate::reportAssertions(checks)

  # RUN SCRIPT ----
  options(
    usethis.description = list(
      `Authors@R` = 'c(person(given = "Petter",
           family = "Hopp",
           role = c("aut", "cre"),
           email = "Petter.Hopp@vetinst.no",
           comment = c(ORCID = "0000-0002-8695-0378")),
    person(given = "Norwegian Veterinary Institute",
           role = "cph"))',
      URL = paste0("https://github.com/NorwegianVeterinaryInstitute/", pkg),
      BugReports = paste0("https://github.com/NorwegianVeterinaryInstitute/", pkg, "/issues"),
      License = paste(license_keyword, "+ file LICENSE"),
      Language = "en-GB",
      Depends = "R (>= 4.0.0)"
    )
  )
}
