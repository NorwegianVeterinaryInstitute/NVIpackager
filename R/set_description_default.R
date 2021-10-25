#' @title Set default Values for the \code{DESCRIPTION}
#' @description Set default Values for the \code{DESCRIPTION}. The values are saved
#'     as the option \code{usethis.description}.
#'
#' @details These options are used when creatingg the package skeleton by
#'     \code{create_NVIpackage_skeleton}.
#'
#'     There is a list of license keywords at
#'     \link{GitHub}[https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository]
#'
#' @param pkg The package name.
#' @param license_keyword The abbreviation for the license that the package will use.
#'
#' @return None. Writes the options to the option  \code{usethis.description}.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
# set_description_default()
#' }


# set up standards for DESCRIPTION file ----
set_description_default <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                                    license_keyword = "BSD_3_clause") {
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
