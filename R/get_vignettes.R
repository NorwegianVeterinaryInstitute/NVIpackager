#' @title Gets the title of the package vignettes
#' @description Gets the title of the vignettes in the package. The function is intended for listing the vignette titles in README.
#' @details The title is extracted from the vignette files in the package directory ./vignettes/. to make it possible to extract the information before the package is installed. This in contrast to \code{base::vignettes} that get the titles from the installed package.
#' @param path [\code{character(1)}]\cr
#' directory with vignettes. Defaults to subdirectory "vignettes" in the package directory.
#' @return character vector with vignette titles.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Used when are in the package directory
#' get_vignettes()
#' }
#'
get_vignettes <- function(path = file.path(usethis::proj_path(), "vignettes")) {
  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # Perform checks
  # path
  checkmate::assert_directory_exists(x = path,
                                     add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)

  # READ ALL VIGNETTE FILES NAMES IN THE DIRECTORY
  filelist <- list.files(path = path, pattern = "\\.Rmd$|\\.asis$", ignore.case = TRUE)

  # FIND VIGNETTE TITLE IN VIGNETTE FILES
  for (i in filelist) {
    # Read the vignette title for each vignette
    vignette <- readLines(file.path(path, i))
    vignette <- grep("VignetteIndexEntry", vignette, value = TRUE, fixed = TRUE)
    # vignette <- sub(pattern = "(?<=\\{).+?(?=\\})", "", vignette)
    vignette <- stringr::str_extract_all(vignette, "(?<=\\{).+?(?=\\})")[[1]]

    # Include file format based on file ending (Rmd -> html, asis -> pdf)
    if (grepl("\\.Rmd$", i)) {vignette <- paste(vignette, "(html)")}
    if (grepl("\\.asis$", i)) {vignette <- paste(vignette, "(pdf)")}

    # Create vector with all vignette titles
    if (!exists("vignettes")) {
      vignettes <- vignette
    } else {
      vignettes <- c(vignettes, vignette)
    }
  }
  vignettes <- unique(vignettes)
  vignettes <- vignettes[order(vignettes)]

  # RETURN VIGNETTE NAMES
  return(vignettes)
}
