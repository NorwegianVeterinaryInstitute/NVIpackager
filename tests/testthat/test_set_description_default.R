
library(testthat)
library(NVIpackager)

test_that("Setting default options for DESCRIPTION", {

  set_description_default(pkg = "NVIpkg", license_keyword = "cc-by-4.0")

  usethis.description <- getOption("usethis.description")

  expect_identical(object = usethis.description$`Authors@R`,
                   expected = 'c(person(given = "Petter",
           family = "Hopp",
           role = c("aut", "cre"),
           email = "Petter.Hopp@vetinst.no",
           comment = c(ORCID = "0000-0002-8695-0378")),
    person(given = "Norwegian Veterinary Institute",
           role = "cph"))')

  expect_identical(object = usethis.description$URL,
                   expected = "https://github.com/NorwegianVeterinaryInstitute/NVIpkg")

  expect_identical(object = usethis.description$BugReports,
                   expected = "https://github.com/NorwegianVeterinaryInstitute/NVIpkg/issues")

  expect_identical(object = usethis.description$License,
                   expected = "cc-by-4.0 + file LICENSE")

  expect_identical(object = usethis.description$Language,
                   expected = "en-GB")

  expect_identical(object = usethis.description$Depends,
                   expected = "R (>= 4.0.0)")
})
