# CREATE, DOCUMENT, TEST AND INSTALL THE PACKAGE

# Update this file with the template in NVIpackager
# NVIpackager::update_develop()

# SET UP ENVIRONMENT ----
# rm(list = ls())    # Use this to empty the environment

# Attach packages
library(NVIpackager)
# library(spelling)

# Global variables
pkg_path = usethis::proj_path()
pkg <- stringi::stri_extract_last_words(pkg_path)


# CREATE PACKAGE SKELETON ----
# create_NVIpkg_skeleton(license_keyword = "CC BY 4.0")

# INCREASE PACKAGE VERSION IN DESCRIPTION AND NEWS ----
# NVIpackager::increase_NVIpkg_version(pkg = pkg,
#                                   pkg_path = pkg_path,
#                                   type = "develop")

# DOCUMENTATION AND STYLING ----
# update_logo should be run if a logo has been created (or updated). Thereafter run "document_NVIpkg" with "readme = TRUE".
# update_logo(pkg = pkg, pkg_path = pkg_path)

# Creates new help files
# Should be run before git push when documentation for functions have been changed
NVIpackager::document_NVIpkg(pkg = pkg,
                             pkg_path = pkg_path,
                             style = TRUE,
                             contributing = FALSE,
                             readme = FALSE,
                             manual = "update",
                             scope = c("spaces", "line_breaks"))

# spelling::spell_check_package(vignettes = TRUE, use_wordlist = TRUE)


# TEST PACKAGE ----
# Run tests included in ./tests.
devtools::test()

# Test package coverage
# The package must be detached to install it.
if(pkg %in% (.packages())){
  pkgname <- paste0("package:", pkg)
  detach(pkgname, unload=TRUE, character.only = TRUE)
}
# Test and print package coverage
code_coverage <- covr::package_coverage(path = ".", group = "functions")
print(x = code_coverage, group = "functions")

# Build the package and thereafter check
# Thereby, no problems with files in .Rbuildignore.
devtools::build(binary = FALSE, manual = TRUE, vignettes = TRUE)
version <- utils::packageVersion(pkg, lib.loc = paste0(pkg_path,"/.."))
# Test built package
devtools::check_built(path = paste0("../", pkg, "_", version, ".tar.gz"), args = c("--no-tests"), manual = TRUE)


# INSTALL PACKAGE ----
# From local version
NVIpackager::install_NVIpkg(pkg = pkg, pkg_path = pkg_path, rsource = "local")
# From GitHub
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


