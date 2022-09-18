#' @title Create the package skeleton for NVIverse packages
#' @description Creates the package skeleton in agreement with the conventions
#'     developed for NVIverse packages. \code{create_NVIpkg_skeleton} should be
#'     run once after a GitHub repository has been synchronized with the the
#'     package directory.
#'
#' @details \code{create_NVIpkg_skeleton} is a wrapper for several \code{usethis}
#'     -functions. It sets up the package directory with standard files and
#'     standard sub-directories. Modifies the \code{DESCRIPTION}, \code{.gitignore},
#'     and \code{.Rbuildignore} in agreement with standard dependencies for
#'     NVIverse.
#'
#'     Standard values are input to \code{DESCRIPTION}. For modifying these values,
#'     you need to modify \code{set_description_default}.
#'
#'     In addition \code{README.Rmd}-template, \code{CONTRIBUTING}, \code{CODE_OF_CONDUCT},
#'     and the vignette \code{Contribute_to_NVIpkg} are copied to the package
#'     directory and \code{develop.R} is copied to "./notes/".
#'
#'     The function accepts a short list of the listed license keywords accepted
#'     at Cran in "./share/license/license.db" in R home. If you need any  other
#'     license than in the short list, submit an issue.
#'
#' @template pkg
#' @template pkg_path
#' @param license_keyword  [\code{character}]\cr
#'     The keyword for the package's license in accord with list of license keywords,
#'     defaults to "BSD_3_clause".
#'
#' @return None.
#'     Sets up the package directories and writes and modifies several files, see details.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Attach packages and set up with temporary directory
#' library(NVIpackager)
#' td <- tempdir()
#' if (!dir.exists(file.path(td, "NVItest"))) {
#'   dir.create(file.path(td, "NVItest"))
#' }
#' # Create package skeleton in temporary directory
#' create_NVIpkg_skeleton(pkg = "NVItest", pkg_path = file.path(td, "NVItest"))
#' }
#'
create_NVIpkg_skeleton <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                                   pkg_path = usethis::proj_path(),
                                   license_keyword = "BSD_3_clause") {

  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # assertions
  checks <- assert_pkg_path(pkg = pkg, pkg_path = pkg_path, add = checks)
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
  # Create standard R-package skeleton
  set_description_default(pkg = pkg, license_keyword = license_keyword)
  usethis::create_package(path = pkg_path, rstudio = FALSE, open = FALSE)
  desc::set_desc("Date" = paste0(format(Sys.Date(), format = "%Y"), "-##-##"))
  update_news(pkg = pkg, pkg_path = pkg_path, template = "first")

  # Modify the description ----
  usethis::use_package(package = "checkmate", type = "Imports", min_version = "2.1.0")
  usethis::use_package(package = "knitr", type = "Imports")
  usethis::use_package(package = "rmarkdown", type = "Imports")
  usethis::use_dev_package(package = "NVIcheckmate",
                           type = "Imports",
                           remote = "github::NorwegianVeterinaryInstitute/NVIcheckmate")
  usethis::use_dev_package(package = "NVIrpackages",
                           type = "Imports",
                           remote = "github::NorwegianVeterinaryInstitute/NVIrpackages")
  usethis::use_package(package = "devtools", type = "Suggests")
  usethis::use_dev_package(package = "NVIpackager",
                           type = "Suggests",
                           remote = "github::NorwegianVeterinaryInstitute/NVIpackager")

  # Add files to .gitignore
  usethis::use_git_ignore(ignores = "*.Rproj")

  # Make extra directories
  usethis::use_directory(path = "notes", ignore = FALSE)
  # Add files to .Rbuildignore
  usethis::use_build_ignore(files = "notes", escape = TRUE)


  # Add dummy for package level documentation.
  # Package level documentation based on DESCRIPTION will be added as an Rd-file when running devtools::document
  usethis::use_package_doc(open = FALSE)

  # Prepare for vignettes ----
  # Use Contribute_to_mypkg as the name for an example vignette. This vigntte is created later based on a template
  usethis::use_vignette(name = paste0("Contribute_to_", pkg), title = paste("Contribute to", pkg))
  usethis::use_build_ignore(files = "CONTRIBUTING.md", escape = TRUE)

  # set up test structure ----
  usethis::use_testthat()
  # spell check ask if shall overwrite file
  # usethis::use_spell_check(vignettes = TRUE, lang = "en-GB", error = FALSE)
  # spelling::spell_check_setup <- function(pkg = ".",
  #                               vignettes = TRUE,
  #                               lang = "en-GB",
  #                               error = FALSE)

  # usethis::use_coverage()




  # INCLUDE TEMPLATES ----
  # Add README.Rmd template
  # read template
  readme <- readLines(system.file('templates', "README.Rmd", package = "NVIpackager"))
  # give correct package name
  readme <- gsub("_package_name_", pkg, readme)
  # give first license year
  readme <- gsub("20##", format(Sys.Date(), "%Y"), readme)
  # save with name of package in filename
  writeLines(readme, paste0(pkg_path, "/README.Rmd"))

  usethis::use_build_ignore(files = "README.Rmd", escape = TRUE)

  author <- eval(str2expression(desc::desc_get_field(key = "Authors@R")))
  email <- NA
  for (i in 1:length(author)) {
    while (is.na(email)) {
      if (grep("cre", author[i])) {
        email <- unlist(author[i])
        email <- email["email"]
      }
    }
  }
  usethis::use_code_of_conduct(contact = email)

  update_contributing()

  update_develop(pkg = pkg, pkg_path = pkg_path)

}
