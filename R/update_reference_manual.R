update_reference_manual <- function(pkg = stringi::stri_extract_last_words(usethis::proj_path()),
                                    pkg_path = usethis::proj_path(),
                                    manual) {

  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # assertions
  assert_pkg_path(pkg = pkg, pkg_path = pkg_path)

  NVIcheckmate::assert_choice_character(manual, choices = c("include", "update", "remove"), add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)

  # RUN SCRIPT ----
  # update
  # Check if manual is included, update if included
  # install
  # install even if not included, if included, update
  # make pkg.pdf.asis
  # create manual
  # update description with
  # suggests: R.rsp (imports?)
  # VignetteBuilder: R.rsp


  devtools::build_manual(path = file.path(pkg_path, "vignettes"))

  file.rename(from = file.path(pkg_path, "vignettes", paste0(pkg, "_", desc::desc_get_field(key = "Version"), ".pdf")),
                              to = file.path(pkg_path, "vignettes", paste0(pkg, ".pdf")))

  asis <- rbind(paste0("%\\VignetteIndexEntry{", pkg, " reference manual}"),
                "%\\VignetteEngine{R.rsp::asis}",
                "%\\VignetteKeyword{PDF}")
  writeLines(asis, con = file.path(pkg_path, "vignettes", paste0(pkg, ".pdf.asis")))

  usethis::use_package(package = "R.rsp", type = "Imports")


  # must update description vignettebuilder.
  # MUST UPDATE GITIGNORE TO KEEP VIGNETTES/*.PDF

  # library(desc)
  # x <- desc::description$new(pkg_path)
  # x$get("VignetteBuilder")
  # x$set("VignetteBuilder" = c("knitr", "R.rsp"))
  # x$fields()
  # Rd2md::ReferenceManual(outdir = "./vignettes")
  # NVIpkg <- "NVIdb"

}
