#' @title Update reference manual
#' @description Update the PDF reference manual and save it together with the vignettes.
#'
#' @details The default is \code{manual = "update"} that will update the reference
#'     manual if it exists, but will do nothing if it doesn't exist. Use
#'     \code{manual = "include"} to make the reference manual for the first time.
#'     For both \code{manual = c("include", "update")}, the \code{DESCRIPTION} and
#'     \code{.gitignore} will be checked and modified if necessary and the "pkgname.pdf.asis"
#'     will be created in addition to the reference manual "pkgname.pdf".
#'
#'     Use \code{manual = "remove"} to remove the reference manual. This will remove
#'     the reference manual "pkgname.pdf" and the file "pkgname.pdf.asis" and modify
#'     \code{.gitignore}. Any changes that have been done to the \code{DESCRIPTION} will not
#'     be reversed as these may also be used by other processes. If these should be
#'     reversed, it must be done manually.
#'
#' @template pkg
#' @template pkg_path
#' @param manual [\code{character(1)}]\cr
#' Must be one of c("include", "update", "remove"), see details. Defaults to
#'     "update".
#'
#' @return None. Creates or updates the PDF reference manual in directory "./vignettes/".
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Update the reference manual if it already exists
#' library(NVIpackager)
#' update_reference_manual(manual = "update")
#' }
update_reference_manual <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                                    pkg_path = usethis::proj_path(),
                                    manual = "update") {

  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # assertions
  checks <- assert_pkg_path(pkg = pkg, pkg_path = pkg_path, add = checks)

  checkmate::assert_choice(manual, choices = c("include", "update", "remove"), add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)

  # RUN SCRIPT ----

  # If manual = "update" and the manual exists, then do exactly the same as for manual = "install"
  if (manual == "update") {
    if (file.exists(file.path(pkg_path, "vignettes", paste0(pkg, ".pdf")))) {
      manual <- "include"
    }
  }

  # If manual = "include" update manual and ensure that all settings are as they should be
  if (manual == "include") {
    # Create manual. The file name includes version number.
    devtools::build_manual(path = file.path(pkg_path, "vignettes"))

    # Rename to file name without version number. If the file already exists, it is replaced.
    file.rename(from = file.path(pkg_path, "vignettes", paste0(pkg, "_", desc::desc_get_field(key = "Version"), ".pdf")),
                to = file.path(pkg_path, "vignettes", paste0(pkg, ".pdf")))

    # Create and replace file with instructions for R.rsp to include pdf-file among vignettes.
    asis <- rbind(paste0("%\\VignetteIndexEntry{", pkg, " reference manual}"),
                  "%\\VignetteEngine{R.rsp::asis}",
                  "%\\VignetteKeyword{PDF}")
    writeLines(asis, con = file.path(pkg_path, "vignettes", paste0(pkg, ".pdf.asis")))

    # Update DESCRIPTION
    # Include R.rsp in import
    usethis::use_package(package = "R.rsp", type = "Imports")

    # Include R.rsp in vignettebuilder if not already included
    VignetteBuilder <- desc::desc_get_field(key = "VignetteBuilder", default = NULL)
    if (length(grep("R.rsp", VignetteBuilder)) == 0) {
      VignetteBuilder <- c(VignetteBuilder, "R.rsp")
      desc::desc_set_list(key = "VignetteBuilder", list_value = VignetteBuilder)
    }

    # read .gitignore
    gitignore <- readLines(file.path(pkg_path, ".gitignore"))
    # save with name of package in filename
    if (identical(grep(paste0("!vignettes/", pkg, ".pdf"), gitignore, fixed = TRUE), integer(0))) {
    gitignore <- c(gitignore, paste0("!vignettes/", pkg, ".pdf"), "")
    writeLines(gitignore, file.path(pkg_path, ".gitignore"))
    }


  }

  if (manual == "remove") {
    if (file.exists(file.path(pkg_path, "vignettes", paste0(pkg, ".pdf.asis")))) {
      file.remove(file.path(pkg_path, "vignettes", paste0(pkg, ".pdf.asis")))
    }
    # Remove all files that consists of pkgname, version numbers and pdf
    filename <- list.files(path = file.path(pkg_path, "vignettes"), pattern = pkg, ignore.case = TRUE, include.dirs = FALSE)
    ## In accord with pattern
    filename <- filename[grepl("\\.pdf$", tolower(filename))]
    if (length(filename) > 0) {
      filelist <- as.data.frame(filename)
      filelist$manual <- grepl(paste0("^", pkg, "_*[0123456789\\.]{1,17}", "pdf$"), filelist$filename)
      for (i in c(1:dim(filelist)[1])) {
        if (filelist[i, "manual"]) {
          file.remove(file.path(pkg_path, "vignettes", filelist[i, "filename"]))
        }
      }
    }
    # read .gitignore
    gitignore <- readLines(file.path(pkg_path, ".gitignore"))
    # save with name of package in filename
    gitignore[!grepl(paste0("!vignettes/", pkg, ".pdf"), gitignore, fixed = TRUE)]
      writeLines(gitignore, file.path(pkg_path, ".gitignore"))
    }

  }
