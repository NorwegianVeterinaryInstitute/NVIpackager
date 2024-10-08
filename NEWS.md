# NVIpackager 0.5.2 - (2024-09-11)

## Bug fixes:

- `update_NEWS` now generates the NEWS.md if no NEWS-file exists.

- `create_NVIpkg_skeleton` don't break when there is no NEWS-file.


# NVIpackager 0.5.1 - (2024-09-10)

## New features:

- `update_news` now works with the file "NEWS.md".


## Bug fixes:

- In `update_reference_manual` the ".gitignore" file is now updated when `manual = "remove"`.


## Other changes:

- Minor updates of develop.R


# NVIpackager 0.5.0 - (2024-03-17)

## New features:

- Created `update_license` for updating copyright year in the LICENSE file.

- Updated the section for help in the README template with a paragraph on vignettes.

- Improved `create_NVIpkg_skeleton`.


## Other changes:

- Created the vignette: "NVIverse coding conventions".

- Standardised function help.

- Created logo.

- "develop.R" includes code to find string in R-scripts. Can be used to check scripts.


# NVIpackager 0.4.0 - (2023-01-26)

## New features:

- Created `update_news`.

- Created `increase_NVIpkg_version` for increasing version number in "NEWS" and "DESCRIPTION". Calls `update_news`.


## Other changes:

- Created NVIpackager.pdf reference manual.

- Updated with package specific usage in README.

- Included `increase_NVIpkg_version` in template for develop.R.

- Styled the template "Contribute_to_NVIpkg.Rmd".


# NVIpackager 0.3.1 - (2022-08-20)

## Bug fixes:

- Removed `build_manual` = `TRUE` from `install_NVIpkg` as could cause problems for those without "MiKTeX" for generating PDF-files.

- Included `build_vignettes` = `TRUE` in README installation guide as vignettes will not be installed without.


## Other changes:

- Removed `build_manual` = `TRUE` from README installation guide as caused problems for those without "MiKTeX" for generating PDF-files.

- corrected installation guide and improved style for README templates.

- improved style in CONTRIBUTION template.

- updated and styled help documents, README and CONTRIBUTING.


# NVIpackager 0.3.0 - (2022-06-08)

## New features:

- `update_logo` created for updating a package logo from 'NVIrpackages'.

- `update_reference_manual` created for including, updating or removing the PDF reference maual from the vignettes.

- `document_NVIpkg` updated so it includes a call to `update_reference_manual`.

- created `update_develop` that copies a template for "develop.R" to notes.

_ included a call to `update_develop` in `create_NVIpkg_skeleton`.


## Other changes:

  - template "Contribute_to_NVIpkg.Rmd" was modified with more precise guidelines for styling code.

  - template "README.Rmd" was prepared for hexagon sticker logo.

  - README and CONTRIBUTING were updated.


# NVIpackager 0.2.0 - (2022-01-20)

## New features:

  - parameterized copyright year and set first_copyright_year to sysdata when creating package skeleton.


## Bug fixes:

  - template "Contribute_to_NVIpkg.Rmd" was modified.

  - template "README_usage_help.Rmd" was corrected.

  - template "README_usage_attach.Rmd" was corrected.

  - template "README_installation.Rmd" was corrected.


## BREAKING CHANGES:

  - `NVIpackages` was moved to the separate package `NVIrpackages`


# NVIpackager 0.1.0 - (2021-11-21)

## First release:

Tools to facilitate development of NVIverse packages.

  - `create_NVIpkg_skeleton` creates the package skeleton for NVIverse packages.

  - `set_description_default` sets default Values for the "DESCRIPTION" file. It is called by 'create_NVIpkg_skeleton'.

  - `document_NVIpkg` updates styling and documentation of a package.

  - `update_readme` updates "README.md".

  - `update_contributing` updates "CONTRIBUTING.md" and the vignette "Contribute_to_NVIpkg.Rmd"

  - `install_NVIpkg` installs an NVIverse package during the development phase.

  - Includes templates for "CONTRIBUTING.md" and "README.Rmd".
