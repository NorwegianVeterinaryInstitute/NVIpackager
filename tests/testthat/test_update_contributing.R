

# Attach packages and set up with temporary directory
library(NVIpackager)
td <- tempdir()

if (!dir.exists(file.path(td, "NVItest"))) {
  dir.create(file.path(td, "NVItest"))
}
if (!dir.exists(file.path(td, "NVItest", "vignettes" ))) {
  dir.create(file.path(td, "NVItest", "vignettes"))
}

test_that("Update contributing", {

  update_contributing(pkg = "NVItest", pkg_path = file.path(td, "NVItest"))

  expect_true(file.exists(paste0(td, "/NVItest/vignettes/Contribute_to_NVItest.Rmd")))

  expect_true(file.exists(paste0 (td, "/NVItest/CONTRIBUTING.md")))
})
