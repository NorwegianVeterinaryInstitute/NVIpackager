# TEST, DOCUMENT AND BUILD NVIdb PACKAGE

# Set up environment
# rm(list = ls())    # Benyttes for å tømme R-environment ved behov

pkg <- stringi::stri_extract_last_words(usethis::proj_path())

Rlibrary <- R.home()

library(devtools)
library(roxygen2)
library(NVIpackager)
# library(withr)

# Creates new help files
# Should be run before git push when documentation for functions have been changed
NVIpackager::document_NVIpkg(style = FALSE,
                             contributing = FALSE,
                             readme = FALSE)
# devtools::document()
#
# # For updating README.md when the Rmd-file has been updated.
# NVIpackager::update_readme()
#
# NVIpackager::update_contributing()

# Alternative for creating the PDF-manual. The manual is not put in the correct directory
# system(paste(shQuote(file.path(R.home("bin"), "R")),
#              "CMD",
#              "Rd2pdf",
#              paste0("../", pkg)))
# file.copy(from = paste0(pkg, ".pdf"), to = "./vignettes", overwrite = TRUE)
# file.remove(".Rd2pdf16372")
# file.remove("NVIdb.pdf")
# check .install_extras

# Run tests included in ./tests.
devtools::test()

# Test package coverage
# DETACH PACKAGE ----
# The package must be detached to install it.
if(pkg %in% (.packages())){
  pkgname <- paste0("package:", pkg)
  detach(pkgname, unload=TRUE, character.only = TRUE)
}
code_coverage <- covr::package_coverage(path = ".", group = "functions")
print(x = code_coverage, group = "functions")

# devtools::build_manual(pkg = "../NVIpackager", path = "./vignettes")

# Build the package
devtools::build(binary = FALSE, manual = TRUE, vignettes = TRUE)

version <- packageVersion(pkg, lib.loc = paste0(getwd(),"/.."))
devtools::check_built(path = paste0("../", pkg, "_", version, ".tar.gz"), args = c("--no-tests"), manual = TRUE)

# Extensive checking of package. Is done after build. Creates PDF-manual
# system("R CMD check --ignore-vignettes ../NVIdb")
