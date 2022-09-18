#' @title Update NEWS
#' @description Create or update the NEWS file. It will include a template for New section if relevant and update the version number.
#'
#' @details Default is  is \code{template = NULL} that will only update the version number.
#'     Use \code{template = "first"} to make the NEWS template for the first
#'     release of the package. Use \code{template = "develop"} to make the NEWS
#'     template for the successive releases of the package.
#'
#' @template pkg
#' @template pkg_path
#' @param template The template to add to the NEWS file Can be c("first", "develop").
#'     Defaults to NULL.
#'
#' @return None. Creates or updates the NEWS file in the package directory.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Create the first NEWS file
#' library(NVIpackager)
#' update_news(template = "first")
#' }
update_news <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                        pkg_path = usethis::proj_path(),
                        template = NULL) {

  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # assertions
  checks <- assert_pkg_path(pkg = pkg, pkg_path = pkg_path, add = checks)
  checkmate::assert_choice(template, choices = c("first", "develop"), null.ok = TRUE, add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)

  # RUN SCRIPT ----

  # Fetch version and date from DESCRIPTION and generate header
  header <- paste(paste(desc::desc_get_field(key = "Package"),
                        desc::desc_get_field(key = "Version"),
                        paste0("- (", desc::desc_get_field(key = "Date"), ")")))

  # If NEWS exist read in file
  if (file.exists(file.path(pkg_path, "NEWS"))) {
    history <- readLines(con = file.path(pkg_path, "NEWS"))
  } else {
    history <- ""
  }

  # If template = "first", then make first template for NEWS in a package. This
  #    is only relevant when the file NEWS doesn't exist.
  if (template == "first") {
    if (!file.exists(file.path(pkg_path, "NEWS"))) {
      template_text <- c("----------------------------------------",
                         "",
                         "First release:",
                         "",
                         paste0(desc::desc_get_field(key = "Title"), ":"),
                         "",
                         "- `function1` description")
    }
  }

  # If template = "develop" update with development version number and include
  #     headlines for potential changes.
  if (template == "develop") {
    template_text <- c("----------------------------------------",
                       "",
                       "New features:",
                       "",
                       "-",
                       "",
                       "",
                       "Bug fixes:",
                       "",
                       "-",
                       "",
                       "",
                       "Other changes:",
                       "",
                       "-",
                       "",
                       "",
                       "BREAKING CHANGES:",
                       "",
                       "-",
                       "",
                       "")
  }

  # WRITE THE NEWS FILE ----
  if (is.null(template)) {
    history <- history[2:length(history)]
    writeLines(text = c(header, history),
               con = file.path(pkg_path, "NEWS"))
  } else {
    writeLines(text = c(header, template_text, history),
               con = file.path(pkg_path, "NEWS"))
  }
}
