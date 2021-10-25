# library(usethis)

# pkg <- stringi::stri_extract_last_words(usethis::proj_path())

# set up standards for DESCRIPTION file ----
options(
  usethis.description = list(
    `Authors@R` = 'c(person(given = "Petter",
           family = "Hopp",
           role = c("aut", "cre"),
           email = "Petter.Hopp@vetinst.no",
           comment = c(ORCID = "0000-0002-8695-0378")),
    person(given = "Norwegian Veterinary Institute",
           role = "cph"))',
    URL = paste0("https://github.com/NorwegianVeterinaryInstitute/", pkg),
    BugReports = paste0("https://github.com/NorwegianVeterinaryInstitute/", pkg, "/issues"),
    License = "BSD_3_clause + file LICENSE",
    Language =  "en-GB",
    Depends = "R (>= 4.0.0)"
  )
)

# Create a new package ----
# pkg <- "mypkg"
# path <- file.path(".", pkg)
usethis::create_package(usethis::proj_path(), rstudio = FALSE, open = FALSE)


# Modify the description ----
usethis::use_package(package = "devtools", type = "Suggests")
usethis::use_package(package = "checkmate", type = "Imports", min_version = NULL)
# usethis::use_dev_package(package = "NVIcheckmate", type = "Imports", remote = "github::NorwegianVeterinaryInstitute/NVIcheckmate")

# This works
usethis::use_git_ignore(ignores = "*.Rproj")
# Set up other files -------------------------------------------------
usethis::use_build_ignore(files = "notes", escape = TRUE)


# SET UP VIGNETTES ----
usethis::use_vignette(name = paste0("Contribute_to_", pkg), title = paste("Contribute to", pkg))
use_contribute_to_NVIpkg()

# INCLUDE TEMPLATES ----
# README.Rmd

# NEWS.md
# usethis::use_template("NEWS.md",
#   data = package_data(),
#   open = open
# )
# Seems like changes must be committed before use_news_md() is run
# usethis::use_news_md(open = FALSE)




# set up test structure ----
usethis::use_testthat()
# spell check ask if shall overwrite file
# usethis::use_spell_check(vignettes = TRUE, lang = "en-GB", error = FALSE)
# spelling::spell_check_setup <- function(pkg = ".",
#                               vignettes = TRUE,
#                               lang = "en-GB",
#                               error = FALSE)

usethis::use_coverage()



usethis::use_directory(path = "notes" , ignore = FALSE)


# description_titel <- desc::desc_get_field(key = "Title")
# description_descr <- desc::desc_get_field(key = "Description")

# use_logo(img, geometry = "240x278", retina = TRUE)
# use_package_doc(open = FALSE)
