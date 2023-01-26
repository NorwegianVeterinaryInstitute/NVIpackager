# Alternative ways for installation of NVIverse packages

# library(devtools)

pkg <- stringi::stri_extract_last_words(usethis::proj_path())
pkg_path = usethis::proj_path()

NVIpackager::install_NVIpkg(pkg = pkg, pkg_path = pkg_path, rsource = "local")

# NVIpackager::install_NVIpkg(pkg = pkg, pkg_path = pkg_path, rsource = "github", username = "PetterHopp")
#
# NVIpackager::install_NVIpkg(pkg = pkg, pkg_path = pkg_path, rsource = "github", username = "NorwegianVeterinaryInstitute")
#


# # Install from NorwegianVeterinaryInstitute at GitHub
# remotes::install_github(paste0("NorwegianVeterinaryInstitute/", pkg),
#                         upgrade = FALSE,
#                         build = TRUE,
#                         build_vignettes = TRUE)
#
#
# # Install from personal repository at GitHub
# remotes::install_github(paste0("PetterHopp/", pkg),
#                         upgrade = FALSE,
#                         build = TRUE,
#                         build_vignettes = TRUE)
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


