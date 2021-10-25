# Alternative ways for installation of NVIverse packages

# library(devtools)

pkg <- stringi::stri_extract_last_words(usethis::proj_path())

Rlibrary <- R.home()

library(withr)

# DETACH PACKAGE ----
# The package must be detached to install it.
if(pkg %in% (.packages())){
  pkgname <- paste0("package:", pkg)
  detach(pkgname, unload=TRUE, character.only = TRUE)
}


# INSTALL PACKAGE ----
# Install from working directory
withr::with_libpaths(paste0(Rlibrary,"/library"),
                     devtools::install(getwd(),
                                       dependencies = c("Depends", "Imports", "LinkingTo"),
                                       upgrade=FALSE,
                                       build_vignettes = TRUE)
)

# Install from NorwegianVeterinaryInstitute at GitHub
remotes::install_github(paste0("NorwegianVeterinaryInstitute/", pkg),
                        upgrade = FALSE,
                        build = TRUE,
                        build_manual = TRUE,
                        build_vignettes = TRUE)


# Install from personal repository at GitHub
remotes::install_github(paste0("PetterHopp/", pkg),
                        upgrade = FALSE,
                        build = TRUE,
                        build_manual = TRUE,
                        build_vignettes = TRUE)


# # Install from source file in catalog "NVIverse"
utils::install.packages(pkgs = paste0(NVIconfig:::path_NVI["NVIverse"], "/", pkg, "/Arkiv/", pkg, "_", version, ".tar.gz"),
                        repos = NULL,
                        type = "source")
#
# # Install from binary file in catalog "NVIverse"
# install.packages(pkgs = paste0(NVIconfig:::path_NVI["NVIverse"], "/", pkg, "/Arkiv/", pkg, "_", version, ".zip"),
#                  repos = NULL,
#                  type = "binary")

# ATTACH PACKAGE ----
utils::help(package = (pkg))

library(package = pkg, character.only = TRUE)


