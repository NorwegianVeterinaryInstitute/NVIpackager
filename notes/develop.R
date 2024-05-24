# CREATE, DOCUMENT, TEST AND INSTALL THE PACKAGE
# develop.r v2024-05-24
# NVIpackager::update_develop() # Update this file from template in NVIpackager

# SET UP R ENVIRONMENT ----
# rm(list = ls())    # Used to empty the environment

# Attach packages
library(NVIpackager)
# library(spelling)

# Global variables
pkg_path = usethis::proj_path()
pkg <- tail(strsplit(normalizePath(pkg_path, winslash = "/"), split = "/")[[1]], 1)

# CREATE PACKAGE SKELETON ----
# create_NVIpkg_skeleton(license_keyword = "BSD_3_clause") # BSD_3_clause # CC BY 4.0

# INCREASE PACKAGE VERSION IN DESCRIPTION AND NEWS ----
# NVIpackager::increase_NVIpkg_version(pkg = pkg,
#                                   pkg_path = pkg_path,
#                                   type = "develop",
#                                   document = FALSE)

# UPDATE LICENSE WITH COPYRIGHT YEAR ----
# NVIpackager::update_license(pkg = pkg,
#                             pkg_path = pkg_path,
#                             copyright_owner = "Norwegian Veterinary Institute")

# DOCUMENTATION AND STYLING ----
# update_logo should be run if a logo has been created (or updated). Thereafter
#   run "document_NVIpkg" with "readme = TRUE".
# update_logo(pkg = pkg, pkg_path = pkg_path)

# Creates new help files
# Should be run before git push when documentation for functions have been changed
NVIpackager::document_NVIpkg(pkg = pkg,
                             pkg_path = pkg_path,
                             style = TRUE,
                             contributing = FALSE,
                             readme = FALSE,
                             manual = "update",
                             # scope = c("spaces", "line_breaks"))
                             scope = c("spaces"))
# filename <- "xxxx.R"
# styler::style_file(path = file.path(pkg_path, "R", filename), scope = I(c("spaces")))

# spelling::spell_check_package(vignettes = TRUE, use_wordlist = TRUE)

# TEST PACKAGE ----
devtools::test()  # Run tests included in ./tests.

# Test package coverage
# The package must be detached to install it.
if(pkg %in% (.packages())){
  pkgname <- paste0("package:", pkg)
  detach(pkgname, unload=TRUE, character.only = TRUE)
}
# Test and print package coverage
code_coverage <- covr::package_coverage(path = ".", group = "functions")
print(x = code_coverage, group = "functions")

# Build the package and thereafter check (Avoids problems as files in .Rbuildignore are removed.)
devtools::build(binary = FALSE, manual = TRUE, vignettes = TRUE)
version <- utils::packageVersion(pkg, lib.loc = paste0(pkg_path,"/.."))
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

# MANUAL CHECK OF SCRIPTS ----
# Search for string
txt <- "\\.data\\$"   # \\.data\\$, dplyr, stringi, %>%, [æøåÆØÅ]
files_with_pattern <- findInFiles::findInFiles(ext = "R", pattern = txt, output = "tibble")
files_with_pattern <- findInFiles::FIF2dataframe(files_with_pattern)
package <- rep(pkg, dim(files_with_pattern)[1])
files_with_pattern <- cbind(package, files_with_pattern)

write.csv2(x = files_with_pattern,
           file = file.path("../", paste0(pkg, "_", "files_with_pattern.csv")),
           row.names = FALSE)

