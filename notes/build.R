# TEST, DOCUMENT AND BUILD NVIdb PACKAGE

# Set up environment
# rm(list = ls())    # Benyttes for å tømme R-environment ved behov

pkg <- stringi::stri_extract_last_words(usethis::proj_path())

Rlibrary <- R.home()

library(devtools)
library(roxygen2)
# library(withr)

# Creates new help files
# Should be run before git push when documentation for functions have been changed
devtools::document()

# For updating CONTRIBUTE.md when the vignette has been updated.
rmarkdown::render(input = paste0("./vignettes/Contribute_to_", pkg, ".Rmd"),
                  output_format = "md_document",
                  output_file = "CONTRIBUTING.md",
                  output_dir = "./")
header <- paste0("# Contribute to ", pkg, "\n")
writeLines(c(header,readLines("./CONTRIBUTING.md")),"./CONTRIBUTING.md")

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

# Build the vignette
# devtools::build_vignettes()
# vignetteRDS <- readRDS("./Meta/vignette.rds")

# devtools::build_manual(pkg = "../NVIdb", path = "./vignettes")

# Build the package
# system("R CMD build ../NVIdb")
# devtools::build(binary = TRUE)
devtools::build(binary = FALSE, manual = TRUE, vignettes = TRUE)

version <- packageVersion(pkg, lib.loc = paste0(getwd(),"/.."))
devtools::check_built(path = paste0("../", pkg, "_", version, ".tar.gz"), args = c("--no-tests"), manual = TRUE)

# Extensive checking of package. Is done after build. Creates PDF-manual
# system("R CMD check --ignore-vignettes ../NVIdb")
