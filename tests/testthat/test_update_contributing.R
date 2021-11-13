

# Attach packages and set up with temporary directory
library(NVIpackager)
td <- tempdir()

if (!dir.exist(file.path(td, "NVIpkg"))) {
  dir.create(file.path(td, "NVItest"))
}
if (!dir.exist(file.path(td, "NVItest", "vignettes" ))) {
  dir.create(file.path(td, "NVItest", "vignettes"))
}

test_that("Update contributing", {

  update_contributing(pkg = "NVItest", pkg_path = file.path(td, "NVItest"))

  expect_true(file.exists(paste0(td, "/vignettes/Contribute_to_NVItest.Rmd")))

  expect_true(file.exists(paste0 (td, "/CONTRIBUTING.md")))
})
