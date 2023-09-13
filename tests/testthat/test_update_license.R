# Attach packages and set up with temporary directory
library(testthat)
td <- tempdir()

if (!dir.exists(file.path(td, "NVItest"))) {
  dir.create(file.path(td, "NVItest"))
}
# Original license year is 2021, add to current year
test_that("Update license year", {
  license <- paste("Copyright (c)",
                   "2021",
                   "Norwegian Veterinary Institute")
  writeLines(license, file.path(td, "NVItest", "LICENSE"))

  update_license(pkg = "NVItest", pkg_path = file.path(td, "NVItest"))

  license <- readLines(file.path(td, "NVItest", "LICENSE"))
  expect_equal(license[1],
               paste("Copyright (c)",
                     "2021", "-", format(Sys.Date(), "%Y"),
                     "Norwegian Veterinary Institute"))

  # Original license year is 2021 to current year, no change
  license <- paste("Copyright (c)",
                   "2021", "-", format(Sys.Date(), "%Y"),
                   "Norwegian Veterinary Institute")
  writeLines(license, file.path(td, "NVItest", "LICENSE"))

  update_license(pkg = "NVItest", pkg_path = file.path(td, "NVItest"))

  license <- readLines(file.path(td, "NVItest", "LICENSE"))
  expect_equal(license[1],
               paste("Copyright (c)",
                     "2021", "-", format(Sys.Date(), "%Y"),
                     "Norwegian Veterinary Institute"))

  # Original license year is 2021 to current year - 1, increase to current year
  license <- paste("Copyright (c)",
                   "2021", "-", as.character(as.numeric(format(Sys.Date(), "%Y")) - 1),
                   "Norwegian Veterinary Institute")
  writeLines(license, file.path(td, "NVItest", "LICENSE"))

  update_license(pkg = "NVItest", pkg_path = file.path(td, "NVItest"))

  license <- readLines(file.path(td, "NVItest", "LICENSE"))
  expect_equal(license[1],
               paste("Copyright (c)",
                     "2021", "-", format(Sys.Date(), "%Y"),
                     "Norwegian Veterinary Institute"))

  # Original license year is current year, no change
  license <- paste("Copyright (c)",
                   format(Sys.Date(), "%Y"),
                   "Norwegian Veterinary Institute")
  writeLines(license, file.path(td, "NVItest", "LICENSE"))

  update_license(pkg = "NVItest", pkg_path = file.path(td, "NVItest"))

  license <- readLines(file.path(td, "NVItest", "LICENSE"))
  expect_equal(license[1],
               paste("Copyright (c)",
                     format(Sys.Date(), "%Y"),
                     "Norwegian Veterinary Institute"))
})
