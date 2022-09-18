
# Attach packages and set up with temporary directory
library(testthat)
library(NVIpackager)
td <- tempdir()
if (!dir.exists(file.path(td, "NVItest"))) {
  dir.create(file.path(td, "NVItest"))
}

test_that("format worksheet", {
  # # ARGUMENT CHECKING ----
  # # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  NVIpackager:::assert_pkg_path(pkg = "NVItest",
                                pkg_path = paste0(td, "/NVItest"),
                                add = checks)
  # Report check-results
  expect_true(checkmate::reportAssertions(checks))


  expect_error(NVIpackager:::assert_pkg_path(pkg = "NVIwrong",
                                             pkg_path = file.path(td, "NVItest"),
                                             add = NULL),
               regexp = "Assertion on \'pkg\' failed: Must be element of set \\{\'NVItest\'\\}, but is \'NVIwrong\'.")


  expect_error(NVIpackager:::assert_pkg_path(pkg = "NVItest",
                                             pkg_path = file.path(td, "NVIwrong"),
                                             add = NULL),
               regexp = "Assertion on \'pkg_path\' failed: Directory \'C:")


  expect_error(NVIpackager:::assert_pkg_path(pkg = "NVIwrong",
                                             pkg_path = paste0(td, "/NVIwrong"),
                                             add = NULL),
               regexp = "Assertion on \'pkg_path\' failed: Directory \'C:")

})
