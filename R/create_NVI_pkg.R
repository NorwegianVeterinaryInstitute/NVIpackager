library(usethis)

pkg <- stringi::stri_extract_last_words(getwd())

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
    Language =  "en-GB"
  )
)

# Create a new package -------------------------------------------------
# pkg <- "mypkg"
# path <- file.path(".", pkg)
usethis::create_package(getwd())

usethis::proj_activate(path)

# Modify the description ----------------------------------------------
usethis::use_package(package = "devtools", type = "Suggests")
usethis::use_package(package = "checkmate", type = "Imports", min_version = NULL)
usethis::use_dev_package(package = "NVIcheckmate", type = "Imports", remote = "github::NorwegianVeterinaryInstitute/NVIcheckmate")

# Set up other files -------------------------------------------------
usethis::use_build_ignore(notes, escape = TRUE)

usethis::git_vaccinate()
usethis::use_git_ignore(ignores, directory = ".")
# Should be in vaccinate?
# usethis::use_git_ignore(ignores, file = "*.Rproj")

usethis::use_readme_md()
#> ✓ Writing 'README.md'

usethis::use_news_md()
#> ✓ Writing 'NEWS.md'

usethis::use_testthat()

usethis::use_code_of_conduct()

usethis::use_directory(path = "notes" , ignore = FALSE)

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
    Language =  "en-GB"
  )
)

usethis::use_vignette(name = "contribute_to_mypkg", title = "Contribute to mypkg")


# use_spell_check(vignettes = TRUE, lang = "en-GB", error = FALSE)
# use_logo(img, geometry = "240x278", retina = TRUE)
# use_package_doc(open = rlang::is_interactive())
