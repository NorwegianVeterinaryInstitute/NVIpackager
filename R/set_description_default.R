#' @title Set default Values for the \code{DESCRIPTION} file
#' @description Set default Values for the \code{DESCRIPTION} file. The values are saved
#'     as the option \code{usethis.description}.
#'
#' @details These options are used when creating the package skeleton in the script
#'     \code{create_NVIpackage_skeleton.R}.
#'
#'     There is a list of license keywords at
#'     [GitHub](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository)
#'
#' @template pkg
#' @param license_keyword The keyword for the package's license in accord with list of license keywords.
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


# set up standards for DESCRIPTION file ----
set_description_default <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                                    license_keyword = "BSD-3-clause") {
  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()

  # Perform checks
  # pkg
  checkmate::assert_character(x = pkg, min.chars = 2, len = 1, add = checks)
  # license_keyword
  NVIcheckmate::assert_choice_character(x = license_keyword,
                                        choices = c("apache-2.0", "bsd-3-clause", "bsd-3-clause-clear",
                                                    "cc0-1.0", "cc-by-4.0", "cc-by-sa-4.0",
                                                    "gpl-2.0", "gpl-3.0", "lgpl-2.1", "lgpl-3.0",
                                                    "mit"),
                                        ignore.case = TRUE,
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
      Language =  "en-GB",
      Depends = "R (>= 4.0.0)"
    )
  )
}
