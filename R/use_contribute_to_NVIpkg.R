use_contribute_to_NVIpkg <- function(pkg = stringi::stri_extract_last_words(getwd())) {
  usethis::use_vignette(name = paste0("Contribute_to_", pkg), title = paste("Contribute to", pkg))
  file.copy(from = "./inst/Rmd/Contribute_to_NVIpkg.Rmd",
            to = paste0("./vignettes/Contribute_to_", pkg, ".Rmd"),
            overwrite = TRUE)
}

