library(NVIpackager)

NVIpackager::create_NVIpkg_skeleton()

usethis::use_data_raw()

pkg_path = usethis::proj_path()
pkg <- stringi::stri_extract_last_words(pkg_path)
NVIpackager::document_NVIpkg(pkg = pkg,
                             pkg_path = pkg_path,
                             style = TRUE,
                             contributing = TRUE,
                             readme = TRUE,
                             scope = c("spaces", "line_breaks"))
