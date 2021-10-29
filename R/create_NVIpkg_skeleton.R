#' @title Create the package skeleton for NVIverse packages
#' @description Creates the package skeleton in agreement with the conventions
#'     developed for NVIverse packages. \code{create_NVIpkg_skeleton} should be
#'     run once after a GitHub repository has been synchronized with the the
#'     package directory and the \code{set_description_default} has been run.
#'
#' @details \code{create_NVIpkg_skeleton} is a wrapper for several \code{usethis}
#'     -functions. It sets up the package directory with standard files and
#'     standard sub-directories. Modifies the \code{DESCRIPTION}, \code{.gitignore},
#'     and \code{.Rbuildignore} in agreement with standard dependencies for
#'     NVIverse.
#'
#'     In addition \code{README.Rmd}-template, \code{CONTRIBUTING}, \code{CODE_OF_CONDUCT},
#'     and the vignette \code{Contribute_to_NVIpkg} are copied to the package
#'     directory.
#'
#' @param pkg The package name.
#' @param pkg_path The path to the package directory.
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
#'
#' }

# pkg <- stringi::stri_extract_last_words(usethis::proj_path())

create_NVIpkg_skeleton <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                                   pkg_path = usethis::proj_path()) {

  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # assertions
  assert_pkg_path(pkg = pkg, pkg_path = pkg_path)
  # Report check-results
  checkmate::reportAssertions(checks)

  # RUN SCRIPT ----

  # Create standard R-package skeleton
  usethis::create_package(path = pkg_path, rstudio = FALSE, open = FALSE)

  # Modify the description ----
  # usethis::use_package(package = "devtools", type = "Suggests")
  usethis::use_package(package = "checkmate", type = "Imports", min_version = "2.0.0")
  usethis::use_dev_package(package = "NVIcheckmate", type = "Imports", remote = "github::NorwegianVeterinaryInstitute/NVIcheckmate")

  # Add files to .gitignore
  usethis::use_git_ignore(ignores = "*.Rproj")

  # Make extra directories
  usethis::use_directory(path = "notes" , ignore = FALSE)
  # Add files to .Rbuildignore
  usethis::use_build_ignore(files = "notes", escape = TRUE)


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
  usethis::use_code_of_conduct()

  update_contributing()

    # README.Rmd

  # NEWS.md
  # usethis::use_template("NEWS.md",
  #   data = package_data(),
  #   open = open
  # )
  # Seems like changes must be committed before use_news_md() is run
  # usethis::use_news_md(open = FALSE)



  # description_titel <- desc::desc_get_field(key = "Title")
  # description_descr <- desc::desc_get_field(key = "Description")

  # use_logo(img, geometry = "240x278", retina = TRUE)
  # use_package_doc(open = FALSE)
}
