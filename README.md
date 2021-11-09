# READ ME

NVIpackager: Tools to facilitate Development of NVIverse Packages
=================================================================

<!-- README.md is generated from README.Rmd. Please edit that file -->

-   [Overview](#overview)
-   [Installation](#installation)
-   [Usage](#usage)
-   [Copyright and license](#copyright-and-license)
-   [Contributing](#contributing)

Overview
--------

`NVIpackager`provides tools to facilitate development of NVIverse
packages. Use create\_NVIpkg\_skeleton to make a package skeleton in
accord with NVIverse standards. Several functions are for maintainance
of the NVIverse package, like update documentation and to streamline
testing and intallation of the package. The NVIpackager functions are to
a large extent wrappers for devtools and usethis functions. In addition,
the templates folder keeps templates for standard files like sections OF
README and CONTRIBUTING.

The package is under development. [Contributions](#contributing) to
enhance the package is highly appreciated.

`NVIpackager` is part of `NVIverse`, a collection of R-packages with
tools to facilitate data management and data reporting at the Norwegian
Veterinary Institute (NVI). The NVIverse consists of the following
packages: NVIconfig, NVIdb, NVIpretty, NVIbatch, OKplan, OKcheck,
NVIcheckmate, NVIpackager. See the vignette “Contribute to NVIpackager”
for more information.

Installation
------------

`NVIpackager` is available at
[GitHub](https://github.com/NorwegianVeterinaryInstitute). To install
`NVIpackager` you will need:

-   R version &gt; 4.0.0
-   R package `remotes`
-   Rtools 4.0

First install and attach the `remotes` package.

    install.packages("remotes")
    library(remotes)

To install (or update) the `NVIpackager` package, run the following
code:

    remotes::install_github("NorwegianVeterinaryInstitute/NVIpackager")
        upgrade = FALSE,
        build = TRUE,
        build_manual = TRUE)

Usage
-----

Usage
=====

The `NVIpackager` package needs to be attached.

    library(NVIdb)

`NVIpackager` provides tools to

The list of available functions and datasets can be accessed by typing

    help(package="NVIdb")

Please check the NEWS for information on new features, bug fixes and
other changes.

Copyright and license
---------------------

Copyright (c) 2021 Norwegian Veterinary Institute.  
Licensed under the BSD 3-Clause License. See
[License](https://github.com/NorwegianVeterinaryInstitute/NVIpackager/blob/main/LICENSE)
for details.

Contributing
------------

Contributions to develop `NVIpackager` is highly appreciated. There are
several ways you can contribute to this project: ask a question, propose
an idea, report a bug, improve the documentation, or contribute code.
The vignette “Contribute to NVIpackager” gives more information.

------------------------------------------------------------------------

Please note that the NVIpackager project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
