# TEST, DOCUMENT AND BUILD NVIdb PACKAGE

# SET UP ENVIRONMENT ----
# rm(list = ls())    # Benyttes for å tømme R-environment ved behov

# Attach packages
# library(devtools)
# library(roxygen2)
library(NVIpackager)
# library(spelling)

# Global variables

pkg_path = usethis::proj_path()
pkg <- stringi::stri_extract_last_words(pkg_path)
# Rlibrary <- R.home()

# create_NVIpkg_skeleton(license_keyword = "CC BY 4.0")

# DOCUMENTATION AND STYLING ----
# Creates new help files
# Should be run before git push when documentation for functions have been changed
NVIpackager::document_NVIpkg(pkg = pkg,
                             pkg_path = pkg_path,
                             style = TRUE,
                             contributing = FALSE,
                             readme = FALSE,
                             scope = c("spaces", "line_breaks"))


# spelling::spell_check_package(vignettes = TRUE, use_wordlist = TRUE)


# Alternative for creating the PDF-manual. The manual is not put in the correct directory
# system(paste(shQuote(file.path(R.home("bin"), "R")),
#              "CMD",
#              "Rd2pdf",
#              paste0("../", pkg)))
# file.copy(from = paste0(pkg, ".pdf"), to = "./vignettes", overwrite = TRUE)
# file.remove(".Rd2pdf16372")
# file.remove("NVIdb.pdf")
# check .install_extras

# TEST PACKAGE ----
# Run tests included in ./tests.
devtools::test()

# Test package coverage
# DETACH PACKAGE
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
# Test built package.
# Thereby, no problems with files in .Rbuildignore.
version <- utils::packageVersion(pkg, lib.loc = paste0(pkg_path,"/.."))
devtools::check_built(path = paste0("../", pkg, "_", version, ".tar.gz"), args = c("--no-tests"), manual = TRUE)

# Extensive checking of package. Is done after build. Creates PDF-manual
# system("R CMD check --ignore-vignettes ../NVIdb")


# INSTALL PACKAGE ----

NVIpackager::install_NVIpkg(pkg = pkg, pkg_path = pkg_path, rsource = "local")

# NVIpackager::install_NVIpkg(pkg = pkg, pkg_path = pkg_path, rsource = "github", username = "PetterHopp")
#
# NVIpackager::install_NVIpkg(pkg = pkg, pkg_path = pkg_path, rsource = "github", username = "NorwegianVeterinaryInstitute")
#
# # # Install from source file in catalog "NVIverse"
# utils::install.packages(pkgs = paste0(NVIconfig:::path_NVI["NVIverse"], "/", pkg, "/Arkiv/", pkg, "_", version, ".tar.gz"),
#                         repos = NULL,
#                         type = "source")
#
# # Install from binary file in catalog "NVIverse"
# install.packages(pkgs = paste0(NVIconfig:::path_NVI["NVIverse"], "/", pkg, "/Arkiv/", pkg, "_", version, ".zip"),
#                  repos = NULL,
#                  type = "binary")

# ATTACH PACKAGE ----
utils::help(package = (pkg))

library(package = pkg, character.only = TRUE)


