#' @title Update \code{README.md}
#' @description Update \code{README.md} 
#'     from \code{README.Rmd} and child templates in \code{NVIpackager}. If the file don't exist, it is created.
#'
#' @details The child templates are found in \code{NVIpackager}. Any change in this 
#'     text must be done in the templates.
#'
#' @template pkg 
#' @template pkg_path 
#'
#' @return None.
#'     Writes the file \code{README.md}. 
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Attach packages and set up with temporary directory
#' library(NVIpackager)
#' td <- tempdir()
#'
#'  update_readme(pkg = "pkg")
#' }

update_readme <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                                pkg_path = usethis::proj_path()) {

  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # assertions
  assert_pkg_path(pkg = pkg, pkg_path = pkg_path)
  # Report check-results
  checkmate::reportAssertions(checks)

  # RUN SCRIPT ----
  # For updating README.md.
  rmarkdown::render(input = paste0(pkg_path, "/README.Rmd"),
                    output_format = "md_document",
                    output_file = "README.md",
                    output_dir = pkg_path)
  header <- paste0("# READ ME" , "\n")
  writeLines(c(header,readLines(paste0(pkg_path, "/README.md"))),
             paste0(pkg_path, "/README.md"))
}